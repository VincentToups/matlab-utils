function unpack(name)


stru = evalin('caller',[name ';']);

fn = fieldnames(stru);

for fni=1:length(fn)
  execstr = sprintf('%s=%s.%s;',fn{fni},name,fn{fni});

  evalin('caller',execstr);
end
