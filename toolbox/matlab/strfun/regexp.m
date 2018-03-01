%REGEXP Match regular expression.
%   START = REGEXP(STRING,EXPRESSION) returns a row vector, START, which
%   contains the indices of the substrings in STRING that match the regular
%   expression string, EXPRESSION.
%
%   In EXPRESSION the following symbols have special meaning:
%
%               Symbol   Meaning
%              --------  --------------------------------
%                  ^     start of string
%                  $     end of string
%                  .     any character
%                  \     quote next character
%                  *     match zero or more
%                  +     match one or more
%                  ?     match zero or one, or match minimally
%                  {}    match a range of occurrances
%                  []    set of characters
%                  [^]   exclude a set of characters
%                  ()    group subexpression
%                  \w    match word [a-z_A-Z0-9]
%                  \W    not a word [^a-z_A-Z0-9]
%                  \d    match digit [0-9]
%                  \D    not a digit [^0-9]
%                  \s    match white space [ \t\r\n\f]
%                  \S    not a white space [^ \t\r\n\f]
%            \<WORD\>    exact word match
%
%   Example
%      str = 'bat cat can car coat court cut ct caoueouat';
%      pat = 'c[aeiou]+t';
%      regexp(str, pat)
%         returns [5 17 28 35]
%
%      which is a row vector of indices that match words that start with c, end
%      with t, and contain one or more vowels between them.
%
%   When either STRING or EXPRESSION is a cell array of strings, REGEXP returns
%   an MxN cell array of row vectors of indices, where M is the the number of
%   strings in STRING and N is the number of regular expression patterns in
%   EXPRESSION.
%
%   Example
%      str = {'Madrid, Spain' 'Romeo and Juliet' 'MATLAB is great'};
%      pat = {'[A-Z]' '\s'};
%      regexp(str, pat)
%         returns {[1 9] [8]; [1 11] [6 10]; [1 2 3 4 5 6] [7 10]}
%
%      which is a cell array of row vectors of indices that match capital
%      letters and whitespaces in the cell array of strings, str.
%
%   [START,FINISH] = REGEXP(STRING,EXPRESSION) returns an additional row vector
%   FINISH, which contains the indices of the last character of the
%   corresponding substrings in START.
%
%   Example
%      str = 'regexp helps you relax';
%      pat = '\w*x\w*';
%      [s,f] = regexp(str, pat)
%         returns
%            s = [1 18]
%            f = [6 22]
%
%      by finding words containing the letter x.
%
%   [START,FINISH,TOKENS] = REGEXP(STRING,EXPRESSION) returns a 1xN cell array,
%   TOKENS, of beginining and ending indices of tokens within the corresponding
%   substrings in START and FINISH.  Tokens are denoted by parentheses in
%   EXPRESSION.
%
%   Example
%      str = 'six sides of a hexagon';
%      pat = 's(\w*)s';
%      [s,f,t] = regexp(str, pat)
%         returns
%            s = [5]
%            f = [9]
%            t = {[6 8]}
%
%      finding substrings contained by the letter s.
%
%   By default, REGEXP returns all matches.  To find just the first match, use
%   REGEXP(STRING,EXPRESSION,'once'). If no matches are found then START,
%   FINISH, and TOKENS are empty.
%
%   REGEXP does not support international character sets.
%
%   See also REGEXPI, REGEXPREP, STRCMP, STRFIND, FINDSTR, STRMATCH.

%
%   E. Mehran Mestchian
%   J. Breslau
%   Copyright 1984-2002 The MathWorks, Inc.
%  $Revision: 1.5 $  $Date: 2002/04/09 00:33:35 $
%
