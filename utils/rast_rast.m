function rast_rast(sp,stru,varargin)

if ~exist('stru','var')
  stru = struct;
end

defaults.color = [0 0 0];
defaults.resolution = 1;
defaults.width = 2;

if length(varargin)>0 && mod(length(varargin),2) ~= 0 
  varargin = [stru varargin];
  stru = struct;
end

stru = merge_structs(defaults, stru, varargs_to_struct(varargin));
unpack stru


sp = ceil(sp);
[i,j,v] = find(sp);
mx = max(v)
mx = mx + round(.05*mx);

r = full(sparse(i,v,ones(size(v)),max(i),mx));
imagesc(r);
colormap([1 1 1;
          0 0 0]);
