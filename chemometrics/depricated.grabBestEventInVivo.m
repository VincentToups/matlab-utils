function [cv,aux] = grabBestEventInVivo(filenameOrData,varargin)
%
%

defaults.dispW = 15; % in steps 
defaults.flatArgs = {};
defaults.nTroughs = 6;
defaults.conservativePad = 10;
defaults.nearestTrough = 5;
defaults.meanPad = 10;
defaults.auxNames = {};
defaults.backgroundSubPolicy = 'weighted';
defaults.useMeanOfBg = 0;
defaults.sigParams = [10 .5];
defaults.localDispersionWidth = 30;
handle_defaults;

if ischar(filenameOrData)
  data = load(filenameOrData);
else
  data = filenameOrData;
end

ds = squareform(pdist(data'));
splitStat = map(@(i)localDispersion(ds,localDispersionWidth,i), 1:size(data,2));

done = 0;
delims = [];
cullStat = splitStat;

while not(done)
  %[val,ii] = min(cullStat);
  xmin = findpeaks(-cullStat);
  xminReal = findpeaks(-splitStat);
  xmin = intersect(xmin.loc,xminReal.loc);
  pots = cullStat(xmin);
  [pots,ii] = sort(pots);
  xmin = xmin(ii);
  ii = first(xmin);
  delims = [delims first(ii)];
  censor = [max([1,ii-round(dispW/2)]) min([ii+round(dispW/2),length(cullStat)])];
  censor =  fromTo(censor);
  cullStat(censor) = max(cullStat);
  if length(delims) == nTroughs
    done = 1;
  end
end
power = data - repmat(mean(data,2),[1 size(data,2)]);
power = sqrt(mean((power.^2)));
fullPower = power;

[bgInds, trInds] = selectPairByPower(power, delims);

bgInds = bgInds(1:(end-conservativePad));
switch backgroundSubPolicy
 case 'bgSegOnly'
  exclude = setdiff(5:(size(data,2)-5),bgInds);
  
 case 'inverseSample'
  exclude = trInds;
  
 case 'weighted'
  mBg = mean(data(:,bgInds),2);
  d = data - repmat(mBg,[1 size(data,2)]);
  d = sqrt(sum(d.^2, 1));
  d = d - min(d);
  d = d/max(d);
  d = 1-d ;
  exclude = d;

end
if ~useMeanOfBg
  flat = flattenBackgroundPoly(data,'excluded',exclude);
else
  flat = repmat(mean(data(:,bgInds),2),[1 size(data,2)])-data;
end

sample = flat(:,trInds);
power = sqrt(mean(sample.^2));
[vv,ii] = max(power);
ii = first(ii);
mind = round(ii-meanPad/2);
mand = round(ii+meanPad/2);
mind = max([1 mind]);
mand = min([length(power) mand]);

cv = mean(sample(:,mind:mand),2);

if ischar(auxNames) && strcmp(auxNames,'all')
  auxNames = who;
end
aux=struct;
for ai=1:length(auxNames)
  auxName=auxNames{ai};
  aux.(auxName) = eval([auxName ';']);
end
