if utils.hasfield(scenario, 'rerouting') && ...
        utils.hasfield(scenario, 'vehicleDistribution')
    warning('scenario.sumo.rerouting has no effect when scenario.sumo.vehicleDistribution is defined.')
end

if utils.hasfield(scenario, 'maxVehicles') && ...
        utils.hasfield(scenario, 'insertRate')
    warning('scenario.sumo.maxVehicles has no effect when scenario.sumo.insertRate is defined.')
end

%% Parse OSM map
scenario = utils.parseOSM(scenario);

%% Generate the mobility traces
scenario = utils.generateTraces(scenario);

%% Introduce the improved actuated traffic light programs
if scenario.sumo.ActuatedTrafficLights
    scenario = utils.generateTLS(scenario);
end

if length(scenario.sumo.maxVehicles) == 1
    scenario.sumo.id = 1;
    for i = 1:length(scenario.sumo.insertRate)
        scenario.sumo.id = i;
        if scenario.runParallel
            j{i} = batch('traciComms.traciCommandsLite',1,{scenario});
        else
            traciComms.traciCommandsLite(scenario);
        end
    end
else
    for i = 1:length(scenario.sumo.maxVehicles)
        scenario.sumo.id = i;
        if scenario.runParallel
            j{i} = batch('traciComms.traciCommandsLite',1,{scenario});
        else
            traciComms.traciCommandsLite(scenario);
        end
        
    end
end

if scenario.runParallel
    noJobsFinished = 0;
    while noJobsFinished < length(j)
        for i_ = 1:length(j)
            if strcmp(j{i}.findTask.State, 'finished')
              noJobsFinished = noJobsFinished + 1;
            end
        end
        pause(5);
    end
end
