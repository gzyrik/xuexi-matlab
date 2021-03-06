%IFFTN N-dimensional inverse discrete Fourier transform.
%   IFFTN(F) returns the N-dimensional inverse discrete Fourier transform of
%   the N-D array F.  If F is a vector, the result will have the same
%   orientation.
%
%   IFFTN(F,SIZ) pads F so that its size vector is SIZ before performing the
%   transform.  If any element of SIZ is smaller than the corresponding
%   dimension of F, then F will be cropped in that dimension.
%
%   IFFTN(..., 'symmetric') causes IFFTN to treat F as multidimensionally
%   conjugate symmetric so that the output is purely real.  This option is
%   useful when F is not exactly conjugate symmetric merely because of
%   round-off error.  See the reference page for the specific mathematical
%   definition of this symmetry.
%
%   IFFTN(..., 'nonsymmetric') causes IFFTN to make no assumptions about the
%   symmetry of F.
%
%   See also FFT, FFT2, FFTN, FFTSHIFT, FFTW, IFFT, IFFT2.

%   Copyright 1984-2005 The MathWorks, Inc.
%   $Revision: 1.14.4.5 $  $Date: 2005/06/21 19:23:59 $

