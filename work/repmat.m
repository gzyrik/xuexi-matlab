function B = repmat(A,M,N)
%REPMAT Replicate and tile an array.
%   B = repmat(A,M,N) creates a large matrix B consisting of an M-by-N
%   tiling of copies of A.
%   
%   B = REPMAT(A,[M N]) accomplishes the same result as repmat(A,M,N).
%
%   B = REPMAT(A,[M N P ...]) tiles the array A to produce a
%   M-by-N-by-P-by-... block array.  A can be N-D.
%
%   REPMAT(A,M,N) when A is a scalar is commonly used to produce
%   an M-by-N matrix filled with A's value.  This can be much faster
%   than A*ONES(M,N) when M and/or N are large.
%   
%   Example:
%       repmat(magic(2),2,3)
%       repmat(NaN,2,3)
%
%   See also MESHGRID.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.17 $  $Date: 2002/04/08 20:21:10 $

if nargin < 2
   error('Requires at least 2 inputs.')
elseif nargin == 2
  if length(M)==1
     siz = [M M];
  else
     siz = M;
  end
else
  siz = [M N];
end

if length(A)==1
  nelems = prod(siz);
  if nelems>0
    % Since B doesn't exist, the first statement creates a B with
    % the right size and type.  Then use scalar expansion to
    % fill the array.. Finally reshape to the specified size.
    B(nelems) = A; 
    B(:) = A;
    B = reshape(B,siz);
  else
    B = A(ones(siz));
  end
elseif ndims(A)==2 & length(siz)==2
  [m,n] = size(A);
  mind = (1:m)';
  nind = (1:n)';
  mind = mind(:,ones(1,siz(1)));
  nind = nind(:,ones(1,siz(2)));
  B = A(mind,nind);
else
  Asiz = size(A);
  Asiz = [Asiz ones(1,length(siz)-length(Asiz))];
  siz = [siz ones(1,length(Asiz)-length(siz))];
  for i=length(Asiz):-1:1
    ind = (1:Asiz(i))';
    subs{i} = ind(:,ones(1,siz(i)));
  end
  B = A(subs{:});
end
