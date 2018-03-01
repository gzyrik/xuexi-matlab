function y = flipdim(x,dim)
%FLIPDIM Flip matrix along specified dimension.
%   FLIPDIM(X,DIM) returns X with dimension DIM flipped.  
%   For example, FLIPDIM(X,1) where
%   
%       X = 1 4  produces  3 6
%           2 5            2 5
%           3 6            1 4
%
%   See also FLIPLR, FLIPUD, ROT90, PERMUTE.

%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 1.17 $  $Date: 2002/04/08 20:21:05 $

if nargin~=2, error('MATLAB:flipdim:requiresTwoArgs', 'Requires two arguments.'); end
dim = floor(dim);
if dim<=0, error('MATLAB:flipdim:dimMustBePositiveNonzeroInteger', 'DIM must be a positive nonzero integer.'); end
siz = [size(x) ones(1,max(dim-ndims(x),0))];
v = cell(size(siz));
for i=1:length(siz),
  v(i) = {':'};
end
v(dim) = {siz(dim):-1:1}; % Flip dimension v
y = x(v{:}); % "Index with v" and flip dimension v.

