function b = permute(a,order)
%PERMUTE Permute array dimensions.
%   B = PERMUTE(A,ORDER) rearranges the dimensions of A so that they
%   are in the order specified by the vector ORDER.  The array produced
%   has the same values of A but the order of the subscripts needed to 
%   access any particular element are rearranged as specified by ORDER.
%   The elements of ORDER must be a rearrangement of the numbers from
%   1 to N.
%
%   PERMUTE and IPERMUTE are a generalization of transpose (.') 
%   for N-D arrays.
%
%   Example
%      a = rand(1,2,3,4);
%      size(permute(a,[3 2 1 4])) % now it's 3-by-2-by-1-by-4.
%
%   See also IPERMUTE.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.15 $  $Date: 2002/04/08 20:21:09 $
%   Built-in function.
