function tf = isfield(s,f)
%ISFIELD True if field is in structure array.
%   F = ISFIELD(S,'field') returns true if 'field' is the name of a field
%   in the structure array S.
%
%   See also GETFIELD, SETFIELD, FIELDNAMES.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.13 $  $Date: 2002/04/08 19:22:48 $

if isa(s,'struct')  
  tf = any(strcmp(fieldnames(s),f));
else
  tf = logical(0);
end


