function [data,aux] = flattenBackgroundPoly(data,varargin)

defaults.excluded            = [85:120];
defaults.polyOrder           = 'adaptive';
defaults.polyRange           = 1:5;
defaults.whiten              = 0;
defaults.useMedian           = 1;
defaults.fSamp               = 10000;
defaults.slowFSamp           = 1/.1;
defaults.auxReturn           = {};
defaults.filterAcrossTrials  = 0;
[b,a]                        = butter(2,500./(defaults.fSamp/2),'low');
defaults.fTrialsBA           = {b a};
defaults.filterAcrossTime    = 0;
[b,a]                        = butter(2,2./(defaults.slowFSamp/2),'low');
defaults.fFtimeBA            = {b a};
handle_defaults;

if filterAcrossTrials
  nTr = size(data,2);
  fdata = filtfilt(fTrialsBA{:},[data data data]')';
  inds = (nTr+1):(2*nTr);
  data = fdata(:,inds);
end

if filterAcrossTime
  data = filtfilt(fTrialsBA{:},data);
end

if whiten
  m = mean(data, 1);
  s = std(data,[],1);
  data = (data-repmat(m,[size(data,1) 1]))./repmat(s,[size(data,1) 1]);
end

if any(notInt(excluded))
  warning('Detected weighted function fit.');
  x = 1:size(data,2);
  y = data;
  ii = find(rand(size(excluded))>excluded);
  x = x(ii);
  y = y(:,ii);
  %fitfun = @(x,y,order) weightedPolyFit(x,y,order,1-excluded);
  fitfun = @polyfit;
else
  %warning('Using hard exclusion.');
  x = setdiff(1:size(data,2), excluded);
  y = data(:,x);
  fitfun = @polyfit;
end
warning off MATLAB:polyfit:RepeatedPointsOrRescale

if ischar(polyOrder)
  score = [];
  result = {};
  
  for i=1:length(polyRange)
    n = polyRange(i);
    cor = y;
    sub = data;
    for row = 1:size(data,1)
      p = fitfun(x, y(row,:),n);
      cor(row,:) = polyval(p,x)-cor(row,:);
      sub(row,:) = polyval(p,1:size(sub,2))-sub(row,:);
    end
%    if any(notInt(excluded))
%      cor = cor.*repmat(1-excluded,[size(cor,1) 1]);
%    end
    score(i) = std(cor(:));
    result{i} = sub;
  end
  
  [v,i] = min(score);
  i = first(i);
  data = result{i};
  chosenOrder = polyRange(i);
else
  sub = data;
  for row = 1:size(data,1)
    p = fitfun(x, y(row,:),polyOrder);
    sub(row,:) = polyval(p,1:size(sub,2))-sub(row,:);
  end
  data = sub;
end

warning on MATLAB:polyfit:RepeatedPointsOrRescale

aux = struct;
for i=1:length(auxReturn)
  s__ = auxReturn{i};
  aux.(s__) = eval([s__ ';']);
end
