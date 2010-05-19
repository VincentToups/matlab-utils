function [hoc__,name,filename]=spike_train_saver(params)
% HOC__=SPIKE_TRAIN_SAVER(PARAMS)
global hoc__

if ~exist('params')
  params = struct;
end
[ststr,name,filename]=create_spike_train_saver(params);
hoc__ = [hoc__ newline ststr];

