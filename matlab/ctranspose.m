function y=ctranspose(x)
% BLFLAB/CTRANSPOSE  A Transpose for multi-dimensional matrices


x=matrifil(x);


matrices=size(x.mtrx, 3);

for i=1:matrices
  y.mtrx(:, :, i)=x.mtrx(:,:,i)';
end
y=matrifil(y);
display(class(y))