function r=s_(varargin)
%
%

n = length(varargin);
s = [];
for i=1:length(varargin)
  s = [s ' ' varargin{i}];
end

eval(['!' s]);
