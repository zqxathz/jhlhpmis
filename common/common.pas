unit common;

interface
uses System.SysUtils,System.DateUtils;

function getuuid:string;
function getmillisecond:int64;

implementation

function getuuid:string;
var
  guid:TGuid;
begin
  CreateGuid(guid);
  SetLength(Result,16);
  StrLFmt(PChar(Result), 16,'%.2x%.2x%.2x%.2x%.2x%.2x%.2x%.2x',   // do not localize
    [guid.D4[0], guid.D4[1],guid.D4[2], guid.D4[3],guid.D4[4], guid.D4[5], guid.D4[6], guid.D4[7]]);
end;

function getmillisecond:int64;
begin
  Result:=DateTimeToUnix(now)*1000+MilliSecondOfTheDay(now);
end;

end.
