function dsevt_drawaxes(ad)
% This is a helper function for the dsevtpicker applet.
%  It handles drawing the axes given an ad object representing
%  the state of the applet.

axes(ad.raster);
dsevt_rast(ad);
set(ad.raster, 'ButtonDownFcn', @dsevt_rastbdf );
axis tight;

axes(ad.model);
dsevt_drawmodel(ad);
set(ad.model, 'XLim', get(ad.raster,'XLim') );
% set(ad.model, 'ButtonDownFcn', @dsevt_modbdf );


