function s=strvcat(varargin)
%STRVCAT Vertically concatenate strings.
%   S = STRVCAT(T1,T2,T3,..) forms the matrix S containing the text
%   strings T1,T2,T3,... as rows.  Automatically pads each string with
%   blanks in order to form a valid matrix. Each text parameter, Ti, can
%   itself be a string matrix.  This allows the creation of arbitrarily
%   large string matrices.  Empty strings in the input are ignored.
%
%   S = STRVCAT(C), when C is a cell array of strings, passes each
%   element of C as an input to STRVCAT.  Empty strings in the input are 
%   ignored.
%
%   STRVCAT('Hello','Yes') is the same as ['Hello';'Yes  '] except
%   that the padding is done automatically.
%
%   See also CELLSTR, CHAR.

%   Clay M. Thompson  3-20-91
%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.25 $  $Date: 2002/04/09 00:33:38 $

numinput = nargin;
if numinput == 1 & iscellstr(varargin{1})
  varargin = {varargin{1}{:}};
  numinput = length(varargin);
end
  
notempty = logical([]);
for i = numinput:-1:1
  notempty(i) = ~isempty(varargin{i});
end

s = char(varargin{notempty});


