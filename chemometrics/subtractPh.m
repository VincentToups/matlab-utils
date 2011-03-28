function [data,names,aux] = subtractPh(data,names,pts,varargin)

queryFunctions
defaults.genArgs = {};
defaults.auxNames = {'oldData','oldNames'};
defaults.trainingPredicate = phTraining;
defaults.smartPCRVar = {};

handle_defaults;

if isempty(data) && isempty(names)
  [data,names] = genDataAndFakeFilenames(genArgs{:});

end

names = names(:);


% notOutlier = fAnd(@(x) dsf(x,[],'newRank')<4,...
%                   @(x) dsf(x,[],'black',0)==0);
% okII = find(map(notOutlier, names));
% names = names(okII);
% data = data(:,okII);

blacks = map(@(x)dsf(x,[],'black',0)==1);
names(blacks) = [];
data(:,blacks) = [];


phTrainingFilesII = find(map(trainingPredicate,names));
otherII = find(map(fNot(trainingPredicate), names));

phTrainingFilesII
names = [ names(phTrainingFilesII); names(otherII) ];
data = [data(:,phTrainingFilesII) data(:,otherII) ];

oldData = data; oldNames = names;

nTr = length(phTrainingFilesII);

xs = data(pts,:)';
ys = data(:,1:nTr)';

[models,predicted,aux,deltas]=iterativeSmartPCR(ys,xs,'showDelta',1,'maxItr', 2,'smartPCRVar',smartPCRVar);
newnames = {};
preds = [];
for ai=1:length(names)
  name=names{ai};
  pred = aux.knownPredicted(ai,:)';
  cv = data(:,ai)-pred;
  preds = [preds pred];
  data(:,ai) = cv;
  %cv(cv<0) = 0;
  newnames{ai} = strrep(name, '.txt', '=phSubtracted=1.txt');
end

names = newnames;

aux = struct;
for ai=1:length(auxNames)
  auxName=auxNames{ai};

  if exist(auxName,'var')
    aux.(auxName) = eval([auxName ';']);
  else
    warning(sprintf('You wanted %s, but it doesn''t exist.',auxName));
  end
end