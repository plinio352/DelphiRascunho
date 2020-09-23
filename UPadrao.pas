unit UPadrao;

interface

uses
   Data.DBXJSON, Data.DBXJSONReflect;

type
   TPadrao = class
   public
      class function ObjectToJSON<O: class>(objeto: O): TJSONValue;
      class function JSONToObjecto<O: class>(json: TJSONValue): O;
   end;


implementation

{ TPadrao }

class function TPadrao.ObjectToJSON<O>(objeto: O): TJSONValue;
VAR
	serializa: TJSONMarshal;
begin
	if Assigned(objeto) then begin
		serializa := TJSONMarshal.create(TJSONConverter.create);
		try
			exit(serializa.Marshal(objeto));
		finally
			serializa.free;
		end;
	end
	else
		exit(TJSONNull.Create);

end;

class function TPadrao.JSONToObjecto<O>(json: TJSONValue): O;
var
	deserializa: TJSONUnMarshal;
begin
	if json is TJSONNull THEN
		Exit(nil);

	deserializa := TJSONUnMarshal.Create;
	try
		exit(O(deserializa.Unmarshal(json)));
	finally
		deserializa.free;
	end;
end;

end.
