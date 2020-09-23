unit UFrmPadraoCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ImgList, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnList, Vcl.ActnMan,
  Vcl.Buttons, Vcl.ToolWin, System.Win.ComObj, UDaoPermissaoTelaClient, UPermissaoTela,
  Datasnap.DBClient, UDaoPadrao, UUtil, UConstante;

type
  TControleBotoes = (cbNovo, cbAltera, cbExcluir, cbCancelar, cbSavar, cbNavegar);
  TOperacao = (opIncluir, opEditar, opNavegar);

  TFrmPadraoCadastro = class(TForm)
    sbPadrao: TStatusBar;
    pnl1: TPanel;
    pgcPadrao: TPageControl;
    tsPesquisa: TTabSheet;
    tsFormulario: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    dgPadrao: TDBGrid;
    lbl1: TLabel;
    edtLocalizar: TEdit;
    ilPadrao: TImageList;
    dsPesq: TDataSource;
    alPadrao: TActionList;
    actNovo: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    actCancelar: TAction;
    actSalvar: TAction;
    actNavegar: TAction;
    actLocaliza: TAction;
    tlbPadrao: TToolBar;
    btnNovo: TToolButton;
    btnAlterar: TToolButton;
    btnExcluir: TToolButton;
    btnCancelar: TToolButton;
    btnSalvar: TToolButton;
    btn1: TToolButton;
    btnNavegar: TToolButton;
    ToolButton1: TToolButton;
    btnExcel: TToolButton;
    actExcel: TAction;
    actAtualiza: TAction;
    btnAtualiza: TToolButton;
    ilPadrao16: TImageList;
    cdsMaster: TClientDataSet;
    dsLigaMaster: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actNavegarExecute(Sender: TObject);
    procedure actLocalizaExecute(Sender: TObject);
    procedure actExcelExecute(Sender: TObject);
    procedure actAtualizaExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dgPadraoTitleClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FCampoPesq: string;
    FOperacao: TOperacao;
    FVarMaster: OleVariant;
    FDataSetLista: OleVariant;
    FPost: string;
    FPut: string;
    FGet: string;
    FDelete: string;
    FPadrao: TDaoPadrao;

    procedure Movimentacao(ABotao: TControleBotoes);
    procedure SetCampoPesq(const Value: string);
    procedure SetOperacao(const Value: TOperacao);
    procedure SetDataSetLista(const Value: OleVariant);
    procedure SetDelete(const Value: string);
    procedure SetGet(const Value: string);
    procedure SetPost(const Value: string);
    procedure SetPut(const Value: string);
    procedure SetPadrao(const Value: TDaoPadrao);

  public
    { Public declarations }

    procedure AtualizaDataSet; virtual;
    procedure OpenDataSet; virtual;
    procedure ConfiguraGrid; virtual;
    procedure Novo; virtual;
    procedure Alterar; virtual;
    procedure Excluir; virtual;
    procedure Cancelar; virtual;
    procedure Salvar; virtual;
    procedure SetObjeto; virtual; abstract;
    procedure Permissao;
    procedure Limpar;

    property CampoPesq: string read FCampoPesq write SetCampoPesq;
    property Operacao: TOperacao read FOperacao write SetOperacao;
    property VarMaster: OleVariant read FVarMaster write FVarMaster;
    property DataSetLista: OleVariant read FDataSetLista write SetDataSetLista;
    property Get: string read FGet write SetGet;
    property Put: string read FPut write SetPut;
    property Post: string read FPost write SetPost;
    property Delete: string read FDelete write SetDelete;
    property Padrao: TDaoPadrao read FPadrao write SetPadrao;
    property SetMovimentacao: TControleBotoes  write Movimentacao;

  end;

var
  FrmPadraoCadastro: TFrmPadraoCadastro;

implementation

{$R *.dfm}

uses
   UDmConexao;

procedure TFrmPadraoCadastro.actAlterarExecute(Sender: TObject);
begin
   if actAlterar.Enabled then
   begin
      Self.Alterar;
   end;
end;

procedure TFrmPadraoCadastro.actAtualizaExecute(Sender: TObject);
begin
   Self.FormShow(Self);
end;

procedure TFrmPadraoCadastro.actCancelarExecute(Sender: TObject);
begin
   Self.Movimentacao(cbCancelar);
   Self.FOperacao := opNavegar;
   Self.Cancelar;
end;

procedure TFrmPadraoCadastro.actExcelExecute(Sender: TObject);
begin
   Excel(dsPesq);
end;

