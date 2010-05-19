function p=gcp(a)
% P = GCP() returns current position.
% P = GCP(H) returns position of H

if ~exist('a')
  a = gca;
end

p = get(a,'position');
