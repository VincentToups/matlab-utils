function hs = plotAutoCVData(data)
cvs = data.cvs;
unpack data


subplot(2,2,1);
imagesc(removeMean(data,2));

subplot(2,2,2);
imagesc(flat);

subplot(2,2,3);
plot(pow,'LineWidth',2);
vlines(choicePoints);

subplot(2,2,4);
load single
plot(voltage,cvs);

