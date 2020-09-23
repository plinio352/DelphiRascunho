unit UFrmOrdemServicoItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPadraoCadastro, Data.DB,
  Datasnap.DBClient, Vcl.ActnList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls,
  UUtil, UFrmPesquisa, UConstante, UOrdemServicoItem, UFrmRelatorioRave, UFrmWhatsApp;

type
  TFrmOrdemServicoItem = class(TFrmPadraoCadastro)
    dgDetail: TDBGrid;
    GroupBox7: TGroupBox;
    Splitter1: TSplitter;
    edtNomeServico: TEdit;
    edtIdServico: TButtonedEdit;
    GroupBox1: TGroupBox;
    edtVrUnitario: TEdit;
    GroupBox2: TGroupBox;
    edtDescUnitario: TEdit;
    GroupBox3: TGroupBox;
    edtTotalGeral: TEdit;
    GroupBox4: TGroupBox;
    edtQtdItens: TEdit;
    cdsDetail: TClientDataSet;
    cdsAux: TClientDataSet;
    btnImprime: TToolButton;
    btnWhatsApp: TToolButton;
    procedure edtIdServicoExit(Sender: TObject);
    procedure edtIdServicoRightButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cdsDetailAfterScroll(DataSet: TDataSet);
    procedure cdsDetailBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnImprimeClick(Sender: TObject);
    procedure btnWhatsAppClick(Sender: TObject);
  private
    { Private declarations }
    ObjOrdemServicoItem: TOrdemServicoItem;

    procedure PesqServico(T: TObject);
    function TotalGeral: string;
    function QtdItens: string;

  public
    { Public declarations }
    procedure Novo; override;
    procedure Alterar; override;
    procedure Excluir; override;
    procedure Cancelar; override;
    procedure Salvar; override;
    procedure ConfiguraGrid; override;
    procedure SetObjeto; override;
    procedure AtualizaDataSet; override;
  end;

var
  FrmOrdemServicoItem: TFrmOrdemServicoItem;

implementation

{$R *.dfm}

procedure TFrmOrdemServicoItem.Alterar;
begin
   if dsPesq.DataSet.FieldByName('idStatus').AsInteger in [1,3,4] then begin
      ShowMessage(Format(_msg00001, ['ANDAMENTO']));
      Exit;
   end;

   if dsLigaMaster.DataSet.RecordCount = 0 then
      ShowMessage(_msg00009)
   else begin
      Self.SetMovimentacao := cbAltera;
      Self.Operacao        := opEditar;
      dsLigaMaster.DataSet.Edit;
   end;

end;

procedure TFrmOrdemServicoItem.AtualizaDataSet;
begin
   inherited;
   cdsDetail.Close;
   cdsDetail.Data            := Self.DataSetLista[1];
   cdsDetail.IndexFieldNames := 'idOrdemServico;id';
   cdsDetail.MasterSource    := dsPesq;
   cdsDetail.MasterFields    := 'id';

   ConfUtlGrid(dgDetail);

end;

procedure TFrmOrdemServicoItem.btnImprimeClick(Sender: TObject);
begin
  inherited;
  TFrmRelatorioRave.Rel001(Self.DataSetLista, dsPesq.DataSet.FieldByName('id').AsString);
end;

procedure TFrmOrdemServicoItem.btnWhatsAppClick(Sender: TObject);
begin
  inherited;
   TfrmWhatsApp.WhatsApp(dsPesq.DataSet.FieldByName('idCliente').AsInteger,
                         dsPesq.DataSet.FieldByName('Cliente').AsString, EmptyStr);
end;

procedure TFrmOrdemServicoItem.Cancelar;
begin
   dsLigaMaster.DataSet.Cancel;
   ShowMessage(_msg00007);
end;

procedure TFrmOrdemServicoItem.cdsDetailAfterScroll(DataSet: TDataSet);
begin
   inherited;
   if (DataSet.State in[dsBrowse]) then begin
      edtIdServico   .Text := DataSet.FieldByName('idServico').AsString;
      edtNomeServico .Text := DataSet.FieldByName('servico').AsString;
      edtVrUnitario  .Text := FormatFloat('#,##0.00', DataSet.FieldByName('valor').AsFloat);
      edtDescUnitario.Text := FormatFloat('#,##0.00', DataSet.FieldByName('desconto').AsFloat);

      edtTotalGeral  .Text := TotalGeral;
      edtQtdItens    .Text := QtdItens;

   end;

end;

procedure TFrmOrdemServicoItem.cdsDetailBeforePost(DataSet: TDataSet);
begin
   inherited;
   DataSet.FieldByName('idOrdemServico').Value := dsPesq.DataSet.FieldByName('id').Value;
   DataSet.FieldByName('idServico'     ).Value := StrToInt(edtIdServico.Text);
   DataSet.FieldByName('valor'         ).Value := StrToFloatDef(edtVrUnitario.Text, 0);
   DataSet.FieldByName('desconto'      ).Value := StrToFloatDef(edtDescUnitario.Text, 0);

   DataSet.FieldByName('servico'       ).AsString := EmptyStr;

end;

