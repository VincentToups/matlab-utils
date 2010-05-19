function emacs_call_return(expr,rsym)
evalin('base','ans=[]');
evalin('base',expr);
r = evalin('base','ans');
str = sprintf('(setq %s "%s")',rsym,to_emacs_string(r));
str
emacs_eval(str);
