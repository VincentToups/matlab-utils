function [app]=flowCellDataSampleChooser(olddir,varargin)
%
%

%{

files = {};
startStop = [10 10];

%}

defaults.initialStartStop = [100 120];
defaults.voltage = [];
defaults.newDirectory = './cvs/';

handle_defaults;

files = ddirnames(olddir);

startStop = initialStartStop;
close all
appInfo.distAxis = subplot(2,2,1);
appInfo.bgSubAxis = subplot(2,2,2);
appInfo.cvAxis = subplot(2,1,2);
set(appInfo.cvAxis,'position',[0.1300    0.2290    0.7750    0.2662]);
appInfo.appFig = gcf;
appInfo.startStop = startStop;
appInfo.files = files;
appInfo.fileII = 1;
appInfo.newFileNames = {};
appInfo.voltage = [];
appInfo.data = [];
appInfo.newDirectory = newDirectory;
appInfo.oldDirectory = olddir;
appInfo.currentSetBlack = 0;
appInfo.blackButton = nuicontrol('position',[.024 .024 .159 .059],...
                                 'String','Black',...
                                 'CallBack',@blackWhiteCallBack);
appInfo.nextButton = nuicontrol('position', [.194 .024 .159 .059],...
                                'String','Next',...
                                'CallBack',@nextCallBack);


unpack appInfo;
set(gcf,'UserData',appInfo);

drawChooserApp(appInfo);
app = appInfo;

system(sprintf('mkdir %s',newDirectory));






