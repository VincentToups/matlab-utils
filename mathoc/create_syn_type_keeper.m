function [str,name]= create_syn_type_keeper(syntypekeeper)
%
%

if ~exist('syntypekeeper')
  syntypekeeper = struct;
end

seed = 10101;
tau = 3;
nsyn = 1;
list_or_name = {'soma'};
e = 0;
g = 4e-3;
dist_from_soma = 0.0;
width = 30;
seed = 10101;
save_spikes_name = '';

inputfn = fieldnames(syntypekeeper)
for fi=1:length(inputfn)
  eval(sprintf('%s = syntypekeeper.%s;', inputfn{fi}, inputfn{fi}));
end

if ~exist('name')
  name = new_unique_obj_name();
end

str = sprintf('objref %s\n', name);
if strcmp('cell',class(list_or_name))
  ws = 'utils.list( ';
  for i=1:length(list_or_name)
    if i~=length(list_or_name)
      ws = [ws list_or_name{i} ','];
    else
      ws = [ws list_or_name{i}];
    end
  end
  ws = [ws ')'];
else
  ws = list_or_name;
end

if ~isempty(save_spikes_name)
  str = [str sprintf('%s = new SynTypeKeeper("%s")\n',name,save_spikes_name)];
else
  str = [str sprintf('%s = new SynTypeKeeper()\n',name)];
end
name 
ws

str = [str sprintf('%s.distribute_synapses_in_sections_prob(%d, %s, %f, %f, %f, new DistFromSomaLambda(%f,%f), %d)\n',...
                   name,nsyn, ws, tau, e, g, dist_from_soma, width, seed)];

