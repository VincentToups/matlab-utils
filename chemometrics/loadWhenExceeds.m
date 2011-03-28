function cv = loadWhenExceeds(thresh, file)
%

cv = load(file);
if max(abs(cv))>thresh
  return;
else
  cv =[];
end
