function A = lower(a)
%LOWER  Convert string to lowercase.
%   B = LOWER(A) converts any uppercase characters in A to
%   the corresponding lowercase character and leaves all
%   other characters unchanged.
%
%   B = LOWER(A), when A is a cell array of strings, returns a cell array
%   the same size as A containing the result of applying LOWER to each
%   string in A.
%
%   Character sets supported:
%      PC   : Windows Latin-1
%      Other: ISO Latin-1 (ISO 8859-1)
%           : Also supports 16-bit character sets.
%
%   See also UPPER.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.14 $  $Date: 2002/04/09 00:33:35 $

%   Built-in function.
