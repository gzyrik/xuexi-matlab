function closereq
%CLOSEREQ  Figure close request function.
%   CLOSEREQ deletes the current figure window.  By default, CLOSEREQ is
%   the CloseRequestFcn for new figures.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.9 $  $Date: 2002/04/08 22:41:27 $

%   Note that closereq now honors the user's ShowHiddenHandles setting
%   during figure deletion.  This means that deletion listeners and
%   DeleteFcns will now operate in an environment which is not guaranteed
%   to show hidden handles.

shh=get(0,'ShowHiddenHandles');
set(0,'ShowHiddenHandles','on');
currFig=get(0,'CurrentFigure');
set(0,'ShowHiddenHandles',shh);
delete(currFig);

