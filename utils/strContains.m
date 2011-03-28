function bool = strContains(s,sOrCell,mode)

if ~exist('mode','var')
  mode = 'all';
end

switch class(sOrCell)
 case class('')
  bool = ~strcmp(strrep(s,sOrCell,''),s);
 case class(cell(0))
  switch mode
   case 'some'
    init = 0;
    folder = @(it,ac) ac || strContains(s,it);
   case 'all'
    init = 1;
    folder = @(it,ac) ac && strContains(s,it);
  end
  bool = foldl(folder, init, sOrCell);
end
