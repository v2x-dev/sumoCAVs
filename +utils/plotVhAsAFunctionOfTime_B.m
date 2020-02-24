function plotVhAsAFunctionOfTime_B(scenarioPath, cityName, maxNoVh, xL, yL, fileName, map, targetRoadLen, O)
    if length(maxNoVh) ~= 3
        error(' The length(maxNoVh) has to be equal to 3');
    end
    
    frameSize = utils.getFrameSize(map, targetRoadLen, 0, O, 1, 1e-1, false);
    
    X = NaN * zeros(36001,9);
    Y = zeros(36001,9);
    cIdx_ = 0;
    for vhKind = {'HD', 'AV', 'CAV'}
        for ll_ = 1:3
            cIdx_ = cIdx_ + 1;
            load( [ scenarioPath '/' cityName '-' cell2mat(vhKind) '-capped-vn-' num2str(maxNoVh(ll_)) '.mat'], 'vehiclesAll' );
            xy_ = countVh(vehiclesAll, O, frameSize);
            X(:,cIdx_) = 0:0.1:3600;
            Y((xy_(:,1) * 10) + 1,cIdx_) = xy_(:,2);
        end
    end
    
    Figure = figure('position',[100 0 16*60 8*60],...
        'paperpositionmode','auto',...
        'InvertHardcopy','off',...
        'Color',[1 1 1]);
    AX = axes('Parent',Figure, ... 
        'YMinorTick','on',...
        'XTick',0:600:3600,... 
        'YTick',0:100:(max(yL)),...
        'YMinorGrid','on',...
        'YGrid','on',...
        'XGrid','on',...
        'LineWidth',0.5,...
        'FontSize',24,...
        'FontName','Times');
    xlim(AX,xL);
    ylim(AX,yL);
    box(AX,'on');
    hold(AX,'all');
    
    CL = [0 0.498039215803146 0; 1.0000 0.4000 0; 1.0000 0.8000 0.4000; 1 0 0; 0 0.498039215803146 0; 0.313725501298904 0.313725501298904 0.313725501298904];
    MRK = {'square','+', 'v'};
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(1,:), 'MarkerSize',8,'Marker',MRK{1},'LineStyle', 'none','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(2,:), 'MarkerSize',8,'Marker',MRK{2},'LineStyle', 'none','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(3,:), 'MarkerSize',8,'Marker',MRK{3},'LineStyle', 'none','LineWidth',1.5);
    
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(end,:), 'MarkerSize',20,'Marker','none','LineStyle', '-.','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(end,:), 'MarkerSize',20,'Marker','none','LineStyle', '--','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(end,:), 'MarkerSize',20,'Marker','none','LineStyle', '-','LineWidth',1.5);
    
    PL = plot(X,Y,...
        'MarkerSize',15,...
        'LineWidth',1);
    
    ls_ = {'-.', '--', '-'};
    set(PL(1),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(2),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(3),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(3)),'LineWidth',1.5);
    
    set(PL(4),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(5),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(6),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(3)),'LineWidth',1.5);
    
    set(PL(7),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(8),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(9),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(3)),'LineWidth',1.5);
    
    xlabel('Time (s)','FontSize',27,'FontName','Times','Interpreter','latex');
    ylabel('No. of Vehicles','FontSize',27,'FontName','Times','Interpreter','latex');
    
    utils.plotTickLatex2D();

    LG = legend(AX,'HD', ...
                   'AV', ...
                   'CAV', ...
                   ['$r = ' num2str(maxNoVh(1)) '$'], ...
                   ['$r = ' num2str(maxNoVh(2)) '$'], ...
                   ['$r = ' num2str(maxNoVh(3)) '$']);
    set(LG,'LineWidth',1, 'Location', 'NorthWest','FontName','Times','FontSize',20,'Interpreter','latex');
    utils.plotsparsemarkers(PL,LG,{MRK{1}, MRK{1}, MRK{1}, MRK{2}, MRK{2}, MRK{2}, MRK{3}, MRK{3}, MRK{3}},50, true, [8,8,8,8,8,8,8,8,8],true);
    LG = legend(AX,'HD', ... % This is bad... But I had to reset the legend...
        'AV', ...
        'CAV', ...
        ['$n = ' num2str(maxNoVh(1)) '$ Hz'], ...
        ['$n = ' num2str(maxNoVh(2)) '$ Hz'], ...
        ['$n = ' num2str(maxNoVh(3)) '$ Hz']);
    
    T = get(gca,'position');
    set(gca,'position',[0.101041666666667 0.13125 0.868749999999999 0.847916666666667]);
    
    set(LG,'position',[0.808585278587472 0.584810239640708 0.156486288706462 0.313541666666667]);

    name = strcat([scenarioPath '/'], fileName, '.eps');
    export_fig(name);
    name = strcat([scenarioPath '/'], fileName, '.pdf');
    export_fig(name);
end

function [output] = countVh(vehiclesAll, O, frameSize)
    xInall = vehiclesAll(:,2)>= O(1)+frameSize & vehiclesAll(:,2) <= O(3)-frameSize;
    yInall = vehiclesAll(:,3)>= O(2)+frameSize & vehiclesAll(:,3) <= O(4)-frameSize;
    vehicleInall = xInall.*yInall;
    [xx,~,cc]=unique(vehiclesAll(logical(vehicleInall),4),'legacy');
    output = [xx, accumarray(cc, 1)];
end
