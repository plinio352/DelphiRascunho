unit UDaoClienteRest;

interface

uses
   System.Classes, Data.DBXJSON, System.SysUtils, UCliente;

type
   {$METHODINFO ON}
   TdaoClienteRest = class(TComponent)
   private
      FCli: TCliente;
   public
      function Cliente:TJSONArray;
      function AcceptCliente(O: TJSONValue): TJSONObject;
      function UpDateCliente(O: TJSONValue): TJSONObject;
      function CancelCliente(Aid: Integer): TJSONObject;
   end;
   {$METHODINFO OFF}

implementation

uses
   UDmCliente;

{ TdaoCliente }

function TdaoClienteRest.Cliente: TJSONArray;
begin
   try
      DmCliente.dtsCliente.Close;
      DmCliente.dtsCliente.Open;

      Result := TJSONArray.Create;

      while not(DmCliente.dtsCliente.Eof) do begin
         FCli                 := TCliente.Create;
         FCli.id              := DmCliente.dtsCliente.FieldByName('id'           ).AsInteger;
         FCli.cliente         := DmCliente.dtsCliente.FieldByName('Cliente'      ).AsString;
         FCli.CPF_CNPJ        := DmCliente.dtsCliente.FieldByName('CPF_CNPJ'     ).AsString;
         FCli.Identidade      := DmCliente.dtsCliente.FieldByName('Identidade'   ).AsString;
         FCli.Sexo            := DmCliente.dtsCliente.FieldByName('Sexo'         ).AsString;
         FCli.DtNascimento    := DmCliente.dtsCliente.FieldByName('DtNascimento' ).AsDateTime;
         FCli.TipoPessoa      := DmCliente.dtsCliente.FieldByName('TipoPessoa'   ).AsString;
         FCli.InscrEstadual   := DmCliente.dtsCliente.FieldByName('InscrEstadual').AsString;

         Result.AddElement(FCli.ObjectToJSON<TCliente>(FCli));
         FCli.Free;

         DmCliente.dtsCliente.Next;
      end;

   except
      Result := nil;
   end;

end;

function TdaoClienteRest.AcceptCliente(O: TJSONValue): TJSONObject;
begin
   Result := TJSONObject.Create;

   try
      FCli := TCliente.JSONToObjecto<TCliente>(O);

      DmCliente.dtsClienteInsert.ParamByName('Cliente'      ).AsString  := FCli.cliente;
      DmCliente.dtsClienteInsert.ParamByName('CPF_CNPJ'     ).AsString  := FCli.CPF_CNPJ;
      DmCliente.dtsClienteInsert.ParamByName('Identidade'   ).AsString  := FCli.Identidade;
      DmCliente.dtsClienteInsert.ParamByName('Sexo'         ).AsString  := FCli.Sexo;
      DmCliente.dtsClienteInsert.ParamByName('DtNascimento' ).AsDateTime:= FCli.DtNascimento;
      DmCliente.dtsClienteInsert.ParamByName('TipoPessoa'   ).AsString  := FCli.TipoPessoa;
      DmCliente.dtsClienteInsert.ParamByName('InscrEstadual').AsString  := FCli.InscrEstadual;
      DmCliente.dtsClienteInsert.ExecSQL();

      Result.AddPair(TJSONPair.Create('True', 'Sucesso!'));
   except
      on E: Exception do begin
         Result.AddPair(TJSONPair.Create('False', E.Message));
      end;
   end;

end;

function TdaoClienteRest.UpDateCliente(O: TJSONValue): TJSONObject;
begin
   Result := TJSONObject.Create;

   try
      FCli   := TCliente.JSONToObjecto<TCliente>(O);

      DmCliente.dtsClienteUpdate.ParamByName('id'           ).AsInteger := FCli.id;
      DmCliente.dtsClienteUpdate.ParamByName('Cliente'      ).AsString  := FCli.cliente;
      DmCliente.dtsClienteUpdate.ParamByName('CPF_CNPJ'     ).AsString  := FCli.CPF_CNPJ;
      DmCliente.dtsClienteUpdate.ParamByName('Identidade'   ).AsString  := FCli.Identidade;
      DmCliente.dtsClienteUpdate.ParamByName('Sexo'         ).AsString  := FCli.Sexo;
      DmCliente.dtsClienteUpdate.ParamByName('DtNascimento' ).AsDateTime:= FCli.DtNascimento;
      DmCliente.dtsClienteUpdate.ParamByName('TipoPessoa'   ).AsString  := FCli.TipoPessoa;
      DmCliente.dtsClienteUpdate.ParamByName('InscrEstadual').AsString  := FCli.InscrEstadual;
      DmCliente.dtsClienteUpdate.ExecSQL();

      Result.AddPair(TJSONPair.Create('True', 'Sucesso!'));
   except
      on E: Exception do begin
         Result.AddPair(TJSONPair.Create('False', E.Message));
      end;

   end;

end;

function TdaoClienteRest.CancelCliente(Aid: Integer): TJSONObject;
begin
   Result := TJSONObject.Create;

   try

      DmCliente.dtsClienteDelete.ParamByName('id').AsInteger := Aid;
      DmCliente.dtsClienteDelete.ExecSQL();

      Result.AddPair(TJSONPair.Create('True', 'Sucesso!'));
   except
      on E: Exception do begin
         Result.AddPair(TJSONPair.Create('False', E.Message));
      end;
   end;

end;

end.

