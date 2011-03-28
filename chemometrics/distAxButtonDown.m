function distAxButtonDown(src,evt)

whichButton  = get(gcf,'SelectionType');
appInfo = get(gcf,'UserData');
unpack appInfo;

pt = get(gca,'CurrentPoint');
x = pt(1,1);
switch whichButton
 case 'normal'
  startStop(1) = x;
 case {'extend','alt'}
  startStop(2) = x; 
end

startStop = sort(startStop);

fns = fieldnames(appInfo);
for fi=1:length(fns)
  fn=fns{fi};
  appInfo.(fn) = eval([fn ';']);
end
set(appFig,'UserData',appInfo);
drawChooserApp(appInfo);
