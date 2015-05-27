function [net, lltrack]=anneal(netin, options)

% MMFUPDATE Mixtures of mean field update
% 
%     netout=mmfupdate(netin)


if nargin==1
  maxiter=10; 				% Maximum passes through algotrithm
  linemintol=0.01; 			% tolerance criteria in minline
  percoflll=0.01; 			% % change in lll for stop
  display=0;
elseif nargin==2
  maxiter=options(14);
  percoflll=options(3);
  linemintol=options(4);
  display=options(1);
end

net=netin;


counter=0;
nrow3=net.nrow3;
nrow2=net.nrow2;
nrow1=net.nrow1;
nnodes=net.nnodes;
nmix=net.mix.nmix;
w=blmpak(net);
nd(1)=net.nrow1;nd(2)=net.nrow2; nd(3)=net.nrow3;  
for factor=3:-.2:0

  if display
    fprintf('lltrack\tlltkold\tlltol\tlldiff\n') 
  end
  wan=w*10^factor;
  net.w= blmunpak(wan, nd);
  JA=nrepmat(net.w.JA, 3, nmix); 	
  JB=nrepmat(net.w.JB, 3, nmix);
  JBt=nrepmat(ctranspose3d(net.w.JB), 3, nmix);
  JAt=nrepmat(ctranspose3d(net.w.JA), 3, nmix);
  h1=nrepmat(net.w.h1, 3, nmix); 	
  h2=nrepmat(net.w.h2, 3, nmix); 	
  h3=nrepmat(net.w.h3, 3, nmix); 	

  % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  net=blmlaopt(net); 			% Optimise the lambdas
  lambdam=repmat(net.mix.lambda, [1 nmix]);
  slambda=shiftdim(net.mix.lambda, -2);
  slambdam=cat(2, slambda, slambda);
  net=blmcoopt(net); 			% Optimise the mixture coefficients
  scoeff=shiftdim(net.mix.coeff, -2);
  coeffm=cat(2, scoeff, scoeff);
  coeffm2=nrepmat(permute(coeffm, [1 2 4 3]), 3, nmix); 

  % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
  for ind=1:nrow3 			% Optimise the mu's in row 3
    
    index=ind+nrow2+nrow1;  
    pi_j=permute(blmpi(net, index), [3 4 1 2]);
    R_i=net.mix.R_i(index, :, :);
    pim=pigrad(net, index);
    mu=permute(cat(2, net.mf.mu1, net.mf.mu2, net.mf.mu3), [2 1 3]);
    
    net.mf.mu3(:,ind,:) = sigmoid(h3(:, ind, :)+ ...
	mtimes3d(JB(ind, :, :),ctranspose3d(net.mf.mu2)) + ...
	shiftdim(hgrad(R_i), -2)-... 	% Why not just pull hgrad in here??
	shiftdim(sumn(lambdam.*pim, 1), -1));
    
    net.mf.mu3(:,ind,:) = net.mf.mu3(:,ind,:)+...
	eps*(net.mf.mu3(:,ind,:)==0)-... % allowing mu to go to 1 or zero
	eps*(net.mf.mu3(:,ind,:)==1); 	% creates some numerical problems
      
    Q_i=cat(2, 1-net.mf.mu3(1,ind,:), ...
	net.mf.mu3(1,ind,:)); 
    
    Q_im=nrepmat(permute(Q_i, [1 2 4 3]), 3, nmix); 
    
    pimat=blmpi(net, index);
    
    pi_RQjm=nrepmat(permute(pimat, [3 4 1 2]), 2, 2);
    
    denom=(slambdam.*(sumn(coeffm2.*Q_im.*pi_RQjm, 4)));
    denom=denom+eps*(denom==0);
    
    numer=(coeffm.*Q_i);
    numer=numer+eps*(numer==0);
    
    R_est=numer./denom;
    normalise=sum(R_est, 2);
    net.mix.R_i(index, :, :)=R_est./cat(2, normalise, normalise);
    
    net=blmlaopt(net); 			% Optimise the lambdas
    lambdam=repmat(net.mix.lambda, [1 nmix]);
    slambda=shiftdim(net.mix.lambda, -2);
    slambdam=cat(2, slambda, slambda);
    net=blmcoopt(net); 			% Optimise the mixture coefficients
    scoeff=shiftdim(net.mix.coeff, -2);
    coeffm=cat(2, scoeff, scoeff);
    coeffm2=nrepmat(permute(coeffm, [1 2 4 3]), 3, nmix); 
       
  end
  % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for ind=1:nrow2 			% Optimise row2 R's
    
    index=ind+nrow1;
    Q_i=cat(2, 1-net.mf.mu2(1,ind,:), ...
	net.mf.mu2(1,ind,:)); 
    Q_im=nrepmat(permute(Q_i, [1 2 4 3]), 3, nmix); 
    
    pimat=blmpi(net, index);
    pi_RQjm=nrepmat(permute(pimat, [3 4 1 2]), 2, 2);
    denom=(slambdam.*(sumn(coeffm2.*Q_im.*pi_RQjm, 4)));    
    denom=denom+eps*(denom==0);
    numer=(coeffm.*Q_i);
    numer=numer+eps*(numer==0);
    R_est=numer./denom;
    normalise=sum(R_est, 2);
    net.mix.R_i(index, :, :)=R_est./cat(2, normalise, normalise);
    
  end
  % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for ind=1:nrow1 			% Optimise row1 R's                          
    index=ind;
    Q_i=cat(2, 1-net.mf.mu1(1,ind,:), ...
	net.mf.mu1(1,ind,:)); 
    Q_im=nrepmat(permute(Q_i, [1 2 4 3]), 3, nmix); 
    
    pimat=blmpi(net, index);
    pi_RQjm=nrepmat(permute(pimat, [3 4 1 2]), 2, 2);
    denom=(slambdam.*(sumn(coeffm2.*Q_im.*pi_RQjm, 4)));
    denom=denom+eps*(denom==0);
    numer=(coeffm.*Q_i);
    numer=numer+eps*(numer==0);
    R_est=numer./denom;
    normalise=sum(R_est, 2);
    net.mix.R_i(index, :, :)=R_est./cat(2, normalise, normalise);
    
  end  
  
  lltrack=blmmixb(net); 		% Initial likelihood value
  lltol=abs(percoflll*lltrack); 	% Tolerance is 1% of likelihood
  lldiff=lltol+1; 			% Difference >Tolerance
  
  
  while lldiff>lltol & counter<maxiter 	% do until difference < 1% or 10 times
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    for ind=1:nrow3 			% Optimise the mu's in row 3
      
      index=ind+nrow2+nrow1;  
      pi_j=permute(blmpi(net, index), [3 4 1 2]);
      R_i=net.mix.R_i(index, :, :);
      pim=pigrad(net, index);
      mu=permute(cat(2, net.mf.mu1, net.mf.mu2, net.mf.mu3), [2 1 3]);
      
      net.mf.mu3(:,ind,:) = sigmoid(h3(:, ind, :)+ ...
	  mtimes3d(JB(ind, :, :),ctranspose3d(net.mf.mu2)) + ...
	  shiftdim(hgrad(R_i), -2)-... 	% Why not just pull hgrad in here??
	  shiftdim(sumn(lambdam.*pim, 1), -1));
      
      net.mf.mu3(:,ind,:) = net.mf.mu3(:,ind,:)+...
	  eps*(net.mf.mu3(:,ind,:)==0)-... % allowing mu to go to 1 or zero
	  eps*(net.mf.mu3(:,ind,:)==1); % creates some numerical problems
      
      Q_i=cat(2, 1-net.mf.mu3(1,ind,:), ...
	  net.mf.mu3(1,ind,:)); 
      
      Q_im=nrepmat(permute(Q_i, [1 2 4 3]), 3, nmix); 
      
      pimat=blmpi(net, index);
      
      pi_RQjm=nrepmat(permute(pimat, [3 4 1 2]), 2, 2);
      
      denom=(slambdam.*(sumn(coeffm2.*Q_im.*pi_RQjm, 4)));
      denom=denom+eps*(denom==0);
      
      numer=(coeffm.*Q_i);
      numer=numer+eps*(numer==0);
      
      R_est=numer./denom;
      normalise=sum(R_est, 2);
      net.mix.R_i(index, :, :)=R_est./cat(2, normalise, normalise);
      
      net=blmlaopt(net); 		% Optimise the lambdas
      lambdam=repmat(net.mix.lambda, [1 nmix]);
      slambda=shiftdim(net.mix.lambda, -2);
      slambdam=cat(2, slambda, slambda);
      net=blmcoopt(net); 		% Optimise the mixture coefficients
      scoeff=shiftdim(net.mix.coeff, -2);
      coeffm=cat(2, scoeff, scoeff);
      coeffm2=nrepmat(permute(coeffm, [1 2 4 3]), 3, nmix); 
      
    end
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    for i=1:nrow3 			% Optimise the xi's in row 3
      for j=1:nmix
	net.mf.xi3(1, i, j)=minline(net.mf.mu2(:, :, j), net.w.JB(i, :), ...
	    net.w.h3(i), linemintol);
      end
    end
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xi3m = nrepmat(net.mf.xi3, 1, nrow2); 	
    
    for ind=1:nrow2 			% Optimise the mu's in row 2
      
      index=ind+nrow1;  
      pi_j=permute(blmpi(net, index), [3 4 1 2]);
      R_i=net.mix.R_i(index, :, :);
      pim=pigrad(net, index);
      mu=permute(cat(2, net.mf.mu1, net.mf.mu2, net.mf.mu3), [2 1 3]);
      % index k is parents of the row
      mu2m = nrepmat(ctranspose3d(net.mf.mu2), 2, nrow3);
      phi3 = exp(h3).* ...
	  prod(1-mu2m+mu2m.*exp((1-xi3m).*JBt), 1)./( ...
	  prod(1-mu2m+mu2m.*exp(-xi3m.*JBt), 1) + ...
	  exp(h3).*prod(1-mu2m+mu2m.*exp((1-xi3m).*JBt), 1));
      
      phi3m = nrepmat(phi3, 1, nrow2); 
      
      K_ji = (1-phi3m).*(1-exp(-xi3m.*JBt))./...
	  (1-mu2m+mu2m.*exp(-xi3m.*JBt)) + ...
	  phi3m.*(1-exp((1-xi3m).*JBt))./ ...
	  (1-mu2m+mu2m.*exp((1-xi3m).*JBt));
      
      net.mf.mu2(:,ind,:) = sigmoid(h2(:, ind, :)+ ...
	  mtimes3d(JA(ind, :, :),ctranspose3d(net.mf.mu1)) + ...
	  mtimes3d((net.mf.mu3-net.mf.xi3), ctranspose3d(JBt(ind, :, :))) +...
	  sumn(K_ji(ind, :, :), 2)+...
	  shiftdim(hgrad(R_i), -2)-... 	% Why not just pull hgrad in here??
	  shiftdim(sumn(lambdam.*pim, 1), -1));
      
      net.mf.mu2(:,ind,:) = net.mf.mu2(:,ind,:)+...
	  eps*(net.mf.mu2(:,ind,:)==0)-... % allowing mu to go to 1 or zero
	  eps*(net.mf.mu2(:,ind,:)==1); % creates some numerical problems
      
      Q_i=cat(2, 1-net.mf.mu2(1,ind,:), ...
	  net.mf.mu2(1,ind,:)); 
      
      Q_im=nrepmat(permute(Q_i, [1 2 4 3]), 3, nmix); 
      
      pimat=blmpi(net, index);
      
      pi_RQjm=nrepmat(permute(pimat, [3 4 1 2]), 2, 2);
      
      denom=(slambdam.*(sumn(coeffm2.*Q_im.*pi_RQjm, 4)));
      denom=denom+eps*(denom==0);
      
      numer=(coeffm.*Q_i);
      numer=numer+eps*(numer==0);
      
      R_est=numer./denom;
      normalise=sum(R_est, 2);
      net.mix.R_i(index, :, :)=R_est./cat(2, normalise, normalise);
      
      net=blmlaopt(net); 		% Optimise the lambdas
      lambdam=repmat(net.mix.lambda, [1 nmix]);
      slambda=shiftdim(net.mix.lambda, -2);
      slambdam=cat(2, slambda, slambda);
      net=blmcoopt(net); 		% Optimise the mixture coefficients
      scoeff=shiftdim(net.mix.coeff, -2);
      coeffm=cat(2, scoeff, scoeff);
      coeffm2=nrepmat(permute(coeffm, [1 2 4 3]), 3, nmix); 
    end
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    for i=1:nrow2 			% Optimise the xi's in row 2
      for j=1:nmix
	net.mf.xi2(1, i, j) = minline(net.mf.mu1(:, :, j), net.w.JA(i, :), ...
	    net.w.h2(i), linemintol); 
      end
    end
    net=blmlaopt(net); 			% Optimise the lambdas
    lambdam=repmat(net.mix.lambda, [1 nmix]);
    slambda=shiftdim(net.mix.lambda, -2);
    slambdam=cat(2, slambda, slambda);
    net=blmcoopt(net); 			% Optimise the mixture coefficients
    scoeff=shiftdim(net.mix.coeff, -2);
    coeffm=cat(2, scoeff, scoeff);
    coeffm2=nrepmat(permute(coeffm, [1 2 4 3]), 3, nmix); 
    
    xi2m = nrepmat(net.mf.xi2, 1, nrow1); 	
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    for ind=1:nrow1 			% Optimise mu's in row 1 
      
      index=ind;
      pi_j=permute(blmpi(net, index), [3 4 1 2]);
      R_i=net.mix.R_i(index, :, :);
      pim=pigrad(net, index);
      mu=permute(cat(2, net.mf.mu1, net.mf.mu2, net.mf.mu3), [2 1 3]); 
      
      mu1m = nrepmat(ctranspose3d(net.mf.mu1), 2, nrow2);
      
      phi2 = exp(h2).* ...
	  prod(1-mu1m+mu1m.*exp((1-xi2m).*JAt), 1)./( ...
	  prod(1-mu1m+mu1m.*exp(-xi2m.*JAt), 1) + ...
	  exp(h2).*prod(1-mu1m+mu1m.*exp((1-xi2m).*JAt), 1));
      
      phi2m = repmat(phi2, [nrow1 1 1]);
      
      K_ji = (1-phi2m).*(1-exp(-xi2m.*JAt))./ ...
	  (1-mu1m+mu1m.*exp(-xi2m.*JAt)) + ...
	  phi2m.*(1-exp((1-xi2m).*JAt))./ ...
	  (1-mu1m+mu1m.*exp((1-xi2m).*JAt));
      
      net.mf.mu1(:,ind,:) = sigmoid(h1(:,ind, :)+...
	  mtimes3d((net.mf.mu2-net.mf.xi2),ctranspose3d(JAt(ind, :, : ))) + ...
	  sumn(K_ji(ind, :, :), 2)+...
	  shiftdim(hgrad(R_i), -2)-...
	  shiftdim(sumn(lambdam.*pim, 1), -1));
    
      net.mf.mu1(:,ind,:) = net.mf.mu1(:,ind,:)+...
	  eps*(net.mf.mu1(:,ind,:)==0)-... % allowing mu to go to 1 or zero
	  eps*(net.mf.mu1(:,ind,:)==1); % creates some numerical problems
      
      Q_i=cat(2, 1-net.mf.mu1(1,ind,:), ...
	  net.mf.mu1(1,ind,:)); 
      
      Q_im=nrepmat(permute(Q_i, [1 2 4 3]), 3, nmix); 
      pimat=blmpi(net, index);
      pi_RQjm=nrepmat(permute(pimat, [3 4 1 2]), 2, 2);
      denom=(slambdam.*(sumn(coeffm2.*Q_im.*pi_RQjm, 4)));
      denom=denom+eps*(denom==0);
      numer=(coeffm.*Q_i);
      numer=numer+eps*(numer==0);
      R_est=numer./denom;
      normalise=sum(R_est, 2);
      net.mix.R_i(index, :, :)=R_est./cat(2, normalise, normalise);
      
      net=blmlaopt(net); 		% Optimise the lambdas
      lambdam=repmat(net.mix.lambda, [1 nmix]);
      slambda=shiftdim(net.mix.lambda, -2);
      slambdam=cat(2, slambda, slambda);
      net=blmcoopt(net); 		% Optimise the mixture coefficients
      scoeff=shiftdim(net.mix.coeff, -2);
      coeffm=cat(2, scoeff, scoeff);
      coeffm2=nrepmat(permute(coeffm, [1 2 4 3]), 3, nmix); 
      
    end
    
    lltrackold=lltrack;
    lltrack=blmmixb(net);
    lldiff=lltrack-lltrackold;
    lltol=abs(percoflll*lltrackold);
    
    if lldiff<0
      fprintf('Log Likelihood has decreased by %1.4f\n', lldiff)
    end
    
    if display
      fprintf(' %3.2f\t%3.2f\t%2.3f\t%2.3f\n', ...
	  lltrack, lltrackold, lltol, lldiff) 
    end 		
  end
  
  
  if counter==maxiter
    fprintf(['Maximum iterations reached in mmfupdate\n' ...
	    'last change %2.2f\ttolerance %2.2f\n'], lldiff, lltol)
  end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pie=blmpi(net, j, k)

