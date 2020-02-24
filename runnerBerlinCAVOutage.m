%% TC-05.0 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAVnoDevice.xml';
scenario.sumo.maxVehicles           = [250 750 1250];
scenario.sumo.cavRerouteProb        = 0;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05.0 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAVnoDevice.xml';
scenario.sumo.maxVehicles           = [250 750 1250];
scenario.sumo.cavRerouteProb        = 0.125;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05.0 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAVnoDevice.xml';
scenario.sumo.maxVehicles           = [250 750 1250];
scenario.sumo.cavRerouteProb        = 0.25;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05.0 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAVnoDevice.xml';
scenario.sumo.maxVehicles           = [250 750 1250];
scenario.sumo.cavRerouteProb        = 0.375;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05.0 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAVnoDevice.xml';
scenario.sumo.maxVehicles           = [250 750 1250];
scenario.sumo.cavRerouteProb        = 0.5;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05.1 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAVnoDevice.xml';
scenario.sumo.maxVehicles           = [250 750 1250];
scenario.sumo.cavRerouteProb        = 0.6250;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05.2 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAVnoDevice.xml';
scenario.sumo.maxVehicles           = [250 750 1250];
scenario.sumo.cavRerouteProb        = 0.7500;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;

%% TC-05.3 - 'Berlin Capped CAV'
utils.initEnv;
scenario.name                       = 'berlin';
scenario.subName                    = 'CAV-capped';
scenario.sumo.seed                  = 1000;
scenario.sumo.startTime             = 0;
scenario.sumo.endTime               = 3600;
scenario.sumo.stepLength            = 0.1;
scenario.sumo.cfg                   = './sumoCfg/sim.sumocfg';
scenario.sumo.vehicleDistribution   = './scenarios/berlin/additional_CAVnoDevice.xml';
scenario.sumo.maxVehicles           = [250 750 1250];
scenario.sumo.cavRerouteProb        = 0.8750;
scenario.sumo.port                  = 8897 + (1:length(scenario.sumo.maxVehicles));
scenario.sumo.noTrafficLights       = false;
scenario.sumo.ActuatedTrafficLights = true;
utils.sumoSimulate;
