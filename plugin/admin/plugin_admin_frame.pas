unit plugin_admin_frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar, Vcl.StdCtrls, Vcl.ExtCtrls, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, System.Actions, Vcl.ActnList, cxCheckBox, Vcl.Samples.Spin, cxSpinEdit,
  Vcl.Menus,cxDataUtils, cxButtonEdit, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, dxDateTimeWheelPicker, cxCalendar,common, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxHyperLinkEdit;

type
  TRoleFormResult = record
    methods:string;
    value:Boolean;
  end;

  TpluginadminFrame = class(TFrame)
    dxNavBar1: TdxNavBar;
    dxNavBar1Group1: TdxNavBarGroup;
    dxNavBar1Item1: TdxNavBarItem;
    dxNavBar1Item2: TdxNavBarItem;
    dxNavBar1Item3: TdxNavBarItem;
    dxNavBar1Group2: TdxNavBarGroup;
    dxNavBar1Item4: TdxNavBarItem;
    dxNavBar1Item5: TdxNavBarItem;
    dxNavBar1Item6: TdxNavBarItem;
    dxNavBar1Item7: TdxNavBarItem;
    dxNavBar1Item8: TdxNavBarItem;
    GroupBox1: TGroupBox;
    ActionList1: TActionList;
    methodsAction: TAction;
    methodDataSource: TDataSource;
    groupAction: TAction;
    memberAction: TAction;
    ScrollBox1: TScrollBox;
    cxGrid1: TcxGrid;
    methodcxGrid1DBTableView: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    Panel1: TPanel;
    methodcxGrid1DBTableViewColumn1: TcxGridDBColumn;
    methodcxGrid1DBTableViewColumn2: TcxGridDBColumn;
    methodcxGrid1DBTableViewColumn3: TcxGridDBColumn;
    methodcxGrid1DBTableViewColumn4: TcxGridDBColumn;
    Button1: TButton;
    Button2: TButton;
    postdataAction: TAction;
    groupcxGrid1DBTableView: TcxGridDBTableView;
    groupcxGrid1DBTableViewColumn1: TcxGridDBColumn;
    groupcxGrid1DBTableViewColumn2: TcxGridDBColumn;
    groupcxGrid1DBTableViewColumn3: TcxGridDBColumn;
    groupcxGrid1DBTableViewColumn4: TcxGridDBColumn;
    groupcxGrid1DBTableViewColumn5: TcxGridDBColumn;
    groupcxGrid1DBTableViewColumn6: TcxGridDBColumn;
    groupDataSource: TDataSource;
    groupaddAction: TAction;
    groupresetAction: TAction;
    methodcxGrid1DBTableViewColumn5: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    groupclassallAction: TAction;
    groupclassnoallAction: TAction;
    N2: TMenuItem;
    membercxGrid1DBTableView: TcxGridDBTableView;
    membercxGrid1DBTableViewColumn1: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn2: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn3: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn4: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn5: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn6: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn7: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn8: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn9: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn10: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn11: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn12: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn13: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn14: TcxGridDBColumn;
    membercxGrid1DBTableViewColumn15: TcxGridDBColumn;
    memberPanel: TPanel;
    usernameEdit: TEdit;
    useridEdit: TEdit;
    groupcxLookupComboBox: TcxLookupComboBox;
    passwordEdit: TEdit;
    nicknameEdit: TEdit;
    fullnameEdit: TEdit;
    phone1Edit: TEdit;
    phone2Edit: TEdit;
    identityEdit: TEdit;
    emailEdit: TEdit;
    qqEdit: TEdit;
    addrEdit: TEdit;
    memberaddButton: TButton;
    memeberresetButton: TButton;
    memberDataSource: TDataSource;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    memeberaddAction: TAction;
    memeberresetAction: TAction;
    PopupMenu2: TPopupMenu;
    groupdeleteMenu: TMenuItem;
    groupdeleteAction: TAction;
    groupundoAction: TAction;
    groupundomenu: TMenuItem;
    PopupMenu3: TPopupMenu;
    memberdeleteAction: TAction;
    memberdeletemenu: TMenuItem;
    memeberundoAction: TAction;
    memberundomenu: TMenuItem;
    memebergroupAction: TAction;
    membergroupmenu: TMenuItem;
    expoDataSource: TDataSource;
    expotypeDataSource: TDataSource;
    expotypecxGrid1DBTableView: TcxGridDBTableView;
    expotypecxGrid1DBTableViewColumn1: TcxGridDBColumn;
    expotypecxGrid1DBTableViewColumn2: TcxGridDBColumn;
    expotypecxGrid1DBTableViewColumn3: TcxGridDBColumn;
    expotypecxGrid1DBTableViewColumn4: TcxGridDBColumn;
    groupPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nameEdit: TEdit;
    titleEdit: TEdit;
    sortSpinEdit: TSpinEdit;
    statusCheckBox: TCheckBox;
    groupaddButton: TButton;
    Button4: TButton;
    groupresetButton: TButton;
    authmethodComboBox: TComboBox;
    expotypeAction: TAction;
    expoAction: TAction;
    expotypeaddAction: TAction;
    expotyperesetAction: TAction;
    expocxGrid1DBTableView: TcxGridDBTableView;
    expocxGrid1DBTableViewColumn1: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn2: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn3: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn4: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn5: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn6: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn7: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn8: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn9: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn10: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn11: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn12: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn13: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn14: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn15: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn16: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn17: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn18: TcxGridDBColumn;
    expocxGrid1DBTableViewColumn19: TcxGridDBColumn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    expomgPanel: TPanel;
    expotypePanel: TPanel;
    Label17: TLabel;
    expotypenameEdit: TEdit;
    expotypeaddButton: TButton;
    expotyperesetButton: TButton;
    expoPanel: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    expotitleEdit: TEdit;
    subtitleEdit: TEdit;
    expotypecxLookupComboBox: TcxLookupComboBox;
    areacxButtonEdit: TcxButtonEdit;
    expoaddrEdit: TEdit;
    startdatecxDateEdit: TcxDateEdit;
    enddatecxDateEdit: TcxDateEdit;
    befordatecxDateEdit: TcxDateEdit;
    afterdatecxDateEdit: TcxDateEdit;
    expoaddButton: TButton;
    exporesetButton: TButton;
    infoMemo: TMemo;
    clientvisiableCheckBox: TCheckBox;
    weblinkEdit: TEdit;
    TabSheet3: TTabSheet;
    procedure methodsActionExecute(Sender: TObject);
    procedure postdataActionExecute(Sender: TObject);
    procedure groupActionExecute(Sender: TObject);
    procedure groupclassallActionExecute(Sender: TObject);
    procedure groupclassnoallActionExecute(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure groupcxGrid1DBTableViewColumn4PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure memberActionExecute(Sender: TObject);
    procedure groupaddActionExecute(Sender: TObject);
    procedure groupresetActionExecute(Sender: TObject);
    procedure memeberaddActionExecute(Sender: TObject);
    procedure groupdeleteActionExecute(Sender: TObject);
    procedure groupundoActionExecute(Sender: TObject);
    procedure memeberresetActionExecute(Sender: TObject);
    procedure memberdeleteActionExecute(Sender: TObject);
    procedure memeberundoActionExecute(Sender: TObject);
    procedure memebergroupActionExecute(Sender: TObject);
    procedure expotypeActionExecute(Sender: TObject);
  private
    procedure groupclassSelect(value: boolean);
    function showroleselectfrom(groupname:string;methods: string=''):TRoleFormResult;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }

  end;

