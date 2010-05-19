function [h,inits]=plotshifted(x,y,shiftperc,varargin)
%
%

vstr = varargs_to_struct(varargin);
if isfield(vstr,'zeroat')
  zeroat = vstr.zeroat;
  vstr = rmfield(vstr,'zeroat');
  varargin = struct_to_varargs(vstr);
else
  zeroat = 0;
end

ss = mean(std(y,1));
shift = shiftperc*ss;
shifts = (0:(size(y,2)-1))*shift;
shifter = repmat(shifts,[size(y,1) 1]);
shifted = y+shifter;
h=plot(x,shifted,varargin{:});
inits = shifted(1,:);
hlines(shifts+zeroat,'LineStyle','--');



