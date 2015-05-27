function [w, nd, v, lls]=blftest080997(xin, niters)

% BLFTEST080997 Train a network to patterns given by xin for niters iterations
% 
%      Descrtiption
%      [w, nd, v, lls]=blftest(xin, niters) framework for network training,
%      train the network to produce data xin. Use niters iterations
% 
%      See Also
%      blf, blffwd, blfll, blfpak, blfunpak

%      Copyright (c) Neil D Lawrence (1997)

learnrate=0.05;

  
nrow1=8;
nrow2=24;
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

[w, nd, v]=blf080997(nrow1, nrow2, nrow3);

[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);
fprintf(1, 'Likelihood    Pre Ascent      Post Ascent\n')

for k=1:niters
  [x, orderindex]=reorder(xin);
  TotalLikelihood=0;
  for l=1:npatterns;
    v=rand(size(v));
    mu3=x(l,:);
    v(size(v, 2)-nrow3+1:size(v,2))=x(l,:);
    
    v=mfupdate(w, nd, v, options);
    lls(l, k)=blfll(w, nd, v); 
    
    wg=blfgrad(w, nd, v); 

    w=w+learnrate*wg;
    TotalLikelihood=TotalLikelihood+lls(l, k);

  end

  lls(:, k)=lls(orderindex, k);
  avelike=TotalLikelihood/npatterns;
  fprintf(1, 'Iteration %4d complete, Average Likelihood %3.3f\n', k, avelike)

end

v=mfupdate(w, nd, v, options);
lls(l, k+1)=blfll(w, nd, v);





