function [hh,w,s,options] = freqz(b,varargin)
%FREQZ Frequency response of digital filter
%   [H,W] = FREQZ(B,A,N) returns the N-point complex frequency response
%   vector H and the N-point frequency vector W in radians/sample of
%   the filter:
%
%               jw               -jw              -jmw
%        jw  B(e)    b(1) + b(2)e + .... + b(m+1)e
%     H(e) = ---- = ------------------------------------
%               jw               -jw              -jnw
%            A(e)    a(1) + a(2)e + .... + a(n+1)e
%
%   given numerator and denominator coefficients in vectors B and A. 
%
%   [H,W] = FREQZ(SOS,N) returns the N-point complex frequency response
%   given the second order sections matrix SOS. SOS is a Kx6 matrix, where
%   the number of sections, K, must be greater than or equal to 2. Each row
%   of SOS corresponds to the coefficients of a second order filter. From
%   the transfer function displayed above, the ith row of the SOS matrix
%   corresponds to [bi(1) bi(2) bi(3) ai(1) ai(2) ai(3)].
%
%   In all cases, the frequency response is evaluated at N points equally
%   spaced around the upper half of the unit circle. If N isn't specified,
%   it defaults to 512.
%
%   [H,W] = FREQZ(...,N,'whole') uses N points around the whole unit
%   circle.
%
%   H = FREQZ(...,W) returns the frequency response at frequencies
%   designated in vector W, in radians/sample (normally between 0 and pi).
%   W must be a vector with at least two elements.
%
%   [H,F] = FREQZ(...,N,Fs) and [H,F] = FREQZ(...,N,'whole',Fs) return
%   frequency vector F (in Hz), where Fs is the sampling frequency (in Hz).
%
%   H = FREQZ(...,F,Fs) returns the complex frequency response at the
%   frequencies designated in vector F (in Hz), where Fs is the sampling
%   frequency (in Hz).
%
%   FREQZ(...) with no output arguments plots the magnitude and
%   unwrapped phase of the filter in the current figure window.
%
%   % Example 1:
%   %   Design a lowpass FIR filter with normalized cut-off frequency at 
%   %   0.3 and determine its frequency response.
%
%   b=fircls1(54,0.3,0.02,0.008);
%   freqz(b)                       
%
%   % Example 2: 
%   %   Design a 5th order lowpass elliptic IIR filter and determine its 
%   %   frequency response.
%
%   [b,a] = ellip(5,0.5,20,0.4);
%   freqz(b,a);                     
%
%   % Example 3:
%   %   Design a Butterworth highpass IIR filter, represent its coefficients
%   %   using second order sections, and display its frequency response.
%
%   [z,p,k] = butter(6,0.7,'high');
%   SOS = zp2sos(z,p,k);    
%   freqz(SOS)                      
%
%   See also FILTER, FFT, INVFREQZ, FVTOOL, and FREQS.

%   Copyright 1988-2012 The MathWorks, Inc.
%   $Revision: 1.43.4.14.2.1 $  $Date: 2013/01/02 17:47:37 $

narginchk(1,5);

a = 1; % Assume FIR for now
isTF = true; % True if dealing with a transfer function

if all(size(b)>[1 1])
  % Input is a matrix, check if it is a valid SOS matrix
  if size(b,2) ~= 6
    error(message('signal:signalanalysisbase:invalidinputsosmatrix'));
  end
  isTF = false; % SOS instead of transfer function  
end

if isTF
  if nargin > 1
    a = varargin{1};
    varargin(1) = [];
  end

  if all(size(a)>[1 1])
    error(message('signal:signalanalysisbase:inputnotsupported'));
  end
end

[options,msg,msgobj] = freqz_options(varargin{:});
if ~isempty(msg)
  error(msgobj);
end

if isTF  
  if length(a) == 1
    [h,w,options] = firfreqz(b/a,options);
  else
    [h,w,options] = iirfreqz(b,a,options);
  end
else
    [h,w,options] = sosfreqz(b,options);
end

% Generate the default structure to pass to freqzplot
s = struct;
s.plot = 'both';
s.fvflag = options.fvflag;
s.yunits = 'db';
s.xunits = 'rad/sample';
s.Fs     = options.Fs; % If rad/sample, Fs is empty
if ~isempty(options.Fs),
  s.xunits = 'Hz';
end

% Plot when no output arguments are given
if nargout == 0  
  if isTF
    phi = phasez(b,a,varargin{:});
  else
    phi = phasez(b,varargin{:});
  end
  
  data(:,:,1) = h;
  data(:,:,2) = phi;
  ws = warning('off'); %#ok<WNOFF>
  freqzplot(data,w,s,'magphase');
  warning(ws);
  
else
  hh = h;
end

%--------------------------------------------------------------------------
function [h,w,options] = firfreqz(b,options)

% Make b a row
b = b(:).';
n  = length(b);

w      = options.w;
Fs     = options.Fs;
nfft   = options.nfft;
fvflag = options.fvflag;

