function [val,vr] = extract_or_return(name,vr,val)
%
%

stru =  varargs_to_struct(vr);
if isfieldi(stru,name)
  ii = find(strcmpi(fieldnames(stru),name));
  nm = gix(fieldnames(stru),ii);
  val = stru.(nm);
  vr = struct_to_varargs(rmfield(stru,nm));
end
