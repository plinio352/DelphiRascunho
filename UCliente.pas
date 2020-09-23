unit UCliente;

interface

uses
  Data.Win.ADODB, Data.DB, System.Generics.Collections, System.SysUtils, UPadrao;

type
   TCliente = class(TPadrao)
   private
      Fid: Integer;
      Fcliente: string;
      FTipoPessoa: string;
      FInscrEstadual: string;
      FCPF_CNPJ: string;
      FDtNascimento: TDateTime;
      FIdentidade: string;
      FSexo: string;
      function GetCliente: string;
      function GetId: Integer;
      procedure SetCliente(const Value: string);
      procedure SetId(const Value: Integer);
      procedure SetCPF_CNPJ(const Value: string);
      procedure SetDtNascimento(const Value: TDateTime);
      procedure SetIdentidade(const Value: string);
      procedure SetInscrEstadual(const Value: string);
      procedure SetSexo(const Value: string);
      procedure SetTipoPessoa(const Value: string);

   public
      property id: Integer read GetId write SetId;
      property cliente: string read GetCliente write SetCliente;
      property CPF_CNPJ: string read FCPF_CNPJ write SetCPF_CNPJ;
      property Identidade: string read FIdentidade write SetIdentidade;
      property Sexo: string read FSexo write SetSexo;
      property DtNascimento: TDateTime read FDtNascimento write SetDtNascimento;
      property TipoPessoa: string read FTipoPessoa write SetTipoPessoa;
      property InscrEstadual: string read FInscrEstadual write SetInscrEstadual;

   end;

   TEndereco = class(TPadrao)
   private
      FBairro: string;
      FIdEndereco: Integer;
      FCep: string;
      FLocalidade: string;
      FComplemento: string;
      FTipoEndereco: string;
      FIdCliente: Integer;
      FCidade: string;
      FEstado: string;
      procedure SetBairro(const Value: string);
      procedure SetCep(const Value: string);
      procedure SetCidade(const Value: string);
      procedure SetComplemento(const Value: string);
      procedure SetEstado(const Value: string);
      procedure SetIdCliente(const Value: Integer);
      procedure SetIdEndereco(const Value: Integer);
      procedure SetLocalidade(const Value: string);
      procedure SetTipoEndereco(const Value: string);
   public
      property IdEndereco: Integer read FIdEndereco write SetIdEndereco;
      property IdCliente: Integer read FIdCliente write SetIdCliente;
      property TipoEndereco: string read FTipoEndereco write SetTipoEndereco;
      property Localidade: string read FLocalidade write SetLocalidade;
      property Bairro: string read FBairro write SetBairro;
      property Cidade: string read FCidade write SetCidade;
      property Estado: string read FEstado write SetEstado;
      property Cep: string read FCep write SetCep;
      property Complemento: string read FComplemento write SetComplemento;

   end;
   TTelefone = class(TPadrao)
   private
      FID: Integer;
      FTipoTelefone: string;
      FIdCliente: Integer;
      FTelefone: string;
      Fddd: string;
      Fwhatsapp: string;
      Fpais: string;
      procedure SetID(const Value: Integer);
      procedure SetIdCliente(const Value: Integer);
      procedure SetTelefone(const Value: string);
      procedure SetTipoTelefone(const Value: string);
      procedure Setddd(const Value: string);
      procedure Setpais(const Value: string);
      procedure Setwhatsapp(const Value: string);
   public
      procedure SetObjeto(const AValue: TFields);

      property ID: Integer read FID write SetID;
      property IdCliente: Integer read FIdCliente write SetIdCliente;
      property TipoTelefone: string read FTipoTelefone write SetTipoTelefone;
      property Telefone: string read FTelefone write SetTelefone;
      property pais: string read Fpais write Setpais;
      property ddd: string read Fddd write Setddd;
      property whatsapp: string read Fwhatsapp write Setwhatsapp;


   end;

   TEmail = class(TPadrao)
  private
    FEmail: string;
    FID: Integer;
    FIdCliente: Integer;
    procedure SetEmail(const Value: string);
    procedure SetID(const Value: Integer);
    procedure SetIdCliente(const Value: Integer);
   public
      property ID: Integer read FID write SetID;
      property IdCliente: Integer read FIdCliente write SetIdCliente;
      property Email: string read FEmail write SetEmail;

   end;

   TImgCli = class(TPadrao)
   private
      FidImagem: Integer;
      FID: Integer;
      FidCliente: Integer;
      procedure SetID(const Value: Integer);
      procedure SetidCliente(const Value: Integer);
      procedure SetidImagem(const Value: Integer);
   public
      property ID: Integer read FID write SetID;
      property idCliente: Integer read FidCliente write SetidCliente;
      property idImagem: Integer read FidImagem write SetidImagem;
   end;

   TGeralCli = class(TPadrao)
   private
      FCliente: TCliente;
      FEndereco: TEndereco;
      FTelefone: TTelefone;
    FEmail: TEmail;
      procedure SetCliente(const Value: TCliente);
      procedure SetEndereco(const Value: TEndereco);
      procedure SetTelefone(const Value: TTelefone);
      procedure SetEmail(const Value: TEmail);
   public
      constructor Create;
      destructor Destroy;override;

      property Cliente: TCliente read FCliente write SetCliente;
      property Endereco: TEndereco read FEndereco write SetEndereco;
      property Telefone: TTelefone read FTelefone write SetTelefone;
      property Email: TEmail read FEmail write SetEmail;
   end;

