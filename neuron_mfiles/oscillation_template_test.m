close all

%poisson oscillation test figures

prefix = 'oscillation_template';


spikes = load([prefix '.spikes']);
template = load([prefix '.template']);

tstop = template(end);

subplot(2,2,1);
pubrast(spikes(1:30,:,:));
xlabel('Time(ms)')
ylabel('Trial')
xlim([0 tstop]);


subplot(2,2,2);
%calculate fano factors
% find counts

nspikes = spikes/tstop;
nbins = 20;
ndt = 1/nbins;
nspikes = nspikes/ndt;
nspikes = ceil(nspikes);
[ii,jj,vv] = find(nspikes);
counts = full(sparse(ii,vv,ones([1 length(vv)])));
m = mean(counts);
s = std(counts);
plot(m,s.*s,'.');
xlabel('Mean');
ylabel('Variance');
title('Fano Ratio');
xl = xlim;
xs = linspace(xl(1),xl(2),200);
hold on;
plot(xs,xs,'LineWidth',2,'Color','k');
hold off;

subplot(2,2,3);

rate = template(1);
freq = template(3);
phase= template(5);
amppct=template(7);

nbperosc = 10;
bw = (1/freq)/nbperosc;
bins = 0:bw:tstop;
binc = bins+(bw/2);

ss = spikes(spikes>0);
[n,x] = hist(ss,binc);

if x~=binc
  error('WHAT!!?')
end

n = n/size(spikes,1);
bw = mean(diff(x));
n = n/bw;
xlim([0 tstop]);

x = x(1:end-nbperosc);
n = n(1:end-nbperosc);

dt = .01;
ns = ceil(tstop/dt);

t = linspace(0,tstop,ns);

plot(x,n,'LineWidth',2,'Color','k');
hold on
plot(t,rate + (amppct*rate)*sin(2*pi*freq*t+phase),'LineWidth',2,'Color','g');
hold off
xlim([0 tstop]);
xlabel('Time(ms)')
ylabel('Rate(ms)');
help legend
legend('Actual','Ideal')

subplot(2,2,4)
plot(n,rate + (amppct*rate)*sin(2*pi*freq*x+phase),'.','LineWidth',2,'Color','g');
hold on;
xl = xlim;
yl = ylim;
xs = xl(1);
ys = yl(1);
xf = xl(2);
yf = yl(2);
xs = linspace(xs,xf,200);
plot(xs,xs,'LineWidth',2,'Color','k');
xlabel('Actual Hz')
ylabel('Ideal Hz')
hold off

vprint('oscillation_template')
