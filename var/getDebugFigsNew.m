clf; clear all; close all; clc;

vh = 500;
figure('units','normalized','outerposition',[0 0 1 1])
fprintf('### regular vehicles\n')
load(strcat('regular_',num2str(vh),'.mat'))
xInall = vehiclesAll(:,2)>= boundaryMinX & vehiclesAll(:,2) <= boundaryMaxX;
yInall = vehiclesAll(:,3)>= boundaryMinY & vehiclesAll(:,3) <= boundaryMaxY;
vehicleInall = xInall.*yInall;
[xx,~,cc]=unique(vehiclesAll(logical(vehicleInall),4),'legacy');
output = [xx, accumarray(cc, 1)];
avgVehicleDensity(1) = mean(output(:,2))
hold on; plot(output(:,2),'LineWidth',3)

uniqueIds=unique(vehiclesAll(:,1));
uniqueVehicleLength(1) = length(uniqueIds)

meanSpeed(1) = mean(vehiclesAll(:,5))


fprintf('\n### autonomous vehicles\n')
load(strcat('AV_',num2str(vh),'.mat'))
xInall = vehiclesAll(:,2)>= boundaryMinX & vehiclesAll(:,2) <= boundaryMaxX;
yInall = vehiclesAll(:,3)>= boundaryMinY & vehiclesAll(:,3) <= boundaryMaxY;
vehicleInall = xInall.*yInall;
[xx,~,cc]=unique(vehiclesAll(logical(vehicleInall),4));
output = [xx, accumarray(cc, 1)];
avgVehicleDensity(2) = mean(output(:,2))
hold on; plot(output(:,2),'LineWidth',3)

uniqueIds=unique(vehiclesAll(:,1));
uniqueVehicleLength(2) = length(uniqueIds)

meanSpeed(2) = mean(vehiclesAll(:,5))


fprintf('\n### connected autonomous vehicles\n')
load(strcat('CAV_',num2str(vh),'.mat'))
xInall = vehiclesAll(:,2)>= boundaryMinX & vehiclesAll(:,2) <= boundaryMaxX;
yInall = vehiclesAll(:,3)>= boundaryMinY & vehiclesAll(:,3) <= boundaryMaxY;
vehicleInall = xInall.*yInall;
[xx,~,cc]=unique(vehiclesAll(logical(vehicleInall),4));
output = [xx, accumarray(cc, 1)];
avgVehicleDensity(3) = mean(output(:,2))
hold on; plot(output(:,2),'LineWidth',3)

uniqueIds=unique(vehiclesAll(:,1));
uniqueVehicleLength(3) = length(uniqueIds)

meanSpeed(3) = mean(vehiclesAll(:,5))


fprintf('\n### connected autonomous vehicles with actuated traffic lights\n')
load(strcat('CAVActuated_',num2str(vh),'.mat'))
xInall = vehiclesAll(:,2)>= boundaryMinX & vehiclesAll(:,2) <= boundaryMaxX;
yInall = vehiclesAll(:,3)>= boundaryMinY & vehiclesAll(:,3) <= boundaryMaxY;
vehicleInall = xInall.*yInall;
[xx,~,cc]=unique(vehiclesAll(logical(vehicleInall),4));
output = [xx, accumarray(cc, 1)];
avgVehicleDensity(4) = mean(output(:,2))
hold on; plot(output(:,2),'LineWidth',3)

uniqueIds=unique(vehiclesAll(:,1));
uniqueVehicleLength(4) = length(uniqueIds)

meanSpeed(4) = mean(vehiclesAll(:,5))


legend('Regular','AV','CAV','CAV Actuated Traffic Light')
xlabel('Time (s)')
ylabel('Number of vehicles')
title(['Vehicles per timestep - ' num2str(vh) ' vehicles'])
set(gca,'FontSize',18)

figure('units','normalized','outerposition',[0 0 1 1])
plot(avgVehicleDensity,'-o','LineWidth',3,'MarkerSize',10)
xticks([1 2 3 4])
xtickangle(45)
xticklabels({'Regular','AV','CAV','CAV Actuated Traffic Light'})
xlabel('Vehicle Type')
ylabel('Number of vehicles')
title(['Average Vehicle Density Per Timeslot - ' num2str(vh) ' vehicles'])
set(gca,'FontSize',18)

figure('units','normalized','outerposition',[0 0 1 1])
plot(uniqueVehicleLength,'-o','LineWidth',3,'MarkerSize',10)
xticks([1 2 3 4])
xtickangle(45)
xticklabels({'Regular','AV','CAV','CAV Actuated Traffic Light'})
xlabel('Vehicle Type')
ylabel('Number of vehicles')
title(['Number of vehicles that completed their trip - ' num2str(vh) ' vehicles'])
set(gca,'FontSize',18)

figure('units','normalized','outerposition',[0 0 1 1])
plot(meanSpeed,'-o','LineWidth',3,'MarkerSize',10)
xticks([1 2 3 4])
xtickangle(45)
xticklabels({'Regular','AV','CAV','CAV Actuated Traffic Light'})
title(['Average speed for all vehicles that completed their trip - ' num2str(vh) ' vehicles'])
set(gca,'FontSize',18)
xlabel('Vehicle Type')
ylabel('Speed (m/s)')

savefig(['Fig_' num2str(vh) '.fig'])