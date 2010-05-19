function dspicker2d(ds)
% DSPICKER is a clustering picker for trial clusterings for DATASETS
%
%     DSPICKER(DS) launches the DSPICKER on the object DS.  If DS has a 
%     name in the calling workspace, then pressing the commit button will
%     save changes.
%
%     If the object is unnamed for any reason, it can be acceses by
%     getting the figure's userdata.
%
%     This applet provides a UI which displays a clustering in the top
%     window and the fitness over q values in the bottom window.  The
%     user clicks on the lower display, showing the fitness, and the
%     clustering corresponding to the particular q value is displayed
%     on the top axis.  The page buttons at the top of the screen
%     allow the user to switch from segment to segment.  When all segments
%     are selected, the user presses COMMIT and the changes are written
%     into the global workspace.
%


ad.f = figure;
ad.a1 = subplot(2,1,1);
ad.a2 = subplot(2,1,2);

ad.ds = ds;
ad.inname = inputname(1);
ad.cur_seg = 1;

axes(ad.a1);

dsrast(ds);

axes(ad.a2);

if ds.segs(1).status < 1
    xx = [  0 1;
            0 1 ];
    yy = [  0 1;
            1 0 ];
            
    line(xx,yy,'Color',[0,0,0]);
else
    ad.fits = rot90(squeeze(mean(ds.segs(1).fits,4)), 1);
    ad.im = imagesc(ad.fits)
    colorbar

%    if ds.segs(1).status >= 2
%        ii = ds.segs(1).tchosenindx(1);
%        q = ds.segs(1).q(ii);
%        plot(q,ds.segs(1).fit2d(ii));
%    end
end

set(ad.a1,'ButtonDownFcn',@dspicker2d_a1bdn);
set(ad.im,'ButtonDownFcn',@dspicker2d_a2bdn);

% Make the commit function

ad.cb = uicontrol(  'Style',    'pushbutton',...
                    'Units',    'normalized',...
                    'Position', [.45 .05 .1 .05],...
                    'String', 'Commit Changes',...
                    'CallBack', @dspicker_commit);

set(ad.f,'UserData',ad);
