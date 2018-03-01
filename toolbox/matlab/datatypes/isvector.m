function t = isvector(v)
%ISVECTOR True for a vector.
% ISVECTOR(V) returns 1 if V is a vector and 0 otherwise.
% Thomas A. Bryan
% Copyright 1999-2002 The MathWorks, Inc.
% $Revision: 1.10 $ $Date: 2002/03/28 20:23:55 $
t = ndims(v)==2 & min(size(v))==1;
