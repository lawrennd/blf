function m = blfmuest(w, nd, v, row, index)

%BLFMUEST Re-estimates the value of the mean field parameter mu.
%
%       Description
%       m = blfmuest(w, nd, v, row, index)g = mlpgrad(w, nd, x, t) takes a 
%	network weight vector w together with the network description vector 
%	nd and mean field Parameters v and estimates a new value for the mu
%	of the row and index specified.
%
%
%       See Also
%       blf, blffwd, blfll, blfpak, blfunpak

%	Copyright (c) Neil D Lawrence (1997)

[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);

if row == 1

  h_i=h1; J_ji=JA'; mu_i=mu1;
  h_j=h2; mu_j=mu2; xi_j=xi2;	%index j represents children of the row
  
 
  mu_im = mu_i'*ones(1, nd(2));
  xi_jm = ones(nd(1), 1)*xi_j;

  phi_j = exp(h_j).* ...
      prodcol(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji))./( ...
      prodcol(1-mu_im+mu_im.*exp(-xi_jm.*J_ji)) + ...
      exp(h_j).*prodcol(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji)));


  
  phi_jm = ones(size(mu_i'))*phi_j;
  
  K_ji = (1-phi_jm).*(1-exp(-xi_jm.*J_ji))./ ...
	 (1-mu_im+mu_im.*exp(-xi_jm.*J_ji)) + ...
	 phi_jm.*(1-exp((1-xi_jm).*J_ji))./ ...
	 (1-mu_im+mu_im.*exp((1-xi_jm).*J_ji));
 

  m = sigmoid(h_i(index)+...
      (mu_j-xi_j)*J_ji(index, :)' + ...
      sumrow(K_ji(index, :)));

elseif row==2
  
  h_k=h1; J_ik=JA; mu_k=mu1;	%index k represents parents of the row
  h_i=h2; J_ji=JB'; mu_i=mu2;		
  h_j=h3; mu_j=mu3; xi_j=xi3;	%index j represents children of the row
 
  mu_im = mu_i'*ones(1, nd(3));
  xi_jm = ones(nd(2), 1)*xi_j;

  phi_j = exp(h_j).* ...
      prodcol(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji))./( ...
      prodcol(1-mu_im+mu_im.*exp(-xi_jm.*J_ji)) + ...
      exp(h_j).*prodcol(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji)));


  
  phi_jm = ones(size(mu_i'))*phi_j;
  
  K_ji = (1-phi_jm).*(1-exp(-xi_jm.*J_ji))./...
         (1-mu_im+mu_im.*exp(-xi_jm.*J_ji)) + ...
         phi_jm.*(1-exp((1-xi_jm).*J_ji))./ ...
	 (1-mu_im+mu_im.*exp((1-xi_jm).*J_ji));

  m = sigmoid(h_i(index)+ ...
	J_ik(index, :)*mu_k' + ...
	(mu_j-xi_j)*J_ji(index, :)' +...
	sumrow(K_ji(index, :)));

elseif row==3

  J_ik=JB; mu_k=mu2;	%index k represents parents of the row
  h_i=h3;		
  m = sigmoid(h_i(index)+ ...
	J_ik(index, :)*mu_k');
else

disp('Error Row one or two only')

end
