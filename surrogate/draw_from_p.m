function ns=draw_from_p(p,n)
% NS=DRAW_FROM_P(P,N) draws N things
%  from distribution P, returns the
%  number of each thing in NS

partitions = cumsum([0 p]);

trial_tosses = rand([n 1]);

partitions = repmat(partitions,[n 1]);
trial_tosses = repmat(trial_tosses,[1 size(partitions,2)]);

precounts = sum( trial_tosses < partitions, 1 );
counts = diff(precounts);
ns = counts;

