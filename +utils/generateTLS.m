function scenario = generateTLS(scenario)
    tmp__ = scenario.sumo.additional;
    try
        iR_ = scenario.sumo.insertRate;
    catch
        iR_ = 0.1;
    end
    scenario.sumo.additional = cell(1,length(iR_));
    for i = 1:length(iR_)
        scenario.sumo.route = [ './scenarios/' scenario.name '/map.rou-' ...
                                    num2str(iR_(i)) '.xml' ];

        tlsCoordinator = [ scenario.sumoToolsPath 'tlsCoordinator.py --net-file ' scenario.sumo.net ...
                           ' --route-file ' scenario.sumo.route ...
                           ' --output-file ./scenarios/' scenario.name '/tlsOffsets-' num2str(iR_(i)) '.add.xml' ];
        system(tlsCoordinator);

        tlsCycleAdaptation = [ scenario.sumoToolsPath 'tlsCycleAdaptation.py --net-file ' scenario.sumo.net ...
                               ' --route-file ' scenario.sumo.route ...
                               ' --output-file ./scenarios/' scenario.name '/tlsCycle-' num2str(iR_(i)) '.add.xml' ];
        system(tlsCycleAdaptation);
        
        scenario.sumo.additional{i} = [ tmp__ ',./scenarios/' scenario.name '/tlsOffsets-' num2str(iR_(i)) '.add.xml,./scenarios/' scenario.name '/tlsCycle-' num2str(iR_(i)) '.add.xml' ];
    end
end