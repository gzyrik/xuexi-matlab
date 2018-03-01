function ndx = sub2ind(siz,varargin)
%SUB2IND Linear index from multiple subscripts.
%   SUB2IND is used to determine the equivalent single index
%   corresponding to a given set of subscript values.
%
%   IND = SUB2IND(SIZ,I,J) returns the linear index equivalent to the
%   row and column subscripts in the arrays I and J for an matrix of
%   size SIZ.
%
%   IND = SUB2IND(SIZ,I1,I2,...,In) returns the linear index
%   equivalent to the N subscripts in the arrays I1,I2,...,In for an
%   array of size SIZ.
%
%   See also IND2SUB.
 
%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.14 $  $Date: 2002/04/08 20:21:11 $

if length(siz)<=nargin-1,
  siz = [siz ones(1,nargin-length(siz)-1)];
else
  siz = [siz(1:nargin-2) prod(siz(nargin-1:end))];
end
for i=length(varargin):-1:1,
  mn(i) = min(varargin{i}(:));
  mx(i) = max(varargin{i}(:));
  s{i} = size(varargin{i});
end
if any(mn < 1) | any(mx > siz), error('Out of range index.'); end
if length(s)>1 & ~isequal(s{:}),
   error('The subscripts must all the be same size.');
end
n = length(siz);
k = [1 cumprod(siz(1:end-1))];
ndx = 1;
for i = 1:n,
  ndx = ndx + (varargin{i}-1)*k(i);
end
