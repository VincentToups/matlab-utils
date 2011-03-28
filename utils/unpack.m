function unpack(name)

newname_____ = [name '_____'];
evalin('caller',sprintf('%s = %s;',newname_____,name));
stru_____ = evalin('caller',[name ';']);

fn_____ = fieldnames(stru_____);

for fni_____=1:length(fn_____)
  execstr_____ = sprintf('%s=%s.%s;',fn_____{fni_____},newname_____,fn_____{fni_____});

  evalin('caller',execstr_____);
end
