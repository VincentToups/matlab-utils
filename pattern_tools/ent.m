function [s, sx, sy] = ent(ma)
% ENT returns the entropy of a matrix
%
%  [S, SX, SY] = ENT(MA) returns the entropy of MA.  S is the entropy, SX
%  is the first marginal and SY is the second marginal.
%  MA is treated as a joint distribution.
%
%  See also: VENTROPY
%
	[x, y] = size(ma);
	px = sum(ma, 1);
	py = sum(ma, 2);
	sx = -(px(px>0)*log2(px(px>0))');
	sy = -(py(py>0)'*log2(py(py>0)));

	ml = reshape(ma, [1 x*y]);
	sxy = -ml(ml>0)*log2(ml(ml>0))';
	s = sx + sy -sxy;
    





%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%



