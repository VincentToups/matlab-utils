function smartstim_add_spikes(name, spiketimes)
%
%

for i=1:length(spiketimes)
  hocf(['%s.onset[%s.ntimes]=%d' newline '%s.ntimes = %s.ntimes + 1' newline],...
       name,name,spiketimes(i),name,name);  
end
 
