function vo = blfxiopt(w, nd, v, tol)

%BLFXIOPT Optimizes all the xi values using fmin of function blfxill
%
%	Description
%	vo = blfxiopt(w, nd, v) takes w, the network weights & biases vector
%	and v, the mean field parameters vector, and optimizes the xi's in 
%	the first and second rows by minimizing the third and second terms 
%	of the likelihood equation using blfxill.
%	
%	See Also
%	blf, blfpak, blffwd, blfll, blfgrad, blfxill
%

%	Copyright (c) Neil D Lawrence (1997)


[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);
vo=v;

for i=1:nd(2)

  vo(nd(1)*2+i) = minline(mu1, JA(i, :), h2(i), tol); 

end

[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, vo);

for i=1:nd(3)

  vo(nd(1)*2+nd(2)*2+i) = minline(mu2, JB(i, :), h3(i), tol);

end


