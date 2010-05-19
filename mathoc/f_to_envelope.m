function envelope=f_to_envelope(f, res, tstop)
%
%
%

starts = 0:res:tstop;
ends = starts(2:end);
starts = starts(1:(end-1));

rates = map(f,starts);

envelope = [ starts(:) ends(:) rates(:) ];





