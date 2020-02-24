%% TC-03 - 'paris Capped HD'
utils.initEnv;
scenario.name                       = 'paris';
scenario.subName                    = 'HD-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/paris/additional_HD.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-04 - 'paris Capped AV'
utils.initEnv;
scenario.name                       = 'paris';
scenario.subName                    = 'AV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/paris/additional_AV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-05 - 'paris Capped CAV'
utils.initEnv;
scenario.name                       = 'paris';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/paris/additional_CAV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-00 - 'paris Uncapped HD'
utils.initEnv;
scenario.name                       = 'paris';
scenario.subName                    = 'HD-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/paris/additional_HD.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-01 - 'paris Uncapped AV'
utils.initEnv;
scenario.name                       = 'paris';
scenario.subName                    = 'AV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/paris/additional_AV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-02 - 'paris Uncapped CAV'
utils.initEnv;
scenario.name                       = 'paris';
scenario.subName                    = 'CAV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/paris/additional_CAV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;
