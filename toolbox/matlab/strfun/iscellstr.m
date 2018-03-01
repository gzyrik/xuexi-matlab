function tf = iscellstr(s)
%ISCELLSTR True for cell array of strings.
%   ISCELLSTR(S) returns 1 if S is a cell array of strings and 0
%   otherwise.  A cell array of strings is a cell array where 
%   every element is a character array.
%
%   See also CELLSTR, ISCELL, CHAR, ISCHAR.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.17 $  $Date: 2002/04/09 00:33:34 $

if isa(s,'cell'),
  res = cellfun('isclass',s,'char');
  tf = all(res(:));
else
  tf = logical(0);
end
