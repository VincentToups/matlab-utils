function pod
%
%
global dirstack__
if ~isempty(dirstack__)
  sprintf('cd %s', dirstack__{1});
  dirstack__ = dirstack__(2:end);
end
