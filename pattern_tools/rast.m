function h=rast( spk, aux, h, style )
% RAST plots rastergrams
%
% H=RAST(SPK) plots a rastergram of the spikes in SPK
% H=RAST(SPK, [], H) plots the rastergram to the axes denoted by H.
% H=RAST(SPK, LABELS) plots a sorted rastergram of the spikes in spk sorted
% by cluster identity and color coded.
% H=RAST(SPK, LABELS, H) does the same to the axes H.
% 
% See also DSRAST, DSEGRAST, FASTRAST

% if exist('aux') & isempty(aux)
%     clear aux;
% end

if  ~exist('aux') | isempty(aux)
    aux = 'b';
end

if ~exist('h') | isempty(h)
    h = gca;
    cla;
end

axes(h);

try
fp = get(gca, 'ButtonDownFcn');
catch
end


if isnumeric( spk ) & ischar(aux)
    
    if ~exist('aux')
        aux = 'k';
    end
    
    spk = spk(:,:,1);
    [x y] = size( spk );
    ii = (1:x)';
    ii = repmat( ii, [1 y] );
    nz = spk > 0;
    spk = spk(nz);
    ii = ii(nz);
    
    xs = [spk'; spk'];
    ys = [(ii-.9)'; ii'-.1];
    
    hold on;
    %plot( spk, ii, [aux '.']);
    if ~exist('style') | strcmp(style, 'nice')
        line( xs, ys, 'Color', aux, 'LineWidth', 1);
    else
        plot( xs, ii, [ '.' aux ] );
    end
    
    hold off;
    
elseif nargin >= 2 & isnumeric( spk ) & isnumeric( aux )
    % aux must be the array of labels
    colors = ['b' 'r' 'm' 'k'];
%     colors = ['k' 'k' 'k' 'k'];
    [cn, cnii] = sort( aux );
    spk = spk(cnii, :, :);
    for i=unique(cn)
        sii = find( cn ~= i );
        sspk = spk;
        sspk(sii,:,:) = 0;
        if ~exist('style') | strcmp(style, 'nice')
            rast( sspk, colors( mod(i, 4)+1 ), h );
        else
            rast( sspk, colors( mod(i, 4)+1 ), h, 'fast');
        end
    end
    
elseif (nargin == 1 | nargin == 3)& isstruct( spk )
    
    seg = spk;
    len = length( seg );
    
    [x y] = size( seg(1).cp.spikes );
    
    for i=1:len
        line( [seg(i).cp.start seg(i).cp.start], [0 x] );
        line( [seg(i).cp.finish seg(i).cp.finish], [0 x] );
        rast( seg(i).cp.spikes, seg(i).best{ seg(i).which }, h );
    end
else
    disp('Error, wrong input type');
end 

try
set(gca,'ButtonDownFcn',fp);
catch
end
axis tight

return


%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%