implementation

{$R *.dfm}

uses plugin_admin_datamod, plugin_admin_roleselectfrom,cxTl;

{ TpluginadminFrame }

function TpluginadminFrame.showroleselectfrom(groupname:string;methods:string=''):TRoleFormResult;
var
  str,str1:string;
  parentnode:TcxTreeListNode;
  list:TArray<string>;
  i:integer;
begin
  str:='';
  list := methods.Split([',']);

  roleselectForm := TroleselectForm.Create(self);
  if groupname='[]' then
    roleselectForm.Panel1.Caption:='未知分组标题[未知分组名]'
  else
    roleselectForm.Panel1.Caption:=groupname;
  pluginadmindm.methodFDMemTable.DisableControls;
  pluginadmindm.methodFDMemTable.IndexesActive:=True;
  pluginadmindm.methodFDMemTable.IndexName:='aaa';
  pluginadmindm.methodFDMemTable.First;

  while not pluginadmindm.methodFDMemTable.Eof do
  begin
    str1:=copy(pluginadmindm.methodFDMemTable.FieldByName('methodalias').AsString,1,
      pluginadmindm.methodFDMemTable.FieldByName('methodalias').AsString.IndexOf('.'));
    if str<>str1 then
    begin
       str:=str1;
       parentnode:=roleselectForm.cxTreeList1.Add;
       parentnode.Texts[0]:=str;
       parentnode.Values[2]:=0;
    end
    else
    begin
      with roleselectForm.cxTreeList1.AddChild(parentnode) do
      begin
        Texts[0]:=pluginadmindm.methodFDMemTable.FieldByName('methodalias').AsString;
        Texts[1]:=pluginadmindm.methodFDMemTable.FieldByName('methodtitle').AsString;
        Values[2]:=0;


          for i := 0 to length(list)-1 do
          begin
            if list[i]=pluginadmindm.methodFDMemTable.FieldByName('methodalias').AsString then
            begin

               Values[2]:=1;
               parentnode.Values[2]:=1;
               break;
            end;
          end;
      end;
    end;
    pluginadmindm.methodFDMemTable.Next;
    //roleselectForm.cxTreeList1.Add.Texts[0]
  end;
  pluginadmindm.methodFDMemTable.IndexName:='';
  pluginadmindm.methodFDMemTable.IndexesActive:=false;
  pluginadmindm.methodFDMemTable.EnableControls;
  Result.methods:='';
  Result.value:=false;
  if roleselectForm.ShowModal=mrOk then
  begin
    str:='';
    for i :=0 to roleselectForm.cxTreeList1.AbsoluteCount-1 do
    begin
      if (roleselectForm.cxTreeList1.AbsoluteItems[i].Level>0) and (roleselectForm.cxTreeList1.AbsoluteItems[i].Values[2]=1) then
      begin
        str:=str+','+roleselectForm.cxTreeList1.AbsoluteItems[i].Texts[0];
      end;
    end;
    Result.methods :=str.Substring(1);
    Result.value:=true;
  end;
  roleselectForm.Free;
