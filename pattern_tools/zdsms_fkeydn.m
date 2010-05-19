function zdsms_fkeydn(src,evtdata)
% ZDSMS_FKEYDN(SRC,EVTDATA) is a callback function for the segment
% finding tool.  It handles keydown events.

%k = evtdata.Key;
k = get(src,'CurrentCharacter');

ad = get(src,'UserData');

switch k
    case {'d','a','m'}
        ad.mode = k;
        set(src,'UserData',ad);
        set(ad.status,'String',ad.mode);
        if ~isfield(evtdata,'fake')
            if k == 'a'
                ssrc = ad.toghands(1);
            elseif k == 'd'
                ssrc = ad.toghands(2);
            elseif k == 'm'
                ssrc = ad.toghands(3);
            end
            togbutcb(ssrc,[]);
        end
    case 'c'
        if ~isempty(ad.inname)
            ad.ds = rmfield(ad.ds, 'segs');
            ad.ds.segs = repmat(dataseg(0,0),[1 ad.ds.nseg]);
            for i=1:ad.ds.nseg
                disp(['zdsms_fkeydn',sprintf(' %d',i)]);
                ad.ds.segs(i).start = ad.ds.segtimes(i);
                ad.ds.segs(i).finish= ad.ds.segtimes(i+1);
            end
            set(src, 'UserData', ad ); 
            evalin('base', sprintf('x__x = get(%d,''UserData'');', src));
            evalin('base', [ad.inname ' = x__x.ds; clear x__x;']);
        else
            warning('Dataset passed in without a workspace name, commit manually.');
        end
    
end        
