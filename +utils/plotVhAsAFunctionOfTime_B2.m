function plotVhAsAFunctionOfTime_B2(scenarioPath, cityName, maxNoVh, xL, yL, fileName)
    X = [];
    Y = [];
    G = [];
    cIdx_ = 0;
    for vhKind = {'HD', 'AV', 'CAV'}
        cIdx_ = cIdx_ + 1;
        for ll_ = 1:length(maxNoVh)
            ll_
            load( [ scenarioPath '/' cityName '-' cell2mat(vhKind) '-capped-vnA-' num2str(maxNoVh(ll_)) '.mat'], 'simulationSummaryA' );
            %vhs = getVh(vehiclesAll, O, frameSize);
            %g = repmat({strcat(num2str(maxNoVh(ll_)),'-',vhKind)},length(vhs),1);
            %G = [ G; g ];
            %Y = [Y; vhs];
            simulationSummaryA.avgRouteLength
            Y(ll_,cIdx_) = simulationSummaryA.avgRouteLength;
        end
        X = [X, maxNoVh' ];
    end
    
    Figure = figure('position',[100 0 16*60 8*60],...
        'paperpositionmode','auto',...
        'InvertHardcopy','off',...
        'Color',[1 1 1]);
    AX = axes('Parent',Figure, ... 
        'YMinorTick','on',...
        'XTick',maxNoVh,... 'YTick',0:100:(max(yL)),...
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
    set(aa(1),'Color',CL(1,:), 'MarkerSize',8,'Marker',MRK{1},'LineStyle', '-.','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(2,:), 'MarkerSize',8,'Marker',MRK{2},'LineStyle', '--','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(3,:), 'MarkerSize',8,'Marker',MRK{3},'LineStyle', '-','LineWidth',1.5);
        
    PL = plot(X,Y,...
        'MarkerSize',15,...
        'LineWidth',1);
    
    ls_ = {'-.', '--', '-'};
    set(PL(1),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(2),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(3),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', cell2mat(ls_(3)),'LineWidth',1.5);
    
    xlabel('Max. Number of Vehicles','FontSize',27,'FontName','Times','Interpreter','latex');
    ylabel('Avg. Speed (m/s)','FontSize',27,'FontName','Times','Interpreter','latex');
    
    utils.plotTickLatex2D();

    LG = legend(AX,'HD', ...
                   'AV', ...
                   'CAV');
    set(LG,'LineWidth',1, 'Location', 'NorthWest','FontName','Times','FontSize',20,'Interpreter','latex');
    utils.plotsparsemarkers(PL,LG,{MRK{1}, MRK{2}, MRK{3}},50, true, [8,8,8],true);
    LG = legend(AX,'HD', ... % This is bad... But I had to reset the legend...
        'AV', ...
        'CAV');
    
    T = get(gca,'position');
    set(gca,'position',[0.059375 0.135416666666667 0.914583333333333 0.841666666666667]);
    
    set(LG,'position',[0.882291666666666 0.810416666666666 0.0866898536682128 0.160416666666667]);

    name = strcat([scenarioPath '/'], fileName, '.eps');
    export_fig(name);
    name = strcat([scenarioPath '/'], fileName, '.pdf');
    export_fig(name);
end

function [vhs] = getVh(vehiclesAll, O, frameSize)
    xInall = vehiclesAll(:,2)>= O(1)+frameSize & vehiclesAll(:,2) <= O(3)-frameSize;
    yInall = vehiclesAll(:,3)>= O(2)+frameSize & vehiclesAll(:,3) <= O(4)-frameSize;
    vehicleInall = xInall.*yInall;
    vhs = vehiclesAll(logical(vehicleInall),5);
end
