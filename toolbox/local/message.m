function s=message(varargin)
s=varargin{1};
c=find(s==':');
if ~isempty(c), s=s(c(end)+1:end); end
