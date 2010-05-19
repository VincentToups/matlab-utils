function add_to_cleanup_list(varargin)
%
%

global hoc_cleanup_files__

for vi=1:length(varargin)
  item=varargin{vi};
  if ischar(item)
    hoc_cleanup_files__{end+1} = item;
  elseif iscell(item)
    add_to_cleanup_list(item{:});
  end
end
