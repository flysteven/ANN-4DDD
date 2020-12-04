filePath = 'D:\Renliang\Research\Simulation\Bloch\GaSb_tiltseries\1\';

thickList = 650:50:850;
tiltx = -0.5:0.02:0.5;
tilty = -0.5:0.02:0.5;
[tiltx,tilty] = meshgrid(tiltx,tilty);
tiltList = [tiltx(:),tilty(:)];
vect0 = [257,257];
vectG1 = [223,209]-vect0;
vectG2 = [291,209]-vect0;
searchRange = [15,15];
nList = [3,-3;3,-2;3,-1;3,0;3,1;
         2,-3;2,-2;2,-1;2,0;2,1;2,2;
         1,-3;1,-2;1,-1;1,0;1,1;1,2;1,3;
         0,-3;0,-2;0,-1;0,0;0,1;0,2;0,3;
         -1,-3;-1,-2;-1,-1;-1,0;-1,1;-1,2;-1,3;
         -2,-2;-2,-1;-2,0;-2,1;-2,2;-2,3;
         -3,-1;-3,0;-3,1;-3,2;-3,3];
nThick = size(thickList,2);
nTilt = size(tiltList,1);

tic
% prepare waitbar
h = waitbar(0,'Please wait...','Name','Disk Intensity',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0);
diskListSim = zeros([size(nList,1),3,nThick,nTilt]);
for iTilt = 1:nTilt
    for iThick = 1:nThick
        currFileName = ['GaSb_',sprintf('%.2f',tiltList(iTilt,1)),'_',...
            sprintf('%.2f',tiltList(iTilt,2)),'_t',...
            sprintf('%d',thickList(iThick)),'.img'];
        currImage = imgRead([filePath,currFileName])';
%         figure;
%         imshow(currImage,[0,0.2]);

        for ni = 1:size(nList,1)
            n1i = nList(ni,1);
            n2i = nList(ni,2);
            vectR = vect0 + n1i*vectG1 + n2i*vectG2;
            currTarget = currImage(max(1,round(vectR(2)-searchRange(2))):min(size(currImage,1),round(vectR(2)+searchRange(2))),...
                                   max(1,round(vectR(1)-searchRange(1))):min(size(currImage,2),round(vectR(1)+searchRange(1))));
%             figure;
%             imshow(currTarget,[0,0.2]);
            diskIntensity = sum(sum(currTarget));

            diskListSim(ni,:,iThick,iTilt) = [n1i,n2i,diskIntensity];
        end
    end
    % update waitbar
    if getappdata(h,'canceling')
        delete(h); % delete waitbar
        return;
    end
    waitbar((iThick+(iTilt-1)*nThick)/(nTilt*nThick),...
        h,sprintf('%d/%d',iThick+(iTilt-1)*nThick,nTilt*nThick));
end
delete(h); % delete waitbar
toc
