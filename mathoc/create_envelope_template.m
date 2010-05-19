function [str,name]=create_envelope_template(env_params)
%
%
global hoc_cleanup_files__
if isempty(hoc_cleanup_files__)
  hoc_cleanup_files__ = {};
end

if ~exist('env_params')
  env_params = struct;
end

unpack env_params

env_params

if ~exist('name')
  name = new_unique_obj_name;
end

str = sprintf('objref %s\n',name);

reduced = envelope(:,[1 3])';
reduced = reduced(:)';

str = [str sprintf('%s = new ShapeTemplate()\n', name) newline];
tempfile = tempname_cleaned();
str = [str sprintf('%s.load_segs_from_file("%s")\n', name, tempfile)];
ff = fopen(tempfile,'w');
fprintf(ff,'%d\n', size(envelope,1) );
for ii=1:size(envelope,1)
  fprintf(ff,'%f %f %f\n',envelope(ii,1),envelope(ii,2),envelope(ii,3));
end
fclose(ff);

hoc_cleanup_files__{end+1} = tempfile;

% for ii=1:size(envelope,1)
%   str = [str sprintf('%s.append_seg(%f,%f,%f)',name,envelope(ii,1),envelope(ii,2), envelope(ii,3)) newline];
% end







