function zdsms_ekeydn(src,evtdat)
% ZDSMS_KEYDOWN(F,IDENT) is a helper function for the manual segmentation
% tool from the pattern tools package.  It handles keypress events
% when editable text boxs have focus.

ud = get(src, 'UserData');
ad = get(get(src,'Parent'),'UserData');

s = ud{1};
step = ud{2};

k = evtdat.Key;

switch s

    case 'peredit'
        if strcmp(k,'uparrow') | strcmp(k,'downarrow')
            v = eval([get(src, 'String') ';']);
            if k(1) == 'u'
                v = v + step;
            else
                v = v - step;
            end
            set(src, 'String', v);
            ds = ad.ds;
            ds.per = v;
            ds.private.reseg = 1;
            ad.ds = dsautoseg(ds);
            axes(ad.rastax);
            dssegdraw(ad.ds);
            set(get(src,'Parent'), 'UserData', ad);
            uicontrol(src);
        elseif strcmp(k,'leftarrow') | strcmp(k,'rightarrow')
            if k(1)=='r'
                step = step + .1;
            elseif step - .1 > 0
                step = step - .1;
            end
            ud{2} = step;
            set(src, 'UserData', ud);
            uicontrol(src);
        end

    case 'paredit'
        if strcmp(k,'uparrow') | strcmp(k,'downarrow')
            v = eval([get(src, 'String') ';']);
            if k(1) == 'u'
                v = v + step*v;
            elseif v - v*step > 0
                v = v - step*v;
            end
            set(src, 'String', v);
            ds = ad.ds;
            ds.segparam = v;
            ds.private.reseg = 1;
            ad.ds = dsautoseg(ds);
            axes(ad.rastax);
            dssegdraw(ad.ds);
            set(get(src,'Parent'), 'UserData', ad);
            uicontrol(src);
        elseif strcmp(k,'leftarrow') | strcmp(k,'rightarrow')
            if k(1)=='r' & step + .1 <= 1
                step = step + .1;
            elseif step - .1 > 0;
                step = step - .1;
            end
            ud{2} = step;
            set(src, 'UserData', ud);
            uicontrol(src);
        end

    case {'d','a','m'}
        ad.mode = k;
        set(get(src,'Parent'),'UserData',ad);
end

            


