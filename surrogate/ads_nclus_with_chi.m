% First a set of candidate event times

potevt = cumsum(rand([1 40])*50); % average 50 ms apart.
potevt = potevt(20:end);
potevt
potevt = [574.36    586.29    600.77    607.50    655.16...
          700.22    710.54    750.28    763.57    775.64...
          807.38    845.24    894.54    927.20    928.63...
          974.18   1018.08   1018.15   1032.42 1073.63   1118.00]- ...
    500;
potevt = potevt(randperm(length(potevt)));
potevt = sort(potevt(1:6));

nclusters = 2:15;
nevtper = 3:4;

ntrials = 10:5:100;

repeat = 10;

resultskl = zeros([length(nclusters) length(ntrials) repeat]);
resultscs = zeros([length(nclusters) length(ntrials) repeat]);
resultscsp = zeros([length(nclusters) length(ntrials) repeat]);

for i=1:length(nclusters)
  nc = nclusters(i);
  ads = build_random_ads(potevt,nc,nevtper);
  for j=1:length(ntrials)
    nt = ntrials(j);
    for k=1:repeat
      disp('[i,j,k]=')
      [i,j,k]
      [oads,w] = ads_produce_sampled_estimate_ads(ads,nt);
      [d,id] = ads_get_word_dist(oads);
      results(i,j,k) = kullback_leibler(d,id);
      [cc,pp] = chi_ps(w);
      resultscs(i,j,k) = cc;
      resultscsp(i,j,k)= pp;
    end
  end
end

resmean = mean(results,3);
resstd = std(results,[],3);

reschmean = mean(resultscs,3);
reschstd = std(resultscs,[],3);

respmean = mean(resultscsp,3);
respstd  = std(resultscsp,[],3);

figure(1);
subplot(2,1,1);
imagesc(ntrials,nclusters,resmean);
title('kl-div');
xlabel('ntrials');
ylabel('nclusters');
subplot(2,1,2);
imagesc(ntrials,nclusters,resstd);
xlabel('ntrials');
ylabel('nclusters');
title('std kl-div');

print -dpng octfigs/ads_nclus_with_chi_kl.png


figure(2);
subplot(2,1,1);
imagesc(ntrials,nclusters,reschmean);
xlabel('ntrials');
ylabel('nclusters');
title('chi2')
subplot(2,1,2);
imagesc(ntrials,nclusters,reschstd);
xlabel('ntrials');
ylabel('nclusters');
title('std chi2')
print -dpng octfigs/ads_nclus_with_chi_chi2.png

figure(3);
subplot(2,1,1);
imagesc(ntrials,nclusters,respmean);
xlabel('ntrials');
ylabel('nclusters');
title('p_0');
subplot(2,1,2);
imagesc(ntrials,nclusters,respstd);
xlabel('ntrials');
ylabel('nclusters');
title('std p_0');
print -dpng octfigs/ads_nclus_with_chi_p0.png


