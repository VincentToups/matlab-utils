p = [];
for i=1:6
    p = [p; get(subplot(3,2,i), 'Position')];
end
p(:,1) = .75*p(:,1);
p(:,3) = .75*p(:,3);

close all

for i=1:100
  print i
end
ted = 11

for i = 1:6
    a = axes;
    set(a,'Position',p(i,:));
end


x = 10