procedure TFrmOrdemServicoItem.ConfiguraGrid;
var I: Integer;
begin
   inherited;
   for I := 0 to dsLigaMaster.DataSet.FieldCount -1 do begin
      case dsLigaMaster.DataSet.Fields[I].DataType of
         ftInteger:
            TIntegerField(dsLigaMaster.DataSet.Fields[I]).DisplayFormat := _msg00010;
         ftFloat, ftCurrency, ftBCD, ftFMTBcd:
            TIntegerField(dsLigaMaster.DataSet.Fields[I]).DisplayFormat := _msg00011;
      end;
   end;
end;

procedure TFrmOrdemServicoItem.edtIdServicoExit(Sender: TObject);
begin
   inherited;
   if edtIdServico.Text <> EmptyStr then begin
      cdsAux.Close;
      cdsAux.Data := Self.DataSetLista[2];
      cdsAux.FieldByName('idGrupoServico').Visible := False;
      cdsAux.FieldByName('GrupoServico'  ).Visible := False;
      if cdsAux.Locate('ID', edtIdServico.Text, [loCaseInsensitive]) then begin
         edtIdServico  .Text := cdsAux.Fields[0].AsString;
         edtNomeServico.Text := cdsAux.Fields[1].AsString;
         edtVrUnitario .Text := FormatFloat(_msg00011, cdsAux.Fields[2].AsFloat);
      end
      else begin
         ShowMessage(_msg00004);
         Self.Limpar;
      end;
   end;

end;

procedure TFrmOrdemServicoItem.edtIdServicoRightButtonClick(Sender: TObject);
begin
   inherited;
   Pesquisa(Self.DataSetLista[2], PesqServico);

end;

procedure TFrmOrdemServicoItem.Excluir;
begin
   if dsPesq.DataSet.FieldByName('idStatus').AsInteger in [1,3,4] then begin
      ShowMessage(Format(_msg00001, ['ANDAMENTO']));
      Exit;
   end;

   inherited;

   If MessageDlg(_msg00005, mtConfirmation, mbOkCancel, 0) = ID_OK then begin
      try
         ExceptDataSnep(Self.Padrao.Moviventacao(ObjOrdemServicoItem.ObjectToJSON<TOrdemServicoItem>(ObjOrdemServicoItem), Self.Delete));
      except
         on E: Exception do begin
            raise Exception.Create(_msg00006+E.Message);
         end;
      end;
   end;

end;

procedure TFrmOrdemServicoItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   ObjOrdemServicoItem.Free;
   Action := caFree;
   FrmOrdemServicoItem := nil;

end;

procedure TFrmOrdemServicoItem.FormCreate(Sender: TObject);
begin
   inherited;
   Self.Get       := _srv00054;
   Self.Put       := _srv00055;
   Self.Post      := _srv00056;
   Self.Delete    := _srv00057;

   ObjOrdemServicoItem := TOrdemServicoItem.Create;

end;

procedure TFrmOrdemServicoItem.FormShow(Sender: TObject);
begin
   inherited;
   Self.Limpar;
end;

procedure TFrmOrdemServicoItem.Novo;
begin
   if dsPesq.DataSet.FieldByName('idStatus').AsInteger in [3,4] then begin
      ShowMessage(Format(_msg00001, ['ABERTO/ANDAMENTO']));
      Exit;
   end;

   Self.SetMovimentacao := cbNovo;
   Self.Operacao        := opIncluir;
   dsLigaMaster.DataSet.Append;
   dsLigaMaster.DataSet.FieldByName('ID').Value := -1;
   Self.Limpar;

end;

procedure TFrmOrdemServicoItem.PesqServico(T: TObject);
begin
   edtIdServico   .Text   := TFrmPesquisa(T).cdsPesq.Fields[0].AsString;
   edtNomeServico .Text   := TFrmPesquisa(T).cdsPesq.Fields[1].AsString;
   edtVrUnitario  .Text   := FormatFloat('#,##0.00', TFrmPesquisa(T).cdsPesq.Fields[2].AsFloat);

end;

procedure TFrmOrdemServicoItem.Salvar;
begin
   dsLigaMaster.DataSet.Post;
   inherited;
   try
      case Self.Operacao of
         opIncluir: begin
            ExceptDataSnep(Self.Padrao.Moviventacao(ObjOrdemServicoItem.ObjectToJSON<TOrdemServicoItem>(ObjOrdemServicoItem), Self.Put));
         end;
         opEditar: begin
            ExceptDataSnep(Self.Padrao.Moviventacao(ObjOrdemServicoItem.ObjectToJSON<TOrdemServicoItem>(ObjOrdemServicoItem), Self.Post));
         end;
         opNavegar: begin
            Self.Cancelar;
         end;
      end;

   except
      on E: Exception do begin
         raise Exception.Create(_msg00006+E.Message);
      end;
   end;

end;

procedure TFrmOrdemServicoItem.SetObjeto;
begin
  inherited;
  ObjOrdemServicoItem.SetObjeto(dsLigaMaster.DataSet.Fields);

end;

function TFrmOrdemServicoItem.QtdItens: string;
begin
   Result := FormatFloat('#000', dsPesq.DataSet.FieldByName('qtdItem').Value);
end;

function TFrmOrdemServicoItem.TotalGeral: string;
begin
   Result := FormatFloat('#,##0.00', dsPesq.DataSet.FieldByName('vrItem').Value);
end;

end.
