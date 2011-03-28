function c=distinctColormap(varargin)
%
%

cm = colormap(varargin);
c = distinctiveOrder(cm);
