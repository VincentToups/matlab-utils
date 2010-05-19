function name=new_unique_obj_name(prefix)
%
%
global global_obj_names

if isempty(global_obj_names)
  global_obj_names = 0;
end

if ~exist('prefix') || strcmp(prefix,'')
  prefix = 'g_o_';
end

prefix = strrep(prefix,' ','_');

name = sprintf([prefix '_%d'], global_obj_names );
global_obj_names = global_obj_names + 1;

