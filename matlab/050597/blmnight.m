% This is a test of the blm code. The data is all possible combinations of
% vertical and horizontal lines a la Hinton. The idea is to test it using a
% mixture model of two different networks. One hundred iterations should be
% appropriate (I hope) the learning rate etc is defined in the file
% blmtest050597 

clear all
load /user/cs_neural/lawrennd/lib/matlab/blmlab/050597/linesdata
[net, lls, initnet]=blmtest050597(data, 100, 2);
eval(['save trainmix2_' date ' net050597 lls'])
[net, lls, initnet]=blmtest050597(data, 100, 3, initnet);
eval(['save trainmix3_' date ' net050597 lls'])
[net, lls, initnet]=blmtest050597(data, 100, 4, initnet);
eval(['save trainmix4_' date ' net050597 lls'])
