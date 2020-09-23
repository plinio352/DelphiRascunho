unit UFrmWhatsApp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UWhatsApp, ShellApi, UConstante, UDaoPadrao, Data.DB, Datasnap.DBClient, UDmConexao;

type
  TFrmWhatsApp = class(TForm)
    Panel1: TPanel;
    mmoMsn: TMemo;
    btnEnviar: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    edtPais: TEdit;
    edtDDD: TEdit;
    edtTel: TEdit;
    cdsAux: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ObjWhats: TWhatsApp;
    FPadrao: TDaoPadrao;
    FDados: OleVariant;

    procedure Limpar;
    procedure Enviar;
  public
    { Public declarations }

    class procedure WhatsApp(const ACodCliente: Integer; const ACliente, AObs: string);
  end;

var
  FrmWhatsApp: TFrmWhatsApp;

implementation

{$R *.dfm}

{ TFrmWhatsApp }

procedure TFrmWhatsApp.btnEnviarClick(Sender: TObject);
begin
   ObjWhats.pais := edtPais.Text;
   ObjWhats.ddd := edtDDD.Text;
   ObjWhats.telefone := edtTel.Text;
   ObjWhats.mensagem := mmoMsn.Lines.Text;

   Enviar;

   FrmWhatsApp.Close;

end;

procedure TFrmWhatsApp.Enviar;
begin
   ShellExecute(Handle, 'open', Pchar(ObjWhats.url), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TFrmWhatsApp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ObjWhats.Free;
   Action := caFree;
   FrmWhatsApp := nil;

end;

procedure TFrmWhatsApp.FormCreate(Sender: TObject);
begin
   ObjWhats := TWhatsApp.Create;
end;

procedure TFrmWhatsApp.FormKeyPress(Sender: TObject; var Key: Char);
begin
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;

end;

procedure TFrmWhatsApp.FormShow(Sender: TObject);
begin
   edtPais.SetFocus;

end;

procedure TFrmWhatsApp.Limpar;
var
   I: Word;
begin
   for I := 0 to ComponentCount -1 do begin
      if Components[I] is TEdit then
         (Components[I] as TEdit).Clear;
      if Components[I] is TMemo then
         (Components[I] as TMemo).Lines.Clear;
   end;

end;

class procedure TFrmWhatsApp.WhatsApp(const ACodCliente: Integer; const ACliente, AObs: string);
begin
   if not Assigned(FrmWhatsApp) then
      FrmWhatsApp := TFrmWhatsApp.Create(nil);
   try
      FrmWhatsApp.Limpar;

      FrmWhatsApp.FPadrao := DmConexao.Factory.ClassDaoPadrao;
      FrmWhatsApp.FDados := FrmWhatsApp.FPadrao.Consultar(_srv00062);

      FrmWhatsApp.cdsAux.Close;
      FrmWhatsApp.cdsAux.Data := FrmWhatsApp.FDados[0];
      FrmWhatsApp.cdsAux.Filtered  := False;
      FrmWhatsApp.cdsAux.Filter    := 'idCliente = ' + IntToStr(ACodCliente);
      FrmWhatsApp.cdsAux.Filtered  := True;
      if FrmWhatsApp.cdsAux.RecordCount > 0 then begin
         FrmWhatsApp.ObjWhats.CodCliente  := FrmWhatsApp.cdsAux.FieldByName('idCliente').AsInteger;
         FrmWhatsApp.ObjWhats.Cliente     := FrmWhatsApp.cdsAux.FieldByName('Cliente').AsString;
         FrmWhatsApp.ObjWhats.pais        := FrmWhatsApp.cdsAux.FieldByName('pais').AsString;
         FrmWhatsApp.ObjWhats.ddd         := FrmWhatsApp.cdsAux.FieldByName('ddd').AsString;
         FrmWhatsApp.ObjWhats.telefone    := FrmWhatsApp.cdsAux.FieldByName('telefone').AsString;

         FrmWhatsApp.edtPais  .Text := FrmWhatsApp.ObjWhats.pais;
         FrmWhatsApp.edtDDD   .Text := FrmWhatsApp.ObjWhats.ddd;
         FrmWhatsApp.edtTel   .Text := FrmWhatsApp.ObjWhats.telefone;
      end
      else begin
         FrmWhatsApp.ObjWhats.CodCliente  := ACodCliente;
         FrmWhatsApp.ObjWhats.Cliente     := ACliente;
         FrmWhatsApp.edtPais.Text         := '55';
         FrmWhatsApp.edtDDD .Text         := '31';
      end;

      FrmWhatsApp.ObjWhats.Obs        := AObs;
      FrmWhatsApp.mmoMsn.Lines.Add(Format(_msg00020, [FrmWhatsApp.ObjWhats.Cliente, FrmWhatsApp.ObjWhats.Obs]));

      if FrmWhatsApp.ShowModal = mrOk then
         FrmWhatsApp.close;

   finally
      FreeAndNil(FrmWhatsApp);
   end;

end;

end.
