function unpack_avoiding_keywords(name)


stru = evalin('caller',[name ';']);

iskw = @(x)any(strcmp(x,{'for','end','if','case','switch','do','while','else'}));

fn = fieldnames(stru);

for fni=1:length(fn)
  if iskw(fn{fni})
    outname = [fn{fni} '__'];
  else
    outname = fn{fni};
  end
  execstr = sprintf('%s=%s.%s;',outname,name,fn{fni});

  evalin('caller',execstr);
end
