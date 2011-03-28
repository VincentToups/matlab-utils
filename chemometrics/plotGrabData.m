function hs=plotGrabData(aux,varargin)
%
%

defaults.titleString = 'grab info';
defaults.voltageFile = 'single.mat';
handle_defaults;


unpack aux;

subplot(2,1,1);
m = mean(data,2);
meanSub = data - repmat(m,[1 size(data,2)]);
imagesc(1:size(meanSub,2),[0 1],flipud(aux.flat));
set(gca,'YDir','normal');
colormap(gray);
vlines(delims,'Color','y','LineStyle','--');
hold on;
plot(uniNorm(aux.fullPower),'r');
plot(uniNorm(aux.splitStat),'k','LineWidth',3);
plot(uniNorm(aux.splitStat),'y','LineWidth',1,'LineStyle','--');
plot(exclude,'w','LineWidth',1,'LineStyle','--');
colorbar

miTr = min(trInds)+2;
maTr = max(trInds)-2;
wTr = maTr - miTr;
%rectangle('position',[miTr .05 wTr .9],'EdgeColor',[1 0 0 ],'LineWidth',2);
xy = rectPatch([miTr .05 wTr .025]);
pTr = patch(xy{:},[1 0 0]);


miBg = min(bgInds)+2;
maBg = max(bgInds)-2;
wBg = maBg - miBg;
%rectangle('position',[miBg .05 wBg .9],'EdgeColor',[0 0 1 ],'LineWidth',2);
xy = rectPatch([miBg .05 wBg .025]);
pBg = patch(xy{:},[0 0 1]);

set([pTr,pBg],'FaceAlpha',.2);

hs = .05:.05:.9;



subplot(2,1,2);
load(voltageFile);
plot(voltage, aux.cv);

xlabel(titleString);
