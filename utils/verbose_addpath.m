function verbose_addpath(path)
%
%

dispf('adding %s', path);
evalin('base',sprintf('addpath(''%s'');',path));