procedure TFrmPadraoCadastro.actExcluirExecute(Sender: TObject);
begin
   Self.FOperacao := opNavegar;
   Self.Excluir;
   Self.OpenDataSet;
   Self.ConfiguraGrid;
   Self.Movimentacao(cbExcluir);
   Self.Permissao;

end;

procedure TFrmPadraoCadastro.actLocalizaExecute(Sender: TObject);
begin
   try
      if Length(Trim(TEdit(Sender).Text)) >= 2 then
         dsPesq.DataSet.Locate(Self.FCampoPesq, TEdit(Sender).Text, [loPartialKey, loCaseInsensitive]);

   except
      ShowMessage(Format(_msg00002, [TEdit(Sender).Text, Self.FCampoPesq]));
   end;
end;

procedure TFrmPadraoCadastro.actNavegarExecute(Sender: TObject);
begin
   Self.Movimentacao(cbNavegar);
end;

procedure TFrmPadraoCadastro.actNovoExecute(Sender: TObject);
begin
   Self.Novo;
end;

procedure TFrmPadraoCadastro.actSalvarExecute(Sender: TObject);
begin
   Self.Salvar;
   Self.OpenDataSet;
   Self.ConfiguraGrid;
   Self.Movimentacao(cbSavar);
   Self.Permissao;
   Self.FOperacao := opNavegar;
   Self.edtLocalizar.SetFocus;

end;

procedure TFrmPadraoCadastro.Alterar;
begin
   Self.Movimentacao(cbAltera);
   Self.FOperacao := opEditar;
   dsPesq.DataSet.Edit;
end;

procedure TFrmPadraoCadastro.AtualizaDataSet;
begin
   if Length(Trim(Self.FGet)) > 0 then begin
      Self.FDataSetLista := Self.FPadrao.Consultar(Self.FGet);
   end;

   Self.VarMaster    := Self.FDataSetLista[0];

   try
      cdsMaster.Close;
      cdsMaster.Data := Self.FVarMaster;

   except
      cdsMaster.IndexName := _msg00022;
      cdsMaster.Open;

   end;

end;

procedure TFrmPadraoCadastro.Cancelar;
begin
   dsPesq.DataSet.Cancel;
   Self.Limpar;
   ShowMessage(_msg00007);
end;

procedure TFrmPadraoCadastro.ConfiguraGrid;
var
   I: Integer;
begin
   for I := 0 to dgPadrao.Columns.Count -1 do begin
      case dgPadrao.Columns[I].Field.DataType of
         ftString, ftWideString:
            dgPadrao.Columns[I].Width := 200;
         ftInteger: begin
            dgPadrao.Columns[I].Width := 50;
         end;
         ftBoolean:
            dgPadrao.Columns[I].Width := 30;
         ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime, ftTimeStamp:
            dgPadrao.Columns[I].Width := 110;
         ftBlob, ftMemo:
            dgPadrao.Columns[I].Width := 400;
      end;
   end;

   for I := 0 to dsPesq.DataSet.FieldCount -1 do begin
      case dsPesq.DataSet.Fields[I].DataType of
         ftInteger:
            TIntegerField(dsPesq.DataSet.Fields[I]).DisplayFormat := _msg00010;
         ftFloat, ftCurrency, ftBCD, ftFMTBcd:
            TIntegerField(dsPesq.DataSet.Fields[I]).DisplayFormat := _msg00011;
      end;
   end;

end;

procedure TFrmPadraoCadastro.dgPadraoTitleClick(Column: TColumn);
begin
   Self.FCampoPesq   := Column.FieldName;
   lbl1.Caption      := Format(_msg00003, [Self.FCampoPesq]);
   OrdenaGrid(cdsMaster, dgPadrao, Column);
end;

procedure TFrmPadraoCadastro.Excluir;
begin
   Self.SetObjeto;
end;

procedure TFrmPadraoCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if Assigned(cdsMaster) then begin
      FreeAndNil(cdsMaster);
   end;

end;

procedure TFrmPadraoCadastro.FormCreate(Sender: TObject);
begin
   Self.FPadrao := DmConexao.Factory.ClassDaoPadrao;

end;

procedure TFrmPadraoCadastro.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//   KeyPreview := True;
   if ((Shift = [ssCtrl]) and (Key = 13)) then
      actSalvarExecute(Self);

   case key of
      VK_F2: actNovoExecute(Self);
      VK_F3: actAlterarExecute(Self);
      VK_F4: actExcluirExecute(Self);
      VK_F5: actSalvarExecute(Self);
      VK_F6: actCancelarExecute(Self);
      VK_F7: actNavegarExecute(Self);
      VK_F8: actExcelExecute(Self);
      VK_F9: actAtualizaExecute(Self);
   end;

end;

