function vs=gau(t,tc,si)

vs = (1/(sqrt(2*pi)*si))*exp( -(1/2)*((t-tc).^2)/(si)^2 );
