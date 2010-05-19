function ds = clusteringtods(spikes, labels, name)
%
%
%

dsconstants;

default name='''unnamed''';

try
ds = pdataset(spikes,name);
catch
  try
    ds = dataset(spikes,name);
  catch
    error('create a symbolic link from dataset.m in pattern_tools to pdataset.m')
  end
  error('create a symbolic link from dataset.m in pattern_tools to pdataset.m')
end

ds.segs(1).tchosenindx = 1;
ds.segs(1).tchosen = labels;
ds.segs(1).status = SCHOSEN;

ds = dsgapfcmspikeclus(ds,1);
ds = dsmodel(ds,1);
ds = dsgapemodel(ds,1);

