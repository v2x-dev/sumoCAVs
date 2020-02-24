function scenario = generateTraces(scenario)
    scenario.sumo.net = [ './scenarios/' scenario.name  '/map.net.xml' ];
    try
        scenario.sumo.vehicleDistribution;
    catch
        if sum(scenario.probabilities)~=1
            error('Wrong number of probabilities. They should add up to one.')
        end
        
        scenario.sumo.vehicleDistribution = [ './scenarios/' scenario.name  '/allVehiclesDistribution.xml' ];

        normalCommand = [ scenario.sumoToolsPath 'createVehTypeDistribution.py ' scenario.vehicleConfigurations '/normal.txt -s ' num2str(scenario.probabilities(1)*100) ' -o ./scenarios/' scenario.name '/normalDistribution.xml' ];
        avCommand = [ scenario.sumoToolsPath 'createVehTypeDistribution.py ' scenario.vehicleConfigurations '/av.txt -s ' num2str(scenario.probabilities(2)*100) ' -o ./scenarios/' scenario.name '/avDistribution.xml' ];
        cavCommand = [ scenario.sumoToolsPath 'createVehTypeDistribution.py ' scenario.vehicleConfigurations '/cav.txt -s ' num2str(scenario.probabilities(3)*100) ' -o ./scenarios/' scenario.name '/cavDistribution.xml' ];

        try
            fprintf('Generate the distribution for the normal vehicles\n')
            system(normalCommand);
            fprintf('\nGenerate the distribution for the autonomous vehicles\n')
            system(avCommand);
            fprintf('\nGenerate the distribution for the connected and autonomous vehicles\n')
            system(cavCommand);
        catch
            error('SUMO tools folder cannot be found.')
        end

        %% Generate distribution file and save it
        fprintf('\nConcatenate all the distributions to one file\n')
        stringStart = '<additional>\n<routes>\n<vTypeDistribution id="typedist1">\n';

        fileID = fopen(['./scenarios/' scenario.name '/allVehiclesDistribution.xml'],'w');
        fprintf(fileID, stringStart );

        strToWrite = utils.readDistribution(['./scenarios/' scenario.name '/normalDistribution.xml' ],'normal');
        fprintf(fileID, strToWrite );

        strToWrite = utils.readDistribution(['./scenarios/' scenario.name '/avDistribution.xml' ],'AV');
        fprintf(fileID, strToWrite );

        strToWrite = utils.readDistribution(['./scenarios/' scenario.name '/cavDistribution.xml' ],'CAV', scenario);
        fprintf(fileID, strToWrite );

        stringStop = '</vTypeDistribution>\n</routes>\n</additional>';
        fprintf(fileID, stringStop );
        fclose(fileID);
    end

    if +utils.hasfield(scenario, 'insertRate')
        rate_ = scenario.sumo.insertRate;
    else
        rate_ = 0.1;
    end
    for rr_ = 1:length(rate_)
        randomTripsCommand = [ scenario.sumoToolsPath 'randomTrips.py' ...
            ' --net-file=' scenario.sumo.net ' --additional-files=' scenario.sumo.vehicleDistribution ...
            ' --output-trip-file=' './scenarios/' scenario.name '/map.trips-' num2str(rate_(rr_)) '.xml' ...
            ' --route-file=' './scenarios/' scenario.name '/map.rou-' num2str(rate_(rr_)) '.xml --begin=0 --end=10000 --verbose --period ' num2str(rate_(rr_)) ...
            ' --trip-attributes="type=\"typedist1\" departLane=\"best\"' ...
            ' departSpeed=\"max\" departPos=\"random\" arrivalPos=\"random\"" --seed ' num2str(scenario.sumo.seed) ];
        system(randomTripsCommand);
    end
end
