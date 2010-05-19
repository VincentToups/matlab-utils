function inst=syndescs_to_lw_synapses(syndescs,generator)
%
%

nm = tempname_cleaned();
fpr = fopen(nm,'w');
n = length(syndescs);
if isfield(syndescs,'tau1')
  syntype = 'Exp2Syn';
else
  syntype = 'ExpSyn';
end
fprintf(fpr,'%s\n',syntype);
fprintf(fpr,'%d\n',n);
for i=1:n
  desc = syndescs(i);
  fprintf(fpr,'%s %d %d %d %d\n',...
          desc.sec,...
          desc.loc,...
          desc.tau,...
          desc.e,...
          desc.g);
end
fclose(fpr);
inst = lw_synapses(nm);
if exist('generator')
  if isstruct(generator)
    hoc_set(inst, 'generator', generator);
  elseif iscell(generator)
    gen_inst = spikes_to_file_generator(generator);
    hoc_set(inst, 'generator', gen_inst);
  else
    error(['syndescs_to_lw_synapses can''t handle a generator of type ' class(generator) '.']);
  end    
end

