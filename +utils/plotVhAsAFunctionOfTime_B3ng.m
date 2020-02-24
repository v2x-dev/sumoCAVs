function plotVhAsAFunctionOfTime_B3ng(scenarioPath, cityName, maxNoVh, xL, yL, fileName)
    X = [];
    Y = [];
    cIdx_ = 0;
    for city_ = 1:size(cityName, 2)
        for vhKind = {'HD', 'AV', 'CAV'}
            cIdx_ = cIdx_ + 1;
            for ll_ = 1:length(maxNoVh)
                ll_
                load( [ scenarioPath{city_} '/' cityName{city_} '-' cell2mat(vhKind) '-capped-vnA-' num2str(maxNoVh(ll_)) '.mat'], 'simulationSummaryA' );
                Y(ll_,cIdx_) = simulationSummaryA.Duration;
            end
            X = [X, maxNoVh' ];
        end
    end
    
    Figure = figure('position',[100 0 16*60 7*60],...
        'paperpositionmode','auto',...
        'InvertHardcopy','off',...
        'Color',[1 1 1]);
    AX = axes('Parent',Figure, ... 
        'YMinorTick','on',...
        'XTick',maxNoVh,... 
        'YTick',[150, 200:100:600, 650],...
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
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', '-','LineWidth',1.5);
        
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
    
    set(PL(7),'Color',CL(3,:), 'MarkerSize',10,'Marker',MRK{1},'LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(8),'Color',CL(3,:), 'MarkerSize',10,'Marker',MRK{2},'LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(9),'Color',CL(3,:), 'MarkerSize',10,'Marker',MRK{3},'LineStyle', cell2mat(ls_(3)),'LineWidth',1.5);
    
    xlabel('Max. Number of Vehicles','FontSize',27,'FontName','Times','Interpreter','latex');
    ylabel('Trip Duration (s)','FontSize',27,'FontName','Times','Interpreter','latex');
    
    utils.plotTickLatex2D();

    LG = legend(AX,'HD', ...
                   'AV', ...
                   'CAV', ...
                   'Berlin', 'Manhattan', 'Rome');
    set(LG,'LineWidth',1, 'Location', 'NorthWest','FontName','Times','FontSize',20,'Interpreter','latex');
    
    T = get(gca,'position');
    set(gca,'position',[0.0885416666666667 0.135416666666667 0.885416666666666 0.841666666666667]);
    
    name = strcat([scenarioPath{1} '/'], fileName, '.eps');
    export_fig(name);
    name = strcat([scenarioPath{1} '/'], fileName, '.pdf');
    export_fig(name);
end

function [vhs] = getVh(vehiclesAll, O, frameSize)
    xInall = vehiclesAll(:,2)>= O(1)+frameSize & vehiclesAll(:,2) <= O(3)-frameSize;
    yInall = vehiclesAll(:,3)>= O(2)+frameSize & vehiclesAll(:,3) <= O(4)-frameSize;
    vehicleInall = xInall.*yInall;
    vhs = vehiclesAll(logical(vehicleInall),5);
end
