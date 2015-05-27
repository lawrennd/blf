function ll=blflll(w, nd, v, data)

% BLFLL Lower bound of the log likelihood for a sigmoid belief network
% 
%	Description
%	ll=blfll(w, nd, v) gives a lowerbound to the log likelihood based on
%	Saul, Jordan & Jaakkola's Mean Field Theory for Sigmoid belief 
%	networks. w is the vector of network weights and biases, v is the 
%	vector of mean field parameters and nd is the network descriptor.
% 
%	See Also
%	blf, blfxiopt, blfxill, blfgrad, blfpak, blfunpak	

%	Copyright (c) Neil D Lawrence (1997)

[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);

% Possible development - in fact xi1 has no effect on the likelihood, it
% is canceled out.
if nargin ==4
  mu3 = data;
end

xi = [xi1'; xi2'; xi3'];	% full vector of xi's
h = [h1'; h2'; h3'];		% full vector of h's
mu = [mu1'; mu2'; mu3'];	% full vector of mu's

xi2m=xi2'*ones(1, nd(1));	% column matrix of repeated xi2's
xi3m=xi3'*ones(1, nd(2));	% column matrix of repeated xi3's

mu1m=ones(nd(2), 1)*mu1;	% row matrix of repeated mu1's
mu2m=ones(nd(3), 1)*mu2;	% row matrix of repeated mu2's

ll = sumcol(sumrow(JA.*(mu2'*mu1))) + ...
  sumcol(sumrow(JB.*(mu3'*mu2))) + ... % First term
  h'*mu - ...		 	       % Second Term
  sumcol(xi.* ...                      % Third Term
  ([zeros(nd(1), 1); JA*mu1';  JB*mu2'] + h)) - ... 	 
  sumcol(-xi.*h + log(...              % Forth Term
     [ones(nd(1), 1); ...
      prodrow(1-mu1m+mu1m.*exp(-xi2m.*JA)); ...
      prodrow(1-mu2m+mu2m.*exp(-xi3m.*JB))]+ exp(h).* ...
     [ones(nd(1), 1); ...
      prodrow(1-mu1m+mu1m.*exp((1-xi2m).*JA)); ...
      prodrow(1-mu2m+mu2m.*exp((1-xi3m).*JB))])) -  ...
     sumcol(mu.*log(mu+(~mu))+(1-mu).*log(1-mu+(~(1-mu)))); % Fifth term


