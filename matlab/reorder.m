function [y, orderindex]=reorder(x, seed);

%REORDER Re-orders the rows of a matrix randomly
%
%	Description
%
%	[y, orderindex]=reorder(x) reoders the rows of matrix x randomly 
%	into a new matrix x. The returned value orderindex gives the
%	indexing of this new matrix.
%
%        See Also
%	 blf, blfll, blfgrad, blfpak, blfunpak

%	Copyright (c) Neil D Lawrence (1997)	

if nargin==2
  rand('seed', seed)
elseif nargin==0
  rand('seed', sum(100*clock))
end

order=rand(size(x, 1), 1);
[t, orderindex] = sort(order);
y=x(orderindex, :);

