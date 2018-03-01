function w = hamming(varargin)
%HAMMING   Hamming window.
%   HAMMING(N) returns the N-point symmetric Hamming window in a column vector.
% 
%   HAMMING(N,SFLAG) generates the N-point Hamming window using SFLAG window
%   sampling. SFLAG may be either 'symmetric' or 'periodic'. By default, a 
%   symmetric window is returned. 
%
%   % Example:
%   %   Create a 64-point Hamming window and display the result in WVTool.
%
%   L=64;
%   wvtool(hamming(L))
%
%   See also BLACKMAN, HANN, WINDOW.

%   Copyright 1988-2002 The MathWorks, Inc.
%   $Revision: 1.14.4.4 $  $Date: 2012/10/29 19:31:16 $

% Check number of inputs
error(nargchk(1,2,nargin,'struct'));

[w,msg,msgobj] = gencoswin('hamming',varargin{:});
if ~isempty(msg), error(msgobj); end


% [EOF] hamming.m
