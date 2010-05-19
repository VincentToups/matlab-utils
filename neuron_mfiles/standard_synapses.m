
m = load_morph('morphology_out');



dend1 = submorph_re(m,'a1_*');
dend2 = submorph_re(m,'a2_*');
dend3 = submorph_re(m,'a3_*');
dend4 = submorph_re(m,'a4_*');

soma = submorph_re(m,'soma*');

axon = submorph_re(m,'axon*');

% Create dend syns

%(let ((n 4) (types '("inh" "exc")))
%  (forward-line) (forward-line)
%  (loop for type in types do
%	 (loop for i from 1 to n do
%	    (insert (format "distribute_syns(\"dend_syns_%s_%d\",dend%d, dend_%s_n, %s_tc,%s_rp,%s_w);\n" 
%						type i i type type type type)))))

dend_inh_n = 150;
dend_exc_n = 1000;
soma_exc_n = 1000;
soma_inh_n = 400;

inh_tc = 11;
inh_rp = -80;
inh_w = .001;

exc_tc = 3;
exc_rp = 0;
exc_w = .002;

distribute_syns('dend_syns_inh_1.syns',dend1, dend_inh_n, inh_tc,inh_rp,inh_w);
distribute_syns('dend_syns_inh_2.syns',dend2, dend_inh_n, inh_tc,inh_rp,inh_w);
distribute_syns('dend_syns_inh_3.syns',dend3, dend_inh_n, inh_tc,inh_rp,inh_w);
distribute_syns('dend_syns_inh_4.syns',dend4, dend_inh_n, inh_tc,inh_rp,inh_w);
distribute_syns('dend_syns_exc_1.syns',dend1, dend_exc_n, exc_tc,exc_rp,exc_w);
distribute_syns('dend_syns_exc_2.syns',dend2, dend_exc_n, exc_tc,exc_rp,exc_w);
distribute_syns('dend_syns_exc_3.syns',dend3, dend_exc_n, exc_tc,exc_rp,exc_w);
distribute_syns('dend_syns_exc_4.syns',dend4, dend_exc_n, exc_tc,exc_rp,exc_w);

distribute_syns('soma_exc.syns',soma, soma_exc_n, exc_tc,exc_rp,exc_w);
distribute_syns('soma_inh.syns',soma, soma_inh_n, inh_tc,inh_rp,inh_w);

% Above constitutes the whole of the local synapses
% Now we create the LGN synapses on two branches

ff_exc_n = 250;
distribute_syns('ff_exc_1.syns',dend1, ff_exc_n, exc_tc,exc_rp,exc_w);
distribute_syns('ff_exc_2.syns',dend2, ff_exc_n, exc_tc,exc_rp,exc_w);

% This constitutes the entire set of synapses for these experiments



