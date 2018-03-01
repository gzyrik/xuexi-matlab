function y = flipud(x)
%FLIPUD Flip matrix in up/down direction.
%   FLIPUD(X) returns X with columns preserved and rows flipped
%   in the up/down direction.  For example,
%   
%   X = 1 4      becomes  3 6
%       2 5               2 5
%       3 6               1 4
%
%   See also FLIPLR, ROT90, FLIPDIM.

%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 5.9 $  $Date: 2002/04/08 20:21:05 $

if ndims(x)~=2, error('X must be a 2-D matrix.'); end
[m,n] = size(x);
y = x(m:-1:1,:);
