




































































  remove = fromTo(candidates(1)-round(avoidWidth/2), candidates(1)+round(avoidWidth/2));
  candidates = setdiff(candidates,remove);
end
cv = cvs{1};

if ischar(alsoReturn) && strcmp(alsoReturn,'all')
  names = who;
  names
