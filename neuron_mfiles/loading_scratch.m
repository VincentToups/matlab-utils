names = dir('ff*.spikes')
close all
for ni = 1:length(names)
  name = names(ni).name;
  load(name);
  ii = find(name=='.');
  ii = ii(end);
  name = name(1:(ii-1));
  spikes = eval([name ';']);
  figure(ni);
  subplot(2,1,1);
  pubrast(spikes);
  xlim([0 1300])
  subplot(2,1,2);
  hist(spikes(spikes>0),300);
  xlim([0 1300])
  name = strrep(name,'_','\_');
  title(name);
end


%e% dir('*.syns')

%e% dir('dend_inh_1*')
names = {...
'dend_inh_1_0',...
'dend_inh_1_4',...
'dend_inh_1_8'...
}
%'dend_inh_1_2',...
%'dend_inh_1_3'...
%}
%'dend_inh_1_4',...
%'dend_inh_1_5',...
%'dend_inh_1_6',...
%'dend_inh_1_7',...
%'dend_inh_1_8',...
%'dend_inh_1_9',...
%'dend_inh_1_10',...
%'dend_inh_1_11'...
%}

tspikes = [];
for ni = 1:length(names)
  name = names{ni}
  tspikes = sloppycat(tspikes,load(name),1);
end

close all;
rast(tspikes);

% HMM

name = names{1}
ss = load(name)
rast(ss)

sss = section(ss,60,100);
sss
