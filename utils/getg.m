function val = getg(name)
eval(sprintf('global %s;',name));
val = eval([name ';']);

