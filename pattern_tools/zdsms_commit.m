function zdsms_commit(src,evt)
% ZDSMS_COMMIT(SRC,EVT) is an internal callback function for DSMANSEG
% It handles saving the segmentation to the work space.

par = get(src,'Parent');
ad =  get(par, 'UserData');

if isempty(ad.inname)
    warning('Object has not input name, commit manually.');
else
    evalin('base',sprintf('x__x = get(%d,''UserData'');',ad.f));
    evalin('base',[ad.inname '= x__x.ds; clear x__x;']);
end


