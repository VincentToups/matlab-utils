function dsevt_kdfcn(src,evt)
% DSEVT_KDFCN(SRC,EVT) is a callback function for the DSEVTPICKER
dsevtconstants


k = get(src, 'CurrentCharacter');
ad= get(src, 'UserData' );

switch k
    case 'a'
        if ad.mode ~= ADD_TO
            ad.mode = ADD_TO;
            try
                delete(ad.selectionlines);
            end
            ad.selecting = 0;
            set(ad.text_status, 'String', EVTMODES{ADD_TO} );
            set(src,'UserData', ad);
        end
        ssrc = ad.toghands(1);
    case 's'
        if ad.mode ~= SELECT
            ad.mode = SELECT;
            try
                delete(ad.selectionlines);
            end
            ad.selecting = 0;
            set(ad.text_status, 'String', EVTMODES{SELECT} );
            set(src, 'UserData', ad);
        end
        ssrc = ad.toghands(2);
        
    case 'k'
        if ad.mode ~= ADD_CLUS
            ad.mode = ADD_CLUS;
            try
                delete(ad.selectionlines);
            end
            ad.selecting = 0;
            set(ad.text_status, 'String', EVTMODES{ADD_CLUS} );
            set(src,'UserData', ad);
        end
        ssrc = ad.toghands(3);
end

if ~isfield(evt,'fake') & (k=='a' | k=='s' | k=='k')
    evttogbutcb(ssrc,[]);
end

        

