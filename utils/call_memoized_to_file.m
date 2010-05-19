function varargout=call_memoized_to_file(filename,f,varargin)
outnames = map(@(x) sprintf('out%d',x),1:nargout);
outcode = ['[' join(outnames,',') ']'];
filename = strrep([filename '.mat'],'.mat.mat','.mat');
ee = exist(filename,'file');

if ee~=2
  eval(sprintf('%s=f(varargin{:});',outcode));
  save(filename, outnames{:});
else
  load(filename);
end

for i=1:length(outnames)
  varargout{i} = eval([outnames{i} ';']);
end

