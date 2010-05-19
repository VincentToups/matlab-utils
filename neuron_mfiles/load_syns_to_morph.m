function [morph] = load_syns_to_morph(morph,filename,prefix)
%
%
%

if ~exist('prefix')
  prefix = '';
end



indx = [morph(:).ind];

filename 