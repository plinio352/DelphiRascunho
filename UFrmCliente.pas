unit UFrmCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPadraoCadastro, Data.DB, Datasnap.DBClient, Vcl.ActnList,
  Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, RxToolEdit, RxDBCtrl, UDaoCliente, UCliente, UDaoImagemClient, UConstante;

type
  TFrmCliente = class(TFrmPadraoCadastro)
    GroupBox1: TGroupBox;
    edtNome: TDBEdit;
    rgSexo: TDBRadioGroup;
    GroupBox2: TGroupBox;
    edtCpf: TDBEdit;
    GroupBox3: TGroupBox;
    edtIdentidade: TDBEdit;
    GroupBox4: TGroupBox;
    rgTipo: TDBRadioGroup;
    GroupBox5: TGroupBox;
    imgFoto: TImage;
    btnEditar: TButton;
    GroupBox6: TGroupBox;
    edtInscEstadual: TDBEdit;
    edtDtNascimento: TDBDateEdit;
    GroupBox7: TGroupBox;
    Splitter5: TSplitter;
    edtNomeArquivo: TEdit;
    edtCodigoArquivo: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure pgcPadraoChange(Sender: TObject);
    procedure dsPesqStateChange(Sender: TObject);
  private
    { Private declarations }
    FCliente: TdaoClienteClient;
    FImagemRest: TDaoImagemClient;
    ObjCliente: TCliente;
    ObjImgCli: TImgCli;
    FDadosImg: OleVariant;

    procedure Pesq(T: TObject);

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
  FrmCliente: TFrmCliente;

implementation

uses
   UDmConexao, UFrmPesqImg;

{$R *.dfm}

{ TFrmCliente }

procedure TFrmCliente.Alterar;
begin
  inherited;

end;

procedure TFrmCliente.AtualizaDataSet;
begin
   Self.DataSetLista := Self.FCliente.DsCliente;
   FDadosImg         := Self.DataSetLista[1];

   inherited;

   edtNome        .DataField := 'Cliente';
   rgSexo         .DataField := 'Sexo';
   edtCpf         .DataField := 'CPF_CNPJ';
   edtIdentidade  .DataField := 'Identidade';
   rgTipo         .DataField := 'TipoPessoa';
   edtInscEstadual.DataField := 'InscrEstadual';
   edtDtNascimento.DataField := 'DtNascimento';

end;

procedure TFrmCliente.btnEditarClick(Sender: TObject);
begin
   inherited;
   if btnEditar.Caption = 'Editar' then begin
      btnEditar.Caption := 'Salvar';
      imgFoto.Picture.Graphic :=  nil;
      PesqImg(FDadosImg, Pesq, dsPesq.DataSet.FieldByName('ID').AsString);
   end
   else begin
      btnEditar.Caption    := 'Editar';
      ObjImgCli.idCliente  := dsPesq.DataSet.FieldByName('ID').Value;
      ObjImgCli.idImagem   := StrToInt(edtCodigoArquivo.Text);

      if (dsPesq.DataSet.FieldByName('idImagem').IsNull) then begin
         Self.FCliente.IncImgCli(TImgCli.ObjectToJSON<TImgCli>(ObjImgCli));
      end
      else begin
         ObjImgCli.ID := dsPesq.DataSet.FieldByName('idCliImg').Value;
         Self.FCliente.AltImgCli(TImgCli.ObjectToJSON<TImgCli>(ObjImgCli));

      end;

      actAtualizaExecute(Self);
      dsPesq.DataSet.Locate('ID', ObjImgCli.idCliente, [loCaseInsensitive]);

   end;

end;

procedure TFrmCliente.Cancelar;
begin
  inherited;

end;

procedure TFrmCliente.ConfiguraGrid;
begin
   inherited;
   dsPesq.DataSet.FieldByName('ID').DisplayLabel := 'Codigo';

end;

