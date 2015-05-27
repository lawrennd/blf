function [w, nd, v, lls, llsi]=blftest100597(xin, niters, prob)

%BLFTES100597 Train a network to patterns given by xin for niters iterations
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
options(1)=1;
options(3)=0.01;
options(4)=0.01;
options(14)=10;
npatterns=size(xin, 1);
inith=invsigmoid(prob);
lls=zeros(npatterns, niters+1);
llsi=zeros(npatterns, 1);
[w, nd, v]=blf100597(nrow1, nrow2, nrow3);
[h1, JA, h2, JB, h3, xi1, mu1, xi2, mu2, xi3, mu3] = blfunpak(w, nd, v);
fid=1;% fopen('testlog', 'a');
% fprintf(1, 'Likelihood    Pre Ascent      Post Ascent\n')
h3=inith;
w = [h1, JA(:)', h2, JB(:)', h3];
% mu3=xin(1,:);
%  v(size(v, 2)-nrow3+1:size(v,2))=xin(1,:);
% v=mfupdate(w, nd, v, options);
% Ltrue=sum(mu3.*log(prob)+(1-mu3).*log(1-prob));
rand('seed', 0)
for k=1:niters
  
  
  [x, orderindex]=reorder(xin, k*npatterns*1000);
  TotalLikelihood=0;
  for l=1:npatterns;
    if ~rem(l,70) | l==1
      fprintf(fid, 'Pattern %4d:\n\n', l)
      options(1)=1;
    else
      options(1)=0;
    end
    mu3=x(l,:);
    v(size(v, 2)-nrow3+1:size(v,2))=x(l,:);
    
    v=mfupdate(w, nd, v, options);
    lls(l, k)=blfll(w, nd, v); 
    if k==1
      llsi(l, 1)=sum(mu3.*log(prob)+(1-mu3).*log(1-prob));
      if ~rem(l,70) | l==1
	
	fprintf(fid, '\nInd. Mod.\tMF LB\n%3.2f\t\t%3.2f\n\n', llsi(l, 1), lls(l, k))
      end
      
    end
    
    wg=blfgrad(w, nd, v); 

    w=w+learnrate*wg;
    % Should really update mean field parameters before doing this!
    L=blfll(w, nd, v);
    TotalLikelihood=TotalLikelihood+lls(l, k);
    if ~rem(l,70) | l==1
      fprintf(fid, 'Pre Ascent\tPost Ascent\n%3.2f \t\t%3.2f\n\n' , lls(l, k), L)
    end 				
    

  end
  %[discard, order]=sort(orderindex);
  lls(:, k)=lls(orderindex, k);
  avelike=TotalLikelihood/npatterns;
  fprintf(fid, 'Iteration %4d complete, Average Likelihood %3.3f\n', k, avelike)

end

v=mfupdate(w, nd, v, options);
lls(l, k+1)=blfll(w, nd, v);





