function y=indfwd(probs, x)

probsm=ones(size(x, 1), 1)*probs;
y=x<probsm;
