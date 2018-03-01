function h = dec2hex(d,n)
%DEC2HEX Convert decimal integer to hexadecimal string.
%   DEC2HEX(D) returns a 2-D string array where each row is the
%   hexadecimal representation of each decimal integer in D.
%   D must contain non-negative integers smaller than 2^52.  
%
%   DEC2HEX(D,N) produces a 2-D string array where each
%   row contains an N digit hexadecimal number.
%
%   Example
%       dec2hex(2748) returns 'ABC'.
%    
%   See also HEX2DEC, HEX2NUM, DEC2BIN, DEC2BASE.

%   Author: L. Shure
%   Revised by: CMT 1-22-95
%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.15 $  $Date: 2002/04/09 00:33:33 $

bits32 = 4294967296;       % 2^32


if ~isempty(find(d < 0 | d ~= fix(d)))
  error('First argument must contain non-negative integers.')
end
if isempty(d), h = ''; return, end
d = d(:); % Make sure d is a column vector.

if nargin==1,
  n = 1; % Need at least one digit even for 0.
end


[f,e] = log2(max(d));
n = max(n,ceil(e/4));

if all(d<bits32),
  h = sprintf(['%0' int2str(n) 'X'],d);
else
  d1 = floor(d/bits32);
  d2 = rem(d,bits32);
  h = sprintf(['%0' int2str(n-8) 'X%08X'],[d1,d2]');
end
h = reshape(h,n,length(d))';
