function [cv,aux] = autoCV(data,varargin)
% [cv, aux] = AUTOCV(DATA,VARARGIN) find a CV in the colorplot in DATA
%
% This function attempts to calculate a CV for a flow cell data set.
%  It isolates the sample from the background using differences in the
%  CVs in each column of DATA and then calculates the background
%  trend and subtracts it.
% It supports the following optional arguments which modify the default
%  behavior.
%
% OPTIONAL ARG          | Default Value
%    marginPct             = 2;
%      After the sample CVs are delineated from the 
%      buffer CVs, pad the region by this percentage before
%      calculating the background.  Two here corresponds to
%      a 200% pad.
%    filename              = 'UNSPECIFIED';
%      Use this as the filename if raw data was passed in and 
%      there is an error.
%    flattenArgs           = {};
%      Arguments to be passed to
%      flattenBackgroundPoly, if it is used to subtract the
%      background.
%    trialSelectionMethod  = 'peak';
%      Specifies the method used to select the trials use for the CV.  
%      'peak' means that the maximum power CV in the sample region, 
%      after background subtract, forms the center of the CV region.
%    aroundPeak            = 10;
%      Number of CVs around the trialSelected for the sample CV to 
%      average to produce the final sample CV.
%    deFlickerData         =  True;
%      Specifies whether to deflicker the data before analysis.  
%      This removes "pops and snaps" in the data before any processing.  
%      Should be mostly harmless for data that doesn't
%      have this kind of noise.
%    deFlickerArgs         =  {};
%      Arguments to pass to the deflicker function, in addition to 
%      the default ones.
%    partitionArgs         = {};
%      Arguments to pass to the function which calculates the sample 
%      and background trials.
%    biasTowardsPre        = 0;
%      Enables biasing towards early CVs in the data set as 
%      background CVs.
%    useSimpleMean         = 0;
%      Disable polynomial background subtraction and simply use 
%      a mean of the background trials as the background to subtract.
%    saveBackground        = 0;
%      Turn this on to save the background CVs, which you might 
%      want to examine to detect long term trends in the data.
%    backgroundDirectory   = './autoBackgrounds/'
%      If you enable background CV saving, this is where they go.
%    autoSignFix           = True;
%      Attempt to automatically flip data that has been inverted 
%      as a consequence of using UEI mode vs non UEI mode.  


defaults.marginPct             = 2;
defaults.filename              = 'UNSPECIFIED';
defaults.flattenArgs           = {};
defaults.trialSelectionMethod  = 'peak';
defaults.aroundPeak            = 10;
defaults.deFlickerData         =  True;
defaults.deFlickerArgs         =  {};
defaults.partitionArgs         = {};
defaults.biasTowardsPre        = 0;
defaults.useSimpleMean         = 0;
defaults.saveBackground        = 0;
defaults.backgroundDirectory   = './autoBackgrounds/'
defaults.autoSignFix           = True;

handle_defaults;

if ischar(data)
  filename = data;
  data     = load(data);
end

if deFlickerData
  data = deFlicker(data,deFlickerArgs{:});
end

edges   = binaryAdjacencyPartitionFast(data,'filenameForWarning',filename,partitionArgs{:});
c       = mean(edges);
w       = abs(diff(edges));
marginW = w*marginPct;

safeMargin = c + [-1 1]*marginW/2;
if ~useSimpleMean
  if ~biasTowardsPre
    flat       = flattenBackgroundPoly(data,'excluded',unique(round(fromTo(safeMargin))),flattenArgs{:});
  else
    befores    = 1:safeMargin(1);
    meanBefore = mean(data(:,befores),2);
    d          = data - repmat(meanBefore,[1 size(data,2)]);
    d          = sqrt(sum(d.^2, 1));
    d          = d - min(d);
    d          = d/max(d);
    %d          = 1-d ;
    excluded   = d;
    flat       = flattenBackgroundPoly(data,'excluded',excluded,flattenArgs{:});
  end
else
  befores    = 1:safeMargin(1);
  flat = repmat(mean(data(:,befores),2),[1 size(data,2)]) - data;
end

if autoSignFix
  check = sign(mean(mean(data,2)));
  if check==-1
    flat = -flat;
  end
    
end

if saveBackground
  if ~exist(backgroundDirectory,'directory')
    mkdir(backgroundDirectory);
  end
  befores    = 1:safeMargin(1);
  meanBefore = mean(data(:,befores),2);

  n = largestBackgroundNumber(backgroundDirectory)+1;
  if strcmp(filename,'UNSPECIFIED')
    bgName = sprintf('bgNumber=%d.txt',n);
  else
    ii = find(filename=='/');
    if ~isempty(ii)
      ii = ii(end);
      bgName = filename((ii+1):end);
    else
      bgName = filename;
    end
    bgName = strrep(bgName,'.txt','');
    bgName = [bgName sprintf('=bgNumber=%d',n) '.txt'];
  end
end

switch trialSelectionMethod
 case 'peak'
  power = sqrt(mean(flat.^2,1));
  [pk,ii] = max(power);
  cvsTrials = ii(1)+[-1 1]*aroundPeak/2;
  cvsTrials(cvsTrials<=0) = 1;
  cvsTrials(cvsTrials>size(flat,2)) = size(flat,2);
  cv = mean(flat(:,fromTo(cvsTrials)),2);
 case 'partition'
  cv = mean(flat(:,fromTo(edges)),2);
 otherwise 
  error(sprintf('Unknown trial selection method %s', trialSelectionMethod));

end

if nargout >= 2
  nn__ = who();
  aux = struct;
  for ni__=1:length(nn__)
    item__=nn__{ni__};
    aux.(item__) = eval([item__ ';']);
  end
end
