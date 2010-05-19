function submorph = submorph_re(morph,re)
% SUBMORPH_RE returns the sections in MORPH which match RE
%  RE is a regular expression
%


for i=1:length(morph)
  if regexp(morph(i).name,re)
    if ~exist('submorph')
      submorph = morph(i);
    else
      submorph(length(submorph)+1) = morph(i);
    end
  end
end

if ~exist('submorph')
  submorph = [];
end
