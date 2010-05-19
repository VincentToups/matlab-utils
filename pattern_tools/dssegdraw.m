function dssegdraw(ds)
% DSSEGDRAW draws a rastergram of segmented DATASET
%
% DSSEGDRAW(DS) draws the rastergram of DS's data with lines indicating the
% current segmentation.  This draws to the current axis, respecting the
% state of the hold variable.
%
% See also DSRAST, RAST
%

rast(ds.dataset, [],[],'fast');
xx = [ds.segtimes; ds.segtimes];
yy = repmat(get(gca,'YLim')', [1 size(xx,2)]);
line(xx,yy,'Color',[0 0 1]);



