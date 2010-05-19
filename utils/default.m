function default(varargin)

wb = 1;
wa = 1;
vstr = [varargin{:}];
ii = find(vstr=='=');
vstr = [vstr(1:ii(1)) '1;;;'];
wb = who;
eval(vstr);
wa = who;
v = setdiff(wa,wb);

str = [...
'if ~exist(''%s''),'...
'  %s;,'...
'end'];
str = sprintf(str,v{1},[varargin{:}]);
evalin('caller', str);


        
