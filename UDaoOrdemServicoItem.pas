unit UDaoOrdemServicoItem;

interface

uses
   Data.DB, System.Classes, System.SysUtils, Data.Win.ADODB, System.Generics.Collections,
   Datasnap.Provider, Data.SqlExpr, Data.DBXJSON, System.Variants, UOrdemServicoItem;

type
   {$METHODINFO ON}
   TDaoOrdemServicoItem = class(TComponent)
   private
      FOrdemServicoItem: TOrdemServicoItem;

      procedure AtualizaOS(const AValue: Integer);

   public
      function OrdemServicoItem: OleVariant;
      function AcceptOrdemServicoItem(O: TJSONValue): Boolean;
      function UpDateOrdemServicoItem(O: TJSONValue): Boolean;
      function CancelOrdemServicoItem(O: TJSONValue): Boolean;

   end;
   {$METHODINFO OFF}


implementation

uses
   UDmConexao, UDmOrdemServicoItem, UDmOrdemServico, UDmServico;

{ TDaoOrdemServicoItem }

function TDaoOrdemServicoItem.AcceptOrdemServicoItem(O: TJSONValue): Boolean;
begin
   try
      FOrdemServicoItem := TOrdemServicoItem.JSONToObjecto<TOrdemServicoItem>(O);

      DmOrdemServicoItem.dtsIncluir.ParamByName('P_idOrdemServico').Value := FOrdemServicoItem.idOrdemServico;
      DmOrdemServicoItem.dtsIncluir.ParamByName('P_idServico'     ).Value := FOrdemServicoItem.idServico;
      DmOrdemServicoItem.dtsIncluir.ParamByName('P_valor'         ).Value := FOrdemServicoItem.valor;
      DmOrdemServicoItem.dtsIncluir.ParamByName('P_desconto'      ).Value := FOrdemServicoItem.desconto;
      DmOrdemServicoItem.dtsIncluir.ExecSQL;

      AtualizaOS(FOrdemServicoItem.idOrdemServico);

      Result := True;

   except
      Result := False;
   end;

end;

procedure TDaoOrdemServicoItem.AtualizaOS(const AValue: Integer);
begin
   DmOrdemServicoItem.dtsCst.Close;
   DmOrdemServicoItem.dtsCst.ParamByName('P_idOrdemServico').Value := AValue;
   DmOrdemServicoItem.dtsCst.Open;

   DmOrdemServico.dtsAlt.ParamByName('P_qtdItem').Value := DmOrdemServicoItem.dtsCstQtd.Value;
   DmOrdemServico.dtsAlt.ParamByName('P_vrItem' ).AsFMTBCD := DmOrdemServicoItem.dtsCstVrTotal.AsBCD;
   DmOrdemServico.dtsAlt.ParamByName('P_id'     ).Value := AValue;
   DmOrdemServico.dtsAlt.ExecSQL;

end;

function TDaoOrdemServicoItem.CancelOrdemServicoItem(O: TJSONValue): Boolean;
begin
   try
      FOrdemServicoItem := TOrdemServicoItem.JSONToObjecto<TOrdemServicoItem>(O);

      DmOrdemServicoItem.dtsDeletar.ParamByName('P_id').Value := FOrdemServicoItem.ID;
      DmOrdemServicoItem.dtsDeletar.ExecSQL;

      AtualizaOS(FOrdemServicoItem.idOrdemServico);

      Result := True;

   except
      Result := False;
   end;

end;

function TDaoOrdemServicoItem.OrdemServicoItem: OleVariant;
begin
   Result := VarArrayCreate([0,2], varVariant);
   try
      DmOrdemServico.dtsLista.Close;
      DmOrdemServico.dtsLista.Open;

      DmOrdemServicoItem.dtsLista.Close;
      DmOrdemServicoItem.dtsLista.Open;

      DmServico.dtsLista01.Close;
      DmServico.dtsLista01.Open;

      Result[0] := DmOrdemServico.dspLista.Data;
      Result[1] := DmOrdemServicoItem.dspLista.Data;
      Result[2] := DmServico.dspLista01.Data;

   except
      on E: Exception do begin
         Result := 'Error Consulta Formulario: '+E.Message;
      end;
   end;

end;

function TDaoOrdemServicoItem.UpDateOrdemServicoItem(O: TJSONValue): Boolean;
begin
   try
      FOrdemServicoItem := TOrdemServicoItem.JSONToObjecto<TOrdemServicoItem>(O);

      DmOrdemServicoItem.dtsAlterar.ParamByName('P_idServico'     ).Value := FOrdemServicoItem.idServico;
      DmOrdemServicoItem.dtsAlterar.ParamByName('P_valor'         ).Value := FOrdemServicoItem.valor;
      DmOrdemServicoItem.dtsAlterar.ParamByName('P_desconto'      ).Value := FOrdemServicoItem.desconto;
      DmOrdemServicoItem.dtsAlterar.ParamByName('P_ID'            ).Value := FOrdemServicoItem.ID;
      DmOrdemServicoItem.dtsAlterar.ExecSQL;

      AtualizaOS(FOrdemServicoItem.idOrdemServico);

      Result := True;

   except
      Result := False;
   end;

end;

end.
