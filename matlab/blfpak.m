function [w, v] = blfpak(h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3)
% BLFPAK Combines J matrix and biases into one vector.
%
%    Description
%    [w, v] = blfpak(h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3) 
%    or w = blfpak(h1, JA, h2, JB, h3)
%    takes the first-row bias vector h1, the first-layer J-vector J1, 
%    the second-row bias vector h2, and the second-layer J-vector J2
%    and combines them  into a single row vector w. If a second output
%    argument is specified then the other parameters for the nodes in 
%    the different rows are combined into a seperate vector v. 
%    
%    
%    See Also
%    blf, blfunpak, blffwd, blferr, blfgrad, blfxiopt, blfmuest
%    

%    Copyright (c) Neil D Lawrence (1997)

w = [h1, JA(:)', h2, JB(:)', h3];

if nargout == 2
    v = [xi1, mu1, xi2, mu2, xi3, mu3];
end