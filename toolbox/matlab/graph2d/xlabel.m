function hh = xlabel(string,varargin)
%XLABEL X-axis label.
%   XLABEL('text') adds text beside the X-axis on the current axis.
%
%   XLABEL('text','Property1',PropertyValue1,'Property2',PropertyValue2,...)
%   sets the values of the specified properties of the xlabel.
%
%   H = XLABEL(...) returns the handle to the text object used as the label.
%
%   See also YLABEL, ZLABEL, TITLE, TEXT.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.13 $  $Date: 2002/04/08 21:44:38 $

if nargin > 1 & (nargin-1)/2-fix((nargin-1)/2),
  error('Incorrect number of input arguments')
end

ax = gca;

%---Check for bypass option
if isappdata(ax,'MWBYPASS_xlabel')
   h = mwbypass(ax,'MWBYPASS_xlabel',string,varargin{:});

%---Standard behavior
else
   h = get(ax,'xlabel');

   %Over-ride text objects default font attributes with
   %the Axes' default font attributes.
   set(h, 'FontAngle',  get(ax, 'FontAngle'), ...
          'FontName',   get(ax, 'FontName'), ...
          'FontSize',   get(ax, 'FontSize'), ...
          'FontWeight', get(ax, 'FontWeight'), ...
          'string',     string,varargin{:});
end

if nargout > 0
  hh = h;
end
