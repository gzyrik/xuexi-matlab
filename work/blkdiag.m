function y = blkdiag(varargin)
%BLKDIAG  Block diagonal concatenation of input arguments.
%
%                                   |A 0 .. 0|
%   Y = BLKDIAG(A,B,...)  produces  |0 B .. 0|
%                                   |0 0 ..  |
%
%   See also DIAG, HORZCAT, VERTCAT

% Copyright 1984-2002 The MathWorks, Inc. 
% $Revision: 1.7 $

isYsparse=0;
for k=1:nargin
    if issparse(varargin{k})
        isYsparse=1;
        break
    end
end

if isYsparse
    y = sparse([]);
    for k=1:nargin
        x = varargin{k};
        [p1,m1] = size(y); [p2,m2] = size(x);
        y = [y sparse(p1,m2); sparse(p2,m1) x];
    end
else
    y = [];
    for k=1:nargin
        x = varargin{k};
        [p1,m1] = size(y); [p2,m2] = size(x);
        y = [y zeros(p1,m2); zeros(p2,m1) x];
    end
end