implementation

uses System.Variants, Vcl.Dialogs;

{$REGION 'TCliente'}
function TCliente.GetCliente: string;
begin
  Result := Self.Fcliente;
end;

function TCliente.GetId: Integer;
begin
  Result := Self.Fid;
end;

procedure TCliente.SetCliente(const Value: string);
begin
  Self.Fcliente := Value;
end;

procedure TCliente.SetCPF_CNPJ(const Value: string);
begin
  FCPF_CNPJ := Value;
end;

procedure TCliente.SetDtNascimento(const Value: TDateTime);
begin
  FDtNascimento := Value;
end;

procedure TCliente.SetId(const Value: Integer);
begin
  Self.Fid := Value;
end;

procedure TCliente.SetIdentidade(const Value: string);
begin
  FIdentidade := Value;
end;

procedure TCliente.SetInscrEstadual(const Value: string);
begin
  FInscrEstadual := Value;
end;

procedure TCliente.SetSexo(const Value: string);
begin
  FSexo := Value;
end;

procedure TCliente.SetTipoPessoa(const Value: string);
begin
  FTipoPessoa := Value;
end;
{$ENDREGION}

{$REGION 'TEndereco' }

procedure TEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCep(const Value: string);
begin
  FCep := Value;
end;

procedure TEndereco.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TEndereco.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetEstado(const Value: string);
begin
  FEstado := Value;
end;

procedure TEndereco.SetIdCliente(const Value: Integer);
begin
  FIdCliente := Value;
end;

procedure TEndereco.SetIdEndereco(const Value: Integer);
begin
  FIdEndereco := Value;
end;

procedure TEndereco.SetLocalidade(const Value: string);
begin
  FLocalidade := Value;
end;

procedure TEndereco.SetTipoEndereco(const Value: string);
begin
  FTipoEndereco := Value;
end;
{$ENDREGION}

{$REGION 'TTelefone' }
procedure TTelefone.Setddd(const Value: string);
begin
  Fddd := Value;
end;

procedure TTelefone.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TTelefone.SetIdCliente(const Value: Integer);
begin
  FIdCliente := Value;
end;

procedure TTelefone.SetObjeto(const AValue: TFields);
begin
   Self.FID             := AValue.FieldByName('ID').Value;
   Self.FIdCliente      := AValue.FieldByName('IdCliente').Value;
   Self.FTipoTelefone   := AValue.FieldByName('TipoTelefone').Value;
   Self.FTelefone       := AValue.FieldByName('Telefone').Value;
   Self.Fpais           := AValue.FieldByName('pais').Value;
   Self.Fddd            := AValue.FieldByName('ddd').Value;
   Self.Fwhatsapp       := AValue.FieldByName('whatsapp').Value;

end;

procedure TTelefone.Setpais(const Value: string);
begin
  Fpais := Value;
end;

procedure TTelefone.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

procedure TTelefone.SetTipoTelefone(const Value: string);
begin
  FTipoTelefone := Value;
end;
procedure TTelefone.Setwhatsapp(const Value: string);
begin
  Fwhatsapp := Value;
end;

{$ENDREGION}

{$REGION 'TEmail' }

procedure TEmail.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TEmail.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TEmail.SetIdCliente(const Value: Integer);
begin
  FIdCliente := Value;
end;
{$ENDREGION}

{$REGION 'TImgCli' }

procedure TImgCli.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TImgCli.SetidCliente(const Value: Integer);
begin
  FidCliente := Value;
end;

procedure TImgCli.SetidImagem(const Value: Integer);
begin
  FidImagem := Value;
end;
{$ENDREGION}

{$REGION 'TGeralCli' }

constructor TGeralCli.Create;
begin
   inherited;

   FCliente  := TCliente.Create;
   FEndereco := TEndereco.Create;
   FTelefone := TTelefone.Create;
   FEmail    := TEmail.Create;
end;

destructor TGeralCli.Destroy;
begin
   FreeAndNil(FCliente);
   FreeAndNil(FEndereco);
   FreeAndNil(FTelefone);
   FreeAndNil(FEmail);

   inherited;
end;

procedure TGeralCli.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TGeralCli.SetEmail(const Value: TEmail);
begin
  FEmail := Value;
end;

procedure TGeralCli.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TGeralCli.SetTelefone(const Value: TTelefone);
begin
  FTelefone := Value;
end;
{$ENDREGION}

end.
