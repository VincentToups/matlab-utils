function varargout=dealCleave(fs,args)
%
%

rs = cleave(fs,args);
for i=1:nargout
  varargout{i} = gix(rs,i);
end
