getCvFiles = @() ddirnames('./cvs/');
mkGetter = @(prop) dsf([],[],prop);
mkMatcher = @(prop,val) @(fn) dsfEq(dsf(fn,[],prop),val);
mkComparitor = @(prop,fun) @(fn) fun(dsf(fn,[],prop))

mkConditionMatcher = @(ph,da,hpo) ...
    fAnd(mkMatcher('samplePh',ph),...
         mkMatcher('sampleDA',da),...
         mkMatcher('sampleHPO',hpo));


ok = fAnd(mkMatcher('outlier',0),...
          mkMatcher('black',0));

phTraining = fAnd(mkMatcher('sampleDA',0),...
                  mkMatcher('sampleHPO',0));
daTraining = fAnd(mkMatcher('sampleHPO',0),...
                  mkMatcher('samplePh',740));
hpoTraining = fAnd(mkMatcher('sampleDA', 0),...
                   mkMatcher('samplePh',740));

fPhTraining = cl(@filt,phTraining);
fHpoTraining = cl(@filt,hpoTraining);
fDaTraining = cl(@filt,daTraining);

training = orF(phTraining,daTraining,hpoTraining);
testing = fNot(training);

okTesting = fAnd(testing, ok);
okTraining = fAnd(training, ok);

scaleCv = @(cv) (cv-min(cv))./max(cv-min(cv));
loadScale = compose(scaleCv,@load);
loadFilesScale = cl(@foldl, @(it,ac) [ac loadScale(it)],[])

normCv = @(x) x./sqrt(x'*x);
loadNorm = compose(normCv,@load);
loadFilesNorm = cl(@foldl, @(it,ac) [ac loadNorm(it)],[])

loadFilesExceeding = @(thresh,files) foldl( @(it,ac) [ac loadWhenExceeds(thresh,it)], [], files);


loadFiles = @(files) foldl(@(it,ac) [ac load(it)],[],files)
loadFiles = cl(@foldl, @(it,ac) [ac load(it)],[])
loadFilesDumbFilter = cl(@foldl, @(it,ac) [ac dumbfilter(load(it)',10)'],[])

maxAbsLoad = compose(@max,@abs,@load);

dag = mkGetter('sampleDA');
hpog = mkGetter('sampleHPO');
phg = mkGetter('samplePh');

plotFiles = decorate(@plot, @(varargin) [{fif(iscell(varargin{1}), @()loadFilesDumbFilter(varargin{1}),@()varargin{1})}...
                    {fif(iscell(varargin{2}), @()loadFilesDumbFilter(varargin{2}),@()varargin{2})}...
                    varargin(3:end)]);
plotMeanFiles = decorate(@plot, @(varargin) [{fif(iscell(varargin{1}), @()mean(loadFilesDumbFilter(varargin{1}),2),@()varargin{1})}...
                    {fif(iscell(varargin{2}), @()mean(loadFilesDumbFilter(varargin{2}),2),@()varargin{2})}...
                    varargin(3:end)]);


groupBy = @(lst,preds) foldl(@(it,ac) [ac {filt(it,lst)}],...
                             {},...
                             preds);
valuesToPreds = @(prop,vals) map(cl(mkMatcher, prop), vals);
uniqueProps = @(prop,files) unique(map(mkGetter(prop), files));

groupByProp = @(prop,files) groupBy(files, valuesToPreds(prop,uniqueProps(prop,files)));
notOutlier = @(x) dsf(x,[],'outlierRank',1)<4;

meanLoadFilt = @(pred,files) mean(loadFiles(filt(pred,files)),2);

matchAll = @(varargin) foldl(...
    @(it,ac)  fAnd(@(fn) dsf(fn,[],it{1},-1)==it{2},ac),...
    @(fn)  1,... 
    cellZip(varargin(1:2:end), varargin(2:2:end)));


matchFromFile = @(varargin) apply(matchAll, dsfPairs(varargin{:}));
