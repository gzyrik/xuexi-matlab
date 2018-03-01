%STRCMPI Compare strings ignoring case.
%   STRCMPI(S1,S2) returns 1 if strings S1 and S2 are the same except for
%   case and 0 otherwise.  
%
%   STRCMPI(S,T), when either S or T is a cell array of strings, returns an
%   array the same size as S and T containing 1 for those elements of S
%   and T that match except for case, and 0 otherwise.  S and T must be
%   the same size (or one can be a scalar cell).  Either one can also be a
%   character array with the right number of rows.
%
%   STRCMPI supports international character sets.
%
%   See also STRCMP, STRNCMPI, FINDSTR, STRMATCH.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.7 $  $Date: 2002/04/09 00:33:37 $
%   Built-in function.

