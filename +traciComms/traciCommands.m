function [ out ] = traciCommands(scenario)
    javaaddpath ./libs/traci4matlab/traci4matlab/traci4matlab.jar
    import traci.constants
    
    sumoArgs = [ ' -b ' num2str(scenario.sumo.startTime)];
    if scenario.sumo.endTime > 0
        sumoArgs = [ sumoArgs ' -e ' num2str(scenario.sumo.endTime) ];
    end
    sumoArgs = [ sumoArgs ' --step-length ' num2str(scenario.sumo.stepLength) ...
        ' --collision.action none --duration-log.statistics ' ];
    
    if ~utils.hasfield(scenario, 'insertRate')
        sumoArgs = [ sumoArgs ' --max-num-vehicles ' num2str(scenario.sumo.maxVehicles(scenario.sumo.id)) ];
    else
        scenario.sumo.route = [ './scenarios/' scenario.name '/map.rou-' ...
                                num2str(scenario.sumo.insertRate(scenario.sumo.id)) '.xml' ];
    end
    
    if utils.hasfield(scenario, 'cavRerouteProb')
        sumoArgs = [ sumoArgs ' --device.rerouting.probability ' num2str(scenario.sumo.cavRerouteProb) ];
    end

    if ~isfile(['./scenarios/' scenario.name '/tmp/poly-' num2str(scenario.sumo.id) '.mat'])
        mkdir(['./scenarios/' scenario.name '/tmp']);
    end
    sumoArgs = [ sumoArgs ' --remote-port ' num2str(scenario.sumo.port(scenario.sumo.id)) ...
        ' --xml-validation never ' ...
        '>./scenarios/' scenario.name '/tmp/sumoLog-' num2str(scenario.sumo.id) '.txt&' ];
    
    if +utils.hasfield(scenario, 'insertRate')
        actId_ = scenario.sumo.id;
    else
        actId_ = 1;
    end
    command = [ scenario.sumo.sumoExecPath ' -c ' scenario.sumo.cfg ...
        ' --net-file ' scenario.sumo.net ...
        ' --route-files ' scenario.sumo.route  ...
        ' --additional-files ' scenario.sumo.additional{actId_} ...
        sumoArgs ];
    try
        command
        system(command);
    catch
        error('sumo is not installed!');
    end

    %% Initialise TraCI
    traci.init(scenario.sumo.port(scenario.sumo.id),10,'127.0.0.1',scenario.name);

    %% Find all the building polygons and put them in an array
    buildings = [];
    foliage = [];
    if ~isfile(['./scenarios/' scenario.name '/tmp/poly-' num2str(scenario.sumo.id) '.mat'])
        polygonIDs = traci.polygon.getIDList();
        polygonType = cell(1,length(polygonIDs));
        for i = 1:length(polygonIDs)
            polygonType{i} = traci.polygon.getType(polygonIDs{i});
            if strcmp(polygonType{i},'building')
                buildings = utils.polygonAddition(buildings,polygonIDs{i},i);
            elseif strcmp(polygonType{i},'forest') || strcmp(polygonType{i},'natural')
                foliage = utils.polygonAddition(foliage,polygonIDs{i},i);
            end
        end
        minX = min(buildings(:,3));
        minY = min(buildings(:,2));
        maxX = max(buildings(:,3));
        maxY = max(buildings(:,2));
        
        mkdir(['./scenarios/' scenario.name '/tmp']);
        save(['./scenarios/' scenario.name '/tmp/poly-' num2str(scenario.sumo.id) '.mat'], 'buildings', 'foliage', ...
            'minX', 'minY', 'maxX', 'maxY');
    else
        load(['./scenarios/' scenario.name '/tmp/poly-' num2str(scenario.sumo.id) '.mat'], 'buildings', 'foliage', ...
            'minX', 'minY', 'maxX', 'maxY');
    end
    

    %% Boundaries
%     boundaryMinX = minX+scenario.sumo.boundary;
%     boundaryMinY = minY+scenario.sumo.boundary;
%     boundaryMaxX = maxX-scenario.sumo.boundary;
%     boundaryMaxY = maxY-scenario.sumo.boundary;
    
    %% Plotter