end;

procedure TpluginadminFrame.groupcxGrid1DBTableViewColumn4PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  roleresult:TRoleFormResult;
begin
  roleresult:=showroleselectfrom(pluginadmindm.groupFDMemTable.FieldByName('title').AsString+'['
                                 +pluginadmindm.groupFDMemTable.FieldByName('name').AsString+']'
                           ,pluginadmindm.groupFDMemTable.FieldByName('authmethod').AsString);
  if roleresult.value then
  begin
    pluginadmindm.groupFDMemTable.Edit;
    pluginadmindm.groupFDMemTable.FieldByName('authmethod').AsString:=roleresult.methods;
    pluginadmindm.groupFDMemTable.Post;
  end;
end;

procedure TpluginadminFrame.groupdeleteActionExecute(Sender: TObject);
begin
  if Application.MessageBox('是否要删除当前记录', '删除记录', MB_OKCANCEL + MB_ICONQUESTION
    + MB_DEFBUTTON2 + MB_TOPMOST) = IDOK then
  begin
    pluginadmindm.groupFDMemTable.Delete;
  end;
end;

procedure TpluginadminFrame.groupresetActionExecute(Sender: TObject);
begin
  nameEdit.Clear;
  titleEdit.Clear;
  authmethodComboBox.Clear;
  sortSpinEdit.Value:=100;
  statusCheckBox.Checked:=true;
  nameEdit.SetFocus;
end;

procedure TpluginadminFrame.groupundoActionExecute(Sender: TObject);
begin
  pluginadmindm.groupFDMemTable.UndoLastChange(true);
end;

procedure TpluginadminFrame.Button4Click(Sender: TObject);
var
  roleresult:TRoleFormResult;
begin
  //ComboBox1.Items.CommaText:=',';
  roleresult:=showroleselectfrom(titleEdit.Text+'['+nameEdit.Text+']',authmethodComboBox.Items.CommaText);
  if roleresult.value then
  begin
    // authmethodEdit.Text:=str;
    authmethodComboBox.Items.CommaText:=roleresult.methods;
    if authmethodComboBox.Items.Count>0 then
       authmethodComboBox.ItemIndex:=0
    else
       authmethodComboBox.ItemIndex:=-1;

  end;

end;

constructor TpluginadminFrame.Create(AOwner: TComponent);
begin
  inherited;
  GroupBox1.Caption:= methodsAction.Caption;
  groupPanel.Visible:=false;
  expomgPanel.Visible:=false;
  pluginadmindm:=Tpluginadmindm.Create(Self);
  try
    pluginadmindm.GetData;
  except
    //pluginadmindm.Free;
    raise;
  end;
end;

destructor TpluginadminFrame.Destroy;
begin
  pluginadmindm.Free;
  inherited;
end;

