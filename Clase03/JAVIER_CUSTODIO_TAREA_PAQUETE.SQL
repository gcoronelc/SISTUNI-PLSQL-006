
CREATE OR REPLACE PACKAGE SCOTT.PKG_UTIL as

function suma( n1 in number, n2 in number ) 
return number; 

END PKG_UTIL;



CREATE OR REPLACE PACKAGE BODY SCOTT.PKG_UTIL AS

function suma( n1 in number, n2 in number ) 
return number 
as
  rtn number;
begin
  rtn := n1 + n2; 
  return rtn;
end;

END PKG_UTIL;


select SCOTT.PKG_UTIL.suma( 12,13) from dual;

