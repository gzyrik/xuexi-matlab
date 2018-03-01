function c = cellstr(s)
%CELLSTR Create cell array of strings from character array.
%   C = CELLSTR(S) places each row of the character array S into 
%   separate cells of C.
%
%   Use CHAR to convert back.
%
%   Another way to create a cell array of strings is by using the curly
%   braces: 
%      C = {'hello' 'yes' 'no' 'goodbye'};
%
%   See also STRINGS, CHAR, ISCELLSTR.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.16 $  $Date: 2002/04/09 00:33:33 $

if iscellstr(s), c = s; return, end
if ndims(s)~=2, error('S must be 2-D.'); end

if isempty(s)
  if isstr(s)
    c = {''};
  else
    error('Input must be a string.');
  end
else
  c = cell(size(s,1),1);
  for i=1:size(s,1)
    c{i} = deblank(s(i,:));
  end
end