procedure TpluginadminFrame.expotypeActionExecute(Sender: TObject);
begin
  groupPanel.Visible:=false;
  memberPanel.Visible:=false;
  expomgPanel.Visible:=True;

  GroupBox1.Caption:= TAction(Sender).Caption;
  if TAction(Sender).Name='expotypeAction' then
  begin
     expoPanel.Visible:=false;
     expotypePanel.Visible:=true;
     expotypePanel.Align:=alBottom;
     expomgPanel.Height:=expotypePanel.Height;
     cxGrid1Level1.GridView:=expotypecxGrid1DBTableView;
  end;
  if TAction(Sender).Name='expoAction' then
  begin
     expotypePanel.Visible:=false;
     expoPanel.Visible:=true;
     expoPanel.Align:=alBottom;
     expomgPanel.Height:=expoPanel.Height;
     cxGrid1Level1.GridView:=expocxGrid1DBTableView;
  end;
  Panel1.Top:=9999;
end;

procedure TpluginadminFrame.groupActionExecute(Sender: TObject);
begin
  GroupBox1.Caption:= groupAction.Caption;
  cxGrid1Level1.GridView:=groupcxGrid1DBTableView;
  groupPanel.Visible:=true;
  memberPanel.Visible:=false;
  expomgPanel.Visible:=false;
end;

procedure TpluginadminFrame.groupaddActionExecute(Sender: TObject);
begin
  if pluginadmindm.groupFDMemTable.Locate('name',Trim(nameEdit.Text),[loCaseInsensitive]) then
  begin
    showmessage('分组名称不能重复');
    exit;
  end;
    if Trim(nameEdit.Text).IsEmpty then
    begin
      showmessage('分组名称不能为空');
      exit;
    end;
    if Trim(titleEdit.Text).IsEmpty then
    begin
      showmessage('分组标题不能为空');
      exit;
    end;
    pluginadmindm.groupFDMemTable.Append;
    pluginadmindm.groupFDMemTable.FieldByName('name').Value:=Trim(nameEdit.Text);
    pluginadmindm.groupFDMemTable.FieldByName('title').Value:=Trim(titleEdit.Text);
    pluginadmindm.groupFDMemTable.FieldByName('authmethod').AsString:=authmethodComboBox.Items.CommaText;
    pluginadmindm.groupFDMemTable.FieldByName('sort').Value:=sortSpinEdit.Value;
    if statusCheckBox.Checked then
       pluginadmindm.groupFDMemTable.FieldByName('status').Value:=1
    else
      pluginadmindm.groupFDMemTable.FieldByName('status').Value:=0;
    pluginadmindm.groupFDMemTable.Post;
    groupresetActionExecute(nil);
end;

procedure TpluginadminFrame.groupclassallActionExecute(Sender: TObject);
begin
  groupclassSelect(true);
end;

procedure TpluginadminFrame.groupclassnoallActionExecute(Sender: TObject);
begin
  groupclassSelect(false);
end;

procedure TpluginadminFrame.groupclassSelect(value:boolean);
var
  a,i,index:Integer;
  Alist:Tlist;
begin

  pluginadmindm.SelectMethodwithClass(value);
  {
  if value then
    a:=1
  else
    a:=0;

  Alist:=TList.Create;
  index:=methodcxGrid1DBTableView.DataController.Groups.DataGroupIndexByRowIndex[methodcxGrid1DBTableView.Controller.FocusedRowIndex];
  methodcxGrid1DBTableView.DataController.Groups.LoadRecordIndexes(Alist,index);
  //methodcxGrid1DBTableView.DataController.BeginFullUpdate;
  for i := 0 to alist.Count-1 do
  begin
    //showmessage(Integer(Alist.Items[i]).ToString);
    methodcxGrid1DBTableView.DataController.Provider.DataSet.RecNo:=Integer(Alist.Items[i]);
    //methodcxGrid1DBTableView.DataController.RecNo:=
    //methodcxGrid1DBTableView.DataController.Values[Integer(Alist.Items[i]),methodcxGrid1DBTableViewColumn4.Index]:=a;
   methodcxGrid1DBTableView.DataController.SetEditValue(methodcxGrid1DBTableViewColumn4.Index,a,TcxDataEditValueSource.evsValue);
   // methodcxGrid1DBTableView.DataController.SetValue();
  end;
  //methodcxGrid1DBTableView.DataController.EndFullUpdate;
  Alist.Free;

  //showmessage(pluginadmindm.methodFDMemTable.FieldByName('status').Value);
  }
