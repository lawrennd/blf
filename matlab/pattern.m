function b=pattern(xin, ni, nj);

%PATTERN Display a vector as an image in an ni by nj size grid.
%
%        Description
%        b=pattern(xin, ni, nj) This function displays as an image the data
%        b which is produced from gridding xin in an ni row and nj colum
%        format. This helps to visualise generated data.
%
%        See Also
%	 blf, blfll, blfgrad, blfpak, blfunpak
%

%	 Copyright (c) Neil D Lawrence (1997)

if ni*nj~=size(xin,1)*size(xin, 2)

disp('Error ni * nj must equal number of elements in vector')

else

x=xin(:);

y=reshape(x, ni, nj)';
b=imagesc(y);
axis('image')
set(gca,'XLim',[.5 nj+.5], ...
     'YLim',[.5 ni+.5], ... 
     'XTick', [0.5:1:(nj+.5)], ...
     'YTick', [0.5:1:(ni+.5)], ...
     'XGrid', 'off', ...
     'YGrid', 'off', ...
     'XTickLabel', [], ...
     'YTickLabel', [], ...
     'GridLineStyle', '-')
   
end