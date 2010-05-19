function togbutcb(src,evt)
% TOGBUTCB internal callback for segment picker.
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
        zdsms_fkeydn(ad.f,evtdata);
    elseif src == ad.toghands(2)
        evtdata.Key = 'd';
        set(ad.f,'CurrentCharacter','d');
        zdsms_fkeydn(ad.f,evtdata);
    elseif src == ad.toghands(3)
        evtdata.Key = 'm';
        set(ad.f,'CurrentCharacter','m');
        zdsms_fkeydn(ad.f,evtdata);
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


