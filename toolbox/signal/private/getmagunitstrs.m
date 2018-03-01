function magunits = getmagunitstrs
%GETMAGUNITSTRS Return a cell array of the standard Magnitude Units strings.

%   Author(s): P. Costa
%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.3.4.1 $  $Date: 2011/10/31 06:34:50 $

magunits = {getString(message('signal:sigtools:Magnitude')),...
            getString(message('signal:sigtools:MagnitudedB')),...
            getString(message('signal:sigtools:MagnitudeSquared'))};

% [EOF]
