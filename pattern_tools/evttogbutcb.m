function evttogbutcb(src,evt)
% EVTTOGBUTCB handles toggle button callbacks.
%
% This function handles the toggle button callbacks for the 
% manual segment picker.

%%disp(src)
%%disp(evt)
par = get(src,'Parent');
ad = get(par,'UserData');
%%disp(ad.toghands);

mx = get(src,'Max');
mn = get(src,'Min');
v = get(src,'Value');
%disp([mx mn v]);
if v==mx
    %disp('Not selected')
    for h=ad.toghands
        if h~=src
            set(h,'Value',mn);
        end
    end

    evtdata.fake = 1;
    if src == ad.toghands(1)
        evtdata.Key = 'a';
        set(ad.f,'CurrentCharacter','a');
        dsevt_kdfcn(ad.f,evtdata);
    elseif src == ad.toghands(2)
        evtdata.Key = 's';
        set(ad.f,'CurrentCharacter','s');
        dsevt_kdfcn(ad.f,evtdata);
    elseif src == ad.toghands(3)
        evtdata.Key = 'k';
        set(ad.f,'CurrentCharacter','k');
        dsevt_kdfcn(ad.f,evtdata);
    end

else
    %disp('Current Selected');
    for h=ad.toghands
        if h~=src
            set(h,'Value',mn);
        end
    end
    set(src,'Value',mx);
end


