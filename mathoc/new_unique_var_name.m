function name=new_unique_var_name(prefix)
%
%
global global_var_names

if isempty(global_var_names)
  global_var_names = 0;
end

if ~exist('prefix') || strcmp(prefix,'')
  prefix = 'g_v_';
end

prefix = strrep(prefix,' ','_');

name = sprintf([prefix '_%d'], global_var_names );
global_var_names = global_var_names + 1;

