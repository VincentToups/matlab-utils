function pud(varargin)
global dirstack__

if isempty(dirstack__)
  dirstack__ = {};
end
  
args = map(partial(@sprintf,'%s ',1), varargin);
directory = [ args{:} ];

dirstack__ = [{directory} dirstack__];
eval(sprintf('cd %s', directory));
