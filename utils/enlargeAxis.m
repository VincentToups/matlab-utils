function [xl,yl]=enlargeAxis(varargin)
%
%

defaults.incFactor = .01;
defaults.x = 1;
defaults.y = 1;

handle_defaults;

xl = xlim;
yl = ylim;

dx = diff(xl);
dy = diff(yl);

xl = xl + incFactor*[-dx dx]/2;
yl = yl + incFactor*[-dy dy]/2;

xlim(xl);
ylim(yl);
