function evaloutloud(str)

disp(str);
evalin('caller',str);
