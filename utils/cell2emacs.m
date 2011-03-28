function s = cell2emacs(cell)


switch class(cell)
 case 'char'
  s = sprintf('"%s"',strrep(cell,'"','\\\\"'));
 case 'double'
  if prod(size(cell))==1
    s = sprintf('%d',cell);
  else
    s = ['(vector'...
         sprintf('%d ', s)...
         ')'];
         