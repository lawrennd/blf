function [w, nd, v, lls]=blftest220897(xin, tin, niters, win, ndin, vin)

% BLFTEST220897 Train a network to patterns given by xin (target tin)
%      for niters iterations
%
%      Descrtiption
%      [w, nd, v, lls]=blftest(xin, niters) framework for network training,
%      train the network to produce data xin. Use niters iterations
%
%      See Also
%      blf, blffwd, blfll, blfpak, blfunpak

%      Copyright (c) Neil D Lawrence (1997)

learnrate=0.05;

  
nrow1=1;
nrow2=30;
nrow3=64;
tol=1e-1;
maxiter=10; 				% Maximum passes through algotrithm
linemintol=0.01; 			% tolerance criteria in linemin
percoflll=0.01; 			% % change in lll for stop
display=0;
options(14)=maxiter;
options(3)=percoflll;
options(4)=linemintol;
options(1)=display;           
npatterns=size(xin, 1);
lls=zeros(npatterns, niters+1);

if nargin<4
  [w, nd, v]=blf220897(nrow1, nrow2, nrow3);
else
  w=win;
  v=vin;
  nd=ndin;
end

[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);
fprintf(1, 'Likelihood    Pre Ascent      Post Ascent\n')

for k=1:niters
  [x, orderindex]=reorder(xin);
  t=tin(orderindex, :);
  TotalLikelihood=0;
  for l=1:npatterns;
    v=rand(size(v));
    mu3=x(l,:);
    if t(l, 1)==2;            % Unsupervised data
      options(15)=1;
      mu1=0.5;               % Prior on mu1 for unsupervised
      v(nrow1+1)=mu1;
    else
      options(15)=0;
      mu1=t(l, :);
      v(nrow1+1)=mu1;
    end
    
    v(size(v, 2)-nrow3+1:size(v,2))=x(l,:);
    
    v=mfupdateopt(w, nd, v, tol, options);
    lls(l, k)=blfll(w, nd, v); 
    
    wg=blfgrad(w, nd, v); 

    w=w+learnrate*wg;
    % Should really update mean field parameters before doing this!
    %L=blfll(w, nd, v);
    TotalLikelihood=TotalLikelihood+lls(l, k);
    %fprintf(1, 'Pattern %4d \t%3.2f \t\t%3.2f\n',l , lls(l, k), L)

  end
  %[discard, order]=sort(orderindex);
  lls(:, k)=lls(orderindex, k);
  avelike=TotalLikelihood/npatterns;
  fprintf(1, 'Iteration %4d complete, Average Likelihood %3.3f\n', k, avelike)

end

v=mfupdate(w, nd, v, tol);
lls(l, k+1)=blfll(w, nd, v);





