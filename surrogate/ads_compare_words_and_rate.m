% First a set of candidate event times

build = 1;
buildname = 'isi_evt_test_data';
if build

    isok = @(x) ~isnan(x) & ~isinf(x);
  
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

    ds = {};
    ids = {};

    rds = {};
    irds = {};

    withins_words = [];
    betweens_words = [];
    nullwithins_words = [];

    withins_rates = [];
    betweens_rates = [];
    nullwithins_rates = [];
    
    withins_words_stds = [];
    betweens_words_stds = [];
    nullwithins_words_stds = [];

    withins_rates_stds = [];
    betweens_rates_stds = [];
    nullwithins_rates_stds = [];

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
          [rd,ird] = ads_get_count_dist(oads);
          ds{i,j,k} = d;
          ids{i,j,k} = id;
          rds{i,j,k} = rd;
          irds{i,j,k} = ird; 
        end
        twithins_words = f_for_pairs({ds{i,j,:}},{ds{i,j,:}},@kullback_leibler);
        tbetweens_words = f_for_pairs({ds{i,j,:}},{ids{i,j,:}},@kullback_leibler);
        tnullwithins_words = f_for_pairs({ids{i,j,:}},{ids{i,j,:}},@kullback_leibler);
        inds = find(triu(~eye(k)));
        withins_words(i,j) = mean(boolfilter(twithins_words(inds),isok));
        betweens_words(i,j) = mean(boolfilter(tbetweens_words(inds),isok));
        nullwithins_words(i,j) = mean(boolfilter(tnullwithins_words(inds),isok));
        
        withins_words_stds(i,j) = std(boolfilter(twithins_words(inds),isok));
        betweens_words_stds(i,j) = std(boolfilter(tbetweens_words(inds),isok));
        nullwithins_words_stds(i,j) = std(boolfilter(tnullwithins_words(inds),isok));

        twithins_rates = f_for_pairs({rds{i,j,:}},{rds{i,j,:}},@kullback_leibler);
        tbetweens_rates = f_for_pairs({rds{i,j,:}},{irds{i,j,:}},@kullback_leibler);
        tnullwithins_rates = f_for_pairs({irds{i,j,:}},{irds{i,j,:}},@kullback_leibler);
        inrds = find(triu(~eye(k)));
        withins_rates(i,j) = mean(boolfilter(twithins_rates(inrds),isok));
        betweens_rates(i,j) = mean(boolfilter(tbetweens_rates(inds),isok));
        nullwithins_rates(i,j) = mean(boolfilter(tnullwithins_rates(inds),isok));
        
        withins_rates_stds(i,j) = std(boolfilter(twithins_rates(inrds),isok));
        betweens_rates_stds(i,j) = std(boolfilter(tbetweens_rates(inds),isok));
        nullwithins_rates_stds(i,j) = std(boolfilter(tnullwithins_rates(inds),isok));
      end
    end
    save(buildname);
else
    load(buildname);
end

close all
figure(1);
subplot(2,2,1);
imagesc(ntrials,nclusters,withins_words);
colorbar
xlabel('ntrials')
ylabel('nclusters');
title('within drawn data');

subplot(2,2,2);
imagesc(ntrials,nclusters,betweens_words);
colorbar
xlabel('ntrials')
ylabel('nclusters');
title('between drawn and nulls');

subplot(2,2,3);
imagesc(ntrials,nclusters,nullwithins_words);
colorbar
xlabel('ntrials')
ylabel('nclusters');
title('between nulls only');

subplot(2,2,4);
imagesc(ntrials,nclusters,betweens_words./(nullwithins_words+withins_words));
colorbar
xlabel('ntrials')
ylabel('nclusters');
title('between./(nullwithins+withins)');

vprint('ads_compare_words_and_rates_words');


figure(2);
subplot(2,2,1);
imagesc(ntrials,nclusters,withins_rates);
colorbar
xlabel('ntrials')
ylabel('nclusters');
title('within drawn data');

subplot(2,2,2);
imagesc(ntrials,nclusters,betweens_rates);
colorbar
xlabel('ntrials')
ylabel('nclusters');
title('between drawn and nulls');

subplot(2,2,3);
imagesc(ntrials,nclusters,nullwithins_rates);
colorbar
xlabel('ntrials')
ylabel('nclusters');
title('between nulls only');

subplot(2,2,4);
imagesc(ntrials,nclusters,betweens_rates./(nullwithins_rates+withins_rates));
colorbar
xlabel('ntrials')
ylabel('nclusters');
title('between./(nullwithins+withins)');

vprint('ads_compare_words_and_rates_rates');

