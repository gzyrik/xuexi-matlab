%STRCMP Compare strings.
%   STRCMP(S1,S2) returns 1 if strings S1 and S2 are the same
%   and 0 otherwise.  
%
%   STRCMP(S,T), when either S or T is a cell array of strings, returns
%   an array the same size as S and T containing 1 for those elements
%   of S and T that match, and 0 otherwise.  S and T must be the same
%   size (or one can be a scalar cell).  Either one can also be a
%   character array with the right number of rows.
%
%   When either S or T is a string array being compared to a cell or cell
%   array of strings, it is deblanked before comparision, i.e., the trailing
%   blanks are removed.  If either S or T is a scalar string, i.e., a string
%   array with a single row then it is not deblanked before comparison.
%
%   STRCMP supports international character sets.
%
%   See also STRNCMP, STRCMPI, FINDSTR, STRMATCH, DEBLANK.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.17 $  $Date: 2002/04/09 00:33:37 $
%   Built-in function.

