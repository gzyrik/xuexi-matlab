function x=bin2dec(s)
%BIN2DEC Convert binary string to decimal integer.
%   BIN2DEC(B) interprets the binary string B and returns the
%   equivalent decimal number.  
%
%   If B is a character array, each row is interpreted as a binary string.
%
%   Example
%       bin2dec('010111') returns 23
%
%   See also DEC2BIN, HEX2DEC, BASE2DEC.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.17 $  $Date: 2002/04/09 00:33:32 $

if iscellstr(s), s = char(s); end
if ~isstr(s), error('Input must be a string.'); end
if isempty(s), x = []; return, end
if size(s,2)>52, error('Binary string must be 52 bits or less.'); end

if ~isempty(find(s==' ' | s==0)), 
  s = strjust(s);
  s(s==' ' | s==0) = '0';
end

[m,n] = size(s);

v = s - '0'; % Convert to numbers
twos = pow2(n-1:-1:0);
x = sum(v .* twos(ones(m,1),:),2);
