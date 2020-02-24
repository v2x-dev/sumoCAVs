%% TC-03 - 'Berlin Capped HD'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'HD-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_HD.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-04 - 'Berlin Capped AV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'AV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_AV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-00 - 'Berlin Uncapped HD'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'HD-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_HD.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-01 - 'Berlin Uncapped AV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'AV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_AV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-02 - 'Berlin Uncapped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;
