function hs=xylabel(xlab,ylab)
%
%

if ~exist('ylab')
  ylab = xlab;
end

xlabel(xlab);
ylabel(ylab);


