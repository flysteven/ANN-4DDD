%% load data for index
load('diskListSim.mat','diskListSim');

inputList = squeeze(diskListSim(:,3,:));
for i = 1:size(inputList,2)
    inputList(:,i) = (inputList(:,i)-min(inputList(:,i)))/(max(inputList(:,i))-min(inputList(:,i)));
end


%% t65-80nm 15-30db
load('trainedAnn_tilt_t65to85nm_noise30db_30nn.mat','net_tiltx','net_tilty');
bestMatchList = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;


%% evaluate accuracy
tiltListTrue = load('tilt_list.txt');
resid = bestMatchList - tiltListTrue(:,1:2);
figure('Name','Tilt error');
hold on;
plot(resid(:,1));
plot(resid(:,2));
hold off;
figure('Name','Tilt X error');
histogram(resid(:,1),'BinWidth',0.005);
xlim([-0.05,0.05]);
xlabel('Tilt X Error (degree)');
ylabel('Counts');
disp(['Average tilt X error: ', num2str(mean(abs(resid(:,1))))]);
disp(['Std tilt X error: ', num2str(std(resid(:,1)))]);
figure('Name','Tilt Y error');
histogram(resid(:,2),'BinWidth',0.005);
xlim([-0.05,0.05]);
xlabel('Tilt Y Error (degree)');
ylabel('Counts');
disp(['Average tilt Y error: ', num2str(mean(abs(resid(:,2))))]);
disp(['Std tilt Y error: ', num2str(std(resid(:,2)))]);

