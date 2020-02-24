function plotVhAsAFunctionOfTime_C1(scenarioPath, cityName, insertionRate, xL, yL, fileName)
    X = [];
    Y = [];
    for vhKind = {'HD', 'AV', 'CAV'}
        X = [ X, insertionRate' ];
        for ll_ = 1:length(insertionRate)
            load( [ scenarioPath '/' cityName '-' cell2mat(vhKind) '-uncapped-irA-' num2str(insertionRate(ll_)) '.mat'], 'simulationSummaryA' );
            Y = [ Y, simulationSummaryA.avgRouteLength ];
        end
    end
    Y = reshape(Y,[length(insertionRate),3]);
    
    Figure = figure('position',[100 0 16*60 8*60],...
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
    
    set(PL(1),'Color',CL(1,:), 'MarkerSize',10,'Marker','none','LineStyle', '-.','LineWidth',1.5);
    set(PL(2),'Color',CL(2,:), 'MarkerSize',10,'Marker','none','LineStyle', '--','LineWidth',1.5);
    set(PL(3),'Color',CL(3,:), 'MarkerSize',10,'Marker','none','LineStyle', '-','LineWidth',1.5);
    
    xlabel('Insertion Rate (Hz)','FontSize',27,'FontName','Times','Interpreter','latex');
    ylabel('Maximum No. of Vehicles','FontSize',27,'FontName','Times','Interpreter','latex');
    
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
    set(gca,'position',[0.103125 0.133333333333333 0.890625 0.845833333333333]);
    
    set(LG,'position',[0.902083379526933 0.808333333333334 0.0866898536682128 0.160416666666667]);

    name = strcat([scenarioPath '/'], fileName, '.eps');
    export_fig(name);
    name = strcat([scenarioPath '/'], fileName, '.pdf');
    export_fig(name);
end

function [output] = countVh(vehiclesAll)
    [xx,~,cc]=unique(vehiclesAll(:,4),'legacy');
    output = [xx, accumarray(cc, 1)];
end
