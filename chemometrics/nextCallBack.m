function nextCallBack(evt, src)

appInfo = get(gcf,'UserData');
unpack appInfo;
currentSetBlack = 0;
set(blackButton,'String','Black (f)');

name = files{fileII};

newName = strrep(name,oldDirectory,newDirectory);

flattened = flattenBackgroundPoly(data);
nameSanExt = strrep(newName,'.txt','');
newName = [nameSanExt sprintf('=black=%d.txt', appInfo.currentSetBlack)];
save(newName,'-ascii','flattened');
fileII = fileII + 1;
fns = fieldnames(appInfo);
data = load(files{fileII});
for fi=1:length(fns)
  fn=fns{fi};
  appInfo.(fn) = eval([fn ';']);
end
set(appFig,'UserData',appInfo);

axes(distAxis);
cla;
axes(bgSubAxis);
cla;
axes(cvAxis);
cla;

drawChooserApp(appInfo);
