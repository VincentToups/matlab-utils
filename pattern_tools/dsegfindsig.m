function dseg=dsegfindsig(dseg)
% DSEGFINDSIG find significance of a DATASEG
% 
% DSEG=DSEGFINDSIG(DSEG) finds the pattern strength and significance
%  for a segment.  
%
%   For a description of these quantities see PATTERN_SIG and PATTERN_STR

m = +(dseg.eventform > 0);
r = sum(m)/size(m,1);

dseg.strength = pattern_str(m);
dseg.significance = pattern_sig(m,r);

