clearvars; close all

srvType = computer('arch');
if strcmp(srvType, 'maci64')
    tmp = system('pgrep sumo');
    if ~tmp
        while ~tmp
            system('killall sumo');
            pause(1);
            tmp = system('pgrep sumo');
        end
    end
    addpath ./libs/traci4matlab/traci4matlab/
    scenario.sumo.sumoExecPath     = 'export SUMO_HOME="/usr/local/share/sumo/"; /usr/local/bin/sumo';
    scenario.sumo.netConvExecPath  = 'export SUMO_HOME="/usr/local/share/sumo/"; /usr/local/bin/netconvert';
    scenario.sumo.polyConvExecPath = 'export SUMO_HOME="/usr/local/share/sumo/"; /usr/local/bin/polyconvert';
    scenario.sumoToolsPath     = 'export SUMO_HOME="/usr/local/share/sumo/"; /usr/local/opt/sumo/share/sumo/tools/';
elseif strcmp(srvType, 'glnxa64')
    system('killall sumo');
    addpath ./libs/traci4matlab/traci4matlab/
    scenario.sumo.sumoExecPath = 'export SUMO_HOME="/usr/local/share/sumo/"; sumo';
    scenario.sumo.netConvExecPath  = 'export SUMO_HOME="/usr/local/share/sumo/"; /usr/local/bin/netconvert';
    scenario.sumo.polyConvExecPath = 'export SUMO_HOME="/usr/local/share/sumo/"; /usr/local/bin/polyconvert';
    scenario.sumoToolsPath     = 'export SUMO_HOME="/usr/local/share/sumo/"; /usr/local/share/sumo/tools/';
elseif strcmp(srvType, 'win64')
    system('taskkill /F /IM sumo.exe')
    system('taskkill /IM cmd.exe')
    addpath ./libs/traci4matlab/traci4matlab/
    scenario.sumo.sumoExecPath = 'sumo';
    scenario.sumo.netConvExecPath  = 'netconvert';
    scenario.sumo.polyConvExecPath = 'polyconvert';
    scenario.sumoToolsPath     = '';
else
    error('Unsupported OS Type!')
end

scenario.runParallel = true;
