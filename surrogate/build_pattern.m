function pattern = build_pattern(varargin)
% PATTERN = BUILD_PATTERN(M1,R1,S1,...,MN,RN,SN)
% Constructs a pattern with the above means, relis
% and standard deviations.

args = cell2mat(varargin);

if mod(length(args),3) ~= 0
  error('Must be n*3 arguments (n an integer)');
end

args = args(:);
args = reshape(args,[3 length(args)/3])'; % get them into m,r,s triplets

for i=1:size(args,1)
  pattern.events(i).m = args(i,1);
  pattern.events(i).r = args(i,2);
  pattern.events(i).s = args(i,3);
end

[nothing,ii] = sort([pattern.events(:).m]);
pattern.events = pattern.events(ii);

