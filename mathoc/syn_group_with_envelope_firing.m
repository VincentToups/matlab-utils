function hoc__=syn_group_with_envelope_firing(synparams, envelope)

global hoc__

hoc__ = [hoc__ newline create_syn_group_with_envelope_firing(synparams,envelope)];

