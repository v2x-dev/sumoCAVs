function plotVhAsAFunctionOfTime_B4(scenarioPath, cityName, maxNoVh, rrProb, xL, yL, fileName, map, targetRoadLen, O)
    frameSize = utils.getFrameSize(map, targetRoadLen, 0, O, 1, 1e-1, false);
    
    X = [];
    Y = [];
    G = [];
    CI = [];
    cIdx_ = 0;
    ee = 0;
    for rrProbVal = [rrProb, 1]
        rrProbVal
        cIdx_ = cIdx_ + 1;
        for ll_ = 1:length(maxNoVh)
            ll_
            try
            ee = ee + 1;
            if rrProbVal ~= 1
                load( [ scenarioPath '/' cityName '-' 'CAV' '-capped-rr-' num2str(rrProbVal) '--vn-' num2str(maxNoVh(ll_)) '.mat'], 'vehiclesAll' );
            else
                load( [ scenarioPath '/' cityName '-' 'CAV' '-capped-vn-' num2str(maxNoVh(ll_)) '.mat'], 'vehiclesAll' );
            end
            vhs = getVh(vehiclesAll, O, frameSize);
            %g = repmat({strcat(num2str(maxNoVh(ll_)),'-',vhKind)},length(vhs),1);
            %G = [ G; g ];
            %Y = [Y; vhs];
            
            %%
            x = vhs;
            SEM = std(x)/sqrt(length(x));               % Standard Error
            ts = tinv([0.025  0.975],length(x)-1);      % T-Score
            CI(cIdx_, ll_, 1:2) = ts*SEM;                      % Confidence Intervals
            %%
                Y(cIdx_, ll_) = mean(vhs);
            catch
                Y(cIdx_, ll_) = NaN;
            end
        end

    end
    for ll_ = 1:length(maxNoVh)
        X = [X, [rrProb, 1]' ];
    end
    
    Figure = figure('position',[100 0 16*60 7*60],...
        'paperpositionmode','auto',...
        'InvertHardcopy','off',...
        'Color',[1 1 1]);
    AX = axes('Parent',Figure, ... 
        'YMinorTick','on',...
        'XTick',[rrProb, 1],... 'YTick',0:100:(max(yL)),...
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
    set(aa(1),'Color',CL(1,:), 'MarkerSize',10,'Marker',MRK{1},'LineStyle', '-.','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(2,:), 'MarkerSize',10,'Marker',MRK{2},'LineStyle', '--','LineWidth',1.5);
    aa = plot([-10 -10], [-10 -10]);
    set(aa(1),'Color',CL(3,:), 'MarkerSize',10,'Marker',MRK{3},'LineStyle', '-','LineWidth',1.5);
        
    PL = plot(X,Y,...
        'MarkerSize',15,...
        'LineWidth',1);
    
%     for ll_ = 1:length(maxNoVh)
%         errorbar(X(:,ll_),Y(:,ll_),CI(:,ll_,1),'Color',[0 0 0],'LineStyle','none','LineWidth',1.5);
%     end
    
    ls_ = {'-.', '--', '-'};
    set(PL(1),'Color',CL(1,:), 'MarkerSize',10,'Marker',MRK{1},'LineStyle', cell2mat(ls_(1)),'LineWidth',1.5);
    set(PL(2),'Color',CL(2,:), 'MarkerSize',10,'Marker',MRK{2},'LineStyle', cell2mat(ls_(2)),'LineWidth',1.5);
    set(PL(3),'Color',CL(3,:), 'MarkerSize',10,'Marker',MRK{3},'LineStyle', cell2mat(ls_(3)),'LineWidth',1.5);
    
    xlabel('Re-Routing Probability','FontSize',27,'FontName','Times','Interpreter','latex');
    ylabel('Avg. Speed (m/s)','FontSize',27,'FontName','Times','Interpreter','latex');
    
    utils.plotTickLatex2D();

    LG = legend(AX,'250', ...
                   '750', ...
                   '1250');
    set(LG,'LineWidth',1, 'Location', 'NorthWest','FontName','Times','FontSize',20,'Interpreter','latex');
    T = get(gca,'position');
    set(gca,'position',[0.059375 0.135416666666667 0.914583333333333 0.841666666666667]);
    
    set(LG,'position',[0.0645833333333327 0.806249999999999 0.086689853668213 0.160416666666667]);

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
