










































%rr




experiment = 'DG096';
subExperiments = ...
    {'Saline'...
     'Control_before_saline'...
     'Control_before_SP'...
     'SP_1_5_ul'...
     'SP_2_5_ul'...
     'SP_1_ul'...
     'SP_2_ul'...
     'SP_3_ul'...
     'Saline'...
     'Quinine_30_uM'...
     'Quinine_300_uM'...
     'Control_before_Quinine_30_uM'...
     'Control_after_Quinine_30_uM'...
     'Control_before_Quinine_300_uM'};

preFiltNorm = 1000; % ms

for si=1:length(subExperiments)
  subExperiment=subExperiments{si};
  bandcs = 5:5:450;
  bandws = 9;
  wo2 = bandws/2;
  vs = [];
  histimage = [];
  binc = linspace(0,9,1000);
  binw = mean(diff(binc));
  binc = binc(1:(end-1)) + binw/2;
  runningNormDuration = 1000;
  span = 1;
  for i=1:span:length(bandcs)
    vs(i) = sqrt(loadChannelRunningNormResidualVariance(...
        experiment,subExperiment,14,...
        'calcRunningNormedChannelRippleBandArgs',{...
            'runningNormDuration',runningNormDuration,...
            'calcRippleBandSubsetArgs',{...
                'normByPowerFirst',preFiltNorm,...
                'band',[-wo2 wo2]+bandcs(i)}}));
    data=loadRunningNormedChannelRippleBand(experiment,subExperiment,14,...
                                            'runningNormDuration',runningNormDuration,...
                                            'calcRippleBandSubsetArgs',{...
                                                'normByPowerFirst',preFiltNorm,...
                                                'band',[-wo2 wo2]+bandcs(i)});
    %data = abs(hilbert(data));
    data = abs(data);
    [n,x] = hist(data,binc);
    n = n(1:(end-1));
    histimage = [histimage n(:)];
  end
  %%rplot
  close all
  subplot(2,1,1);
  imagesc(bandcs(1:span:end),x,(histimage));
  colormap(flipud(gray));
  colormap(flipud(gray));
  held(@plot,bandcs(1:span:end),vs,'LineWidth',2);
  set(gca,'ydir','normal');
  set(gca,'LineWidth',2,'FontSize',16);
  ylabel('Post-Norm-Amp/std of.');
  set(gca,'XTickLabel',[]);
  title(sprintf('%s-%s',strrep(experiment,'_',' '),strrep(subExperiment,'_',' ')));
  xl = xlim();
  ylim([0 3.5]);

  subplot(2,1,2);
  ii=find(x>4.5);
  ii = ii(1:(end-1));
  censored = histimage(ii,:);
  jj = find(bandcs<25);
  censored(:,jj) = 0;
  imagesc(bandcs,x(ii),censored);
  colormap(flipud(gray));
  set(gca,'position',[0.1300    0.2737    0.7750    0.2744]);
  set(gca,'ydir','normal');
  set(gca,'LineWidth',2,'FontSize',16);
  ylabel('Post-Norm-Amp.');
  set(gca,'XTickLabel',[]);
  xlim(xl);

  axes('position',[0.1301    0.0686    0.7758    0.1803]);
  ss = sum(censored,1)./length(data);
  plot(bandcs,ss,'LineWidth',2);
  set(gca,'LineWidth',2,'FontSize',16);
  xylabel('Frequency (Hz)','Pct. > 4.5 \sigma');
  xlim(xl);

  vprint('%s-%s-running-norm-std-analysis-%d-ms-power-normed',experiment,subExperiment,runningNormDuration);
  %%rplot

end

%rr
