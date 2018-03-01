function hh = ylabel(string,varargin)
%YLABEL Y-axis label.
%   YLABEL('text') adds text beside the Y-axis on the current axis.
%
%   YLABEL('text','Property1',PropertyValue1,'Property2',PropertyValue2,...)
%   sets the values of the specified properties of the ylabel.
%
%   H = YLABEL(...) returns the handle to the text object used as the label.
%
%   See also XLABEL, ZLABEL, TITLE, TEXT.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.13 $  $Date: 2002/04/08 21:44:38 $

if nargin > 1 & (nargin-1)/2-fix((nargin-1)/2),
  error('Incorrect number of input arguments')
end

ax = gca;

%---Check for bypass option
if isappdata(ax,'MWBYPASS_ylabel')
   h = mwbypass(ax,'MWBYPASS_ylabel',string,varargin{:});

%---Standard behavior
else
   h = get(ax,'ylabel');

   %Over-ride text objects default font attributes with
   %the Axes' default font attributes.
   set(h, 'FontAngle',  get(ax, 'FontAngle'), ...
          'FontName',   get(ax, 'FontName'), ...
          'FontSize',   get(ax, 'FontSize'), ...
          'FontWeight', get(ax, 'FontWeight'), ...
          'string',     string, varargin{:});
end

if nargout > 0
  hh = h;
end
