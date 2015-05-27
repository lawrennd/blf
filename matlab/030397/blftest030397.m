function [w, nd, v, lls]=blftimedtest(xin, niters)

%BLFTIMEDTEST Train a network to patterns given by xin for niters iterations
%
%      Descrtiption
%      [w, nd, v, lls]=blftest(xin, niters) framework for network training,
%      train the network to produce data xin. Use niters iterations
%
%      See Also
%      blf, blffwd, blfll, blfpak, blfunpak

%      Copyright (c) Neil D Lawrence (1997)

learnrate=0.15;

nrow1=4;
nrow2=24;
nrow3=64;
tol=1e-1;
npatterns=size(xin, 1);

lls=zeros(npatterns, niters+1);

[w, nd, v]=blf(nrow1, nrow2, nrow3);
[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);
fprintf(1, 'Likelihood    Pre Ascent      Post Ascent\n')

for k=1:niters
  [x, orderindex]=reorder(xin);
  TotalLikelihood=0;
  for l=1:npatterns;
    
    mu3=x(l,:);
    v(size(v, 2)-nrow3+1:size(v,2))=x(l,:);
    
    v=mfupdate(w, nd, v, tol);
    lls(l, k)=blfll(w, nd, v); 
    wg=blfgrad(w, nd, v); 

    w=w+learnrate*wg;
    % Should really update mean field parameters before doing this!
    L=blfll(w, nd, v);
    TotalLikelihood=TotalLikelihood+lls(l, k);
    %fprintf(1, 'Pattern %4d \t%3.2f \t\t%3.2f\n',l , lls(l, k), L)

  end
  %[discard, order]=sort(orderindex);
  lls(:, k)=lls(orderindex, k);
  avelike=TotalLikelihood/npatterns;
  fprintf(1, 'Iteration %4d complete, Average Likelihood %3.2f\n', k, avelike)

end

for l=1:npatterns;
  
  v=blfxiopt(w, nd, v, tol);
  v=blfmuopt(w, nd, v, 4);

  lls(l, k+1)=blfll(w, nd, v);

end



