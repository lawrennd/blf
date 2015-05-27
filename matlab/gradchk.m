function gradchk(w, nd, v, weights)

%GRADCHK Gradient checker for a belief net.
%
%        Description
%        gradchk(w, nd, v, weights) This function can be used to calculate 
%        that gradients a are being calculated correctly wrt weights and
%        biases. To use this option set the parameter weights to 1. To check
%        the wrt the mean field parameters set weights to zero.
%
%        See Also
%	 blf, blfll, blfgrad, blfpak, blfunpak
%

%	 Copyright (c) Neil D Lawrence (1997)

epsilon = 1.0e-6;
  
if weights==1 
  worig = w;
  deltaf = zeros(size(w));
  
  for i = 1:size(w, 2)
    w(i) = worig(i) + epsilon;
    fplus = blfll(w, nd, v);
    w(i) = worig(i) - epsilon;
    fminus = blfll(w, nd, v);
    deltaf(i) = 0.5*(fplus - fminus)/epsilon;
    w(i) = worig(i);
  end
  gradient = blfgrad(w, nd, v);
  fprintf(1, 'Checking gradient ...\n\n');
  fprintf(1, '   analytic   diffs     delta\n\n');
  disp([gradient', deltaf', gradient' - deltaf'])
elseif weights==0
  vorig = v;
  deltaf = zeros(size(v));
  
  for i = 1:size(v, 2)
    v(i) = vorig(i) + epsilon;
    fplus = blfll(w, nd, v);
    v(i) = vorig(i) - epsilon;
    fminus = blfll(w, nd, v);
    deltaf(i) = .5 * (fplus - fminus)/epsilon;
    v(i) = vorig(i);
  end
  
  fprintf(1, 'Checking gradient ...\n\n');
  %fprintf(1, '   analytic   diffs     delta\n\n');
  disp( deltaf')
else
  disp('Error weights should be 1 or 0')
end