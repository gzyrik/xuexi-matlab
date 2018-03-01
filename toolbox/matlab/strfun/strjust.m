function t = strjust(s,justify)
%STRJUST Justify character array.
%   T = STRJUST(S) or T = STRJUST(S,'right') returns a right justified 
%   version of the character array S.
%
%   T = STRJUST(S,'left') returns a left justified version of S.
%
%   T = STRJUST(S,'center') returns a center justified version of S.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.11 $  $Date: 2002/04/09 00:33:37 $

if nargin<2, justify = 'right'; end

if isempty(s), t = s; return, end

% Find non-pad characters
ch = (s ~= ' ' & s ~= 0);
[r,c] = find(ch);
[m,n] = size(s);

% Determine offset
switch justify
case 'right'
    spa = sparse(c,r,c);
    offset = full(max(spa,[],1))';
    offset = n-offset;
case 'left'
    [dum,offset] = max(ch,[],2);
    offset = 1 - offset;
case 'center'
    spa = sparse(c,r,c,n,m);
    offset1 = full(max(spa))';
    [dum,offset2] = max(ch,[],2);
    offset = floor((n - offset1 - offset2 + 1)/2);
end

% Apply offset to justify character array
newc = c + offset(r);
t = repmat(' ',m,n);
t(r + (newc-1)*m) = s(r + (c-1)*m);
