function dsmanclus(ds)
% DSMANCLUS currently non-functional manual clusterer.
%
% DSMANCLUS(DS) launches the GUI for the manual cluster picker
%  associated with the pattern_tools toolbox.

ad.ds = ds;
ad.iname = inputname(1);
ad.f = figure;
%% Create buttons

entries = {};
for i=1:ds.nseg
    entries{i} = sprintf('Segment %d: <unchosen>', i);
end

ad.seglist  =   uicontrol(  'Style', 'listbox',...
                            'Units', 'normalized',...
                            'Position', [.75 .70 .25 .30],...
                            'String', entries );
                            
ad.pupb     =   uicontrol(  'Style', 'pushbutton',...
                            'Units', 'normalized',...
                            'Position', [.75 .65 .05 .05],...
                            'String', 'up',...
                            'Enable', 'off' );

ad.pdnb     =   uicontrol(  'Style', 'pushbutton',...
                            'Units', 'normalized',...
                            'Position', [.8 .65 .05 .05],...
                            'String', 'dn',...
                            'Enable', 'off' );

ad.pgtxt    =   uicontrol(  'Style', 'text',...
                            'Units', 'normalized',...
                            'Position', [.85 .65 .05 .05],...
                            'String', '...',...
                            'Enable', 'off' );

cc = get(ad.pgtxt, 'BackgroundColor');
set(ad.f, 'Color', cc);

ad.seltxt   =   uicontrol(  'Style', 'text',...
                            'Units', 'normalized',...
                            'Position', [.75 .6 .15 .05],...
                            'String', 'Selection:' );

ad.indtxt   =   uicontrol(  'Style', 'text',...
                            'Units', 'normalized',...
                            'Position', [.75 .55 .15 .05],...
                            'String', 'indx: ',...
                            'HorizontalAlignment', 'left' );

%% Create first window

ad.layout  = [...
    0.0975    0.7093    0.2510    0.2157;
    0.4278    0.7093    0.2510    0.2157;
    0.0975    0.4096    0.2510    0.2157;
    0.4278    0.4096    0.2510    0.2157;
    0.0975    0.1100    0.2510    0.2157;
    0.4278    0.1100    0.2510    0.2157 ];

ad.axss = []; 

for i=1:size(ad.layout,1)
    ad.axss(i) = axes('Position', ad.layout(i,:));
end

ad.perpage = size(ad.layout,1);


ad.numpages = [];
for i=1:ds.nseg
    ad.numpages(i) = ceil(length(ds.segs(i).tcluss)/ad.perpage);
end

spikes = section(ds.dataset, ds.segtimes(1), ds.segtimes(2));

for i=1:min(ad.perpage,length(ds.segs(1).tcluss))
    cc = ds.segs(1).tcluss(i).ui;
    axes(ad.axss(i));
    rast(spikes, cc, [], 'fast');
end

