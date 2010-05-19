function dsevt_figbdf(src,evt)
% DSEVT_FIGBDF(SRC,EVT) is a callback function for the event picker applet

src
ad = get(src, 'UserData')
p = get(src,'CurrentPoint');
pos = get(src,'Position');
p = p./pos(3:4);

disp(pointinpos(p, get(ad.raster,'Position')));
