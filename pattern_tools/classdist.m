function [D, S, S1, S2, classprob]=classdist( class1, class2, tp)
% CLASSDIST quantifies the difference between clusterings
%   [D, S, S1, S2, CLASSPROB] = CLASSDIST(CLASS1, CLASS2, TYPE)
%       Returns the distance between two classifications CLASS1 and CLASS2 as
%       the entropy of their joint distribution.  D is S divided by the max of
%       S1 and S2.  S1 and S2 are the principles
%       of the joint distribution CLASSPROB.  If TYPE is one, function expects
%       U matrices, if TYPE is zero, function expects maximum likelyhood
%       representations of the classes.  TYPE defaults to 0.  Either case gives
%       results based on the maximum likelihood estimate.
%
%       See also ENT, VENTROPY, EVENTMERGE, DSSPIKECLUSTER, CLASSDISTP

if ~exist('tp')
    tp = 0;
end

if tp == 1
    tmp1 = class1;
    tmp2 = class2;
    
    [maxu, class1] = max(tmp1);
    [maxu, class2] = max(tmp2);
end
[class1, indx  ]  = sort(class1);
class2 = class2(indx);
classprob = full(sparse( class1, class2, ones(size(class1))) );
classprobn=classprob/sum(classprob(:));
[S, S1 ,S2]=ent(classprobn);
% D= 1 - S/max([S1 S2]);  % For the Toups version
if max([S1 S2]) ~= 0
    D = S/max([S1 S2]);
else
    D = 0;
end

%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%



