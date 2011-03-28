



























phTrainingFilesII = find(map(trainingPredicate,names));
otherII = find(map(fNot(trainingPredicate), names));

phTrainingFilesII
names = [ names(phTrainingFilesII); names(otherII) ];
data = [data(:,phTrainingFilesII) data(:,otherII) ];

nTr = length(phTrainingFilesII);

xs = data(pts,:)';
ys = data(:,1:nTr)';

[models,predicted,aux,deltas]=itera
