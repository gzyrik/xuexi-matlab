function d = hex2dec(h)
%HEX2DEC Convert hexadecimal string to decimal integer.
%   HEX2DEC(H) interprets the hexadecimal string H and returns the
%   equivalent decimal number.  
%  
%   If H is a character array, each row is interpreted as a hexadecimal string.
%
%   Examples
%       hex2dec('12B') and hex2dec('12b') both return 299
%
%   See also DEC2HEX, HEX2NUM, BIN2DEC, BASE2DEC.

%   Author: L. Shure, Revised: 12-23-91, CBM.
%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.17 $  $Date: 2002/04/09 00:33:34 $

if iscellstr(h), h = char(h); end
if isempty(h), d = []; return, end

[m,n]=size(h);

% Right justify strings and form 2-D character array.
if ~isempty(find(h==' ' | h==0)),
  h = strjust(h);

  % Replace any leading blanks and nulls by 0.
  h(find(cumsum(h ~= ' ' & h ~= 0,2) == 0)) = '0';
else
  h = reshape(h,m,n);
end

% Check for out of range values
if any(h < '0' | (h > '9' & h < 'A') | (h > 'F' & h < 'a') | h > 'f')
  error('Input string found with characters other than 0-9, a-f, or A-F.');
end

sixteen = 16;
p = fliplr(cumprod([1 sixteen(ones(1,n-1))]));
p = p(ones(m,1),:);

d = h <= 64; % Numbers
h(d) = h(d) - 48;

d =  h > 64 & h <= 96; % Uppercase letters
h(d) = h(d) - 55;

d = h > 96; % Lowercase letters
h(d) = h(d) - 87;

d = sum(h.*p,2);
