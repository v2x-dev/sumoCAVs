function [scenario] = parseOSM(scenario)
    try
        netCommand  = [ scenario.sumo.netConvExecPath ' --osm-files ' './scenarios/' scenario.name '/map.osm.xml' ' --output-file ' './scenarios/' scenario.name '/map.net.xml' ' --no-turnarounds --opposites.guess --opposites.guess.fix-lengths --roundabouts.guess --ramps.guess --keep-edges.by-vclass passenger,taxi,authority,private,emergency,truck --tls.guess-signals --tls.discard-simple --tls.join' ];
        if scenario.sumo.ActuatedTrafficLights
            netCommand  = [ netCommand ' --tls.default-type actuated' ];
        end
        if utils.hasfield(scenario, 'leftHand') && scenario.sumo.leftHand
            netCommand  = [ netCommand ' --lefthand' ];
        end
        system(netCommand);
        polyCommand = [ scenario.sumo.polyConvExecPath ' --osm-files ' './scenarios/' scenario.name '/map.osm.xml' ' --net-file ' './scenarios/' scenario.name '/map.net.xml' ' --output-file ' './scenarios/' scenario.name '/map.poly.xml' ];
        system(polyCommand);
    catch
        warning('net, rou and poly files already provided.');
    end
    scenario.sumo.net        = ['./scenarios/' scenario.name '/map.net.xml'];
    scenario.sumo.route      = ['./scenarios/' scenario.name '/map.rou.xml'];
    scenario.sumo.additional = [ './scenarios/' scenario.name  '/map.poly.xml' ];
end
