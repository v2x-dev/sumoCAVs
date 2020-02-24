clf; clear all; close all;clc;

sumo.startTime = 0;
sumo.endTime = 3600;
sumo.sumoPath = '/usr/local/bin';
sumo.boundary = 300;
sumo.stepLength = 0.1;
sumo.routeFile = './av.sumocfg';

scenarioName = 'AV';
maxVehicles = [ 500 1000 ];
port = [ 8883 8885 ];
noTrafficLights = 0;

%% Kill SUMO and add path (if needed)
% tmp = system('pgrep sumo');
% if ~tmp
%     while ~tmp
%         system('killall sumo');
%         pause(1);
%         tmp = system('pgrep sumo');
%     end
% end

pathVar = getenv('PATH');
if ~contains(pathVar,sumo.sumoPath)
    pathVar = [pathVar ':' sumo.sumoPath ];
    setenv('PATH', pathVar);
end

for i = 1:length(maxVehicles)
    %% SUMO Settings
    
    sumo.maxVehicleNumber = maxVehicles(i); % maximum number of vehicles per timestep - set to zero if all vehicles are to be considered
    
%     functionForAll(sumo,scenarioName)
    
    portToUse = port(i);
    label = ['sumo' num2str(i) ];
    
    batch('traciCommands',1,{sumo,portToUse,label,scenarioName,noTrafficLights})
    
end

% Regular 83.3480 - 72.2548
% CAVs 74.9686 - 67.3949