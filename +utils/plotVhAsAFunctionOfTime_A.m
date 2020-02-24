function plotVhAsAFunctionOfTime_A(scenarioPath, cityName, insertRate, xL, yL, fileName)
    if length(insertRate) ~= 3
        error(' The length(insertRate) has to be equal to 3');
    end
    
    X = [];
    Y = [];
    for vhKind = {'HD', 'AV', 'CAV'}
        for ll_ = 1:3
            load( [ scenarioPath '/' cityName '-' cell2mat(vhKind) '-uncapped-ir-' num2str(insertRate(ll_)) '.mat'], 'vehiclesAll' );
            xy_ = countVh(vehiclesAll);
            X = [ X, xy_(:,1) ];
            Y = [ Y, xy_(:,2) ];
        end
    end
    
    Figure = figure('position',[100 0 16*60 7*60],...
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
    MRK = {'square','o', 'v'};
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(1,:), 'MarkerSize',10,'Marker',MRK{1},'LineStyle', 'none','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(2,:), 'MarkerSize',10,'Marker',MRK{2},'LineStyle', 'none','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(3,:), 'MarkerSize',10,'Marker',MRK{3},'LineStyle', 'none','LineWidth',1.5);
    
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(end,:), 'MarkerSize',20,'Marker','none','LineStyle', ':','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(end,:), 'MarkerSize',20,'Marker','none','LineStyle', '-','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(end,:), 'MarkerSize',20,'Marker','none','LineStyle', '-','LineWidth',4);
    
    PL = plot(X,Y,...
        'MarkerSize',15,...
        'LineWidth',1);
    
    ls_ = {':', '-', '-'};
    set(PL(1),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(2),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(3),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(3)),'LineWidth',4);
    
    set(PL(4),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(5),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(6),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(3)),'LineWidth',4);
    
    set(PL(7),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(8),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(9),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(3)),'LineWidth',4);
    
    xlabel('Time (s)','FontSize',27,'FontName','Times','Interpreter','latex');
    ylabel('No. of Vehicles','FontSize',27,'FontName','Times','Interpreter','latex');
    
    utils.plotTickLatex2D();

    LG = legend(AX,'HD', ...
                   'AV', ...
                   'CAV', ...
                   ['$r = ' num2str(insertRate(1)) '$ s'], ...
                   ['$r = ' num2str(insertRate(2)) '$ s'], ...
                   ['$r = ' num2str(insertRate(3)) '$ s']);
    set(LG,'LineWidth',1, 'Location', 'NorthWest','FontName','Times','FontSize',20,'Interpreter','latex');
    utils.plotsparsemarkers(PL,LG,{MRK{1}, MRK{1}, MRK{1}, MRK{2}, MRK{2}, MRK{2}, MRK{3}, MRK{3}, MRK{3}},20, true, 10 * ones(1,9),true);
    LG = legend(AX,'HD', ... % This is bad... But I had to reset the legend...
        'AV', ...
        'CAV', ...
        ['$r = ' num2str(insertRate(1)) '$ s'], ...
        ['$r = ' num2str(insertRate(2)) '$ s'], ...
        ['$r = ' num2str(insertRate(3)) '$ s']);
    
    T = get(gca,'position');
    set(gca,'position',[0.0864583333333333 0.145238095238095 0.888541666666667 0.828571428571431]);
    
    %set(LG,'position',[0.827823512548073 0.653560239640708 0.138843154118593 0.313541666666667]);

    name = strcat([scenarioPath '/'], fileName, '.eps');
    export_fig(name);
    name = strcat([scenarioPath '/'], fileName, '.pdf');
    export_fig(name);
end

function [output] = countVh(vehiclesAll)
    [xx,~,cc]=unique(vehiclesAll(:,4),'legacy');
    output = [xx, accumarray(cc, 1)];
end
