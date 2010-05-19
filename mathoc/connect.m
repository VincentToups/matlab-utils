function hoc__=connect(n1,p1,n2,p2)
%
%
global hoc__

if strcmp('struct',class(n1))
  if isfield(n1,'name') && ~strcmp(n1.name,'')
    n1 = n1.name;
  else
    in1 = inputname(1);
    if ~strcmp('',in1)
      n1 = in1;
    else
      error('Thing to connnect to must be either a struct with a name slot or something with a name itself or a string.');
    end
  end  
end

if strcmp('struct',class(n2))
  if isfield(n2,'name') && ~strcmp(n2.name,'')
    n2 = n2.name;
  else
    in2 = inputname(3);
    if ~strcmp('',in2)
      n2 = in2;
    else
      error('Thing to connnect to must be either a struct with a name slot or something with a name itself or a string.');
    end
  end
end

hoc__ = [hoc__ newline create_connection(n1,p1,n2,p2) newline];
