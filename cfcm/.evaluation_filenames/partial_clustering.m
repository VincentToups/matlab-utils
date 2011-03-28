dataSet = '/media/34C46F47C46F0B06/06082010/7.42-tris-COLOR.txt';
nClusters = 2;



data = load(dataSet);
[c,u,p] = myfcm(data',2);
[nn,ii] = max(u);

figure(1);
for i=1:nClusters
  subplot(nClusters,1,i);
  
  subset = data(:,find(ii==i));
  plot(subset);
end

