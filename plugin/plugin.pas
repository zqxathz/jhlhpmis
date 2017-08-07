unit plugin;

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

  TGetPluginInfo = function:TPluginInfo;



implementation

end.
