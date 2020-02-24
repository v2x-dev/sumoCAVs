%% TC-03 - 'rome Capped HD'
utils.initEnv;
scenario.name                       = 'rome';
scenario.subName                    = 'HD-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/rome/additional_HD.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-04 - 'rome Capped AV'
utils.initEnv;
scenario.name                       = 'rome';
scenario.subName                    = 'AV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/rome/additional_AV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-05 - 'rome Capped CAV'
utils.initEnv;
scenario.name                       = 'rome';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/rome/additional_CAV.xml';
scenario.sumo.maxVehicles           = 250:250:1500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-00 - 'rome Uncapped HD'
utils.initEnv;
scenario.name                       = 'rome';
scenario.subName                    = 'HD-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/rome/additional_HD.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-01 - 'rome Uncapped AV'
utils.initEnv;
scenario.name                       = 'rome';
scenario.subName                    = 'AV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/rome/additional_AV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;

%% TC-02 - 'rome Uncapped CAV'
utils.initEnv;
scenario.name                       = 'rome';
scenario.subName                    = 'CAV-uncapped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/rome/additional_CAV.xml';
scenario.sumo.maxVehicles           = 0;
scenario.sumo.insertRate            = 1:(-0.05):0.8;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.insertRate));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulateLite;
