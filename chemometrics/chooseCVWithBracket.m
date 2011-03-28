function cv = chooseCVWithBracket(data,bracket,varargin)
%
%

defaults.flattenArgs = {};
defaults.conservativePad = 10;
defaults.meanWidth = 10;

handle_defaults;

if ischar(data)
  data = load(data);
end

sta = bracket(1)-conservativePad;
sto = bracket(1)+conservativePad;

exclude = sta:sto;

flat = flattenBackgroundPoly(data,'exclude',exclude,flattenArgs{:});

outsidePoints = setdiff(1:size(flat,2), exclude);
mags = mean(abs(flat),1);
mags(outsidePoints) = 0;
[mx,ii] = max(mags);
ii = ii(1);
cvInds = [ii-meanWidth/2 ii+meanWidth/2];
cvInds = fromTo([max([1 cvInds(1)])...
                 min([size(flat,2) cvInds(2)])]);
cv = mean( flat(:,cvInds),2);



