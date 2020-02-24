function plotVhAsAFunctionOfTime_Cng(scenarioPath, cityName, insertionRate, xL, yL, fileName)
    X = [];
    Y = [];
    for city_ = 1:size(cityName, 2)
        for vhKind = {'HD', 'AV', 'CAV'}
            X = [ X, insertionRate' ];
            for ll_ = 1:length(insertionRate)
                load( [ scenarioPath{city_} '/' cityName{city_} '-' cell2mat(vhKind) '-uncapped-ir-' num2str(insertionRate(ll_)) '.mat'], 'vehiclesAll' );
                xy_ = countVh(vehiclesAll);
                Y = [ Y, max(xy_(:,2)) ];
            end
        end
    end
    Y = reshape(Y,[length(insertionRate),6]);
    
    Figure = figure('position',[100 0 16*60 7*60],...
        'paperpositionmode','auto',...
        'InvertHardcopy','off',...
        'Color',[1 1 1]);
    AX = axes('Parent',Figure, ... 
        'YMinorTick','on',...
        'XTick',insertionRate,... 'YTick',0:100:500,...
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
    set(aa(1),'Color',CL(6,:), 'MarkerSize',10,'Marker',MRK{1},'LineStyle', '-.','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(6,:), 'MarkerSize',10,'Marker',MRK{2},'LineStyle', '--','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(6,:), 'MarkerSize',10,'Marker',MRK{3},'LineStyle', '-','LineWidth',1.5);
    
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', '-','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', '-','LineWidth',1.5);
    
    PL = plot(X,Y,...
        'MarkerSize',15,...
        'LineWidth',1);
    
    ls_ = {'-.', '--', '-'};
    set(PL(1),'Color',CL(1,:), 'MarkerSize',10,'Marker',MRK{1},'LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(2),'Color',CL(1,:), 'MarkerSize',10,'Marker',MRK{2},'LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(3),'Color',CL(1,:), 'MarkerSize',10,'Marker',MRK{3},'LineStyle', cell2mat(ls_(3)),'LineWidth',1.5);
    
    set(PL(4),'Color',CL(2,:), 'MarkerSize',10,'Marker',MRK{1},'LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(5),'Color',CL(2,:), 'MarkerSize',10,'Marker',MRK{2},'LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(6),'Color',CL(2,:), 'MarkerSize',10,'Marker',MRK{3},'LineStyle', cell2mat(ls_(3)),'LineWidth',1.5);
    
    xlabel('Insertion Rate (s)','FontSize',27,'FontName','Times','Interpreter','latex');
    ylabel('Maximum No. of Vehicles','FontSize',27,'FontName','Times','Interpreter','latex');
    
    utils.plotTickLatex2D();

    LG = legend(AX,'HD', ...
                   'AV', ...
                   'CAV', 'Paris', 'Manhattan');
    set(LG,'LineWidth',1, 'Location', 'NorthWest','FontName','Times','FontSize',20,'Interpreter','latex');
    
    T = get(gca,'position');
    set(gca,'position',[0.103125 0.133333333333333 0.890625 0.845833333333333]);
    
    set(LG,'position',[0.902083379526933 0.808333333333334 0.0866898536682128 0.160416666666667]);

    name = strcat([scenarioPath{1} '/'], fileName, '.eps');
    export_fig(name);
    name = strcat([scenarioPath{1} '/'], fileName, '.pdf');
    export_fig(name);
end

function [output] = countVh(vehiclesAll)
    [xx,~,cc]=unique(vehiclesAll(:,4),'legacy');
    output = [xx, accumarray(cc, 1)];
end