end;



procedure TpluginadminFrame.memberActionExecute(Sender: TObject);
begin
  GroupBox1.Caption:= TAction(Sender).Caption;
  cxGrid1Level1.GridView:=membercxGrid1DBTableView;
  groupPanel.Visible:=false;
  memberPanel.Visible:=true;
  expomgPanel.Visible:=false;
end;

procedure TpluginadminFrame.memberdeleteActionExecute(Sender: TObject);
begin
  if Application.MessageBox('是否要删除当前记录', '删除记录', MB_OKCANCEL + MB_ICONQUESTION
    + MB_DEFBUTTON2 + MB_TOPMOST) = IDOK then
  begin
    pluginadmindm.memberFDMemTable.Delete;
  end;
end;

procedure TpluginadminFrame.memeberaddActionExecute(Sender: TObject);
var
  groupname:string;
  groupid:string;
begin

  if groupcxLookupComboBox.ItemIndex=-1 then
  begin
    showmessage('分组不能为空');
    exit;
  end;
  if Trim(usernameEdit.Text).IsEmpty then
  begin
    showmessage('用户名不能为空');
    exit;
  end;
  if Trim(passwordEdit.Text).IsEmpty then
  begin
    showmessage('密码不能为空');
    exit;
  end;

  with pluginadmindm.memberFDMemTable do
  begin
    Append;
    FieldByName('username').AsString:=Trim(usernameEdit.Text);
    FieldByName('password').AsString:=Trim(passwordEdit.Text);
    FieldByName('userid').AsString:=Trim(useridEdit.Text);
    FieldByName('nickname').AsString:=Trim(nicknameEdit.Text);
    FieldByName('fullname').AsString:=Trim(fullnameEdit.Text);
    FieldByName('identity').AsString:=Trim(identityEdit.Text);
    FieldByName('mobilephone1').AsString:=Trim(phone1Edit.Text);
    FieldByName('mobilephone2').AsString:=Trim(phone2Edit.Text);
    FieldByName('email').AsString:=Trim(emailEdit.Text);
    FieldByName('qq').AsString:=Trim(qqEdit.Text);
    FieldByName('addr').AsString:=Trim(addrEdit.Text);
    FieldByName('locked').AsInteger:=0;
    FieldByName('logindatetime').AsDateTime:=now;
    groupname:= groupcxLookupComboBox.Properties.Grid.DataController.Values[groupcxLookupComboBox.Properties.Grid.DataController.FocusedRecordIndex,1];
    groupid:= pluginadmindm.groupFDMemTable.Lookup('name',groupname,'id');
    FieldByName('groupid').AsString:=groupid;
    Post;
  end;
  memeberresetActionExecute(nil);
end;

procedure TpluginadminFrame.memebergroupActionExecute(Sender: TObject);
begin
  if not TAction(Sender).Checked then
  begin
    TAction(Sender).Checked:=true;
    membercxGrid1DBTableViewColumn2.GroupIndex:=0;
  end
  else
  begin
    TAction(Sender).Checked:=false;
    membercxGrid1DBTableViewColumn2.GroupIndex:=-1;
  end;

end;

procedure TpluginadminFrame.memeberresetActionExecute(Sender: TObject);
var
  i:integer;
begin
  for i := 0 to memberPanel.ControlCount-1 do
  begin
    if (memberPanel.Controls[i] is TEdit) then
      (memberPanel.Controls[i] as TEdit).Clear;
    if (memberPanel.Controls[i] is TcxLookupComboBox) then
    (memberPanel.Controls[i] as TcxLookupComboBox).ItemIndex:=-1;
  end;
  groupcxLookupComboBox.SetFocus;

end;

procedure TpluginadminFrame.memeberundoActionExecute(Sender: TObject);
begin
  if Application.MessageBox('是否要恢复上一步操作', '恢复上一步', MB_OKCANCEL +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDOK then
  begin
    pluginadmindm.memberFDMemTable.UndoLastChange(true);
  end;

end;

procedure TpluginadminFrame.methodsActionExecute(Sender: TObject);
begin
  GroupBox1.Caption:= TAction(Sender).Caption;
  cxGrid1Level1.GridView:=methodcxGrid1DBTableView;
  groupPanel.Visible:=false;
  memberPanel.Visible:=false;
  expomgPanel.Visible:=false;
end;

procedure TpluginadminFrame.postdataActionExecute(Sender: TObject);
begin
  pluginadmindm.PostData;
end;

end.
