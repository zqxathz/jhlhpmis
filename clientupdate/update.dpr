program update;

uses
  Vcl.Forms,
  Vcl.Dialogs,
  main in 'main.pas' {updateForm},
  datamoudle in 'datamoudle.pas' {updateDataModule: TDataModule},
  servermethods in '..\clientsyc\servermethods.pas';

{$R *.res}

begin
  updateDataModule:= TupdateDataModule.Create(nil);
  try
   if updateDataModule.GetUpdateList then
   begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TupdateForm, updateForm);
    updateForm.updateJson:=updateDataModule.UpdateJson;
    Application.Run;
   end;
  except

  end;
  updateDataModule.Free;
  exit;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TupdateForm, updateForm);
  Application.CreateForm(TupdateDataModule, updateDataModule);
  Application.Run;
end.
