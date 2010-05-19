function slide_ax(axs,vert,hori)
% Slides axes around vectorially

if length(vert) == 1
    vert = repmat(vert,size(axs));
end

if length(hori) == 1
    hori = repmat(hori,size(axs));
end

for i = 1:length(axs)
    p = get(axs(i),'Position');
    p = p + [hori(i) vert(i) 0 0];
    set(axs(i),'Position',p);
end
