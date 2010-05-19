function hoc__=init_hoc( )
% HOC=INIT_HOC( )
%
%

global hoc__
global hoc_cleanup_files__
global hoc_mathoc_hoc_files__

if isempty(hoc_mathoc_hoc_files__)
  w = which('init_hoc');
  ii = find(w=='/');
  d = w(1:ii(end));
  hoc_mathoc_hoc_files__ = dircat(d,'basic_hocs');
end

reset_unique_section_names();
reset_unique_object_names();
clear_sections();
cleanup_temp_files();
hoc_cleanup_files__ = {};

hoc__ = '';
hoc('load_file("noload.hoc")');