% Actual Frequency Response Computation
if fvflag,
  %   Frequency vector specified.  Use Horner's method of polynomial
  %   evaluation at the frequency points and divide the numerator
  %   by the denominator.
  %
  %   Note: we use positive i here because of the relationship
  %            polyval(a,exp(1i*w)) = fft(a).*exp(1i*w*(length(a)-1))
  %               ( assuming w = 2*pi*(0:length(a)-1)/length(a) )
  %
  if ~isempty(Fs), % Fs was specified, freq. vector is in Hz
    digw = 2.*pi.*w./Fs; % Convert from Hz to rad/sample for computational purposes
  else
    digw = w;
  end
  
  s = exp(1i*digw); % Digital frequency must be used for this calculation
  h = polyval(b,s)./exp(1i*digw*(n-1));
else
  % freqvector not specified, use nfft and RANGE in calculation
  s = find(strncmpi(options.range, {'twosided','onesided'}, length(options.range)));
  
  if s*nfft < n,
    % Data is larger than FFT points, wrap modulo s*nfft
    b = datawrap(b,s.*nfft);
  end
  
  % dividenowarn temporarily shuts off warnings to avoid "Divide by zero"
  h = fft(b,s.*nfft).';
  % When RANGE = 'half', we computed a 2*nfft point FFT, now we take half the result
  h = h(1:nfft);
  h = h(:); % Make it a column only when nfft is given (backwards comp.)
  w = freqz_freqvec(nfft, Fs, s);
  w = w(:); % Make it a column only when nfft is given (backwards comp.)
end

%--------------------------------------------------------------------------
function [h,w,options] = iirfreqz(b,a,options)
% Make b and a rows
b = b(:).';
a = a(:).';

nb = length(b);
na = length(a);
a  = [a zeros(1,nb-na)];  % Make a and b of the same length
b  = [b zeros(1,na-nb)];
n  = length(a); % This will be the new length of both num and den

w      = options.w;
Fs     = options.Fs;
nfft   = options.nfft;
fvflag = options.fvflag;

% Actual Frequency Response Computation
if fvflag,
  %   Frequency vector specified.  Use Horner's method of polynomial
  %   evaluation at the frequency points and divide the numerator
  %   by the denominator.
  %
  %   Note: we use positive i here because of the relationship
  %            polyval(a,exp(1i*w)) = fft(a).*exp(1i*w*(length(a)-1))
  %               ( assuming w = 2*pi*(0:length(a)-1)/length(a) )
  %
  if ~isempty(Fs), % Fs was specified, freq. vector is in Hz
    digw = 2.*pi.*w./Fs; % Convert from Hz to rad/sample for computational purposes
  else
    digw = w;
  end
  
  s = exp(1i*digw); % Digital frequency must be used for this calculation
  h = polyval(b,s) ./ polyval(a,s);
else
  % freqvector not specified, use nfft and RANGE in calculation
  s = find(strncmpi(options.range, {'twosided','onesided'}, length(options.range)));
  
  if s*nfft < n,
    % Data is larger than FFT points, wrap modulo s*nfft
    b = datawrap(b,s.*nfft);
    a = datawrap(a,s.*nfft);
  end
  
  % dividenowarn temporarily shuts off warnings to avoid "Divide by zero"
  h = dividenowarn(fft(b,s.*nfft),fft(a,s.*nfft)).';
  % When RANGE = 'half', we computed a 2*nfft point FFT, now we take half the result
  h = h(1:nfft);
  h = h(:); % Make it a column only when nfft is given (backwards comp.)
  w = freqz_freqvec(nfft, Fs, s);
  w = w(:); % Make it a column only when nfft is given (backwards comp.)
end
%--------------------------------------------------------------------------
function [h,w,options] = sosfreqz(sos,options)

[h, w] = iirfreqz(sos(1,1:3), sos(1,4:6), options);
for indx = 2:size(sos, 1)
    h = h.*iirfreqz(sos(indx,1:3), sos(indx,4:6), options);    
end

%-------------------------------------------------------------------------------
function [options,msg,msgobj] = freqz_options(varargin)
%FREQZ_OPTIONS   Parse the optional arguments to FREQZ.
%   FREQZ_OPTIONS returns a structure with the following fields:
%   options.nfft         - number of freq. points to be used in the computation
%   options.fvflag       - Flag indicating whether nfft was specified or a vector was given
%   options.w            - frequency vector (empty if nfft is specified)
%   options.Fs           - Sampling frequency (empty if no Fs specified)
%   options.range        - 'half' = [0, Nyquist); 'whole' = [0, 2*Nyquist)


% Set up defaults
options.nfft   = 512;
options.Fs     = [];
options.w      = [];
options.range  = 'onesided';
options.fvflag = 0;
isreal_x       = []; % Not applicable to freqz

[options,msg,msgobj] = psdoptions(isreal_x,options,varargin{:});

if any(size(options.nfft)>1),
  % frequency vector given, may be linear or angular frequency
  options.w = options.nfft;
  options.fvflag = 1;
end

% [EOF] freqz.m


