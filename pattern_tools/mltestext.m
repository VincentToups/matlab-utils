function bool=mltestext(s1,r1,p1,s2,r2,p2,ts)
% MLTESTEXT extend MLTEST taking account of reliability and precision.
%
% BOOL = MLTESTEXT(S1,R1,P1,S2,R2,P2,THRESH) extended Maximum
%  likelyhood test of event similarity.  It also tests
%  for similarity between the reliabilities and precisions
%  of the events, given by r1 and r2 and p1 and p2 respectively.
%
%  See also MLTEST
%

d1 = d1(:)';
d2 = d2(:)';

m1 = mean(d1);
m2 = mean(d2);
std1 = std(d1);
std2 = std(d2);

dt = [d1 d2];
dt = dt(:)';
mt = mean(dt);
stdt = std(dt);

lls = sum((-(m1-d1).^2)./std1)+sum((-(m2-d2).^2)./std2);

llt = sum((-(mt-dt).^2)./stdt);
lls
llt
bool = (1-lls/llt) > ts;

bool = bool & abs(r1-r2) < (1/sqrt(length(d1)) + 1/sqrt(length(d2)));

