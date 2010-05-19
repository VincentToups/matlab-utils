function res=between(f,varargin)
%
%

if length(varargin) == 1
  band = varargin{1};
else length(varargin) == 2
  band = [varargin{1} varargin{2}];
end
res = (f >= band(1) & f <= band(2) );
