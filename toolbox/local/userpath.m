function p = userpath
%USERPATH User environment path.
%   USERPATH returns a path string containing the current user
%   environment path (if it exists).  This function returns empty on
%   the PC and MAC.  On UNIX and VMS, the userpath is taken from the
%   MATLABPATH environment variable.

%   Copyright 1984-2002 The MathWorks, Inc. 
%   $Revision: 1.10 $ $Date: 2002/06/07 21:45:03 $

cname = computer;
% Look for VAX, this covers VAX_VMSxx as well as AXP_VMSxx.
if (length (cname) >= 7) & strcmp(cname(4:7),'_VMS')
  p = [getenv('MATLABPATH') ','];
  p = strrep(p,'toolbox:[local]',''); % Remove any redundant toolbox:[local]
  p = strrep(p,',,',',');
  
elseif (strncmp(cname,'PC',2))
   p = getenv('USERPROFILE');
   if ~(isempty(p))
      p = [p '\matlab'];
      if (exist(p,'dir'))
         p(end+1) = ';';
      else 
         p = '';
      end
   end   
   
% Look for UNIX
elseif ~strncmp(cname,'PC',2) & ~strncmp(cname,'MAC',3) % Must be UNIX
  p = [getenv('MATLABPATH') ':'];
  % Remove any redundant toolbox/local
  p = strrep(p,[matlabroot '/toolbox/local'],'');
  p = strrep(p,'::',':');
else
 p = '';
end

