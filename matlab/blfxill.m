function y = blfxill(xi_i, mu_row, J_row, h_i)


%BLFXILL The portion of the lowerbound log likelihood equation affected by xi.
%
%	y = blfxill(xi_i, mu_row, J_col, h_i)
%	J_row ith row of J matrix which represents the children of the 
%	ith node, mu_row the children of the ith nodes mu vales, 
%	xi_i xi value of the ith node, h_i bias value of the ith node. 
%
%	See Also
%	blf, blfpak, blffwd, blfll, blfgrad, blfxiopt
%

%	Copyright (c) Neil D Lawrence (1997)


mu_rowm=ones(size(xi_i))*mu_row; 
h_i=ones(size(xi_i))*h_i;

y = xi_i.*(mu_rowm*J_row'+h_i)- ... 				   %third term
    xi_i.*h_i +log(prodrow(1-mu_rowm+mu_rowm.*exp(-xi_i*J_row)) ...%forth term
    +exp(h_i).*prodrow(1-mu_rowm+mu_rowm.*exp((1-xi_i)*J_row)));
