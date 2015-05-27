function g = blfwgrad(w, nd, v, data);

%BLFGRAD Evaluate gradient of log likelihood function for 2-layer belief network.
%
%       Description
%       g = mlpgrad(w, nd, x, t) takes a network weight vector w together
%       with the network description vector nd and MeanField Parameters v, 
%	a matrix x of input vectors and evaluates the gradient g of the
%       lowerbound of the log likelihood function with respect to the 
%	network weights (J) and biases (h). 
%
%
%        See Also
%        blf, blffwd, blfll, blfpak, blfunpak

  
[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);
if nargin == 4
  mu3 = data;
end

xi = [xi1'; xi2'; xi3'];
h = [h1'; h2'; h3'];
mu = [mu1'; mu2'; mu3'];

xi2m=xi2'*ones(1, nd(1));
xi3m=xi3'*ones(1, nd(2));

mu1m=ones(nd(2), 1)*mu1;
mu2m=ones(nd(3), 1)*mu2;

phi = (exp(h).* ...
    [ones(nd(1), 1); ...
    prodrow(1-mu1m+mu1m.*exp((1-xi2m).*JA)); ...
    prodrow(1-mu2m+mu2m.*exp((1-xi3m).*JB))]./( ...
    [ones(nd(1), 1); ...
    prodrow(1-mu1m+mu1m.*exp(-xi2m.*JA)); ...
    prodrow(1-mu2m+mu2m.*exp(-xi3m.*JB))] + exp(h).* ...
    [ones(nd(1), 1); ...
    prodrow(1-mu1m+mu1m.*exp((1-xi2m).*JA)); ...
    prodrow(1-mu2m+mu2m.*exp((1-xi3m).*JB))]))';

phi1 = phi(1:nd(1));
phi2 = phi(nd(1)+1:nd(2)+nd(1));
phi3 = phi(nd(1)+nd(2)+1:sum(nd));

dL_dJA=-(xi2 - mu2)'*mu1+...
    (((1-phi2).*xi2)'*ones(1, nd(1))).*mu1m.*exp(-xi2m.*JA)./...
    (1-mu1m+mu1m.*exp(-xi2m.*JA)) - ...
    (((1-xi2).*phi2)'*ones(1, nd(1))).*mu1m.*exp((1-xi2m).*JA)./...
    (1-mu1m+mu1m.*exp((1-xi2m).*JA));

dL_dJB = -(xi3 - mu3)'*mu2 + ...
    (((1-phi3).*xi3)'*ones(1, nd(2))).*mu2m.*exp(-xi3m.*JB)./...
    (1-mu2m+mu2m.*exp(-xi3m.*JB)) - ...
    (((1-xi3).*phi3)'*ones(1, nd(2))).*mu2m.*exp((1-xi3m).*JB)./...
    (1-mu2m+mu2m.*exp((1-xi3m).*JB));

dL_dh1 = mu1-phi1;
dL_dh2 = mu2-phi2;
dL_dh3 = mu3-phi3;

g=blfpak(dL_dh1, dL_dJA, dL_dh2, dL_dJB, dL_dh3);