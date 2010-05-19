function ns = distribute_syns(filename,mstruct, nsyns, tcm, rpm, wm, seed, tcsd,rpmsd,wmsd)
% distribute_syns(filename, mstruct,nsyns)
%
%

if isfield(mstruct,'distribution_weight')
  dw = mstruct(:).distribution_weight;
else
  dw = ones([1 length(mstruct)]);
end

if exist('seed')
  randn('state',seed)
end

if ~exist('tcsd')
  tcsd = 0;
end

if ~exist('rpmsd')
  rpmsd = 0;
end

if ~exist('wmsd')
  wmsd = 0;
end

%e% mstruct = load_morph('morphology_out')
%e% nsyns = 100000

inds = [mstruct(:).ind];
areas = [mstruct(:).area].*dw;

ta = sum(areas);

nareas = areas/ta;

[nareas,ii] = sort(nareas);
sii = ii;
inds = inds(ii);

pspace = cumsum(nareas);

left = [0 pspace(1:(end-1))];
right= pspace;

indcounts = repmat(0,[1 max(inds)+1]);


for i=1:nsyns
  cast = rand(1);
  ii = find(cast>left & cast<right);
  ind = inds(ii);
  indcounts(ind+1) = indcounts(ind+1) + 1;
end

fpr = fopen(filename,'w');

fprintf(fpr,'%d %s\n',nsyns,'unused');

for i=1:length(indcounts)
  ind = i -1;
  for j=1:indcounts(i)
    p = rand(1);
    tt = tcm + tcsd*randn(1);
    rp = rpm + rpmsd*randn(1);
    w = wm + wmsd*randn(1);
    fprintf(fpr,'%d %f %f %f %f\n',ind,p,tt,rp,w);
  end
end

ns = indcounts;

fclose(fpr);
