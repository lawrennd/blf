function x=blfmuopt(w, nd, v, niters)

%BLFMUOPT Re-estimates the value of every mean field parameter mu.
%
%       Description
%       x = blfmuopt(w, nd, v, niters) takes a network weight vector w 
%       together with the network description vector nd and mean field 
%       Parameters v and estimates new values for each mu in the first and
%       second rows.
%
%       See Also
%       blf, blffwd, blfll, blfpak, blfunpak

%	Copyright (c) Neil D Lawrence (1997)

x=v;

[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);

for j=1:niters
  
  h_j=h2; mu_j=mu2; xi_j=xi2;	%index j represents children of the row
  h_i=h1; J_ji=JA';
  xi_jm = ones(nd(1), 1)*xi_j;

  for index=1:nd(1)  %optimize row 1 
    %previously placed function blfmuopt in here but it was v. slow

    mu_i = mu1;
    mu_im = mu_i'*ones(1, nd(2));

    phi_j = exp(h_j).* ...
        prod(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji))./( ...
        prod(1-mu_im+mu_im.*exp(-xi_jm.*J_ji)) + ...
        exp(h_j).*prod(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji)));
  
    phi_jm = ones(size(mu_i'))*phi_j;
  
    K_ji = (1-phi_jm).*(1-exp(-xi_jm.*J_ji))./...
	(1-mu_im+mu_im.*exp(-xi_jm.*J_ji)) + ...
	phi_jm.*(1-exp((1-xi_jm).*J_ji))./ ...
	(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji));
 
%   x(nd(1)+index) is mu1(index) - would be cleaner to use bfunpak etc but
%   in this case there is a speed problem with that approach.
    
    x(nd(1)+index) = 1./(1+exp(-(h_i(index)+...
	(mu_j-xi_j)*J_ji(index, :)' + ...
        sum(K_ji(index, :)')')));
    
    mu1(index)=x(nd(1)+index);

 

  end

  h_k=h1; J_ik=JA; mu_k=mu1; xi_k=mu1;  %index k represents parents of the row
  h_j=h3; mu_j=mu3; xi_j=xi3; 		%index j represents children of the row
  h_i=h2; J_ji=JB'; xi_i=xi2;
  xi_jm = ones(nd(2), 1)*xi_j; 

  for index=1:nd(2)  %optimize row 2
     
    mu_i=mu2;		
    
    mu_im = mu_i'*ones(1, nd(3));
    xi_jm = ones(nd(2), 1)*xi_j;

    phi_j = exp(h_j).* ...
        prod(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji))./( ...
        prod(1-mu_im+mu_im.*exp(-xi_jm.*J_ji)) + ...
        exp(h_j).*prod(1-mu_im+mu_im.*exp((1-xi_jm).*J_ji)));

    phi_jm = ones(size(mu_i'))*phi_j;
  
    K_ji = (1-phi_jm).*(1-exp(-xi_jm.*J_ji))./...
	(1-mu_im+mu_im.*exp(-xi_jm.*J_ji)) + ...
        phi_jm.*(1-exp((1-xi_jm).*J_ji))./ ...
        (1-mu_im+mu_im.*exp((1-xi_jm).*J_ji));

    x(nd(1)*2+nd(2)+index) = 1./(1+exp(-(h_i(index)+ ...
        J_ik(index, :)*mu_k' + ...
        (mu_j-xi_j)*J_ji(index, :)' +...
        sum(K_ji(index, :)')')));
    
    mu2(index)=x(nd(1)*2+nd(2)+index);
  
  end

end



