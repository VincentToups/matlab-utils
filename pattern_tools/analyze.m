% PATTERN_TOOLS TEST SUITE
% First we generate a surrogate data set.
%
% See the documentation of MTFAKE for details

m = [10 25 30 35 45 50 55];
s = [1  1  1  1  1  1  1 ];
r = [.6 .6 .6 .6 .6 .6 .6];
tc= {1 1 2 1 2 [1 2] 2};
nt= [30 70];

spikes = mtfake(m,s,r,tc,nt);
ds = dataset(spikes(randperm(size(spikes,1)),:),'testsuite');

holder = 1;

% We start my selecting the segments.  This data is short enough
%  to leave unsegmented.

dsmanseg(ds);
set(gcf,'DeleteFcn','holder=0;');

disp('Exit the segment picker to continue');

while holder % This while loop keeps the script from continuing 
    pause(.5); % until the segment picker is closed.
end

disp('Starting to cluster the trials, this will take a while.');

ds = dstrialcluster(ds,1:length(ds.segs));  % Cluster the data

holder = 1;

disp('Starting the dspicker, please click in the lower window')
disp('to select a good clustering.');

dspicker(ds);
set(gcf,'DeleteFcn','holder=0');

disp('Exit the trial picker to continue');

while holder
    pause(.5);
end

ds = dsspikecluster(ds);  % Cluster the spike times

ds = dsautospikechoose(ds); % Pick a tentative spike clustering based on fitness
ds = dsmodel(ds); % Produce a model of the data on a per cluster basis

holder = 1;

disp('Starting the dsevtpicker...');
disp('Please select the correct spike time clustering and event');
disp('identifications.');

dsevtpicker(ds); 

set(gcf,'DeleteFcn','holder=0');

while holder
    pause(.5);
end

% Find significance

ds = dsfindsig(ds);

sethand.dst = ds;

