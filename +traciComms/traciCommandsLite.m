function [ out ] = traciCommandsLite(scenario)
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

    if ~isfile(['./scenarios/' scenario.name '/tmp/poly-' num2str(scenario.sumo.id) '.mat'])
        mkdir(['./scenarios/' scenario.name '/tmp']);
    end
    sumoArgs = [ sumoArgs ' --xml-validation never ' ];
    
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
        [~, cmd_] = system(command);
    catch
        error('sumo is not installed!');
    end
        
    allData = textscan(cmd_,'%s','Delimiter','\n');
    simulationSummaryA.sumoOutputLog = cmd_;
    for ss_ = 1:(size(allData{1,1},1)-1)
        t_ = cell2mat(allData{1,1}(end-ss_));
        if contains(t_, 'RouteLength')
            simulationSummaryA.avgRouteLength = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
            break;
        elseif contains(t_, 'Duration')
            simulationSummaryA.Duration = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
        elseif contains(t_, 'WaitingTime')
            simulationSummaryA.WaitingTime = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
        elseif contains(t_, 'TimeLoss')
            simulationSummaryA.TimeLoss = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
        elseif contains(t_, 'DepartDelay')
            simulationSummaryA.DepartDelay = str2double(cell2mat(regexp(t_,'\d+\.?\d*','match')));
        end
    end
    
    if ~+utils.hasfield(scenario, 'insertRate')
        save(['./scenarios/' scenario.name '/' scenario.name '-' scenario.subName '-vnA-' num2str(scenario.sumo.maxVehicles(scenario.sumo.id)) '.mat'], 'simulationSummaryA')
    else
        save(['./scenarios/' scenario.name '/' scenario.name '-' scenario.subName '-irA-' num2str(scenario.sumo.insertRate(scenario.sumo.id)) '.mat'], 'simulationSummaryA')
    end
    out = 1;
end
