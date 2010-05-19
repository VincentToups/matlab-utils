function setg(name,val)
eval(sprintf('global %s;',name));
val = eval(val);
eval(sprintf('%s = val;',name));
