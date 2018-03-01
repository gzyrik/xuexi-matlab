function t = ismatrix(m)
%ISMATRIX True for a ismatrix.
% ISMATRIX(M) returns 1 if M is a matrix and 0 otherwise.
t = ndims(m)>=2 & min(size(m))>=2;