procedure TFrmPadraoCadastro.FormKeyPress(Sender: TObject; var Key: Char);
begin
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;

end;

procedure TFrmPadraoCadastro.FormShow(Sender: TObject);
begin
   Self.OpenDataSet;
   Self.ConfiguraGrid;
   Self.Width := TamanhoGrid(dgPadrao);
   Self.Height:= 550;
   Self.Movimentacao(cbSavar);
   Self.Permissao;

   Self.FCampoPesq := dgPadrao.SelectedField.FieldName;
   lbl1.Caption    := Format(_msg00003, [Self.FCampoPesq]);
   Self.edtLocalizar.SetFocus;

end;

procedure TFrmPadraoCadastro.Limpar;
var
   I: Word;
begin
   for I := 0 to ComponentCount -1 do begin
      if Components[I] is TEdit then
         (Components[I] as TEdit).Clear;
      if Components[I] is TButtonedEdit then
         (Components[I] as TButtonedEdit).Clear;
      if Components[I] is TImage then
         (Components[I] as TImage).Picture.Graphic := nil;
   end;

end;

procedure TFrmPadraoCadastro.Movimentacao(ABotao: TControleBotoes);
begin
   case ABotao of
      cbNovo, cbAltera:begin
         actNovo.Enabled      := False;
         actAlterar.Enabled   := False;
         actExcluir.Enabled   := False;
         actCancelar.Enabled  := True;
         actSalvar.Enabled    := True;
         actNavegar.Enabled   := False;
         actExcel.Enabled     := False;
         actAtualiza.Enabled  := False;
         pgcPadrao.ActivePage := tsFormulario;
      end;

      cbExcluir, cbCancelar, cbSavar:begin
         actNovo.Enabled      := True;
         actAlterar.Enabled   := True;
         actExcluir.Enabled   := True;
         actCancelar.Enabled  := False;
         actSalvar.Enabled    := False;
         actNavegar.Enabled   := True;
         actExcel.Enabled     := True;
         actAtualiza.Enabled  := True;
         pgcPadrao.ActivePage := tsPesquisa;
      end;

      cbNavegar: begin
         if pgcPadrao.ActivePage = tsPesquisa then
            pgcPadrao.ActivePage := tsFormulario
         else
            pgcPadrao.ActivePage := tsPesquisa;
      end;
   end;
end;

procedure TFrmPadraoCadastro.Novo;
begin
   Self.Movimentacao(cbNovo);
   Self.FOperacao := opIncluir;
   dsPesq.DataSet.Append;
end;

procedure TFrmPadraoCadastro.OpenDataSet;
begin
   try
      Self.AtualizaDataSet;
      sbPadrao.Repaint;
      sbPadrao.Panels[0].Text := _msg00013+ IntToStr(dsPesq.DataSet.RecordCount);
   except
      on E: Exception do begin
         raise Exception.Create(_msg00012 + E.Message);
      end;
   end;
end;

procedure TFrmPadraoCadastro.Permissao;
var
   ObjPTela: TtbPermissaoTela;
begin
   try
      ObjPTela           := TtbPermissaoTela.JSONToObjecto<TtbPermissaoTela>(
         DmConexao.Factory.PermissaoTela.GetPermissaoTela(Self.Name, 1));
      actNovo.Enabled    := (ObjPTela.Incluir = 'S');
      actAlterar.Enabled := (ObjPTela.Alterar = 'S');
      actExcluir.Enabled := (ObjPTela.Excluir = 'S');

   finally
      FreeAndNil(ObjPTela);
   end;

end;

procedure TFrmPadraoCadastro.Salvar;
begin
   if dsPesq.DataSet.RecordCount > 0 then
      Self.SetObjeto;
end;

procedure TFrmPadraoCadastro.SetCampoPesq(const Value: string);
begin
  FCampoPesq := Value;
end;

procedure TFrmPadraoCadastro.SetDataSetLista(const Value: OleVariant);
begin
  FDataSetLista := Value;
end;

procedure TFrmPadraoCadastro.SetDelete(const Value: string);
begin
  FDelete := Value;
end;

procedure TFrmPadraoCadastro.SetGet(const Value: string);
begin
  FGet := Value;
end;

procedure TFrmPadraoCadastro.SetOperacao(const Value: TOperacao);
begin
  FOperacao := Value;
end;

procedure TFrmPadraoCadastro.SetPadrao(const Value: TDaoPadrao);
begin
  FPadrao := Value;
end;

procedure TFrmPadraoCadastro.SetPost(const Value: string);
begin
  FPost := Value;
end;

procedure TFrmPadraoCadastro.SetPut(const Value: string);
begin
  FPut := Value;
end;

end.
