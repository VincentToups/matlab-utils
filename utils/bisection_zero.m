function [z,v,done]=bisection_zero(f,bracket,tol,maxit)

if ~exist('tol','var')
  tol = 1e-6;
end

if ~exist('maxit','var')
  maxit = 100;
end

left = f(bracket(1));
right = f(bracket(2));

if abs(left)<tol
  v = left;
  z = bracket(1);
  return;
end

if abs(right)<tol
  v = right;
  z = bracket(2);
  return;
end

it = 0;
done = 0;
while it < maxit && not(done)
  midpoint = mean(bracket);
  mid = f(midpoint);
  if abs(mid)<tol
    v = mid;
    z = midpoint;
    return;
  else
    if sign(mid) ~= sign(left)
      right = mid;
      bracket(2) = midpoint;
    elseif sign(mid) ~= sign(right)
      left = mid;
      bracket(1) = midpoint;
    else
      error('Seems like your bracket fails to bracket the root');
    end
  end
  it = it + 1;
  if it==maxit
    warning('bisection reached maxit before convergence.');
    v = mid;
    z = midpoint;
  end
end
