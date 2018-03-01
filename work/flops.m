function f = flops(x)
%FLOPS Obsolete floating point operation count.
%   Earlier versions of MATLAB counted the number of floating point
%   operations.  With the incorporation of LAPACK in MATLAB 6, this
%   is no longer practical.  

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.12 $  $Date: 2002/04/08 20:21:05 $

if (nargin < 1) | (x ~= 0)
    warning('MATLAB:flops:UnavailableFunction', ...
        'Flop counts are no longer available.')
end
if nargout > 0
    f = 0;
end
