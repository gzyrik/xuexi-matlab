function string = mat2str(matrix,n)
%MAT2STR Convert a 2-D matrix to eval'able string.
%   STR = MAT2STR(MAT) converts the 2-D matrix MAT to a MATLAB 
%   string so that EVAL(STR) produces the original matrix (to 
%   within 15 digits of precision).  Non-scalar matrices are 
%   converted to a string containing brackets [].
%
%   STR = MAT2STR(MAT,N) uses N digits of precision. 
%
%   Example
%       mat2str(magic(3)) produces the string '[8 1 6; 3 5 7; 4 9 2]'.
%
%   See also NUM2STR, INT2STR, SPRINTF.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   D.Packer 7-10-90
%   Revised, A.Grace, 10-29-90
%   Revised, A.Potvin  9-21-92, 6-22-94
%   $Revision: 1.28 $  $Date: 2002/04/09 00:33:35 $

if isstr(matrix),
   string = matrix;
   return
end

if (ndims(matrix) > 2)
   error('Input matrix must be 2-D.');
end

[rows, cols] = size(matrix);
if isempty(matrix)
    if (rows==0) & (cols==0)
        string = '[]';
    else
        string = ['zeros(' int2str(rows) ',' int2str(cols) ')'];
    end
    return
end
if nargin<2,
   form = '%.15g';
else
   form = ['%.' int2str(n) 'g'];
end
if rows*cols ~= 1
    string = '[';
else
    string = '';
end
for i = 1:rows
    for j = 1:cols
        if(matrix(i,j) == Inf)
            string = [string,'Inf'];
        elseif (matrix(i,j) == -Inf)
            string = [string,'-Inf'];
        else
            string = [string,sprintf(form,real(matrix(i,j)))];
            if(imag(matrix(i,j)) < 0)
                string = [string,'-i*',sprintf(form,abs(imag(matrix(i,j))))];
            elseif(imag(matrix(i,j)) > 0)
                string = [string,'+i*',sprintf(form,imag(matrix(i,j)))];
            end
        end
        string = [string ' '];
    end
    l = length(string);
    string(l) = ';';
end
if rows==0,
    string = [string ' '];
end
l = length(string);
if rows * cols ~= 1
    string(l)  = ']';
else
    string(l)  = [];
end
% end mat2str
