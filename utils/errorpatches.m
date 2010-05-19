function [lh,ph]=errorpatches(x,y,e,varargin)
% ERRORPATCHES(X,Y,E,VARARGIN) plots y vs x with patches indicating error.

stru = varargs_to_struct(varargin);
fns = fieldnames(stru);
fnsl = lower(fns);
ii = find(strcmp(fnsl,'patchprops'));
if ~isempty(ii)
  patchprops = stru.(fns(ii));
  stru = rmfield(stru,fns(ii));
  varargin = struct_to_varargs(stru);
else
  patchprops = {};
end

stru = varargs_to_struct(varargin);
fns = fieldnames(stru);
fnsl = lower(fns);
ii = find(strcmp(fnsl,'patchcolor'));
if ~isempty(ii)
  patchcolor = stru.(fns(ii));
  stru = rmfield(stru,fns(ii));
  varargin = struct_to_varargs(stru);
else
  patchcolor = [.5 .5 .5];
end


holdstate = ishold;
if ~holdstate
  cla;
end

xx = [x(:)' fliplr(x(:)')];
yy = [y(:)'-e(:)' fliplr(y(:)'+e(:)')];

ph = patch(xx,yy,patchcolor);
if ~isempty(patchprops)
  set(ph,patchprops{:});
end
hold on
lh = plot(x,y,varargin{:});
if holdstate
  hold on;
else
  hold off
end


