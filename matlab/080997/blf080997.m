function [w, nd, v] = blf080997(nrow1, nrow2, nrow3)
% difference is weights are only set to approx 1e-6
% BLF080997 Create a 2-layer belief network.
% 
% 	Description
% 
% 	[w, nd, v] = blf220897(nrow1, nrow2, nrow3) takes the number of inputs,
% 	hidden units and output units for a 2-layer belief network, and 
% 	returns a row vector w of network parameters, together with a network 
% 	description vector nd and a mean field vector v. The weights are drawn 
% 	from a zero mean, unit variance isotropic Gaussian. This makes use of 
% 	the Matlab function randn and so the seed for the random weight 
% 	initialization can be  set using randn('seed', s) where s is the
% 	seed value. The v vector for xi and mu parameters is drawn from the 
% 	uniform distribution rand.
% 
% 	The parameters in nd are   nd(1) = number units in row 1   
% 	nd(2) = number of units in row 2,  nd(3) = number of units in row 3
% 
% 	
% 	See Also
% 	blf, blffwd, blfll, blfpak, blfunpak, blfxiopt, blfxill
% 

% 	Copyright (c) Neil D Lawrence (1997)

nd = [nrow1 nrow2 nrow3];
nunits = sum(nd);

nwts = nrow1*nrow2 + nrow2*nrow3 + nunits;	% Total number of weights. 
w = randn(1, nwts)*1e-6;

nvs = 2 * nunits;
v = rand(1, nvs);