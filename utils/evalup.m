function v=evalup(howfar, expr)
%
%

howfar
disp(expr)


if howfar==0
  try
    v=evalin('caller',expr);
  catch
    evalin('caller',expr);
  end
else
  str = sprintf('evalin(''caller'',''%s'')',expr);
  disp('here we are')
  for i=1:howfar
    disp(i)
    str = sprintf('evalin(''caller'',''%s'')',protect_quotes(str));
  end
  str = [str ';'];
  disp(str);
  try
    v=eval(str);
  catch
    eval(str);
  end
end

