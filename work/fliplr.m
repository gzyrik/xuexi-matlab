function y = fliplr(x)
%FLIPLR Flip matrix in left/right direction.
%   FLIPLR(X) returns X with row preserved and columns flipped
%   in the left/right direction.
%   
%   X = 1 2 3     becomes  3 2 1
%       4 5 6              6 5 4
%
%   See also FLIPUD, ROT90, FLIPDIM.

%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 5.9 $  $Date: 2002/04/08 20:21:05 $

if ndims(x)~=2, error('X must be a 2-D matrix.'); end
[m,n] = size(x);
y = x(:,n:-1:1);
