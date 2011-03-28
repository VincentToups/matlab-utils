















close all
appInfo.distAxis = subplot(2,2,1);
appInfo.bgSubAxis = subplot(2,2,2);
appInfo.cvAxis = subplot(2,1,2);
set(appInfo.cvAxis,'position',[0.1300    0.2290    0.7750    0.2662]);
appInfo.appFig = gcf;
appInfo.startStop = startStop;
appInfo.files = files;
appInfo.newFileNames = {};
appInfo.blackButton = nuicontrol('position',[.024 .024 .159 .059],...
                                 'String','White',...
                                 'CallBack',@blackWhiteCallBack);
appInfo.nextButton = nuicontrol('position', [.194 .024 .159 .059],...
                                'String','Next',...
                                'CallBack',@nextCallBack);

unpack appInfo;
set(gcf,'UserData',appInfo);

