clear all
data=[];
rand('seed',0) 
randn('seed', 0)
for i=2:3
  eval(['load /user/cs_neural/lawrennd/MIT/digits/vs4tr' num2str(i)])  
  data=[data; a];
end
rand('seed', 0)
randn('seed', 0)
[w, nd, v, lls]=blftest080997(data, 5);
eval(['save train_' date ' w nd v lls data'])
