program update;

uses
  System.SysUtils,
  Vcl.Forms,
  System.SyncObjs,
  main in 'main.pas' {updateForm},
  datamoudle in 'datamoudle.pas' {updateDataModule: TDataModule},
  servermethods in '..\clientsyc\servermethods.pas';

{$R *.res}

var
  hAppMutex: TMutex; //ÉùÃ÷»¥³â±äÁ¿

begin
  hAppMutex := TMutex.Create(nil,true,'{3DE1B19B-A903-4879-97FE-AB18266539AE}');
  if  hAppMutex.WaitFor(1)=wrTimeout then exit;
  hAppMutex.Acquire;
  try
    updateDataModule := TupdateDataModule.Create(nil);
    try
      if updateDataModule.GetUpdateList then
      begin
        Application.Initialize;
        Application.MainFormOnTaskbar := True;
        Application.CreateForm(TupdateForm, updateForm);
        updateForm.updateJson := updateDataModule.UpdateJson;
        if updateForm.CanShow then
          Application.Run
        else
          Application.Terminate;
      end;
    except

    end;
  finally
    updateDataModule.Free;
    hAppMutex.Release;
    hAppMutex.Free;
  end;

//
//  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
//  Application.CreateForm(TupdateForm, updateForm);
//  Application.CreateForm(TupdateDataModule, updateDataModule);
//  Application.Run;
end.

