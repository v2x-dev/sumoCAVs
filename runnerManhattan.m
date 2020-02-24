%% TC-03 - 'manhattan Capped HD'
utils.initEnv;
scenario.name                       = 'manhattan';
scenario.subName                    = 'HD-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/manhattan/additional_HD.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-04 - 'manhattan Capped AV'
utils.initEnv;
scenario.name                       = 'manhattan';
scenario.subName                    = 'AV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/manhattan/additional_AV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05 - 'manhattan Capped CAV'
utils.initEnv;
scenario.name                       = 'manhattan';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/manhattan/additional_CAV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-00 - 'manhattan Uncapped HD'
utils.initEnv;
scenario.name                       = 'manhattan';
scenario.subName                    = 'HD-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/manhattan/additional_HD.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-01 - 'manhattan Uncapped AV'
utils.initEnv;
scenario.name                       = 'manhattan';
scenario.subName                    = 'AV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/manhattan/additional_AV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-02 - 'manhattan Uncapped CAV'
utils.initEnv;
scenario.name                       = 'manhattan';
scenario.subName                    = 'CAV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/manhattan/additional_CAV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;
