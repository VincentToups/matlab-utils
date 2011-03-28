function [models,aux]=doPCR(trainingData,otherData,componentChoiceMethod,varargin)
%
%

defaults.auxNames         = {'kept','nKept',};
defaults.subPoints        = 1:length(trainingData(1).data);
defaults.pcrJustTraining  = False;

handle_defaults;

% first get principle components 
%% collect data

%tdata = foldl(@(it,ac) [ac it.data(:)], [], trainingData);
tdata = [];
for i=1:length(trainingData)
  data = trainingData(i).data;
  data = data(:);
  tdata = [tdata data(subPoints)];
end
min(subPoints)
max(subPoints)
size(tdata)
if ~isempty(otherData)
  allData = [tdata otherData(subPoints,:)];
else
  allData = tdata;
end

if ~pcrJustTraining
  [la,ve] = pca(allData');

  % choose components

  kept = componentChoiceMethod(allData,la,ve);
  nKept = length(kept);
else
  [la,ve] = pca(tdata');

  % choose components

  kept = componentChoiceMethod(tdata,la,ve);
  nKept = length(kept);
end
pCoExp = ve'*allData;
reduced = pCoExp(kept,:)';

%keyboard

variables = filt(...
    @(x) ~strcmp('data',x),...
    fieldnames(trainingData));

nTrainingData = length(trainingData);
nVariables = length(variables);

models = struct;

for i=1:nVariables
  var = variables{i};
  known = [];
  components = [];
  for j=1:length(trainingData)
    if ~isempty(trainingData(j).(var))
      known = [known; trainingData(j).(var)];
      components = [components; 1 reduced(j,:)];
    end
  end
  [b,bint,r,rint,stats] = regress(known,components);
  models.(var).b = b;
  models.(var).bint = bint;
  models.(var).r = r;
  models.(var).rint = rint;
  models.(var).stats = stats;
%  keyboard
  for j=1:size(allData,2)
    pred = [1 reduced(j,:)]*b;
    models.(var).predicted(j) = pred;
  end
end

for i=1:length(auxNames)
  aux.(auxNames{i}) = eval([auxNames{i} ';']);
end


