% Sigmoid Belief Net Toolbox
% Version 1.0 11-Feb-97
% Copyright (c) 1997 Neil D Lawrence
% $Revision: 1 $
%
% blf		- Initialize parameters for net
% blffwd		- Run a forward pass of the net
% blfgrad	- Evaluate gradient of lll wrt weights & biases
% blfll		- Evaluate lll of the net
% blfmuest	- Re-estimate mean field parameter mu
% blfmuopt	- Optimize all the mu's
% blfpak		- Combine all parameter vectors into one
% blftest	- An example of how these functions may be applied
% blfunpak	- Un-combine the parameters
% blfxill	- The section of lll dependant on xi
% blfxiopt	- Optimize all the xi's
% gradchk	- Gradient checking to ensure optimizations are O.K.
% genlines      - generates some vertical lines for a data set 
% pattern	- Display vector as a grid image
% plotpatt	- Plot a data set of vectors as grids
% reorder	- Reorder a data set rowwise randomly
% minline       - inverse parabolic interpolation for line minimization
%
% lll = lower bound on log likelihood estimated through mean field theory
