function ll=blftll(w, nd, data)
[h1, JA, h2, JB, h3] = blfunpak(w, nd);
mu3 = data;
state3 = mu3;
x=0;
% for i=0:2^net.nrow1-1
%   
%   x=abs(dec2bin(i))-48;
%   x=[zeros(1, net.nrow1 - size(x,2)) x];
  for j=0:2^nd(1)-1
    state1=abs(dec2bin(j))-48;
    state1=[zeros(1, nd(1)-size(state1, 2)) state1];
  
    prob1=state1.*sigmoid(h1) +  ...
	(1-state1).*(1-sigmoid(h1));
    for k=0:2^nd(2)-1
      x=x+1;
      state2=abs(dec2bin(k))-48;
      state2=[zeros(1, nd(2)-size(state2, 2)) state2];
      prob2=state2.*sigmoid(state1*JA' + h2) + ...
	  (1-state2).*(1-sigmoid(state1*JA' + h2));
      prob3=state3.*sigmoid(state2*JB' + h3) + ...
	  (1-state3).*(1-sigmoid(state2*JB' + h3));
      prob(x)=prodrow([prob1 prob2 prob3]);
    end
  end
% end
%prob=prob*1/(2^net.nrow1)

ll=log(sumrow(prob));
  
  
  
 