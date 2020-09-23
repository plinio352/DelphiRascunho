unit UFactory;

interface

uses
   System.SysUtils, Data.DBXJSON,
   UDaoConfiguracaoClient, UDaoPermissaoTelaClient, UDaoImagemClient,
   UDaoFormularioClient, UDaoUsuario, UDaoGrupoPessoa, UDaoImagemDSClient,
   UDaoImgCli, UDaoCliente, UDaoPadrao;

type
   IFactory = interface
   ['{584046D2-0333-40A1-9318-237B20BF5D03}']
      function Config: TDaoConfiguracaoClient;
      function PermissaoTela: TDaoPermissaoTelaClient;
      function ImagemRest: TDaoImagemClient;
      function Formulario: TDaoFormularioClient;
      function Usuario: TDaoUsuarioClient;
      function GrupoPessoa: TDaoGrupoPessoaClient;
      function ImagemDS: TdaoImagemDSClient;
      function ImgCli: TdaoImgCliClient;
      function Cliente: TdaoClienteClient;
      function ClassDaoPadrao: TDaoPadrao;

   end;

   TFactoryClas = class(TInterfacedObject, IFactory)
   private
      FConfig: TDaoConfiguracaoClient;
      FPermissaoTela: TDaoPermissaoTelaClient;
      FImagemRest: TDaoImagemClient;
      FFormulario: TDaoFormularioClient;
      FUsuario: TDaoUsuarioClient;
      FGrupoPessoa: TDaoGrupoPessoaClient;
      FImagemDS: TdaoImagemDSClient;
      FImgCli: TdaoImgCliClient;
      FCliente: TdaoClienteClient;
      FClassDaoPadrao: TDaoPadrao;

   public
      class function New: IFactory;
      destructor Destroy; override;

      function Config: TDaoConfiguracaoClient;
      function PermissaoTela: TDaoPermissaoTelaClient;
      function ImagemRest: TDaoImagemClient;
      function Formulario: TDaoFormularioClient;
      function Usuario: TDaoUsuarioClient;
      function GrupoPessoa: TDaoGrupoPessoaClient;
      function ImagemDS: TdaoImagemDSClient;
      function ImgCli: TdaoImgCliClient;
      function Cliente: TdaoClienteClient;
      function ClassDaoPadrao: TDaoPadrao;
   end;

implementation

uses
   UDmConexao;

{ TFactoryClas }

function TFactoryClas.ClassDaoPadrao: TDaoPadrao;
begin
   if not Assigned(Self.FClassDaoPadrao) then
      Self.FClassDaoPadrao := TDaoPadrao.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FClassDaoPadrao;

end;

function TFactoryClas.Cliente: TdaoClienteClient;
begin
   if not Assigned(Self.FCliente) then
      Self.FCliente := TdaoClienteClient.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FCliente;

end;

function TFactoryClas.Config: TDaoConfiguracaoClient;
begin
   if not Assigned(Self.FConfig) then
      Self.FConfig := TDaoConfiguracaoClient.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FConfig;

end;

destructor TFactoryClas.Destroy;
begin
   FreeAndNil(self.FConfig);
   FreeAndNil(self.FPermissaoTela);
   FreeAndNil(self.FImagemRest);
   FreeAndNil(self.FFormulario);
   FreeAndNil(self.FUsuario);
   FreeAndNil(self.FGrupoPessoa);
   FreeAndNil(self.FImgCli);
   FreeAndNil(self.FClassDaoPadrao);
   FreeAndNil(self.FImagemDS);
   FreeAndNil(self.FCliente);
   inherited;
end;

function TFactoryClas.Formulario: TDaoFormularioClient;
begin
   if not Assigned(Self.FFormulario) then
      Self.FFormulario := TDaoFormularioClient.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FFormulario;

end;

function TFactoryClas.GrupoPessoa: TDaoGrupoPessoaClient;
begin
   if not Assigned(Self.FGrupoPessoa) then
      Self.FGrupoPessoa := TDaoGrupoPessoaClient.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FGrupoPessoa;

end;

function TFactoryClas.ImagemDS: TdaoImagemDSClient;
begin
   if not Assigned(Self.FImagemDS) then
      Self.FImagemDS := TdaoImagemDSClient.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FImagemDS;

end;

function TFactoryClas.ImagemRest: TDaoImagemClient;
begin
   if not Assigned(Self.FImagemRest) then
      Self.FImagemRest := TDaoImagemClient.Create;

   Result := Self.FImagemRest;

end;

function TFactoryClas.ImgCli: TdaoImgCliClient;
begin
   if not Assigned(Self.FImgCli) then
      Self.FImgCli := TdaoImgCliClient.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FImgCli;

end;

class function TFactoryClas.New: IFactory;
begin
   Result := Self.Create;
end;

function TFactoryClas.PermissaoTela: TDaoPermissaoTelaClient;
begin
   if not Assigned(Self.FPermissaoTela) then
      Self.FPermissaoTela := TDaoPermissaoTelaClient.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FPermissaoTela;

end;

function TFactoryClas.Usuario: TDaoUsuarioClient;
begin
   if not Assigned(Self.FUsuario) then
      Self.FUsuario := TDaoUsuarioClient.Create(DmConexao.conDS.DBXConnection);

   Result := Self.FUsuario;

end;

end.
