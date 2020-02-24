addpath ./libs/export_fig/
cities = {'berlin' 'london' 'manhattan' 'paris' 'rome'};

UL(1).PL00 = 800;
UL(1).PL010 = 1.6e3;
UL(1).PL011 = 7;
LL(1).PL013 = 150;
UL(1).PL013 = 300;
UL(1).PL014 = 5;
UL(1).PL02 = 2.2e3;
UL(1).PL021 = 300;
LL(1).PL021 = 100;

UL(2).PL00 = 800;
UL(2).PL010 = 1.6e3;
UL(2).PL011 = 7;
LL(2).PL013 = 150;
UL(2).PL013 = 500;
UL(2).PL02 = 2.2e3;
UL(2).PL021 = 300;
LL(2).PL021 = 100;

UL(3).PL00 = 300;
UL(3).PL010 = 1.6e3;
UL(3).PL011 = 8;
LL(3).PL013 = 150;
UL(3).PL013 = 500;
UL(3).PL02 = 400;
UL(3).PL021 = 300;
LL(3).PL021 = 100;

UL(4).PL00 = 800;
UL(4).PL010 = 1.6e3;
UL(4).PL011 = 7;
LL(4).PL013 = 150;
UL(4).PL013 = 650;
UL(4).PL02 = 2.2e3;
UL(4).PL021 = 300;
LL(4).PL021 = 100;

UL(5).PL00 = 800;
UL(5).PL010 = 1.6e3;
UL(5).PL011 = 8;
LL(5).PL013 = 150;
UL(5).PL013 = 650;
UL(5).PL02 = 2.2e3;
UL(5).PL021 = 300;
LL(5).PL021 = 100;

idx = 0;
for c_ = cities
    idx = idx + 1;
    close all
    cc_ = cell2mat(c_);
    %% PL-00 Plot No. of vh. as a function of time for any insertion rate and vh type
    utils.plotVhAsAFunctionOfTime_A(strcat('scenarios/',cc_), cc_, 0.8:0.1:1, [0 , 3600], [0, UL(idx).PL00], strcat('PL-00-',cc_));
        
    %% PL-01.0 Plot No. of vh. as a function of time for any max no. of vh. and type
    mapNet = utils.xml2struct(strcat('scenarios/',cc_,'/map.net.xml'));
    load( [ 'scenarios/' cc_ '/' cc_ '-HD-capped-vn-250.mat'], 'minX', 'minY', 'maxX', 'maxY' );
    targetRoadLen = 1.3e5;
    utils.plotVhAsAFunctionOfTime_B(strcat('scenarios/',cc_), cc_, [250 500 1500], [0 , 3600], [0, UL(idx).PL010], strcat('PL-01.0-',cc_), ...
        mapNet, targetRoadLen, [minX, minY, maxX, maxY]);
    
    %% PL-01.1 Plot speed (avg. across time and vh.) as a function of max no. of vh. for any type of vh.
    mapNet = utils.xml2struct(strcat('scenarios/',cc_,'/map.net.xml'));
    load( [ 'scenarios/' cc_ '/' cc_ '-HD-capped-vn-250.mat'], 'minX', 'minY', 'maxX', 'maxY' );
    targetRoadLen = 1.3e5;
    utils.plotVhAsAFunctionOfTime_B1(strcat('scenarios/',cc_), cc_, 250:250:1500, [250 , 1500], [0, UL(idx).PL011], strcat('PL-01.1-',cc_), ...
        mapNet, targetRoadLen, [minX, minY, maxX, maxY]);
    
    %% PL-01.4 Plot speed (avg. across time and vh.) as a function of Re-Routing prob. for CAVs
    if idx == 1
        mapNet = utils.xml2struct(strcat('scenarios/',cc_,'/map.net.xml'));
        load( [ 'scenarios/' cc_ '/' cc_ '-HD-capped-vn-250.mat'], 'minX', 'minY', 'maxX', 'maxY' );
        targetRoadLen = 1.3e5;
        utils.plotVhAsAFunctionOfTime_B4(strcat('scenarios/',cc_), cc_, [250 750 1250], 0:0.25:0.75, [0 , 1], [0, UL(idx).PL014], strcat('PL-01.4-',cc_), ...
            mapNet, targetRoadLen, [minX, minY, maxX, maxY]);
    end

    %% PL-01.3 Plot Duration as a function of max no. of vh. for any type of vh.
    utils.plotVhAsAFunctionOfTime_B3(strcat('scenarios/',cc_), cc_, 250:250:1500, [250 , 1500], [LL(idx).PL013, UL(idx).PL013], strcat('PL-01.3-',cc_));
    
    %% PL-02 Plot Max No. of vh. as a function of insertion rate for any vh. type
    utils.plotVhAsAFunctionOfTime_C(strcat('scenarios/',cc_), cc_, 0.8:0.05:1, [0.8 , 1], [0, UL(idx).PL02], strcat('PL-02-',cc_));
    
    %% PL-02.1 Plot Duration of vh. as a function of insertion rate for any vh. type
    utils.plotVhAsAFunctionOfTime_C2(strcat('scenarios/',cc_), cc_, 0.8:0.05:1, [0.8 , 1], [LL(idx).PL021, UL(idx).PL021], strcat('PL-02.1-',cc_));    
end

%% Compressed Figures
%--------------%
mapNet{1} = utils.xml2struct(strcat('scenarios/','berlin','/map.net.xml'));
mapNet{2} = utils.xml2struct(strcat('scenarios/','london','/map.net.xml'));
mapNet{3} = utils.xml2struct(strcat('scenarios/','manhattan','/map.net.xml'));
load( [ 'scenarios/' 'berlin' '/' 'berlin' '-HD-capped-vn-250.mat'], 'minX', 'minY', 'maxX', 'maxY' );
A(1,1:4) = [minX, minY, maxX, maxY];
load( [ 'scenarios/' 'london' '/' 'london' '-HD-capped-vn-250.mat'], 'minX', 'minY', 'maxX', 'maxY' );
A(2,1:4) = [minX, minY, maxX, maxY];
load( [ 'scenarios/' 'manhattan' '/' 'manhattan' '-HD-capped-vn-250.mat'], 'minX', 'minY', 'maxX', 'maxY' );
A(3,1:4) = [minX, minY, maxX, maxY];
%
targetRoadLen = 1.3e5;
utils.plotVhAsAFunctionOfTime_B1ng({'scenarios/berlin', ...
                                    'scenarios/london', ...
                                    'scenarios/manhattan'}, ...
                                    {'berlin', 'london', 'manhattan'}, ...
                                    250:250:1500, [250 , 1500], [0, 8], 'PL-01.1', ...
                                    mapNet, targetRoadLen, A);
%
utils.plotVhAsAFunctionOfTime_B3ng({'scenarios/berlin', ...
                                    'scenarios/manhattan', ...
                                    'scenarios/rome'}, ...
                                   {'berlin', 'manhattan', 'rome'}, ...
                                   250:250:1500, [250 , 1500], [150, 650], ...
                                   'PL-01.3');
%%
utils.plotVhAsAFunctionOfTime_Cng({'scenarios/paris', ...
                                   'scenarios/manhattan'}, ...
                                   {'paris', 'manhattan'}, ...
                                   0.8:0.05:1, [0.8 , 1], [0, 2.2e3], 'PL-02');
    