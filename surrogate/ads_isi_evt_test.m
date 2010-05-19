build = 1;
buildname = 'ads_isi_evt_test';
if build

  pa1 = build_pattern(10,.2,3,40,.9,3,90,.9,3);
  pa2 = build_pattern(10,.9,3,60,.6,3,120,.9,3);

  ads = build_abstract_data_set(1,pa1,1,pa2);

  xinds = 10:2:100;
  repeats = 100;
  space = logspace(log10(.01),log10(.9),30);
  dt = 2;
  min = 4;
  filtn = 1;
  best = [];
  for i=1:length(xinds);
    xind = xinds(i);
    for j=1:repeats
      [i,j]
      [spikes,naught,wordrast] = ads_full_draw(ads,xind);
      resspace = [];
      for k=1:length(space)
        thresh = space(k);
        evt = extract_events_isi_2(spikes,thresh,filtn,dt,5);
        if isempty(evt)
          resspace = [ resspace 0 ];
        else
          evwordrast = isi_events_to_lrast(spikes,evt);
  %        evwordrast(evwordrast>0)
  %        wordrast(wordrast>0)
          resspace = [ resspace classdist(evwordrast(evwordrast>0),wordrast(wordrast>0))];
        end
      end
      mx = max(resspace);
      best(i,j) = mx(1);
    end
  end

  save(buildname);

else
  load(buildname);
end

best = mean(best, 2);
plot(xind,best);
xlabel('ntrials');
ylabel('mutinf');
vprint('isi_evt_test');



