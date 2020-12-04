%% prepare data
load('diskListSim.mat','diskListSim');

xx = reshape(squeeze(diskListSim(:,3,:,:)),[43,13005]);
for i = 1:size(xx,2)
    xx(:,i) = awgn(xx(:,i),30,'measured');
    xx(:,i) = (xx(:,i)-min(xx(:,i)))/(max(xx(:,i))-min(xx(:,i)));
end
% xx = xx([31,32,33,41,42,43,51,52,53],:); % 9 disk
% xx = xx([21,22,30,31,32,33,40,41,42,43,44,51,52,53,54,62,63],:); % 17 disk
% xx = xx([20,21,22,23,30,31,32,33,34,40,41,42,43,44,50,51,52,53,54,61,62,...
%          63,64],:); % 23 disk
% xx = xx([11,12,13,14,15,19,20,21,22,23,24,29,30,31,32,33,34,35,39,40,41,...
%          42,43,44,45,49,50,51,52,53,54,55,60,61,62,63,64,65,69,70,71,72,...
%          73],:); % 43 disk
% xx = xx([5,6,7,8,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,28,29,30,...
%          31,32,33,34,35,38,39,40,41,42,43,44,45,46,49,50,51,52,53,54,55,...
%          56,59,60,61,62,63,64,65,66,68,69,70,71,72,73,74,76,77,78,79],:); % 63 disk

tiltx = -0.5:0.02:0.5;
tilty = -0.5:0.02:0.5;
[tiltx,tilty] = meshgrid(tiltx,tilty);
y_tiltx = tiltx(:)';
y_tilty = tilty(:)';
% normalization
y_tiltx = y_tiltx + 0.5;
y_tilty = y_tilty + 0.5;

% size match with 13005 dps
y_tiltx = repmat(y_tiltx,[5,1]);
y_tiltx = y_tiltx(:)';
y_tilty = repmat(y_tilty,[5,1]);
y_tilty = y_tilty(:)';

y_thick = repmat(65:5:85,[1,2601]);
y_thick = (y_thick - 65) / 20; % normalization


%% train neural network
% input: xx: 83x1681
% output: yy: 2x1681
% number of hidden neurons: 30
net_tiltx = fitnet(30,'trainlm');
net_tiltx.divideParam.trainRatio = 0.8;
net_tiltx.divideParam.valRatio = 0.1;
net_tiltx.divideParam.testRatio = 0.1;
% view(net)
net_tiltx = train(net_tiltx,xx,y_tiltx);
% view(net)

net_tilty = fitnet(30,'trainlm');
net_tilty.divideParam.trainRatio = 0.8;
net_tilty.divideParam.valRatio = 0.1;
net_tilty.divideParam.testRatio = 0.1;
% view(net)
net_tilty = train(net_tilty,xx,y_tilty);
% view(net)


%% test neural network on training data
y_tiltx_predict = net_tiltx(xx);
y_tilty_predict = net_tilty(xx);
figure('Name','Tilt error');
hold on;
plot(y_tiltx_predict - y_tiltx);
plot(y_tilty_predict - y_tilty);
hold off;
figure('Name','Tilt X error');
histogram(y_tiltx_predict - y_tiltx);
disp(['Average tilt X error: ', num2str(mean(abs(y_tiltx_predict - y_tiltx)))]);
disp(['Std tilt X error: ', num2str(std(y_tiltx_predict - y_tiltx))]);
figure('Name','Tilt Y error');
histogram(y_tilty_predict - y_tilty);
disp(['Average tilt Y error: ', num2str(mean(abs(y_tilty_predict - y_tilty)))]);
disp(['Std tilt Y error: ', num2str(std(y_tilty_predict - y_tilty))]);
