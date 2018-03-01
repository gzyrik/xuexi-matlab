function hh = title(string,varargin)
%TITLE  Graph title.
%   TITLE('text') adds text at the top of the current axis.
%
%   TITLE('text','Property1',PropertyValue1,'Property2',PropertyValue2,...)
%   sets the values of the specified properties of the title.
%
%   H = TITLE(...) returns the handle to the text object used as the title.
%
%   See also XLABEL, YLABEL, ZLABEL, TEXT.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.14 $  $Date: 2002/04/08 21:44:38 $

if nargin > 1 & (nargin-1)/2-fix((nargin-1)/2),
  error('Incorrect number of input arguments')
end

ax = gca;

%---Check for bypass option
if isappdata(ax,'MWBYPASS_title')       
   h = mwbypass(ax,'MWBYPASS_title',string,varargin{:});

%---Standard behavior      
else
   h = get(ax,'title');

   %Over-ride text objects default font attributes with
   %the Axes' default font attributes.
   set(h, 'FontAngle',  get(ax, 'FontAngle'), ...
          'FontName',   get(ax, 'FontName'), ...
          'FontSize',   get(ax, 'FontSize'), ...
          'FontWeight', get(ax, 'FontWeight'), ...
          'Rotation',   0, ...
          'string',     string, varargin{:});
end

if nargout > 0
  hh = h;
end
