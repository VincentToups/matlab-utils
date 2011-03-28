function [cv,cvs,aux] = autoCVInVivo(dataOrName,varargin)
%
%

defaults.filename          = 'UNSPECIFIED';
defaults.meanF             = @(x) median(x);
defaults.stdF              = @(x) sqrt(median((median(x)-x).^2));
defaults.initialEstimateF  = @(data) 1:size(data,2);
defaults.maxIt             = 30;
defaults.convCritF         = @(old,new,data) length(absSetDiff(old,new))<round(.02*size(data,2));
defaults.sigmaF            = 3;
defaults.warnOnConvFail    = 1;
defaults.useMean           = 1;
defaults.maxReturnedCvs    = 5;
defaults.avoidWidth        = 20;
defaults.meanWidth         = 10;
defaults.flattenArgs       = {};
defaults.alsoReturn        = {};
defaults.minCVThresh       = 1; %uA
defaults.deFlickerData     = True;
defaults.deFlickerArgs     = {};
defaults.warnIfNoneFound   = True;
defaults.saveBackgrounds   = False;
defaults.saveBackgroundsFolder = './inVivoBackgrounds/';
defaults.saveNonConvergentBg = False;

handle_defaults;

done = 0;
it = 0;
if ischar(dataOrName)
  filename = dataOrName;
  data = load(dataOrName);
end

if deFlickerData
  data = deFlicker(data,deFlickerArgs{:});
end

bgII = initialEstimateF(data)

while ~done
  mBg = mean(data(:,bgII),2);
  sub = data - repmat(mBg,[1 size(data,2)]);
  pow = mean(sub.^2,1);
  mEst = meanF(pow);
  sEst = stdF(pow);
  oldBgII = bgII;
  bgII = find(abs(pow-mEst) < sigmaF*sEst);
  if it > maxIt || convCritF(oldBgII,bgII,data)
    done = 1;
  end
  it = it + 1;
  
  
end

converged = convCritF(oldBgII,bgII,data);

if ~converged && warnOnConvFail
  warning(sprintf('autoCVInVivo didn''t converge on %s.', filename));
end

bg = mean(data(:,bgII),2);
if useMean

  flat = repmat(bg,[1 size(data,2)])-data;
else
  excluded = setdiff(1:size(data,2), bgII);
  flat = flattenBackgroundPoly(data,'excluded',excluded,flattenArgs{:});
end

if saveBackgrounds
  if ~exist(saveBackgroundsFolder,'dir')
    mkdir(saveBackgroundsFolder);
  end
  switch filename
   case 'UNSPECIFIED'
    ofn = dircat(saveBackgroundsFolder,sprintf('bgNumber=%d.txt',largestBackgroundNumber(saveBackgroundsFolder)+1));
    ofn = ofn(1:(end-1));
   otherwise 
    ii = find(filename=='/');
    if ~isempty(ii)
      ii = ii(end);
      ofn = filename((ii+1):end);
    else
      ofn = filename;
    end
    ofn = strrep(ofn,'.txt','');
    ofn = [ofn sprintf('=bgNumber=%d.txt',largestBackgroundNumber(saveBackgroundsFolder)+1)];
    ofn = dircat(saveBackgroundsFolder,ofn);
    ofn = ofn(1:(end-1));
  end
  
  if converged || saveNonConvergentBg
    save(ofn,'-ascii','bg');
  end
  
end

pow = sqrt(sum(flat.^2,1));
pow = dumbfilteruntil(pow,maxReturnedCvs);

candidates = findpeaks(pow);
candidates = candidates.loc;
[powsAt,ii] = sort(pow(candidates),'descend');
candidates = candidates(ii);

cvs = [];
choicePoints = [];
while ~isempty(candidates)
  candidates
  inds = fromTo(candidates(1)-round(meanWidth/2), candidates(1)+round(meanWidth/2));
  inds(inds<1) = [];
  inds(inds>size(data,2)) = [];
  cv = mean(flat(:,inds),2);
  if max(abs(cv)) > minCVThresh
    cvs = [ cvs  cv];
  end
  remove = fromTo(candidates(1)-round(avoidWidth/2), candidates(1)+round(avoidWidth/2));
  choicePoints = [choicePoints candidates(1)];
  candidates = setdiff(candidates,remove);
end
if ~isempty(cvs)
  cv = cvs(:,1);
else
  if warnIfNoneFound
    warning(sprintf('No cvs found for %s',filename));
  end
  cv = [];
end

names = {};
if ischar(alsoReturn) && strcmp(alsoReturn,'all')
  names = who;
else
  names = alsoReturn;
end

if nargout == 3 && ~isempty(names);
  aux = struct;
  for ni=1:length(names)
    name=names{ni};
    aux.(name) = eval([name ';']);
  end
end
