function [x, options, errlog, scalelog] = scg(f, x, options, gradf, ...
                                    P1, P2, P3, P4, P5, P6, P7, P8, P9, P10)
%SCG	Scaled conjugate gradient optimization.
%
%	Description
%	scg('f', x, options, gradf) uses a scaled conjugate gradient
%	algorithm to find the minimum of the function f(x) whose gradient is
%	given by gradf(x).  Here x is a row vector and f returns a scalar
%	value.   scg(f, x, options, gradf, p1, ..., p10) allows up to 10
%	additional arguments to be passed to f() and gradf().     The
%	optional parameters have the following interpretations.
%
%	options(1) is set to 1 to display error values; also logs error
%	values in the return argument errlog, and values of the scaling
%	parameter in the return argument scalelog.
%
%	options(2) is a measure of the precision required for the value of x
%	at the solution.
%
%	options(3) is a measure of the precision required of the objective
%	function at the solution.  Both this and the previous condition must
%	be satisfied for termination.
%
%	options(9) is set to 1 to check user defined gradient function.
%
%	options(14) is the maximum number of iterations; default 100.
%

%	Copyright (c) Christopher M Bishop and Ian T Nabney (1996)

%  Set up the options.

if(options(14))
  niters = options(14);
else
  niters = 100;
end

options = foptions(options);

display = options(1);
gradcheck = options(9);

funcstr = [f];
funcstr=[funcstr, '(x'];
for i=1:nargin - 4
  funcstr = [funcstr,',P',int2str(i)];
end
funcstr = [funcstr, ')'];

gradstr = [gradf];
    gradstr=[gradstr, '(x'];
for i=1:nargin - 4
    gradstr = [gradstr,',P',int2str(i)];
end
gradstr = [gradstr, ')'];

%  Check gradients

nparams = length(x);

if(gradcheck)
  epsilon = 1.0e-6;
  xorig = x;
  deltaf = zeros(size(x));
  for i = 1:nparams
    x(i) = xorig(i) + epsilon;
    fplus = eval(funcstr);
    x(i) = xorig(i) - epsilon;
    fminus = eval(funcstr);
    deltaf(i) = 0.5*(fplus - fminus)/epsilon;
    x(i) = xorig(i);
  end
  gradient = eval(gradstr);
  fprintf(1, 'Checking gradient ...\n\n');
  fprintf(1, '   analytic   diffs     delta\n\n');
  disp([gradient', deltaf', gradient' - deltaf'])
end

% Main optimization loop.

errlog = zeros(1, niters);
scalelog = zeros(1, niters);

sigma0 = 1.0e-4;
fold = eval(funcstr);	% Initial function value.
options(10) = options(10) + 1;	% Increment function evaluation counter.
grad = eval(gradstr);	% Initial gradient.
options(11) = options(11) + 1;	% Increment gradient evaluation counter.
srch = - grad;		% Initial search direction.
success = 1;
lambda = 1.0;		% Initial scale parameter.
lambdamin = 1.0e-15; 
lambdamax = 1.0e100;
n = 1;			% n counts number of iterations.
nsuccess = 0;		% nsuccess counts number of successes.
xval = x;

while (n <= niters)

  % Calculate first and second directional derivatives.

  if (success == 1)
    mu = srch*grad';
    if (mu >= 0)
      srch = - grad;
      mu = srch*grad';
    end
    kappa = srch*srch';
    sigma = sigma0/sqrt(kappa);
    x = xval + sigma*srch;
    gplus = eval(gradstr);
    options(11) = options(11) + 1; 
    gamma = (srch*(gplus' - grad'))/sigma;
  end

  % Increase effective curvature and evaluate step size alpha.

  delta = gamma + lambda*kappa;
  if (delta <= 0) 
    delta = lambda*kappa;
    lambda = lambda - gamma/kappa;
  end
  alpha = - mu/delta;
  
  % Calculate the comparison ratio.

  x = xval + alpha*srch;
  fnew = eval(funcstr);
  options(10) = options(10) + 1;
  rho = 2*(fnew - fold)/(alpha*mu);
  if (rho  >= 0)
    success = 1;
  else
    success = 0;
  end

  % Update the parameters to new location.

  if (success == 1)
    xval = xval + alpha*srch;
    nsuccess = nsuccess + 1;
    x = xval;
    fold = fnew;
  end

  if (display)
    errlog(n) = fold;
    scalelog(n) = lambda;
    fprintf(1, 'Cycle %4d  Error %11.6f  Scale %e\n', n, fold, lambda);
  end

  if (success == 1)
    % Test for termination

    if (max(abs(alpha*srch)) < options(2) & max(abs(fnew-fold)) < options(3))
      options(8) = fold;
      return;

    else
      gold = grad;
      grad = eval(gradstr);
      options(11) = options(11) + 1;
    end
  end

  % Adjust lambda according to comparison ratio.

  if (rho < 0.25)
    lambda = 4.0*lambda;
    if (lambda > lambdamax)
      lambda = lambdamax;
    end
  end
  if (rho > 0.75)
    lambda = 0.5*lambda;
    if (lambda < lambdamin)
      lambda = lambdamin;
    end
  end

  % Re-compute search direction using Hestenes-Steifel formula, or re-start 
  % in direction of negative gradient after nparams steps.

  if (nsuccess == nparams)
    srch = -grad;
    nsuccess = 0;
  else
    if (success == 1)
      beta = (gold - grad)*grad'/mu;
      srch = - grad + beta*srch;
    end
  end
  n = n + 1;
end

% If we get here, then we haven't terminated in the given number of 
% iterations.

options(8) = fold;
if (options(1) >= 0)
  disp('Warning: Maximum number of iterations has been exceeded');
end

