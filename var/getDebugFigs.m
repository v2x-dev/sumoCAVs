clearvars
close all

vh = 500;
load(strcat('regular_',num2str(vh),'.mat'))
xInall = vehiclesAll(:,2)>= boundaryMinX & vehiclesAll(:,2) <= boundaryMaxX;
yInall = vehiclesAll(:,3)>= boundaryMinY & vehiclesAll(:,3) <= boundaryMaxY;
vehicleInall = xInall.*yInall;
[xx,~,cc]=unique(vehiclesAll(logical(vehicleInall),4));
output = [xx, accumarray(cc, 1)];
mean(output(:,2))
hold on; plot(output(:,2))

load(strcat('AV_',num2str(vh),'.mat'))
xInall = vehiclesAll(:,2)>= boundaryMinX & vehiclesAll(:,2) <= boundaryMaxX;
yInall = vehiclesAll(:,3)>= boundaryMinY & vehiclesAll(:,3) <= boundaryMaxY;
vehicleInall = xInall.*yInall;
[xx,~,cc]=unique(vehiclesAll(logical(vehicleInall),4));
output = [xx, accumarray(cc, 1)];
mean(output(:,2))
hold on; plot(output(:,2))

load(strcat('CAV_',num2str(vh),'.mat'))
xInall = vehiclesAll(:,2)>= boundaryMinX & vehiclesAll(:,2) <= boundaryMaxX;
yInall = vehiclesAll(:,3)>= boundaryMinY & vehiclesAll(:,3) <= boundaryMaxY;
vehicleInall = xInall.*yInall;
[xx,~,cc]=unique(vehiclesAll(logical(vehicleInall),4));
output = [xx, accumarray(cc, 1)];
mean(output(:,2))
hold on; plot(output(:,2))
