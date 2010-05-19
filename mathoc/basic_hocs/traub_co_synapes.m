function traub_co_synapes(varargin)


if length(varargin) &&  strcmp(class(varargin{1}),class(struct))
  stru = varargin{1};
  varargin = varargin(2:end);
else
  stru = struct;
end

defaults = struct;
defaults.correlate.split = 5;
defaults.min_rate = .5;
defaults.max_rate = 1.5;
defaults.min_len = 1;
defaults.max_len = 

stru = merge_structs(defaults, stru, varargs_to_struct(varargin));
unpack stru
