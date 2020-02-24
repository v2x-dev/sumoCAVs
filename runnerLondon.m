%% TC-03 - 'london Capped HD'
utils.initEnv;
scenario.name                       = 'london';
scenario.subName                    = 'HD-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/london/additional_HD.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
scenario.sumo.leftHand              = true;
utils.sumoSimulate;

%% TC-04 - 'london Capped AV'
utils.initEnv;
scenario.name                       = 'london';
scenario.subName                    = 'AV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/london/additional_AV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
scenario.sumo.leftHand              = true;
utils.sumoSimulate;

%% TC-05 - 'london Capped CAV'
utils.initEnv;
scenario.name                       = 'london';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/london/additional_CAV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
scenario.sumo.leftHand              = true;
utils.sumoSimulate;

%% TC-00 - 'london Uncapped HD'
utils.initEnv;
scenario.name                       = 'london';
scenario.subName                    = 'HD-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/london/additional_HD.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
scenario.sumo.leftHand              = true;
utils.sumoSimulate;

%% TC-01 - 'london Uncapped AV'
utils.initEnv;
scenario.name                       = 'london';
scenario.subName                    = 'AV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/london/additional_AV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
scenario.sumo.leftHand              = true;
utils.sumoSimulate;

%% TC-02 - 'london Uncapped CAV'
utils.initEnv;
scenario.name                       = 'london';
scenario.subName                    = 'CAV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/london/additional_CAV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
scenario.sumo.leftHand              = true;
utils.sumoSimulate;
