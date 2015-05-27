function minxi = minline(mu_row, J_row, h_i, tol);

% MINLINE Inverse parabolic interpolation line minimization method. 
%
%    Description
%    This is line minimization which relies on inverse parabolic 
%    interpolation to find the minimum. We must know that the function
%    is convex in order to apply it
%    
%    See Also
%    blf, blfll, blfgrad, blfpak, blfunpak
%    

%    Copyright (c) Neil D Lawrence (1997)

diffy=1;
diffx=1;
y=zeros(3, 1);

x=[0; .5; 1];
y=blfxill(x, mu_row, J_row, h_i);
counter=0;
maxiter=7;

lltol=abs(tol*y(2)); 		% Tolerance is 1% of likelihood
diffy=lltol+1; 			% Difference >Tolerance

while abs(diffy)>lltol & counter<maxiter
  counter=counter+1; 			% for i=1:1
  
  y23=y(2)-y(3);
  y21=y(2)-y(1);
  x23=x(2)-x(3);
  x21=x(2)-x(1);
  %min of fitted parabola
  denom=(x21*y23-x23*y21);
  if denom~=0
    xmin=x(2)-0.5*((x21*x21*y23-x23*x23*y21)/denom);

    if xmin<0
      xmin=0;% For the case when the parabola would be skewed left.
    end  
    if xmin>1
      xmin=1;% FOr the case when the parabola would be skewed right.
    end
    
  else 
    % fprintf('minline:points are colinear\n')
    % Need to think of something intelligent for this eventuality
    xmin=x(2);
  end
  
  diffx=x(2)-xmin;
  xold=x(2);
  x=[x(2); xmin; x(2)+2*diffx];
  yold=y(2);
  y=blfxill(x, mu_row, J_row, h_i);
  diffy=y(2)-yold;
  lltol=abs(tol*y(2));

end

if counter==maxiter
  fprintf(['Maximum iterations reached in minline\n' ...
	  'last change %1.4f\ttolerance %1.4f\tvalue %1.4f\n'] ...
          , diffy,lltol, x(2))
end
minxi=x(2);
