unit inisetting;

interface

uses System.Classes, System.IniFiles;

type
  TIniSetting = class(TCustomIniFile)
  private
    FSettingList:TStringList;
  public
    procedure SaveToFile;
    procedure LoadFromFile;
    procedure SetValue(name,value:string);
    function GetValue(name:string):string;
    constructor Create(const FileName: string);overload;virtual;
    destructor Destroy; override;
  end;

implementation

{ TIniSetting }


constructor TIniSetting.Create(const FileName: string);
begin
  inherited Create(FileName);
  FSettingList:=TStringList.Create;
end;

destructor TIniSetting.Destroy;
begin
  if Assigned(FSettingList) then FSettingList.Free;
  inherited;
end;

function TIniSetting.GetValue(name: string): string;
begin
  Result:=FSettingList.Values[name];
end;

procedure TIniSetting.LoadFromFile;
begin
  ReadSections(FSettingList);
end;

procedure TIniSetting.SaveToFile;
begin

end;

procedure TIniSetting.SetValue(name, value: string);
begin
  FSettingList.Values[name]:=value;
end;

end.
