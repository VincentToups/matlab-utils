function [spikes,name] = exp_syn_reader(filename)

fpr = fopen(filename,'r');

line = fgetl(fpr);
[n,rem]= strtok(line);
n = str2num(n);
name = rem;

spikes = [];
for i=1:n
 line = fgetl(fpr);
 [m,rem] = strtok(line);
 [ns,rem] = strtok(rem);
 rem = ['[ ' rem ' ];'];
 v = eval(rem);
 spikes(i,1:length(v)) = v;
end

