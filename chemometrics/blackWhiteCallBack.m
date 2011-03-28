function blackWhiteCallBack(src,evt)
appInfo = get(gcf,'UserData');
appInfo.currentSetBlack = ~appInfo.currentSetBlack
if appInfo.currentSetBlack
  newStr = sprintf('Black (t)');
else
  newStr = sprintf('Black (f)');
end

set(appInfo.blackButton,'String',...
                  newStr);
set(gcf,'UserData',appInfo);
