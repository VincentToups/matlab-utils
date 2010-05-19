function t=letter(a,letter,position)
% LETTER Tries to automatically letter a figure.
% T=LETTER(A,LETTER,POSITION) leters axis a with letter LETTER at the given POSITION
% T=LETTER(LETTER,POSITION) labels the current axes
% T is the title handle

if nargin == 2
    t = letter;
    letter = a;
    position = t;
    a = gca;
end

a
letter
position

%normalize the lettering position

axes(a);
xl = xlim;
yl = ylim;

dx = diff(xl);
dy = diff(yl);

position(1) = dx*position(1) + xl(1);
position(2) = dy*position(2) + yl(1);

t = title(letter);
set(t,'Position',position);

