unit common;

interface

uses
  System.IOUtils,
  System.SysUtils,
  System.Types;

function DeleteTempfile(path:string):integer;

const
  TempPath = 'updatetemp\';
  UpdateUrl = 'http://update.jhlotus.com/';

implementation

function DeleteTempfile(path:string):integer;
var
  files:TStringDynArray;
  i:integer;
begin
  Result:=0;
  if not path.IsDelimiter(PathDelim,path.Length-1) then path:=path+PathDelim;
  files:= TDirectory.GetFileSystemEntries(path);
  for i := 0 to Length(files)-1 do
    if (TFileAttribute.faDirectory in TFile.IntegerToFileAttributes(FileGetAttr(files[i]))) and
        ((ExtractFileName(files[i]).ToLower+'\') <> TempPath) then
             Result:=Result + DeleteTempfile(files[i])
    else
      if ExtractFileExt(files[i]) = '.tmp' then
        if DeleteFile(files[i]) then Result:=Result+1;
end;

end.