% BLMPI The equation for the quantity PI eqn. 25 Tommi's paper
% 
%    Description
%    pie=blmpi(net, j) The output is of the form m on dimension 1, m' on
%    dimension 2 and if more than 1 j is specified j on dimension 3.
%   
%    See Also
%   
%   

%   Copyright (c) Neil D Lawrence (1997) Version 2.0 for MATLAB vs 5.0


% Can remove all the code accounting for k
Q_i=blmqi(net);
Q_im=permute(nrepmat(Q_i, 4, net.mix.nmix), [1 2 4 3]);
R_i=net.mix.R_i;
R_im=nrepmat(R_i, 4, net.mix.nmix);
nodes=net.nnodes;
nmix=net.mix.nmix;

if nargin==1
  
  pie=squeeze(prod(sumn(R_im.*Q_im, 2), 1));

elseif nargin==2 & j==0;
  
  pie=squeeze(prod(sumn(R_im.*Q_im, 2), 1));

elseif (nargin==2 & max(j>0 & j<nodes+1)) 
  
  numberofvalues=max(size(j));
  permuter=[1:j(1)-1 j(1)+1:nodes];
  R_im2=R_im(permuter, :, :, :);
  Q_im2=Q_im(permuter, :, :, :);
  pie=squeeze(prod(sumn(R_im2.*Q_im2, 2),1));
  
  if numberofvalues>1
    for i=2:numberofvalues;
      permuter=[1:j(i)-1 j(i)+1:nodes];
      R_im2=R_im(permuter, :, :, :);
      Q_im2=Q_im(permuter, :, :, :);
      pie=cat(3, pie, squeeze(prod(sumn(R_im2.*Q_im2, 2),1)));
    end
  end
