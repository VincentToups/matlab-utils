function dsevt_rastbdf(src,evt)
% DSEVT_RASTBDF(SRC,EVT) is a callback function for the raster
%  axes in the event picker.

ad = get(get(src, 'Parent'),'UserData');

dsevtconstants;
p = get(src,'CurrentPoint');
p = p(1,1:2);

switch ad.mode
    case SELECT

        tc = find( p(2) > ad.triallines & p(2) < [ad.triallines(2:end) ad.triallines(end)] );
        cm = ad.ds.segs(ad.seg).clusmod;
        [nothing, sc] = min( abs(p(1)-[cm(tc).events(:).mean]) );
        ad.tclus = tc;
        ad.sclus = sc;
        set(ad.edit_sclus,'String',sprintf('%d',sc));
        dsevt_drawaxes(ad);
    case ADD_TO

        
        if ~ad.selecting


            tc = find( p(2) > ad.triallines & p(2) < [ad.triallines(2:end) ad.triallines(end)] );
            cm = ad.ds.segs(ad.seg).clusmod;
            [nothing, sc] = min( abs(p(1)-[cm(tc).events(:).mean]) );
            ad.tclus = tc;
            ad.sclus = sc;
            set(ad.edit_sclus,'String',sprintf('%d',sc));
            dsevt_drawaxes(ad);

            
            ad.selecting = 1;
            axes(ad.raster);
            xx = [p(1) p(1)]';
            yy = [ad.triallines(ad.tclus) ad.triallines(ad.tclus+1)];
            ad.selectionlines = line(xx,yy,'Color',[0 0 1]);
        else
            ad.selecting = 0;
            x = get(ad.selectionlines, 'XData');
            x(2) = p(1);
            x = sort(x);
            delete(ad.selectionlines);
            cc = ad.ds.segs(ad.seg).tchosen;
            spikes = section(ad.ds.dataset(cc==ad.tclus,:,:), ad.ds.segtimes(ad.seg),ad.ds.segtimes(ad.seg+1));
            spikes = spikes(spikes>0);
            ii = find(spikes > x(1) & spikes < x(2) );
            cc = relabel( ad.ds.segs(ad.seg).schosen{ad.tclus} );
            cc(ii) = ad.sclus;
            ad.ds.segs(ad.seg).schosen{ad.tclus} = relabel(cc);
            ad.ds = dsmodel(ad.ds,ad.seg);
            dsevt_drawaxes(ad);
            set(ad.f, 'UserData', ad);            
        end
    case ADD_CLUS
        if ~ad.selecting


            tc = find( p(2) > ad.triallines & p(2) < [ad.triallines(2:end) ad.triallines(end)] );
            cm = ad.ds.segs(ad.seg).clusmod;
            [nothing, sc] = min( abs(p(1)-[cm(tc).events(:).mean]) );
            ad.tclus = tc;
            ad.sclus = sc;
            set(ad.edit_sclus,'String',sprintf('%d',sc));
            dsevt_drawaxes(ad);

            
            ad.selecting = 1;
            axes(ad.raster);
            xx = [p(1) p(1)]';
            yy = [ad.triallines(ad.tclus) ad.triallines(ad.tclus+1)];
            ad.selectionlines = line(xx,yy,'Color',[0 0 1]);
        else
            ad.selecting = 0;
            x = get(ad.selectionlines, 'XData');
            x(2) = p(1);
            x = sort(x);
            delete(ad.selectionlines);
            cc = ad.ds.segs(ad.seg).tchosen;
            spikes = section(ad.ds.dataset(cc==ad.tclus,:,:), ad.ds.segtimes(ad.seg),ad.ds.segtimes(ad.seg+1));
            spikes = spikes(spikes>0);
            ii = find(spikes > x(1) & spikes < x(2) );
            disp(sprintf('Found %d spikes between %f and %f.',length(ii),x(1),x(2)));
%            sp = spikes(ii);
%            m = mean(sp);
%            s = std(sp);
%            d = abs(m-sp)/s;
%            jj = find(d>5);
%            if ~isempty(jj)
%                for j=jj
%                    disp(sprintf('I found a spike at %f greater than 3 sigma away from the mean of %f\n',m,sp(j)));
%                end
%            end
%
            cc = relabel(ad.ds.segs(ad.seg).schosen{ad.tclus});
            cc(ii) = max(cc)+1;
            ad.ds.segs(ad.seg).schosen{ad.tclus} = relabel(cc);
            ad.ds = dsmodel(ad.ds,ad.seg);
            dsevt_drawaxes(ad);
            set(ad.f, 'UserData', ad); 
        end      
        
end

set(get(src,'Parent'),'UserData',ad);



