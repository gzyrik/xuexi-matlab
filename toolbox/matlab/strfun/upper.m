function A = upper(a)
%UPPER  Convert string to uppercase.
%   B = UPPER(A) converts any lower case characters in A to
%   the corresponding upper case character and leaves all
%   other characters unchanged.
%
%   B = UPPER(A), when A is a cell array of strings, returns a cell array
%   the same size as A containing the result of applying UPPER to each
%   string in A.
%
%   Character sets supported:
%     PC   : Windows Latin-1
%     Other: ISO Latin-1 (ISO 8859-1)
%          : Also supports 16-bit character sets.
%
%   See also LOWER.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.15 $  $Date: 2002/04/09 00:33:38 $
%   Built-in function.
