function t = strcat(varargin)
%STRCAT Concatenate strings.
%   T = STRCAT(S1,S2,S3,...) horizontally concatenates corresponding
%   rows of the character arrays S1, S2, S3 etc. All input arrays must 
%   have the same number of rows (or any can be a single string). When 
%   the inputs are all character arrays, the output is also a character 
%   array.
%
%   When any of the inputs is a cell array of strings, STRCAT returns 
%   a cell array of strings formed by concatenating corresponding 
%   elements of S1, S2, etc. The inputs must all have the same size 
%   (or any can be a scalar). Any of the inputs can also be character 
%   arrays.
%
%   Trailing spaces in character array inputs are ignored and do not 
%   appear in the output. This is not true for inputs that are cell 
%   arrays of strings. Use the concatenation syntax [S1 S2 S3 ...] 
%   to preserve trailing spaces.
%
%   Example
%       strcat({'Red','Yellow'},{'Green','Blue'})
%   returns
%       'RedGreen'    'YellowBlue'
%
%   See also STRVCAT, CAT, CELLSTR.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.16 $  $Date: 2002/04/09 00:33:37 $

%   The cell array implementation is in @cell/strcat.m

if nargin<1, error('Not enough input arguments.'); end

for i=nargin:-1:1,
  rows(i) = size(varargin{i},1);
  twod(i) = ndims(varargin{i})==2;
end
if ~all(twod), error('All the inputs must be two dimensional.'); end

% Remove empty inputs
k = (rows == 0);
varargin(k) = [];
rows(k) = [];

% Scalar expansion
for i=1:length(varargin),
  if rows(i)==1 & rows(i)<max(rows),
    varargin{i} = varargin{i}(ones(1,max(rows)),:);
    rows(i) = max(rows);
  end
end

if any(rows~=rows(1)),  
  error('All the inputs must have the same number of rows or a single row.');
end

n = rows(1);
t = '';
for i=1:n,
  s = deblank(varargin{1}(i,:));
  for j=2:length(varargin),
    s = [s deblank(varargin{j}(i,:))];
  end
  t = strvcat(t,s);
end
