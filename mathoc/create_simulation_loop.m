function str=create_simulation_loop(n,do_first,do_last)
%
%

if ~exist('n')
  n = 1;
else
  n = round(n);
end

if ~exist('do_first')
  do_first = '\n';
end
if ~exist('do_last')
  do_last = '\n';
end
str=[];
str = [str sprintf('for(repeat_i=0;repeat_i<%d;repeat_i=repeat_i+1){\n',n)];
str = [str     do_first];
str = [str '	printf("Do presim\\\\n")\n'];
str = [str '	preSim()\n'];
str = [str '	printf("Done prep\\\\n")\n'];
str = [str '	run()\n'];
str = [str '	printf("Done sim\\\\n")\n'];
str = [str '	save()\n'];
str = [str '	postSim()\n'];
str = [str     do_last];
str = [str '}\n'];
str = [str '\n'];


str = sprintf(str);
