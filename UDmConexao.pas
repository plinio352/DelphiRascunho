unit UDmConexao;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXDataSnap, IndyPeerImpl,
  Data.DBXCommon, UUtil, Vcl.Dialogs, UFactory, Datasnap.DBClient, UConfiguracao, Datasnap.Provider;

type
  TDmConexao = class(TDataModule)
    conDS: TSQLConnection;
    cdsUsuario: TClientDataSet;
    ClientDataSet1: TClientDataSet;
    cdsPermissao: TClientDataSet;
    cdsConfImg: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FFactory: IFactory;
    FObjConf: TConfiguracao;

  public
    { Public declarations }
    property Factory: IFactory read FFactory write FFactory;
    property ObjConf: TConfiguracao read FObjConf write FObjConf;

  end;

var
  DmConexao: TDmConexao;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{
   DmConexao.cdsDetalhe.Close;
   DmConexao.cdsDetalhe.Data            := Self.FVarDetalhe;
   DmConexao.cdsDetalhe.MasterSource    := DmConexao.dsLigaMaster;
   DmConexao.cdsDetalhe.MasterFields    := Self.FMasterField;
   DmConexao.cdsDetalhe.IndexFieldNames := Self.FDetalheField;

}

{$R *.dfm}

procedure TDmConexao.DataModuleCreate(Sender: TObject);
var
  IP_temp: string;
begin
   FFactory := TFactoryClas.New;
   FObjConf := TConfiguracao.Create;
   try
      IP_temp := GetLocalIP;
      InputQuery('Insira o IP do Servidor','IP do Servidor:', IP_temp);

      conDS.Close;
      conDS.Params.Values['HostName'] := IP_temp;
      conDS.Open;

   except
      on E: Exception do
         MessageDlg('Ocorreu um erro: '+ E.Message,mtError,[mbOK],0);
   end;

end;

procedure TDmConexao.DataModuleDestroy(Sender: TObject);
begin
   FreeAndNil(FObjConf);
end;

end.
