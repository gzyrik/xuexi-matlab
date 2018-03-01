function d = base2dec(h,b)
%BASE2DEC Convert base B string to decimal integer.
%   BASE2DEC(S,B) converts the string number S of base B into its 
%   decimal (base 10) equivalent.  B must be an integer
%   between 2 and 36. 
%
%   If S is a character array, each row is interpreted as a base B string.
%
%   Example
%      base2dec('212',3) returns 23
%
%   See also DEC2BASE, HEX2DEC, BIN2DEC.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.17 $  $Date: 2002/04/09 00:33:32 $

%   Douglas M. Schwarz, 18 February 1996

error(nargchk(2,2,nargin));

if iscellstr(h), h = char(h); end
if isempty(h), d = []; return, end

if ~isempty(find(h==' ' | h==0)), 
  h = strjust(h);
  h(h==' ' | h==0) = '0';
end

[m,n] = size(h);
b = [ones(m,1) cumprod(b(ones(m,n-1)),2)];
values(real('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')) = 0:35;
a = fliplr(reshape(values(abs(upper(h))),size(h)));
d = sum((b .* a),2);
