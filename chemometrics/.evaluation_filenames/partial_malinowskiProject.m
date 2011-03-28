



rank = rankMalinowski(data);
[l,v]=pca(data');
l((rank+1):end) = 0;
l = repmat(l(:)',[size(v,1) 1]);
vt = l.*v;

