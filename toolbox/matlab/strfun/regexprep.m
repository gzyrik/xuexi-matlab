%REGEXPREP Replace string using regular expression.
%   S = REGEXPREP(STRING,EXPRESSION,REPLACE) replaces all occurrences of the
%   regular expression, EXPRESSION, in string, STRING, with the string, REPLACE.
%   The new string is returned.  If no matches are found REGEXPREP returns
%   STRING unchanged.
%
%   When any of STRING, EXPRESSION or REPLACE are cell arrays of strings,
%   REGEXPREP returns an LxMxN cell array of strings, where L is the number of
%   strings in STRING, M is the number of regular expressions in EXPRESSION and
%   N is the number of strings in REPLACE.
%
%   By default, REGEXPREP replaces all matches, is case sensitive, and does not
%   use tokens.  Available options are:
%
%      'ignorecase'   - Ignore the case of characters when matching EXPRESSION
%                       to STRING.
%      'preservecase' - Ignore case when matching (as with 'ignorecase'), but
%                       override the case of REPLACE characters with the case
%                       of corresponding characters in STRING when replacing.
%      'tokenize'     - Modify REPLACE to use the tokens delimited by
%                       parenthesis in EXPRESSION such that $1 is the first
%                       token, $2 is the second token... $N is the Nth token.
%      'once'         - Replace only the first occurrence of EXPRESSION in
%                       STRING.
%      N              - Replace only the Nth occurrence of EXPRESSION in STRING.
%
%   REGEXPREP does not support international character sets.
%
%   Examples:
%      str = 'My flowers may bloom in May';
%      pat = 'm(\w*)y';
%      regexprep(str, pat, 'April')
%         returns 'My flowers April bloom in May'
%
%      regexprep(str, pat, 'April', 'preservecase')
%         returns 'April flowers april bloom in April'
%
%      str = 'I walk up, they walked up, we are walking up, she walks.'
%      pat = 'walk(\w*) up'
%      regexprep(str, pat, 'ascend$1', 'tokenize')
%         returns 'I ascend, they ascended, we are ascending, she walks.'
%
%   See also REGEXP, REGEXPI, STRREP, STRCMP, STRNCMP, FINDSTR, STRMATCH.
%

%
%   E. Mehran Mestchian
%   J. Breslau
%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 1.7 $  $Date: 2002/04/09 00:33:35 $
%
