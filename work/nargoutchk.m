function msg = nargoutchk(low,high,number)
%NARGOUTCHK Validate number of output arguments. 
%   MSG = NARGOUTCHK(LOW,HIGH,N) returns an appropriate error message if
%   N is not between low and high. If it is, return empty matrix.
%
%   See also NARGCHK, NARGIN, NARGOUT, INPUTNAME.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.5 $  $Date: 2002/04/08 23:29:23 $

msg = [];
if (number < low)
    msg = 'Not enough output arguments.';
elseif (number > high)
    msg = 'Too many output arguments.';
end