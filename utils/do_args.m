function val=do(varargin)
args = varargin;
for ai=1:(length(args)-1)
  arg=args{ai};
  arg();
end
arg = args{end};
val = arg();
