function positions=shift_axes(axs,shift)

positions = [];
if length(shift) == 2
  shift(4) = 0;
end
for a=axs
  p = get(a,'position');
  p = p + shift;
  positions = [positions;p];
  set(a,'position',p);
end
