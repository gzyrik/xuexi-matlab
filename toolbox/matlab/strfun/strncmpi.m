%STRNCMPI Compare first N characters of strings ignoring case.
%   STRNCMPI(S1,S2,N) returns 1 if the first N characters of the strings
%   S1 and S2 are the same except for case and 0 otherwise.
%
%   TF = STRNCMPI(S,T,N), when either S or T is a cell array of strings,
%   returns an array the same size as S and T containing 1 for those
%   elements of S and T that match except for case (up to N characters),
%   and 0 otherwise.  S and T must be the same size (or one can be a
%   scalar cell).  Either one can also be a character array with the right
%   number of rows.
%
%   STRNCMPI supports international character sets.
%
%   See also STRNCMP, STRCMPI, FINDSTR, STRMATCH.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.8 $  $Date: 2002/04/09 00:33:38 $
%   Built-in function.