%     if false
%         utils.plotPolygons(buildings, 'k-');
%         load(['./scenarios/' scenario.name '/tmp/poly-' num2str(scenario.sumo.id) '.mat'], 'foliage');
%         utils.plotPolygons(foliage, 'g-');
%         plot([minX, maxX, maxX, minX, minX], ...
%             [minY, minY, maxY, maxY, minY], 'r-.')
%     end
    %% Progress to the first simulation step
    traci.simulationStep;
    timeStep = traci.simulation.getTime;
    vehiclesAll = [];

    timeStepCounter = 0;
    
    vehicleNumber = NaN * zeros(1, (scenario.sumo.endTime - scenario.sumo.startTime) / scenario.sumo.stepLength + 1);
    while (timeStep < scenario.sumo.endTime)
        timeStep = traci.simulation.getTime;
        timeStepCounter = timeStepCounter + 1;
        vehicleIDs = traci.vehicle.getIDList();
        
        vehicleIDs = sort(cellfun(@str2num,vehicleIDs));
        vehicleNumber(timeStepCounter) = length(vehicleIDs);
        if ~utils.hasfield(scenario, 'insertRate')
            fprintf('Scenario: %s. Max. Vehicles: %d. Current timestep: %f. Current number of vehicles: %f\n', scenario.name, scenario.sumo.maxVehicles(scenario.sumo.id), timeStep, vehicleNumber(timeStepCounter));
        else
            fprintf('Scenario: %s. Current timestep: %f. Current number of vehicles: %f\n', scenario.name, timeStep, vehicleNumber(timeStepCounter));
        end

        vehiclesTimestep = [];
        newVehicles = traci.simulation.getDepartedIDList;
        newVehicles = sort(cellfun(@str2num,newVehicles));

        % Parse all the vehicles from this timestep
        vehiclesTimestep = NaN * zeros(length(vehicleIDs),5);
        for k = 1:length(vehicleIDs)
    %         vehicleClass = traci.vehicle.getTypeID(vehicleIDs{k});
    %         if strcmp(vehicleClass,'normal')
    %             class = 1;
    %         elseif strcmp(vehicleClass,'AV')
    %             class = 2;
    %         elseif strcmp(vehicleClass,'CAV')
    %             class = 3;
    %         end
           
            if ismember(vehicleIDs(k),newVehicles)
                traci.vehicle.subscribe(num2str(vehicleIDs(k)),{constants.VAR_SPEED,constants.VAR_POSITION})
                if scenario.sumo.noTrafficLights
                    traci.vehicle.setSpeedMode(num2str(vehicleIDs(k)),7); % 7 for 00111, 8 for 01000 in binary
                end
                %   traci.vehicle.setRoutingMode(vehicleIDs{i},1)
            end
            
            % vehiclesTimestep(k,:) = [ vehicleIDs(k) traci.vehicle.getPosition(num2str(vehicleIDs(k))) timeStep traci.vehicle.getSpeed(num2str(vehicleIDs(k))) ];
            
            curVehicle = traci.vehicle.getSubscriptionResults(num2str(vehicleIDs(k)));
            if all(curVehicle=='None')
                traci.vehicle.subscribe(num2str(vehicleIDs(k)),{constants.VAR_SPEED,constants.VAR_POSITION})
                curVehicle = traci.vehicle.getSubscriptionResults(num2str(vehicleIDs(k)));
            end
            vehiclesTimestep(k,:) = [ vehicleIDs(k) curVehicle(constants.VAR_POSITION)  timeStep curVehicle(constants.VAR_SPEED) ];
        end
        
%         if length(vehicleIDs) == 0
%             numVehiclesIn(timeStepCounter) = 0;
%         else
%             xIn = vehiclesTimestep(:,2) >= boundaryMinX & vehiclesTimestep(:,2) <= boundaryMaxX;
%             yIn = vehiclesTimestep(:,3) >= boundaryMinY & vehiclesTimestep(:,2) <= boundaryMaxY;
%             vehicleIn = xIn.*yIn;
%             numVehiclesIn(timeStepCounter) = sum(vehicleIn);
%         end

        vehiclesAll = [ vehiclesAll ; vehiclesTimestep  ];

        % go to the next timestep
        traci.simulationStep;
    end
    simulationSummary.ArrivedIDList = traci.simulation.getArrivedIDList;
    simulationSummary.ArrivedNumber = traci.simulation.getArrivedNumber;
    simulationSummary.CollidingVehiclesIDList = traci.simulation.getCollidingVehiclesIDList;
    simulationSummary.CollidingVehiclesNumber = traci.simulation.getCollidingVehiclesNumber;
    simulationSummary.DepartedIDList = traci.simulation.getDepartedIDList;
    simulationSummary.DepartedNumber = traci.simulation.getDepartedNumber;
    simulationSummary.EmergencyStoppingVehiclesIDList = traci.simulation.getEmergencyStoppingVehiclesIDList;
    simulationSummary.EmergencyStoppingVehiclesNumber = traci.simulation.getEmergencyStoppingVehiclesNumber;
    simulationSummary.EndingTeleportIDList = traci.simulation.getEndingTeleportIDList;
    simulationSummary.EndingTeleportNumber = traci.simulation.getEndingTeleportNumber;
    simulationSummary.SumoCmd = command;
    traci.close()
    
    fPt_ = ['./scenarios/' scenario.name '/tmp/sumoLog-' num2str(scenario.sumo.id) '.txt'];
    fileID = fopen(fPt_,'r');
    allData = textscan(fileID,'%s','Delimiter','\n');
    simulationSummary.sumoOutputLog = allData;
    for ss_ = 1:(size(allData{1,1},1)-1)
        t_ = cell2mat(allData{1,1}(end-ss_));
        if contains(t_, 'RouteLength')
            simulationSummary.avgRouteLength = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
            break;
        elseif contains(t_, 'Duration')
            simulationSummary.Duration = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
        elseif contains(t_, 'WaitingTime')
            simulationSummary.WaitingTime = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
        elseif contains(t_, 'TimeLoss')
            simulationSummary.TimeLoss = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
        elseif contains(t_, 'DepartDelay')
            simulationSummary.DepartDelay = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
        end
    end
    
    if utils.hasfield(scenario, 'cavRerouteProb')
        scenario.subName = strcat(scenario.subName, '-rr-', num2str(scenario.sumo.cavRerouteProb), '-');
    end
    
    if ~+utils.hasfield(scenario, 'insertRate')
        save(['./scenarios/' scenario.name '/' scenario.name '-' scenario.subName '-vn-' num2str(scenario.sumo.maxVehicles(scenario.sumo.id)) '.mat'], 'vehiclesAll', 'buildings', 'foliage', ...
              'minX', 'minY', 'maxX', 'maxY', 'simulationSummary')
    else
        save(['./scenarios/' scenario.name '/' scenario.name '-' scenario.subName '-ir-' num2str(scenario.sumo.insertRate(scenario.sumo.id)) '.mat'], 'vehiclesAll', 'buildings', 'foliage', ...
              'minX', 'minY', 'maxX', 'maxY', 'simulationSummary')
    end
    out = 1;
end
