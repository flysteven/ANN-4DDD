load('diskSeedStack.mat','diskSeedStack');

totDisk = 10000;
shiftRange = 12;

diskShift = shiftRange * (rand([totDisk,2])-0.5)*2;

diskStack = zeros([121,121,totDisk]);

tic
% prepare waitbar
h = waitbar(0,'Please wait...','Name','Randomize disk position',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0);
for iDisk = 1:totDisk
    % update waitbar
    if getappdata(h,'canceling')
        delete(h); % delete waitbar
        return;
    end
    diskStack(:,:,iDisk) = imgaussfilt(diskSeedStack(:,:,randi(size(diskSeedStack,3))),1);
    diskStack(:,:,iDisk) = imtranslate(diskStack(:,:,iDisk),diskShift(iDisk,:));
    diskStack(:,:,iDisk) = awgn(diskStack(:,:,iDisk),15+15*rand(),'measured');
    diskStack(:,:,iDisk) = (diskStack(:,:,iDisk)-min(min(diskStack(:,:,iDisk)))) ./ (max(max(diskStack(:,:,iDisk)))-min(min(diskStack(:,:,iDisk))));
    waitbar(iDisk/totDisk,h,sprintf('%d/%d',iDisk,totDisk));
end
delete(h); % delete waitbar
toc
