function [d,isi_lbls,old_lbls,rs]= compare_isi_evt(spikes,isi_event_model,event_model,noise)
%
%
%

%e% spikes = spikes;
%e% isi_event_model = isi_events;
%e% event_model = old_events;
%e% noise = ds.segs(1).noise;


spikes = spikes(:,:,1);

%isi_labels = [];
%isi_times =  [];
%isi_trials = [];
%j_inds = repmat(1:size(spikes,2),[size(spikes,1) 1]);
%trials = repmat((1:size(spikes,1))',[1 size(spikes,2)]);
%size(j_inds)
%isi_js = [];
%nt = size(spikes,1)
%ns = size(spikes,2)
%for ei = 1:length(isi_event_model)
%  e = isi_event_model(ei);
%  ss = section(spikes, e.bracket);
%  ii = find(ss>0);
%  ss = ss(ss>0);
%  ss = ss(:)'; % Make sure we have a colum vector
%  tl = trials(ii);
%  tl = tl(:)';
%  isi_trials = [isi_trials tl];
%  isi_labels = [isi_labels repmat(ei,size(ss))];
%  isi_times = [isi_times ss];
%  js = j_inds(ii);
%  isi_js = [isi_js js(:)']; 
%end
%isi_js;
%isi_reconlbls = full(sparse(isi_trials,isi_js,isi_labels,nt,ns));
%isi_reconspikes=full(sparse(isi_trials,isi_js,isi_times,nt,ns));

isi_lbls = spikes;
nzii = spikes~=0;
set_iis = [];
for ei=1:length(isi_event_model)
  e = isi_event_model(ei);
  ii = spikes >  e.bracket(1) & spikes < e.bracket(2);
  isi_lbls(ii) = ei;
  set_iis = [set_iis find(ii)'];
end
alls = 1:prod(size(spikes));
alls = alls(:);
untouched = setdiff(alls,set_iis);
isi_lbls(untouched) = ei + 1;
isi_lbls = isi_lbls .* nzii;
isi_reconlbls = isi_lbls;
isi_reconspikes = spikes;

if isempty(noise)
  clear noise
  noise.spikes = [];
  noise.trials = [];
end


reconspikes = [];
reconlbls = [];
for ti=1:size(spikes,1)
  jjs = [];
  iis = [];
  vvs = [];
  lls = [];
  for ei = 1:length(event_model.events)
    e = event_model.events(ei);
    tl = e.trials;
    cti = find(tl==ti);
    ss = e.spikes(cti);
    ss = ss(:)';
    vvs = [vvs ss];
    tmp = tl(cti);
    iis = [iis tmp(:)'];
    lls = [lls repmat(ei,size(ss))];
  end  
  tl = noise.trials;
  cti = find(tl==ti);
  ss = noise.spikes(cti);
  ss = ss(:)';
  vvs = [vvs ss];
  lls = [lls repmat(ei+1,size(ss))];
  if isempty(vvs)
    vvs = 0;
  end
  if isempty(lls)
    lls = 0;
  end
  reconspikes = sloppycat(reconspikes,vvs,1);
  reconlbls = sloppycat(reconlbls,lls,1);
end

isi_reconspikes = trimzeros(isi_reconspikes);
reconspikes = trimzeros(reconspikes);
size(isi_reconspikes)
size(reconspikes)

%if not(all(isi_reconspikes==reconspikes))
%  warning('HEY, something is funny here');
%end
final_spikes = [];
final_isil = [];
final_oldl = [];
for ti=1:size(spikes)
  isi = isi_reconspikes(ti,:);
  old = reconspikes(ti,:);
  isil = isi_reconlbls(ti,:);
  oldl = reconlbls(ti,:);
  iiisi = isi>0;
  iiold = old>0;
  outs = [];
  [uu,aa,bb] = unique([isi(iiisi) old(iiold)]);
  was_empty = 0;
  if isempty(uu)
    final_spikes = sloppycat(final_spikes,0,1);
  else
    uu
    final_spikes = sloppycat(final_spikes,uu(:)',1);
  end
  new_isilbls = [];
  new_oldlbls = [];
  if ~isempty(uu)
      for ui=1:length(uu)
        u = uu(ui);
        if any(isi==u) & any(old==u)
          location = find(isi==u);
          if isempty(location)
            new_isilbls(ui) = length(isi_event_model)+1;
          else
            new_isilbls(ui) = isil(location);
          end
          location = find(old==u);
          if isempty(location)
            new_oldlbls(ui) = length(event_model.events)+1
          else
            new_oldlbls(ui) = oldl(location);
          end
        end
      end
  else
    new_oldlbls = 0;
    new_isilbls = 0;
  end
  if isempty(new_oldlbls) | isempty(new_isilbls)
    new_oldlbls = 0;
    new_isilbls = 0;
    final_spikes(ti,:) = 0;
  end
  final_isil = sloppycat(final_isil,new_isilbls(:)',1);
  final_oldl = sloppycat(final_oldl,new_oldlbls(:)',1);
end

reconspikes = final_spikes;
reconlbls = final_oldl;
isi_reconlbls = final_isil;

labels = reconlbls(reconspikes>0);
isi_labels = isi_reconlbls(reconspikes>0);
isi_lbls = isi_labels;
old_lbls = labels;
rs = reconspikes;
d=classdistp(labels,isi_labels);

keyboard
