function [vo, counter]=mfupdateopt(w, nd, v , tol, options)


% MFUPDATE Update for mean field parameters designed for running as MEX
%
%         Description
%         vo=mfupdate(w, nd, v, options) this function updates all the mean
%         field parameters returing a new vector v. It is being written to
%         compile into a mex file and is therefore not as easy to read as
%         would be preffered.
% 
%         See Also
% 	  blf, blffwd, blfll, blfpak, blfunpak, blfxiopt, blfxill


% 	  Copyright (c) Neil D Lawrence (1997)
       

vo=v;
nrow1=nd(1);
nrow2=nd(2);
nrow3=nd(3);
mu1opt=1;                               % Set default mu optimisation true
if nargin==4
  maxiter=10; 				% Maximum passes through algotrithm
  linemintol=0.01; 			% tolerance criteria in linemin
  percoflll=0.01; 			% % change in lll for stop
  display=0;
elseif nargin==5
  maxiter=options(14);
  percoflll=options(3);
  linemintol=options(4);
  display=options(1);
  mu1opt=options(15);
end
    
mark1 = nrow1;
h1 = w(1:mark1);
mark2 = mark1 + nrow1*nrow2;
JA = zeros(nrow2, nrow1);
JA(:) = w(mark1 + 1: mark2);
mark3 = mark2 + nrow2;
h2 = w(mark2 + 1: mark3);
mark4 = mark3 + nrow2*nrow3;
JB = zeros(nrow3, nrow2);
JB(:) = w(mark3 + 1: mark4);
mark5 = mark4 + nrow3;
h3 = w(mark4 + 1: mark5);
mark1 = nrow1;
JAt=JA';
JBt=JB';


lltrack=blfll(w, nd, vo); 		% Initial likelihood value
lltol=abs(percoflll*lltrack); 		% Tolerance is 1% of likelihood
lldiff=lltol+1; 			% differnce > tolerance
counter=0;

xi1 = v(1:mark1);
mark2 = mark1 + nrow1;
mu1 = v(mark1 + 1: mark2);
mark3 = mark2 + nrow2;
xi2 = v(mark2 + 1: mark3);
mark4 = mark3 + nrow2;
mu2 = v(mark3 + 1: mark4);
mark5 = mark4 + nrow3;
xi3 = v(mark4 + 1: mark5);
mark6 = mark5 + nrow3;
mu3 = v(mark5 + 1: mark6);
% mu2m
% xi3m


if display
  fprintf('lltrack\tlltkold\tlltol\tlldiff\n') 
end

while lldiff>lltol & counter<maxiter
  counter=counter+1;
  

  
  vold=vo;
  %Update xi3 for one iteration
  for i=1:nrow3
    vo(mark4+i) = minline(mu2, JB(i, :), h3(i), linemintol);
  end
  xi3=vo(mark4+1:mark5);
  tosser=xi3;
  %Update mu2 for one iteration
  
  xi3m = ones(nrow2, 1)*xi3;
  
  for index=1:nrow2 			%optimize row 2
        
    mu2m = mu2'*ones(1, nrow3);

    phi3 = exp(h3).* ...
        prod(1-mu2m+mu2m.*exp((1-xi3m).*JBt))./( ...
        prod(1-mu2m+mu2m.*exp(-xi3m.*JBt)) + ...
        exp(h3).*prod(1-mu2m+mu2m.*exp((1-xi3m).*JBt)));

    phi3m = ones(size(mu2'))*phi3;
    
    K_ji = (1-phi3m).*(1-exp(-xi3m.*JBt))./...
	(1-mu2m+mu2m.*exp(-xi3m.*JBt)) + ...
        phi3m.*(1-exp((1-xi3m).*JBt))./ ...
        (1-mu2m+mu2m.*exp((1-xi3m).*JBt));

    vo(mark3 + index) = 1./(1+exp(-(h2(index)+ ...
        JA(index, :)*mu1' + ...
        (mu3-xi3)*JB(:, index) +...
        sum(K_ji(index, :)')')));
    
    mu2(index)=vo(mark3 + index);
  
  end
  
  %Update xi2 for one iteration
  for i=1:nrow2
    vo(mark2+i) = minline(mu1, JA(i, :), h2(i), linemintol); 
  end
  xi2=vo(mark2+1:mark3);
  
  xi2m = ones(nrow1, 1)*xi2;
  
  if mu1opt==1
    for index=1:nrow1 			%optimize row 1 

      mu1m = mu1'*ones(1, nrow2);

      phi2 = exp(h2).* ...
	  prod(1-mu1m+mu1m.*exp((1-xi2m).*JAt))./( ...
	  prod(1-mu1m+mu1m.*exp(-xi2m.*JAt)) + ...
	  exp(h2).*prod(1-mu1m+mu1m.*exp((1-xi2m).*JAt)));

      phi2m = ones(size(mu1'))*phi2;
  
      K_ji = (1-phi2m).*(1-exp(-xi2m.*JAt))./...
	  (1-mu1m+mu1m.*exp(-xi2m.*JAt)) + ...
	  phi2m.*(1-exp((1-xi2m).*JAt))./ ...
	  (1-mu1m+mu1m.*exp((1-xi2m).*JAt));
    
      vo(mark1+index) = 1./(1+exp(-(h1(index)+...
	  (mu2-xi2)*JA(:, index) + ...
	  sum(K_ji(index, :)')')));
      
      mu1(index)=vo(mark1+index);
      
    end
  end
  lltrackold=lltrack;
  lltrack=blfll(w, nd, vo);
  lldiff=lltrack-lltrackold;
  lltol=abs(percoflll*lltrackold);
   
  if display
    fprintf('%3.2f\t%3.2f\t%2.3f\t%2.3f\n', ...
	lltrack, lltrackold, lltol, lldiff) 
  end 					% 
  
  
end

if counter==maxiter
  
  fprintf(['Maximum iterations reached in mmfupdate\n' ...
	  'last change %2.2f\ttolerance %2.2f\n'], lldiff, lltol)
end 
