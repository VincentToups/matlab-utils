function inst=file_list_template(files)
%
%
nm = new_unique_obj_name();
strlist = foldl(@(it,ac) [ac '"' it '"' ','], '', files);
strlist = strlist(1:(end-1));
hocf(['objref %s' newline '%s = new FileListTemplate(utils.strlist(%s))' newline],nm,nm,...
     strlist);
inst.name = nm;
inst.instance = 1;
