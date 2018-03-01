function rmax = realmax
%REALMAX Largest positive floating point number.
%   x = realmax is the largest floating point number representable
%   on this computer.  Anything larger overflows.
%
%   See also EPS, REALMIN.

%   C. Moler, 7-26-91, 6-10-92, 8-27-93.
%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.9 $  $Date: 2002/04/08 20:21:10 $

% 2-eps is the largest floating point number smaller than 2.
f = 2-eps;
maxexp = 1023;

% pow2(f,e) is f*2^e, computed by adding e to the exponent of f.

rmax = pow2(f,maxexp);
