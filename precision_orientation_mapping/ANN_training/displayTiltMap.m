function displayTiltMap(tiltList)
tiltXMap = reshape(tiltList(:,1),[50,50]);
figure('Name','Tilt X');
imagesc(tiltXMap');
axis equal;
axis off;
c = colorbar;
c.Label.String = 'Tilt X (deg)';

tiltYMap = reshape(tiltList(:,2),[50,50]);
figure('Name','Tilt Y');
imagesc(tiltYMap');
axis equal;
axis off;
c = colorbar;
c.Label.String = 'Tilt Y (deg)';

vfcolor(tiltXMap', tiltYMap', 0.3);