else
  error('If j is defined, it must be less than the number of nodes')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function g=pigrad(net, index)

% PIGRAD Evaluation of the gradient of pi wrt mu 
%
%    Description
%    g=pigrad(net, index) for checking code, will eventually be either
%    discarded or incorporated into existing code
if nargin==2
  nmix=net.mix.nmix;
  Rm=nrepmat(net.mix.R_i(index, 2, :)-net.mix.R_i(index, 1, :), ...
      4, nmix); 			%[1 1 1 nmix]);
  pi_j=permute(blmpi(net, index), [3 4 1 2]);
  g = squeeze(Rm.*pi_j);
else

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y=mtimes3d(a, b)

% MTIMES3D Multiplying two 3D arrays together like an matrix array.
% 
%    y=mtimes3d(a, b)

%    Copyright Neil D Lawrence 1997

y=zeros(size(a, 1), size(b, 2), size(a, 3));
if ndims(a)>3 | ndims(b)>3
  error('Both multiplicands must have less than 3 dimensions')
end

if size(a, 2)~=size(b, 1)
  error('Inner matrix dimensions must agree')
end

matrices=size(a, 3);
y=zeros(size(a, 1), size(b, 2), size(a, 3));

for i=1:matrices
  y(:,:,i)=a(:,:,i)*b(:,:,i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y=ctranspose3d(a)

% CTRANSPOSE3D Transpose a 3D array like an array of matrices
% 
%    y=ctranspose3d(a)

%    Copyright Neil D Lawrence 1997

y=permute(a, [2 1 3]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function g=hgrad(R_i)

g=squeeze(log(R_i(:, 2, :)./R_i(:, 1, :))); 
