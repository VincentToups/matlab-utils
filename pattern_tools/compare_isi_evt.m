function [d,isi_lbls,old_lbls,rs]= compare_isi_evt(spikes,isi_event_model,event_model)

isi_lbls = isi_events_to_lrast(spikes,isi_event_model);
old_lbls = old_events_to_lrast(spikes,event_model);

isi_lbls(isnan(isi_lbls)) = max(isi_lbls(:)) + 1;
old_lbls(isnan(old_lbls)) = max(old_lbls(:)) + 1;

isi_lbls = isi_lbls(isi_lbls~=0);
old_lbls = old_lbls(old_lbls~=0);
rs = spikes;
d = classdist(isi_lbls,old_lbls);

