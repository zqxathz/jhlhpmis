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
   plugauther:string;
   plugcommit:string;
   plugclassname:string;
  end;

  TGetPluginInfo = function:TPluginInfo;



implementation

end.
