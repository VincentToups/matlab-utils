function ll=number_counts_to_list(counts)
%
%
%

ll = zeros([1 sum(counts)]);
tail = 1;
for i=1:length(counts)
  if counts(i) ~= 0
    ll(tail:(tail-1+counts(i))) = i;
    tail = tail + counts(i);
  end
end

