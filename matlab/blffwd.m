function [y3, y2, y1] = blffwd(w, nd, ndata)
%BLFFWD Forward propagation through 2-layer belief network.
%
%	Description
%	y = blffwd(w, nd, x) takes a belief network vector w together with
%	the network description vector nd and a matrix x of input vectors,
%	and forward propagates the inputs through the network to generate a
%	matrix y of output vectors. Each row of x corresponds to one input
%	vector and each row of y corresponds to one output vector.
%
%	[y, z] = blffwd(w, nd, x) also generates a matrix z of the hidden
%	unit activations where each row corresponds to one pattern.
%
%	[y, z, a] = blffwd(w, nd, x) also returns a matrix a  giving the
%	summed inputs to each output unit, where each row  corresponds to one
%	pattern.
%
%	See Also
%	blf, blfll, blfgrad, blfpak, blfunpak
%

%	Copyright (c) Neil D Lawrence (1997)

% ndata = size(x, 1);

[h1, JA, h2, JB, h3] = blfunpak(w, nd);
%row1p = sigmoid(x + ones(ndata, 1)*h1);	% Calculate probabilites in first row
row1p = sigmoid(ones(ndata, 1)*h1);
row1rand = rand(size(row1p));
y1 = row1rand<row1p;

row2p = sigmoid(y1*JA' + ones(ndata, 1)*h2);
row2rand = rand(size(row2p));
y2 = row2rand<row2p;

row3p = sigmoid(y2*JB' + ones(ndata, 1)*h3);
row3rand = rand(size(row3p));
y3 = row3rand<row3p;

