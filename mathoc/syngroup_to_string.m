function str=syngroup_to_string(sg)
% 
%

str = [];
switch length(sg)
 case 1
  str = [sprintf('synapse group: %s', sg.name) newline];
  str = [str tab sprintf('nsyn:        %d', sg.nsyn) newline];
  str = [str tab sprintf('rev. pot:    %d', sg.e) newline];
  str = [str tab sprintf('syn. cond:   %d', sg.g) newline];
  str = [str tab sprintf('dist. soma:  %d', sg.dist_from_soma) newline];
  str = [str tab sprintf('distr. wid.: %d', sg.width) newline];
  class(sg.list_or_name)
  isclass(class({}),sg.list_or_name)
  if isclass(class({}),sg.list_or_name)
    str = [str tab sprintf('sections: ') join(sg.list_or_name) newline];
  else
    str = [str tab sprintf('section: %s', sg.list_or_name) newline];
  end
  if isclass(class(inline), sg.envelope)
    str = [str tab classy_truncate(sprintf('env:    %s', char(sg.envelope)),65) newline];
  end
  
 otherwise
  str = join(map(@syngroup_to_string, sg), newline);
end
