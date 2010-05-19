function h=fastrast(dataset)
% FASTRAST simple rastergram plotter which uses fast rendering technique.
% H=FASTRAST(DATASET) is a wrapper for RAST which uses the FAST option by
% default.
%
% See also RAST, DSRAST, DSEGRAST
%

h = rast(dataset, [],[], 'fast');
