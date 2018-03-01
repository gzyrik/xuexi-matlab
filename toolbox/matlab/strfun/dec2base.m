function s = dec2base(d,b,nin)
%DEC2BASE Convert decimal integer to base B string.
%   DEC2BASE(D,B) returns the representation of D as a string in
%   base B.  D must be a non-negative integer smaller than 2^52
%   and B must be an integer between 2 and 36.
%
%   DEC2BASE(D,B,N) produces a representation with at least N digits.
%
%   Examples
%       dec2base(23,3) returns '212'
%       dec2base(23,3,5) returns '00212'
%
%   See also BASE2DEC, DEC2HEX, DEC2BIN.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.13 $  $Date: 2002/04/09 00:33:33 $

% Original by Douglas M. Schwarz, Eastman Kodak Company, 1996.

d = d(:);
if d ~= floor(d) | any(d < 0) | any(d > 1/eps)
   error('D must be an integer, 0 <= D <= 2^52.');
end
if b ~= floor(b) | b < 2 | b > 36
   error('B must be an integer, 2 <= B <= 36.');
end
n = max(1,round(log2(max(d)+1)/log2(b)));
while any(b.^n <= d)
   n = n + 1;
end
if nargin == 3
   n = max(n,nin);
end
s(:,n) = rem(d,b);
while n > 1 & any(d)
   n = n - 1;
   d = floor(d/b);
   s(:,n) = rem(d,b);
end
symbols = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
s = reshape(symbols(s + 1),size(s));
