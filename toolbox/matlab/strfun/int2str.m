function s = int2str(x)
%INT2STR Convert integer to string.
%   S = INT2STR(X) rounds the elements of the matrix X to
%   integers and converts the result into a string matrix.
%   Return NaN and Inf elements as strings 'NaN' and 'Inf', respectively.
%
%   See also NUM2STR, SPRINTF, FPRINTF.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 5.20 $  $Date: 2002/04/09 00:33:34 $

x = round(real(x));
if length(x) == 1
   % handle special case of single infinite or NaN element
   s = sprintf('%.1f',x);
   if (~strcmp(s, '-Inf') & ~strcmp(s, 'Inf') & ~strcmp(s, 'NaN'))
     s(end-1:end) = [];
   end
else
   s = '';
   [m,n] = size(x);
   % Determine elements of x that are finite.
   xfinite = x(isfinite(x));
   % determine the variable text field width quantity
   d = max(1,max(ceil(log10(abs(xfinite(:))+(xfinite(:)==0)))));
   clear('xfinite')
   % delimit string array with one space between all-NaN or all-Inf columns
   if any(isnan(x(:)))|any(isinf(x(:)))
      d = max([d;3]);
   end
   % walk through numbers array and convert elements to strings
   for i = 1:m
      t = [];
      for j = 1:n
         t = [t sprintf('%*.0f',d+2,x(i,j))];
      end
      s = [s; t];
   end
   % trim leading spaces from string array within constraints of rectangularity.
   if ~isempty(s)
      while all(s(:,1) == ' ')
         s(:,1) = []; 
      end
   end
end
