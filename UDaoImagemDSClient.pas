unit UDaoImagemDSClient;

interface

uses
   Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy,
   System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXJSONReflect,
   UConstante;

type
  TdaoImagemDSClient = class(TDSAdminClient)
  private
    FImagemCommand: TDBXCommand;
    FAlteraImagemCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function Imagem: OleVariant;
    function AlteraImagem(O: TJSONValue): Boolean;
  end;


implementation

{ TdaoImagemClient }

function TdaoImagemDSClient.AlteraImagem(O: TJSONValue): Boolean;
begin
  if FAlteraImagemCommand = nil then
  begin
    FAlteraImagemCommand := FDBXConnection.CreateCommand;
    FAlteraImagemCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAlteraImagemCommand.Text := _srv00021;
    FAlteraImagemCommand.Prepare;
  end;
  FAlteraImagemCommand.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
  FAlteraImagemCommand.ExecuteUpdate;
  Result := FAlteraImagemCommand.Parameters[1].Value.GetBoolean;
end;

constructor TdaoImagemDSClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

constructor TdaoImagemDSClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

destructor TdaoImagemDSClient.Destroy;
begin
  FreeAndNil(FImagemCommand);
  FreeAndNil(FAlteraImagemCommand);
  inherited;
end;

function TdaoImagemDSClient.Imagem: OleVariant;
begin
  if FImagemCommand = nil then
  begin
    FImagemCommand := FDBXConnection.CreateCommand;
    FImagemCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FImagemCommand.Text := _srv00022;
    FImagemCommand.Prepare;
  end;
  FImagemCommand.ExecuteUpdate;
  Result := FImagemCommand.Parameters[0].Value.AsVariant;
end;

end.
