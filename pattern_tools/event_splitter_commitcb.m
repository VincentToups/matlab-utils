function event_splitter_commitcb(src,evt)
% DSEVT_COMMITCB(SRC,EVT) is a callback for the DSEVTPICKER
%

gud = get(get(src,'Parent'),'UserData');

if isempty(gud.inname)
    warning('No input name available, commit manually...');
    return;
else
    disp('Object commited.');
    ds = gud.ds;
    evalin('base',sprintf('x__x = get(%d,''UserData'');',gud.f));
    evalin('base',[gud.inname '= x__x.ds; clear x__x;']);
end

    

