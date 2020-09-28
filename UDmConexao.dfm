object DmConexao: TDmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 459
  Width = 771
  object conDS: TSQLConnection
    DriverName = 'Datasnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=16.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 64
    Top = 48
    UniqueId = '{A027FB5B-EF99-4344-9676-3FD2803EBCCE}'
  end
  object cdsUsuario: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 112
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 16
  end
  object cdsPermissao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 112
  end
  object cdsConfImg: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 112
  end
end