procedure TFrmCliente.dsPesqStateChange(Sender: TObject);
begin
   inherited;
   edtNome        .Enabled := (TDataSource(Sender).DataSet.State in[dsInsert, dsEdit]);
   rgSexo         .Enabled := edtNome.Enabled;
   edtCpf         .Enabled := edtNome.Enabled;
   edtIdentidade  .Enabled := edtNome.Enabled;
   rgTipo         .Enabled := edtNome.Enabled;
   edtInscEstadual.Enabled := edtNome.Enabled;
   edtDtNascimento.Enabled := edtNome.Enabled;

end;

procedure TFrmCliente.Excluir;
begin
   inherited;
   If MessageDlg(_msg00005, mtConfirmation, mbOkCancel, 0) = ID_OK then begin
      Self.FCliente.DeletarCliente(ObjCliente.ObjectToJSON<TCliente>(ObjCliente));
   end;

end;

procedure TFrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   ObjCliente.Free;
   ObjImgCli.Free;
   Action := caFree;
   FrmCliente := nil;

end;

procedure TFrmCliente.FormCreate(Sender: TObject);
begin
   inherited;
   Self.FCliente  := DmConexao.Factory.Cliente;
   Self.FImagemRest := DmConexao.Factory.ImagemRest;
   Self.CampoPesq := 'ID';

   ObjCliente     := TCliente.Create;
   ObjImgCli      := TImgCli.Create;


end;

procedure TFrmCliente.Novo;
begin
   inherited;
   dsPesq.DataSet.FieldByName('ID').Value := -1;

end;

procedure TFrmCliente.Pesq(T: TObject);
begin
   edtCodigoArquivo.Text   := TFrmPesqImg(T).cdsPesq.Fields[0].AsString;
   edtNomeArquivo  .Text   := TFrmPesqImg(T).cdsPesq.Fields[1].AsString;
   ImgFoto.Stretch         := True;
   imgFoto.Picture.Graphic := TFrmPesqImg(T).ImgFoto.Picture.Graphic;

end;

procedure TFrmCliente.pgcPadraoChange(Sender: TObject);
begin
   inherited;
   if (pgcPadrao.ActivePage = tsFormulario) then begin
      if (dsPesq.DataSet.FieldByName('idImagem').IsNull) then begin
         edtCodigoArquivo.Clear;
         edtNomeArquivo.Clear;
         imgFoto.Picture.Graphic := nil;
      end
      else begin
         edtCodigoArquivo.Text   := dsPesq.DataSet.FieldByName('idImagem').AsString;
         edtNomeArquivo  .Text   := dsPesq.DataSet.FieldByName('MD5'     ).AsString;
         FImagemRest.Download(dsPesq.DataSet.FieldByName('idImagem').AsInteger, ImgFoto);
      end;
   end
   else begin
      btnEditar.Caption := 'Editar';
   end;

end;

procedure TFrmCliente.Salvar;
begin
   dsPesq.DataSet.Post;
   inherited;
   case Self.Operacao of
      opIncluir: begin
         Self.FCliente.IncluirCliente(TCliente.ObjectToJSON<TCliente>(ObjCliente));
      end;
      opEditar: begin
         Self.FCliente.AlteraCliente(TCliente.ObjectToJSON<TCliente>(ObjCliente));
      end;
      opNavegar: begin
         Self.Cancelar;
      end;
   end;

end;

procedure TFrmCliente.SetObjeto;
begin
   inherited;
   ObjCliente.id              := dsPesq.DataSet.FieldByName('ID').Value;
   ObjCliente.cliente         := dsPesq.DataSet.FieldByName('Cliente').Value;
   ObjCliente.CPF_CNPJ        := dsPesq.DataSet.FieldByName('CPF_CNPJ').Value;
   ObjCliente.Identidade      := dsPesq.DataSet.FieldByName('Identidade').Value;
   ObjCliente.Sexo            := dsPesq.DataSet.FieldByName('Sexo').Value;
   ObjCliente.DtNascimento    := dsPesq.DataSet.FieldByName('DtNascimento').Value;
   ObjCliente.TipoPessoa      := dsPesq.DataSet.FieldByName('TipoPessoa').Value;
   ObjCliente.InscrEstadual   := dsPesq.DataSet.FieldByName('InscrEstadual').Value;

end;

end.
