function enum(varargin)

for i=1:length(varargin)
  evalin('caller',sprintf('%s=%d;',varargin{i},i));
end

