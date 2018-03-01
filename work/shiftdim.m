function [b,nshifts] = shiftdim(x,n)
%SHIFTDIM Shift dimensions.
%   B = SHIFTDIM(X,N) shifts the dimensions of X by N.  When N is
%   positive, SHIFTDIM shifts the dimensions to the left and wraps the
%   N leading dimensions to the end.  When N is negative, SHIFTDIM
%   shifts the dimensions to the right and pads with singletons.
%
%   [B,NSHIFTS] = SHIFTDIM(X) returns the array B with the same
%   number of elements as X but with any leading singleton 
%   dimensions removed. NSHIFTS returns the number of dimensions 
%   that are removed. If X is a scalar, SHIFTDIM has no effect.
%
%   SHIFTDIM is handy for creating functions that, like SUM
%   or DIFF, work along the first non-singleton dimension.
%
%   Examples:
%       a = rand(1,1,3,1,2);
%       [b,n]  = shiftdim(a); % b is 3-by-1-by-2 and n is 2.
%       c = shiftdim(b,-n);   % c == a.
%       d = shiftdim(a,3);    % d is 1-by-2-by-1-by-1-by-3.
%
%   See also CIRCSHIFT, RESHAPE, SQUEEZE.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.15 $  $Date: 2002/04/08 20:21:10 $

siz = size(x);
if nargin==1,
  n = min(find(siz>1))-1; % Find leading singleton dimensions
end

if isequal(n,0) | isempty(x) | isempty(n),
  b = x;    % Quick exit if no shift required
  nshifts = 0;
else
  if n > 0, % Wrapped shift to the left
    n = rem(n-1,ndims(x))+1;
    if isequal(siz(1:n),ones(1,n)),
      s = [siz ones(1,n+2-length(siz))]; % Protect against 1-d array
      b = reshape(x,s(n+1:end));
    else
      s = [siz(n+1:end) siz(1:n)];
      b = permute(x,[n+1:ndims(x) 1:n]);
    end
  else % Shift to the right (padding with singleton's).
    b = reshape(x,[ones(1,-n),siz]);
  end
  nshifts = n;
end
