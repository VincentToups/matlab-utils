function d=j8_dist_to_end_of(section_name)
% D=J8_DIST_TO_END_OF(SECTION_NAME)
%  finds the distance to the end of SECTION_NAME

acc = section_name;
d = 0;
while acc(end) ~= '_'
  s = j8secinfo(acc);
  d = d + s.L;
  acc = acc(1:(end-1));
end 
