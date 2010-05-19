function ads = build_abstract_data_set(varargin)
% ADS =
% BUILD_ABSTRACT_DATA_SET(p1,pattern1,p2,pattern2,...,pN,patternN)
% Constructs an abstract data set with patterns 1-N each with
% probabilities P 1-N.  The probabilities are normalized so
% that sum([P1 ... PN]) == 1 is true.
% 
% See also BUILD_PATTERN
%

%  NB:  This is a more complicated problem than it 
%  appears.  We need to merge several patterns into 
%  a single description which means each event must
%  have a unique event number, and we have to take
%  care to merge events which are shared between
%  two or more events.

if mod(length(varargin),2)~=0
  error('Number of arguments must be 2*n (n an integer)');
end

args = reshape(varargin(:),[2 length(varargin)/2])';

ms = [];
rs = [];
ss = [];
ads.p = [];
cs = [];
en = [];

% First we collect all event means
% For our purposes event means are simply
% a convenient way of keeping track of
% which events are which.

for i=1:size(args,1)
  ads.p(i) = args{i,1};
  ads.pattern(i) = args{i,2};
  for j=1:length(ads.pattern(i).events)
    ms = [ms ads.pattern(i).events(j).m];
    rs = [rs ads.pattern(i).events(j).r];
    ss = [ss ads.pattern(i).events(j).s];
    cs = [cs i];
  end
end

ads.p = ads.p/sum(ads.p);

% Find all the unique means.
[ums,ii,jj] = unique(ms);
urs = rs(ii);
uss = ss(ii);

% The length of the unique means defines
% the number of events (ne)
ne = length(ums);

ads.pattern(1).merged_indexes = [];

for i=1:ne
  % Here we create an entry for each event, regardless of what
  % patterns appear in it...
  events(i).m = ums(i);
  events(i).s = uss(i);
  for j=1:length(ads.pattern)
    ii = find([ads.pattern(j).events(:).m] == events(i).m);
    % and now we record the reliability for each pattern
    % on the event.  This is the information we need
    % to calculate the word probability.
    if isempty(ii)
      events(i).r(j) = 0;
    else
      events(i).r(j) = ads.pattern(j).events(ii(1)).r;
      ads.pattern(j).merged_indexes = ...
          sort([ads.pattern(j).merged_indexes i]);
                          
    end
  end
end



ads.events = events;

