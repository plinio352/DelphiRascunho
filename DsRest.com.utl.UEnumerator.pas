unit DsRest.com.utl.UEnumerator;

interface

uses
  System.TypInfo, System.SysUtils, System.StrUtils, Vcl.StdCtrls;

type
{$SCOPEDENUMS ON}
   TTipoAnexo = (Selecione, Cliente, Produto);
{$SCOPEDENUMS OFF}

   TTipoAnexoClass = class
   end;

   TTipoAnexoHelper = class helper for TTipoAnexoClass
      class function AnexoToValue(const AValue: TTipoAnexo): string;
      class function ValueToAnexo(const AValue: string): TTipoAnexo;
      class function AnexoToCompont(const AValue: TTipoAnexo): Integer;
      class procedure CarregaComboBox(const AComboBox: TComboBox);
   end;

implementation
{ TTipoAnexoHelper }

class function TTipoAnexoHelper.AnexoToCompont(const AValue: TTipoAnexo): Integer;
begin
   Result := 0;

   case AValue of
      TTipoAnexo.Selecione : Result := 0;
      TTipoAnexo.Cliente   : Result := 1;
      TTipoAnexo.Produto   : Result := 2;
   end;
end;

class function TTipoAnexoHelper.AnexoToValue(const AValue: TTipoAnexo): string;
begin
   case AValue of
      TTipoAnexo.Cliente,
      TTipoAnexo.Produto   : Result := GetEnumName(TypeInfo(TTipoAnexo), Integer(AValue));
      TTipoAnexo.Selecione : Result := EmptyStr;
   end;
end;

class procedure TTipoAnexoHelper.CarregaComboBox(const AComboBox: TComboBox);
var
   AtipoAnexo: TTipoAnexo;
begin
   AComboBox.Clear;
   for AtipoAnexo := TTipoAnexo.Selecione to TTipoAnexo.Produto do
      AComboBox.Items.Add(GetEnumName(TypeInfo(TTipoAnexo), Integer(AtipoAnexo)));
end;

class function TTipoAnexoHelper.ValueToAnexo(const AValue: string): TTipoAnexo;
begin
   Result := TTipoAnexo.Selecione;

   case AnsiIndexStr(AValue, ['Selecione', 'Cliente', 'Produto']) of
      0: Result := TTipoAnexo.Selecione;
      1: Result := TTipoAnexo.Cliente;
      2: Result := TTipoAnexo.Produto;
   end;
end;

end.
