clear all

for i=0:9
  eval(['load /user/cs_neural/lawrennd/MIT/digits/tr' num2str(i)]) 
  [w, nd, v, lls]=blftest290497(a, 5);
  eval(['save train' num2str(i) '_' date ' w nd v lls a'])
end