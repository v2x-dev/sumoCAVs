function functionForAll(sumo,scenarioName,noTrafficLights)
    
    import traci.constants

    %% Kill SUMO and add path (if needed)
    tmp = system('pgrep sumo');
    if ~tmp
        while ~tmp
            system('killall sumo');
            pause(1);
            tmp = system('pgrep sumo');
        end
    end

    pathVar = getenv('PATH');
    if ~contains(pathVar,sumo.sumoPath)
        pathVar = [pathVar ':' sumo.sumoPath ];
        setenv('PATH', pathVar);
    end

    %% Initialise SUMO or SUMO-GUI to run in the background
    sumoArgs = [ ' -b ' num2str(sumo.startTime)];
    if sumo.endTime > 0
        sumoArgs = [ sumoArgs ' -e ' num2str(sumo.endTime) ];
    end
    sumoArgs = [ sumoArgs ' --step-length ' num2str(sumo.stepLength) ' --max-num-vehicles ' num2str(sumo.maxVehicleNumber) ' --collision.action warn ' ];


    sumoArgs = [ sumoArgs ' --remote-port 8813 --xml-validation never&' ];
    command = ['sumo -c ' sumo.routeFile  sumoArgs];
    system(command);

    %% Initialise TraCI
    [traciVersion,sumoVersion] = traci.init();

    tic
    
    %% Find all the building polygons and put them in an array
    buildings = [];
    foliage = [];
    polygonIDs = traci.polygon.getIDList();
    for i = 1:length(polygonIDs)
        polygonType{i} = traci.polygon.getType(polygonIDs{i});
        if strcmp(polygonType{i},'building')
            buildings = polygonAddition(buildings,polygonIDs{i},i);
        elseif strcmp(polygonType{i},'forest') || strcmp(polygonType{i},'natural')
            foliage = polygonAddition(foliage,polygonIDs{i},i);
        end
    end

    minX = min(buildings(:,2));
    minY = min(buildings(:,3));
    maxX = max(buildings(:,2));
    maxY = max(buildings(:,3));

    %% Boundaries
    boundaryMinX = minX+sumo.boundary;
    boundaryMinY = minY+sumo.boundary;
    boundaryMaxX = maxX-sumo.boundary;
    boundaryMaxY = maxY-sumo.boundary;

    %% Progress to the first simulation step
    traci.simulationStep;
    timeStep = traci.simulation.getTime;
    vehiclesAll = [];
    uniqueVehicles = {};

    timeStepCounter = 0;
    cc = 0;
    while timeStep<sumo.endTime
        timeStep = traci.simulation.getTime;
        timeStepCounter = timeStepCounter + 1;
        vehicleIDs = traci.vehicle.getIDList();
        
        vehicleIDs = sort(cellfun(@str2num,vehicleIDs));
        vehicleNumber(timeStepCounter) = length(vehicleIDs);
        fprintf('Scenario: %s. Max. Vehicles: %d. Current timestep: %f. Current number of vehicles: %f\n', scenarioName, sumo.maxVehicleNumber, timeStep, vehicleNumber(timeStepCounter));

        vehiclesTimestep = [];
        newVehicles = traci.simulation.getDepartedIDList;
        newVehicles = sort(cellfun(@str2num,newVehicles));

        % Parse all the vehicles from this timestep
        for k = 1:length(vehicleIDs)
    %         vehicleClass = traci.vehicle.getTypeID(vehicleIDs{k});
    %         if strcmp(vehicleClass,'normal')
    %             class = 1;
    %         elseif strcmp(vehicleClass,'AV')
    %             class = 2;
    %         elseif strcmp(vehicleClass,'CAV')
    %             class = 3;
    %         end
    
%             
            if ismember(vehicleIDs(k),newVehicles)
%                 traci.vehicle.subscribe(num2str(vehicleIDs(k)),{constants.VAR_SPEED,constants.VAR_POSITION})
                traci.vehicle.setSpeedMode(num2str(vehicleIDs(k)),7); % 8 for 01000 in binary
                %   traci.vehicle.setRoutingMode(vehicleIDs{i},1)
            end
            
            vehiclesTimestep(k,:) = [ vehicleIDs(k) traci.vehicle.getPosition(num2str(vehicleIDs(k))) timeStep traci.vehicle.getSpeed(num2str(vehicleIDs(k))) ];
            
%             curVehicle = traci.vehicle.getSubscriptionResults(num2str(vehicleIDs(k)));
%             if all(curVehicle=='None')
%                 cc = cc + 1;
%                 traci.vehicle.subscribe(num2str(vehicleIDs(k)),{constants.VAR_SPEED,constants.VAR_POSITION})
%                 curVehicle = traci.vehicle.getSubscriptionResults(num2str(vehicleIDs(k)));
%             end
%             vehiclesTimestep(k,:) = [ vehicleIDs(k) curVehicle(constants.VAR_POSITION)  timeStep curVehicle(constants.VAR_SPEED) ];

        end

        xIn = vehiclesTimestep(:,2) >= boundaryMinX & vehiclesTimestep(:,2) <= boundaryMaxX;
        yIn = vehiclesTimestep(:,3) >= boundaryMinY & vehiclesTimestep(:,2) <= boundaryMaxY;
        vehicleIn = xIn.*yIn;
        numVehiclesIn(timeStepCounter) = sum(vehicleIn);

        vehiclesAll = [ vehiclesAll ; vehiclesTimestep  ];

        % go to the next timestep
        traci.simulationStep;
    end
    
    fprintf('The overall time was: %f\n',toc)
    traci.close()
end