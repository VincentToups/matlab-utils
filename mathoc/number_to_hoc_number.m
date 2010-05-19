function str=number_to_hoc_number(nameornum,num)
%
%
%

if nargin == 2
  if length(num) == 1
    str = sprintf('%s = %f',nameornum,num);    
  else
    str = sprintf('objref %s\n %s = new Vector()\n',nameornum,nameornum);    
    tmp = sprintf('%f,',num)
    tmp = tmp(1:(end-1));
    str = [str sprintf('%s.append(', nameornum) tmp ')'];
  end
else
  num = nameornum;
  str = sprintf('%f',num);
end
  
