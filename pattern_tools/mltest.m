function [bool,ratio] = mltest(d1,d2,ts)
% MLTEST maximum likelihood estimate test if two events are the same.
%
% BOOL = MLTEST(D1,D2) returns 1 if it is more likely that the
%  distributions (1d) D1 and D2 are drawn from two seperate 
%  guassians and 1 if they are more likely to be from a single 
%  distributions.
% [BOOL,RATIO] = MLTEST(..) also returns the RATIO of the log-
%  likelihood for two distributions over the log-likelihood for
%  one.

d1 = d1(:)';
d2 = d2(:)';

m1 = mean(d1);
m2 = mean(d2);
std1 = std(d1);
std2 = std(d2);

x1 = min([d1 d2]);
x2 = max([d1 d2]);
x = linspace(x1,x2,1000);
%plot(x, exp(-((m1-x)/std1).^2))
%hold on
%plot(x, exp(-((m2-x)/std2).^2));
%hold off

%m1
%m2 
%std1
%std2



dt = [d1 d2];
dt = dt(:)';
mt = mean(dt);
stdt = std(dt);

lls = ((sum((-(m1-d1).^2)./std1^2) +sum((-(m2-d2).^2)./std2^2)));

llt = sum((-(mt-dt).^2)./stdt^2);
bool = (1-lls/llt) > ts;
lls
llt
ratio = lls-llt;

