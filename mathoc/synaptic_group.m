function hoc__=synaptic_group(params)
% HOC__=SYNAPTIC_GROUP(PARAMS)
global hoc__

hoc__ = [hoc__ newline create_synaptic_group(params)];

