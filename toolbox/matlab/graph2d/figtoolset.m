function figtoolset(setwhat,fig)
%FIGTOOLSET CreateFcns for figure toolbar toggles

% this is an internal utility function and may not
% be available in future releases.
% figtoolset(setwhat,fig) sets the state of the figure
% toolbar toggle indicated by setwhat to the appropriate
% state.  i.e. if setwhat is 'zoomin', and if zoom is on
% then the state property will be set to on for the 
% zoomin toggle button of the figure toolbar.  Since the
% figure toolbar toggles are created with default 'state' ('off')
% only setting 'state' to 'on' needs to be handled.

%   Glen M. DeLoid 08-14-2001
%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 1.2 $  $Date: 2002/04/08 21:44:26 $

% for the zoomin toggle, set its state to on if zoom is on and
% not in zoom out mode
if strcmpi(setwhat,'zoomin')
    if isappdata(fig,'ZoomOnState') & ...
            ~strcmpi(getappdata(fig,'ZOOMFigureMode'),'out')
        zintool = findall(fig,'Tag','figToolZoomIn');
        set(zintool,'state','on');
    end

% for the zoomout toggle, set its state to on if zoom is on and
% is in zoom out mode
elseif strcmpi(setwhat,'zoomout')
    if isappdata(fig,'ZoomOnState') & ...
            strcmpi(getappdata(fig,'ZOOMFigureMode'),'out')
        zouttool = findall(fig,'Tag','figToolZoomOut');
        set(zouttool,'state','on');
    end

% for the rotate3d toggle, set its state to on if rotate3d is on
elseif strcmpi(setwhat,'rotate3d')
    if isappdata(fig,'Rotate3dOnState')
        rot3dtool = findall(fig,'Tag','figToolRotate3D');
        set(rot3dtool,'state','on');
    end
end
