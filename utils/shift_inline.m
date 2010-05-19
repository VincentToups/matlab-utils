function f=shift_inline(f,var,dvar)
%
%

strf = char(f);
tokens = filt(@(x) ~isempty(x), unique(tokenize(strf,'.^+-*,()/\\[]{}')));
%class(tokens)

lens = map(@length,tokens);
[lens,ii] = sort(lens);
tokens = fliplr(tokens(ii));
tokenssub = gen_unique_names(length(tokens),ix(max(lens),1)+10,{},tokens);

tokens;
tokenssub;


for ti=1:length(tokens)
  token=tokens{ti};
  if ~strcmp(token,var)
    %us = token;
    %us = repmat('_',[1 ti+000]);
    %us = md5(token);
    us = tokenssub{ti};
    strf = strrep(strf,token,us);
  else
    dvar;
    strf = strrep(strf,token,sprintf('(%s-%d)',token,dvar));
  end
end

for ti=length(tokens):-1:1
  token=tokens{ti};
  %us = repmat('_',[1 ti+000]);
  %us = md5(token);
  us = tokenssub{ti};
  strf = strrep(strf,us,token);
end
f = inline(strf);
