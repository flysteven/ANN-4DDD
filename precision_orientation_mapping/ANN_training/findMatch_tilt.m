%% load exp data
load('005_exp_diskList_withcenter.mat','diskList');

inputList = squeeze(diskList(:,3,:));
for i = 1:size(inputList,2)
    inputList(:,i) = (inputList(:,i)-min(inputList(:,i)))/(max(inputList(:,i))-min(inputList(:,i)));
end


%% t65nm
load('trainedAnn_tilt_t65nm_30nn.mat','net_tiltx','net_tilty');
bestMatchList_65 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
displayTiltMap(bestMatchList_65);


%% t70nm
load('trainedAnn_tilt_t70nm_30nn.mat','net_tiltx','net_tilty');
bestMatchList_70 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
displayTiltMap(bestMatchList_70);


%% t75nm
load('trainedAnn_tilt_t75nm_30nn.mat','net_tiltx','net_tilty');
bestMatchList_75 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
displayTiltMap(bestMatchList_75);


%% t80nm
load('trainedAnn_tilt_t80nm_30nn.mat','net_tiltx','net_tilty');
bestMatchList_80 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
displayTiltMap(bestMatchList_80);


%% t80nm 30db
load('trainedAnn_tilt_t80nm_noise30db_30nn.mat','net_tiltx','net_tilty');
bestMatchList_80_noise30 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
displayTiltMap(bestMatchList_80_noise30);


%% t80nm 15-30db
load('trainedAnn_tilt_t80nm_noise15to30db_30nn.mat','net_tiltx','net_tilty');
bestMatchList_80_noise1530 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
displayTiltMap(bestMatchList_80_noise1530);


%% t85nm
load('trainedAnn_tilt_t85nm_30nn.mat','net_tiltx','net_tilty');
bestMatchList_85 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
displayTiltMap(bestMatchList_85);


%% t65-85nm
load('trainedAnn_tilt_t65to85nm_30nn.mat','net_tiltx','net_tilty');
bestMatchList_6585 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
displayTiltMap(bestMatchList_6585);


%% t65-85nm 30db
load('trainedAnn_tilt_t65to85nm_noise30db_30nn.mat','net_tiltx','net_tilty');
tic
bestMatchList_6585_noise30 = [net_tiltx(inputList)', net_tilty(inputList)'] - 0.5;
toc
displayTiltMap(bestMatchList_6585_noise30);
