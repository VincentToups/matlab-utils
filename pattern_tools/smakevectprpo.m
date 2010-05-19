function vect=smakevectprpo(spikes, svw)
% SMAKEVECTPRPO makes sorting vectors out of spikes.
%
% VECT=SMAKEVECTPRPO(SPIKES,SVW) returns vectors for the spikes in spikes
%  given the vector weights in svw, a 1x2 matrix of values between 0,1.
%
% This function is a drop in function for creating vectors for spike clustering
%  with FCM.
%
% See also DATASEG for how to plug in your own function for creating
%  vectors to sort spikes.

% try
spikes = spikes(:,:,1);

spr = abs([spikes(:,2:end) 2*spikes(:,end)] - spikes);
spo = abs(spikes - [2*spikes(:,1) spikes(:,1:end-1)]);

si = find(spikes>0);

vect = [spikes(si) spr(si) spo(si)];

if size(vect,1) > 1
    norm = repmat(sum(vect), [size(vect,1) 1]);
    vect = (vect./norm).*(repmat([1 svw], [size(vect,1) 1]));
else
    vect = vect;
end

% catch
%     keyboard
% end




