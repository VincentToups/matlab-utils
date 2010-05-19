function name=new_unique_section_name(prefix)
%
%
global global_sec_names

if isempty(global_sec_names)
  global_sec_names = 0;
end

if ~exist('prefix') || strcmp(prefix,'')
  prefix = 'g_s_';
end

prefix = strrep(prefix,' ','_');

name = sprintf([prefix '_%d'], global_sec_names );
global_sec_names = global_sec_names + 1;

