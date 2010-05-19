function hoc=create_synaptic_group(name, nsyn, group_name, tau, e, g, cent_rel_soma, width, seed)
% HOC=CREATE_SYNAPTIC_GROUP(NAME, NSYN, GROUP_NAME, TAU, E, G, CENT_REL_SOMA, WIDTH, SEED)
%
% 

template = ['objref __NAME__\n__NAME__ = new SynTypeKeeper()\n'...
	'__NAME__.distribute_synapses_in_sections_prob(__NSYN__, __GROUP_NAME__, __TAU__,__E__,__G__,new DistFromSomaLambda(__CENT_REL_SOMA__, __WIDTH__),__SEED__)\n'];

replacer = @(str) ['__' upper(str) '__'];

template = strrep(template,replacer('name'), name);

template = strrep(template,replacer('nsyn'), num2str(nsyn));

template = strrep(template,replacer('group_name'), group_name);

template = strrep(template,replacer('tau'), num2str(tau));

template = strrep(template,replacer('e'), num2str(e));

template = strrep(template,replacer('g'), num2str(g));

template = strrep(template,replacer('cent_rel_soma'), num2str(cent_rel_soma));

template = strrep(template,replacer('width'), num2str(width));

hoc = strrep(template,replacer('seed'), num2str(seed));







