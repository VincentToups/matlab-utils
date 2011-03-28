function d=absSetDiff(x,y)
args = {x,y};
[lens,ii] = sort(map(@length, args));
args = fliplr(args(ii));
d = setdiff(args{:});

