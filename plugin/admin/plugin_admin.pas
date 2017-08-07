unit plugin_admin;

interface
uses System.Classes;

type
   TPluginInfo = record
     plugguid:string;
     plugtype:integer;
     plugname:string;
     plugtitle:string;
     plugversion:string;
     plugcommit:string;
   end;

function GetPluginInfo:TPluginInfo;

exports GetPluginInfo;

implementation

function GetPluginInfo:TPluginInfo;
begin
  Result.plugguid:='{2B9D420D-B838-4BD7-B617-CFB425C3E2D4}';
  Result.plugtype:=0;
  Result.plugname:='admin';
  Result.plugtitle:='系统管理';
  Result.plugversion:='1.0';
  Result.plugcommit:='';
end;


end.
