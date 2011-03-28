function drawChooserApp(appInfo)
unpack appInfo

if isempty(data)
  data = load(files{fileII});
end
axes(distAxis);
hh = imagesc(squareform(pdist(data')));
vlines(startStop,'Color','k','LineWidth',2);
set(distAxis,'ButtonDownFcn',@distAxButtonDown);
set(hh,'ButtonDownFcn',@distAxButtonDown);

flat = flattenBackgroundPoly(data);
axes(bgSubAxis);
imagesc(flat);
vlines(startStop,'Color','k','LineWidth',2);

axes(cvAxis);
cv = mean(flat(:,fromTo(round(startStop))),2);
if isempty(voltage) || length(voltage) ~= size(cv,1);
  voltage = 1:size(cv,1);
end
plot(voltage, cv);
xlabel(files{fileII});


fns = fieldnames(appInfo);
for fi=1:length(fns)
  fn=fns{fi};
  appInfo.(fn) = eval([fn ';']);
end
set(appFig,'UserData',appInfo);
