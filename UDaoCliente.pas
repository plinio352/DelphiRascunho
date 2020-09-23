//
// Created by the DataSnap proxy generator.
// 25/11/2019 10:50:57
//

unit UDaoCliente;

interface

uses Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy,
     System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXJSONReflect,
     UConstante;

type
  TdaoClienteClient = class(TDSAdminClient)
  private
    FDsClienteCommand: TDBXCommand;
    FIncluirClienteCommand: TDBXCommand;
    FAlteraClienteCommand: TDBXCommand;
    FDeletarClienteCommand: TDBXCommand;
    FIncImgCliCommand: TDBXCommand;
    FAltImgCliCommand: TDBXCommand;
    FDelImgCliCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function DsCliente: OleVariant;
    function IncluirCliente(O: TJSONValue): Boolean;
    function AlteraCliente(O: TJSONValue): Boolean;
    function DeletarCliente(O: TJSONValue): Boolean;

    function IncImgCli(O: TJSONValue): Boolean;
    function AltImgCli(O: TJSONValue): Boolean;
    function DelImgCli(O: TJSONValue): Boolean;
end;

implementation

{ TdaoClienteClient }

function TdaoClienteClient.DsCliente: OleVariant;
begin
  if FDsClienteCommand = nil then
  begin
    FDsClienteCommand := FDBXConnection.CreateCommand;
    FDsClienteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDsClienteCommand.Text := _srv00023;
    FDsClienteCommand.Prepare;
  end;
  FDsClienteCommand.ExecuteUpdate;
  Result := FDsClienteCommand.Parameters[0].Value.AsVariant;
end;

function TdaoClienteClient.IncImgCli(O: TJSONValue): Boolean;
begin
  if FIncluirClienteCommand = nil then
  begin
    FIncluirClienteCommand := FDBXConnection.CreateCommand;
    FIncluirClienteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FIncluirClienteCommand.Text := _srv00024;
    FIncluirClienteCommand.Prepare;
  end;
  FIncluirClienteCommand.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
  FIncluirClienteCommand.ExecuteUpdate;
  Result := FIncluirClienteCommand.Parameters[1].Value.GetBoolean;
end;

function TdaoClienteClient.IncluirCliente(O: TJSONValue): Boolean;
begin
  if FIncluirClienteCommand = nil then
  begin
    FIncluirClienteCommand := FDBXConnection.CreateCommand;
    FIncluirClienteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FIncluirClienteCommand.Text := _srv00025;
    FIncluirClienteCommand.Prepare;
  end;
  FIncluirClienteCommand.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
  FIncluirClienteCommand.ExecuteUpdate;
  Result := FIncluirClienteCommand.Parameters[1].Value.GetBoolean;
end;

function TdaoClienteClient.AlteraCliente(O: TJSONValue): Boolean;
begin
  if FAlteraClienteCommand = nil then
  begin
    FAlteraClienteCommand := FDBXConnection.CreateCommand;
    FAlteraClienteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAlteraClienteCommand.Text := _srv00026;
    FAlteraClienteCommand.Prepare;
  end;
  FAlteraClienteCommand.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
  FAlteraClienteCommand.ExecuteUpdate;
  Result := FAlteraClienteCommand.Parameters[1].Value.GetBoolean;
end;

function TdaoClienteClient.DeletarCliente(O: TJSONValue): Boolean;
begin
  if FDeletarClienteCommand = nil then
  begin
    FDeletarClienteCommand := FDBXConnection.CreateCommand;
    FDeletarClienteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeletarClienteCommand.Text := _srv00027;
    FDeletarClienteCommand.Prepare;
  end;
  FDeletarClienteCommand.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
  FDeletarClienteCommand.ExecuteUpdate;
  Result := FDeletarClienteCommand.Parameters[1].Value.GetBoolean;
end;

function TdaoClienteClient.DelImgCli(O: TJSONValue): Boolean;
begin
  if FDeletarClienteCommand = nil then
  begin
    FDeletarClienteCommand := FDBXConnection.CreateCommand;
    FDeletarClienteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeletarClienteCommand.Text := _srv00028;
    FDeletarClienteCommand.Prepare;
  end;
  FDeletarClienteCommand.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
  FDeletarClienteCommand.ExecuteUpdate;
  Result := FDeletarClienteCommand.Parameters[1].Value.GetBoolean;

end;

constructor TdaoClienteClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

function TdaoClienteClient.AltImgCli(O: TJSONValue): Boolean;
begin
  if FAlteraClienteCommand = nil then
  begin
    FAlteraClienteCommand := FDBXConnection.CreateCommand;
    FAlteraClienteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAlteraClienteCommand.Text := _srv00029;
    FAlteraClienteCommand.Prepare;
  end;
  FAlteraClienteCommand.Parameters[0].Value.SetJSONValue(O, FInstanceOwner);
  FAlteraClienteCommand.ExecuteUpdate;
  Result := FAlteraClienteCommand.Parameters[1].Value.GetBoolean;

end;

constructor TdaoClienteClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TdaoClienteClient.Destroy;
begin
  FreeAndNil(FDsClienteCommand);
  FreeAndNil(FIncluirClienteCommand);
  FreeAndNil(FAlteraClienteCommand);
  FreeAndNil(FDeletarClienteCommand);

  FreeAndNil(FIncImgCliCommand);
  FreeAndNil(FAltImgCliCommand);
  FreeAndNil(FDelImgCliCommand);
  inherited;
end;

end.
