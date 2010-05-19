function sp = spikes_to_psd(spikes, w)
%

x = spikes(spikes>0);

tf = max(x)+5;

%f = inline(sprintf('exp( -(m-t).^2/(%f).^2 )',w),'t','m');
%t = linspace(0,tf,tf/w);
%t = repmat(t',[1 length(x)]);
%x = repmat(x',[size(t,1) 1]);

%vs = f(t,x)
%vs = repmat(0,size(t));
%for i=1:length(x)
%  vs = vs + f(t,repmat(x(i),size(t)));
%end

vs = hist(x,0:w:tf);
t = linspace(0,tf,tf/w);

h = spectrum.mtm;
fs = 1000/(mean(diff(t)));
sp = psd(h,vs,'Fs',fs);
