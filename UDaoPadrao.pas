unit UDaoPadrao;

interface

uses
   Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON,
   Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr,
   Data.DBXDBReaders, Data.DBXJSONReflect;

type
   TDaoPadrao = class(TDSAdminClient)
   private
      FCmd: TDBXCommand;


   public
      constructor Create(ADBXConnection: TDBXConnection); overload;
      constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
      destructor Destroy; override;

      function Consultar(ATxtClassMt: string): OleVariant;overload;
      function Consultar(O: TJSONValue; ATxtClassMt: string): OleVariant;overload;
      function Moviventacao(O: TJSONValue; ATxtClassMt: string): Boolean;

   end;

implementation

{ TDaoPadrao }

constructor TDaoPadrao.Create(ADBXConnection: TDBXConnection);
begin
   inherited Create(ADBXConnection);
end;

function TDaoPadrao.Consultar(ATxtClassMt: string): OleVariant;
begin
   if FCmd = nil then
      FCmd := FDBXConnection.CreateCommand;

   FCmd.CommandType  := TDBXCommandTypes.DSServerMethod;
   FCmd.Text         := ATxtClassMt; //Exemplo: 'TdaoCliente.DsCliente';
   FCmd.Prepare;
   FCmd.ExecuteUpdate;
   Result := FCmd.Parameters[0].Value.AsVariant;

end;

function TDaoPadrao.Consultar(O: TJSONValue; ATxtClassMt: string): OleVariant;
begin
   if FCmd = nil then
      FCmd := FDBXConnection.CreateCommand;

   FCmd.CommandType  := TDBXCommandTypes.DSServerMethod;
   FCmd.Text         := ATxtClassMt; //Exemplo: 'TdaoCliente.DsCliente';
   FCmd.Prepare;
   FCmd.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
   FCmd.ExecuteUpdate;
   Result := FCmd.Parameters[1].Value.AsVariant;

end;

constructor TDaoPadrao.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TDaoPadrao.Destroy;
begin
  FreeAndNil(FCmd);

  inherited;
end;

function TDaoPadrao.Moviventacao(O: TJSONValue; ATxtClassMt: string): Boolean;
begin
   if FCmd = nil then
      FCmd := FDBXConnection.CreateCommand;

   FCmd.CommandType  := TDBXCommandTypes.DSServerMethod;
   FCmd.Text         := ATxtClassMt; //Exemplo: 'TdaoCliente.DsCliente';
   FCmd.Prepare;
   FCmd.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
   FCmd.ExecuteUpdate;
   Result := FCmd.Parameters[1].Value.GetBoolean;

end;

end.
