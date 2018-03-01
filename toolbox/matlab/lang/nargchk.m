function msg = nargchk(low,high,number,outtype)
%NARGCHK Validate number of input arguments. 
%   MSG = NARGCHK(LOW,HIGH,N) returns an appropriate error message if
%   N is not between low and high. If it is, return empty matrix.
%
%   See also NARGOUTCHK, NARGIN, NARGOUT, INPUTNAME.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.12 $  $Date: 2002/04/08 23:29:23 $

msg = [];
if (number < low)
    msg = 'Not enough input arguments.';
elseif (number > high)
    msg = 'Too many input arguments.';
end
