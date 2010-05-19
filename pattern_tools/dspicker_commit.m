function dspicker_commit(src,evt)
% DSPICKER_COMMIT(SRC,EVT) is a help function for the DSPICKER application.
%  It writes out the changes made to the ds object, if an object name is
%  available.

par = get(src,'Parent');

ad = get(par, 'UserData');

if ~isempty(ad.inname)
    evalin('base',sprintf('x__x = get(%d,''UserData'');',ad.f));
    evalin('base',sprintf('%s = x__x.ds; clear x__x;', ad.inname ));
else
    warning('No input name available, commit changes manually.');
end

