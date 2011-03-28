function [models,predicted,aux]=smartPCRegress(ys,xs,varargin)
% [MODELS,PREDICTED,AUX]=SMARTPCREGRESS(YS,XS,VARARGIN) does a PCR
% regression performs a regression on YS and XS.  
% YS is an NxD matrix,
% where N is the number of trials and D is the dimensionality of the
% data.  
% XS is MxD, where M is greater than or equal to N.  The first N
% elements of XS are used to perform the regression, the rest
% constitute data for which there are no Y values.  They are predicted
% and returned in PREDICTED.  The regression models for each dimension
% of Y are returned in MODELS.  AUX holds any other values wished
% returned.

defaults.maxComponents = floor((20/100)*size(xs,2));
defaults.alsoReturn = {'pcX','keepers','refResidual','deltaRes','knownPredicted'};

handle_defaults;

addOnes = @(x) [ones([size(x,1) 1]) x];

nCal = size(ys,1);

[la,ve] = pca(xs);
pcX = (ve'*xs')';
%pcX = [ones([size(pcX,1) 1]) pcX];
size(pcX)
take = max([min([size(pcX,2) maxComponents]) 1])
pcXR = pcX(:,1:take);

% s = std(pcXR,1);
% ii = find(s<1e-4);
% pcXR = pcXR(:,1:(ii(1)-1));

warning off stats:regress:RankDefDesignMat

residual = [];
% size(ys)
% size(pcXR)
% nCal
for yi=1:size(ys,2)
  y = ys(:,yi);
  [b,bint,r,rint,stats] = regressAddOnes(y,pcXR(1:nCal,:));
  yPred = addOnes(pcXR(1:nCal,:))*b;
  residual = sum((yPred(:)-y(:)).^2);
end
refResidual = sum(residual);

deltaRes = [];
for ci=1:size(pcXR,2)
  censored = pcXR;
  censored(:,ci) = [];
  residual = [];
  for yi=1:size(ys,2)
    y = ys(1:nCal,yi);
    [b,bint,r,rint,stats] = regressAddOnes(y,censored(1:nCal,:));
    yPred = addOnes(censored(1:nCal,:))*b;
    residual = sum((yPred(:)-y(:)).^2);
  end
  deltaRes(ci) = sum(residual);
end

keepers = find(deltaRes>refResidual)

pcXRR = pcXR(:,keepers);
predicted = [];
knownPredicted = [];
for yi=1:size(ys,2)
  y = ys(1:nCal,yi);
  [b,bint,r,rint,stats] = regressAddOnes(y,pcXRR(1:nCal,:));
  models(yi) = struct('b',b,...
                      'bint',bint,...
                      'r',r,...
                      'rint',rint,...
                      'stats',stats);
  predicted = [predicted addOnes(pcXRR((nCal+1):end,:))*b];
  knownPredicted = [knownPredicted addOnes(pcXRR(1:nCal,:))*b];
end

warning on stats:regress:RankDefDesignMat

aux = struct;
for ai=1:length(alsoReturn)
  item=alsoReturn{ai};
  aux.(item) = eval([item ';']);
end
