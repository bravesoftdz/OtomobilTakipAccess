unit frmAna1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Data.Win.ADODB, Vcl.Menus;

type
  TfrmAna = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Edit3: TEdit;
    Edit4: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Button3: TButton;
    Button4: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    GridPopup: TPopupMenu;
    GiriiSil1: TMenuItem;
    ProgramSonlandr1: TMenuItem;
    N1: TMenuItem;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure ProgramSonlandr1Click(Sender: TObject);
    procedure GiriiSil1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAna: TfrmAna;

implementation

{$R *.dfm}

procedure TfrmAna.Button1Click(Sender: TObject);
begin
 with ADOQuery1 do
 begin
   Close;
   SQL.Clear;
   SQL.Text := 'insert into tbl_araclar(aracSase, aracPlaka, aracYapilanlar, aracSikayet, aracGirisTarih) VALUES(:aracSase, :aracPlaka, :aracYapilanlar, :aracSikayet, :aracGirisTarih)';
   Parameters.ParamByName('aracSase').Value := Edit2.Text;
   Parameters.ParamByName('aracPlaka').Value := Edit1.Text;
   Parameters.ParamByName('aracYapilanlar').Value := Memo2.Lines.Text;
   Parameters.ParamByName('aracSikayet').Value := Memo1.Lines.Text;
   Parameters.ParamByName('aracGirisTarih').Value := DateToStr(Date);
   ExecSQL;
   SQL.Text := 'select * from tbl_araclar';
   Open;
 end;

  ShowMessage('Kay�t ba�ar�l�!');
        Button2Click(sender);

end;

procedure TfrmAna.Button2Click(Sender: TObject);
begin
 Edit1.Clear;
 Edit2.Clear;
 Memo1.Clear;
 Memo2.Clear;
end;

procedure TfrmAna.Button3Click(Sender: TObject);
begin
 with ADOQuery1 do
 begin
   Close;
   SQL.Clear;
   SQL.Text := 'select * from tbl_araclar where aracPlaka=:aracPlaka or aracSase=:aracSase';
   Parameters.ParamByName('aracPlaka').Value := Edit3.Text;
   Parameters.ParamByName('aracSase').Value := Edit4.Text;
   ExecSQL;
   Open;
 end;
end;

procedure TfrmAna.Button4Click(Sender: TObject);
begin
 Edit3.Clear;
 Edit4.Clear;

 with ADOQuery1 do
 begin
   Close;
   SQL.Clear;
   SQL.Text := 'select * from tbl_araclar';
   ExecSQL;
   Open;
 end;
end;

procedure TfrmAna.DBGrid1DblClick(Sender: TObject);
begin
 Memo1.Lines.Text := ADOQuery1.FieldByName('aracSikayet').AsString;
 Memo2.Lines.Text := ADOQuery1.FieldByName('aracYapilanlar').AsString;
 Edit1.Text := ADOQuery1.FieldByName('aracPlaka').AsString;
 Edit2.Text := ADOQuery1.FieldByName('aracSase').AsString;
end;

procedure TfrmAna.FormCreate(Sender: TObject);
begin
 ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+ExtractFilePath(Application.ExeName)+'\Data\data.mdb;Mode=Share Deny None;Jet OLEDB:System database=""'+
 ';Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create System '+
 'Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'+#39+'t Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False;';

 ADOConnection1.Connected := True;
 ADOQuery1.Connection := ADOConnection1;
 ADOQuery1.SQL.Text := 'select * from tbl_araclar';
 ADOQuery1.Active := True;
 DataSource1.DataSet := ADOQuery1;
 DBGrid1.DataSource := DataSource1;
 end;

procedure TfrmAna.GiriiSil1Click(Sender: TObject);
begin
 ADOQuery1.Delete;
 Button2Click(sender);
end;

procedure TfrmAna.ProgramSonlandr1Click(Sender: TObject);
begin
Application.Terminate;
end;

end.
