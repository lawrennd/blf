function [h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v)
% BLFUNPAK Separates w vector into J and bias matrices. 
%
%    Description
%    [h1, JA, h2, JB, h3] = blfunpak(w, nd) takes a parameters 
%    vector w and  a network description vector nd and returns the 
%    first-layer J matrix JA, the first-row bias vector h1, the 
%    second-layer  weight matrix JB, the second-row bias vector h2, 
%    the third-row h3.
%    
%    The parameters in nd are nd(1) = number of first row units   
%    nd(2) = number of second row   nd(3) = number of third row 
%    units.
%    [h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v)
%    See Also
%    blf, blfpak, blffwd, blfll, blfgrad
%    

%    Copyright (c) Neil D Lawrence (1997)

nrow1 = nd(1);
nrow2 = nd(2);
nrow3 = nd(3);

mark1 = nrow1;
h1 = reshape(w(1:mark1), 1, nrow1);
mark2 = mark1 + nrow1*nrow2;
JA = reshape(w(mark1 + 1: mark2), nrow2, nrow1);
mark3 = mark2 + nrow2;
h2 = reshape(w(mark2 + 1: mark3), 1, nrow2);
mark4 = mark3 + nrow2*nrow3;
JB = reshape(w(mark3 + 1: mark4), nrow3, nrow2);
mark5 = mark4 + nrow3;
h3 = reshape(w(mark4 + 1: mark5), 1, nrow3);

if nargin == 3
    mark1 = nrow1;
    xi1 = reshape(v(1:mark1), 1, nrow1);
    mark2 = mark1 + nrow1;
    mu1 = reshape(v(mark1 + 1: mark2), 1, nrow1);
    mark3 = mark2 + nrow2;
    xi2 = reshape(v(mark2 + 1: mark3), 1, nrow2);
    mark4 = mark3 + nrow2;
    mu2 = reshape(v(mark3 + 1: mark4), 1, nrow2);
    mark5 = mark4 + nrow3;
    xi3 = reshape(v(mark4 + 1: mark5), 1, nrow3);
    mark6 = mark5 + nrow3;
    mu3 = reshape(v(mark5 + 1: mark6), 1, nrow3);
end
