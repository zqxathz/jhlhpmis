unit staticstr;

interface

const
   //C:\Program Files\PremiumSoft\Navicat Premium\
   sqlite3DLL = '..\..\..\sqlite3.dll';
   sqlite3password = '123';
   databasename =  '..\..\..\database2.db';
   inifile  = 'jhlh.ini';
   LOGIN_SQL = 'select id,userid from jhlh_admin_member where username = "%s" and password = "%s"';

implementation

end.
