function xmin = realmin
%REALMIN Smallest positive floating point number.
%   x = realmin is the smallest positive normalized floating point
%   number on this computer.  Anything smaller underflows or is
%   an IEEE "denormal".
%
%   See also EPS, REALMAX.

%   C. Moler, 7-26-91, 6-10-92.
%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.9 $  $Date: 2002/04/08 20:21:10 $

minexp = -1022;

% pow2(f,e) is f*2^e, computed by adding e to the exponent of f.

xmin = pow2(1,minexp);
