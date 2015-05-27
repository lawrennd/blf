function plothint(x, ni, nj, samples)

%PLOTPATT For plotting matrix x made up of sub vectors in an image form.
%
%         Description
%         plotdata(x, ni, nj, samples) - plot the first 'samples' samples of
%         the data in matrix x in a ni*nj grid.
%         
%         See Also
%	  blf, blfll, blfgrad, blfpak, blfunpak
%

%	 Copyright (c) Neil D Lawrence (1997)

rows=round(sqrt(samples));
cols=ceil(samples/rows);

for i=1:samples

	subplot(rows, cols, i)
	mattern(x(i, :), ni, nj);

end 