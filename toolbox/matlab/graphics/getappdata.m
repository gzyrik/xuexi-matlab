function value = getappdata(h, name)
%GETAPPDATA Get value of application-defined data.
%  VALUE = GETAPPDATA(H, NAME) gets the value of the
%  application-defined data with name specified by NAME in the
%  object with handle H.  If the application-defined data does
%  not exist, an empty matrix will be returned in VALUE.
%
%  VALUES = GETAPPDATA(H) returns all application-defined data
%  for the object with handle H.
%
%  See also SETAPPDATA, RMAPPDATA, ISAPPDATA.

%  Damian T. Packer, May 1998
%  Copyright 1984-2002 The MathWorks, Inc.
%  $Revision: 1.11 $  $Date: 2002/04/08 22:41:29 $


error(nargchk(1, 2, nargin));

if length(h) ~= 1
   error('H must be a single handle.');
end

value = get(h, 'ApplicationData');
if nargin == 2
  if(isfield(value, name))
    value = subsref(value,struct('type','.','subs',name)); 
  else
    value = [];
  end
end
