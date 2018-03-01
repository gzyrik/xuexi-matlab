%ISEQUALWITHEQUALNANS True if arrays are numerically equal.
%   Numeric data types and structure field order
%   do not have to match.
%   NaNs are considered equal to each other.
%
%   ISEQUALWITHEQUALNANS(A,B) is 1 if the two arrays are the same size
%   and contain the same values, and 0 otherwise.
%
%   ISEQUALWITHEQUALNANS(A,B,C,...) is 1 if all the input arguments are
%   numerically equal.
%
%   ISEQUALWITHEQUALNANS recursively compares the contents of cell
%   arrays and structures.  If all the elements of a cell array or
%   structure are numerically equal, ISEQUALWITHEQUALNANS will return 1.
%
%
%   See also ISEQUAL, EQ.

%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 1.1 $  $Date: 2002/04/01 21:49:12 $
%   Built-in function.
