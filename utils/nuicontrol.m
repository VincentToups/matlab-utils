function h=nuicontrol(varargin)
% H=NUICONTROL(VARARGIN) just like uicontrol but with normalized units by default
h=uicontrol('units','normalized',varargin{:});
