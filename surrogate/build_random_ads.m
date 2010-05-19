function ads=build_random_ads(potevt,nclusrange,nevtrange, fixed, r, s)
% ADS=BUILD_RANDOM_ADS(POTEVT,NCLUSRANGE,NEVTRANGE) returns a
% random ADS
%
%

if ~exist('fixed')
  fixed = {};
end

if ~exist('s')
  s=3;
end

if ~exist('r')
  r = .9;
end

nclus = nclusrange(randperm(length(nclusrange)));
nclus = nclus(1);

args = {}; % Matlab needs an APPLY function...
for i=1:nclus
  nevt = nevtrange(randperm(length(nevtrange)));
  nevt = nevt(1);
  nevt
  evtm = potevt(randperm(length(potevt)));
  evtm = sort(evtm(1:nevt));
  pargs = {};
  for j=1:nevt
    pargs = [ pargs { evtm(j), r, s } ];
  end
  pargs = [ pargs fixed ];
  args = [args {1, build_pattern(pargs{:})}];
end
args

ads = build_abstract_data_set(args{:});
