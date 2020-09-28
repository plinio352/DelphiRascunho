inherited FrmCliente: TFrmCliente
  Caption = 'Cliente'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPadrao: TPageControl
    ActivePage = tsFormulario
    OnChange = pgcPadraoChange
    inherited tsFormulario: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 27
      ExplicitWidth = 831
      ExplicitHeight = 406
      object GroupBox1: TGroupBox
        Left = 10
        Top = 187
        Width = 545
        Height = 40
        Caption = 'Nome:'
        TabOrder = 0
        object edtNome: TDBEdit
          Left = 2
          Top = 15
          Width = 541
          Height = 21
          Align = alTop
          DataSource = dsPesq
          TabOrder = 0
        end
      end
      object rgSexo: TDBRadioGroup
        Left = 565
        Top = 187
        Width = 150
        Height = 40
        Caption = 'Sexo:'
        Columns = 2
        DataSource = dsPesq
        Items.Strings = (
          'Feminino'
          'Masculino')
        ParentBackground = True
        TabOrder = 1
        Values.Strings = (
          'F'
          'M')
      end
      object GroupBox2: TGroupBox
        Left = 172
        Top = 232
        Width = 185
        Height = 40
        Caption = 'CPF / CNPJ:'
        TabOrder = 3
        object edtCpf: TDBEdit
          Left = 2
          Top = 15
          Width = 181
          Height = 21
          Align = alTop
          DataSource = dsPesq
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 10
        Top = 278
        Width = 185
        Height = 40
        Caption = 'Identidade:'
        TabOrder = 5
        object edtIdentidade: TDBEdit
          Left = 2
          Top = 15
          Width = 181
          Height = 21
          Align = alTop
          DataSource = dsPesq
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 207
        Top = 278
        Width = 150
        Height = 40
        Caption = 'Dt. Nascimento:'
        TabOrder = 6
        object edtDtNascimento: TDBDateEdit
          Left = 2
          Top = 15
          Width = 146
          Height = 23
          Align = alClient
          DataSource = dsPesq
          NumGlyphs = 2
          TabOrder = 0
          ExplicitHeight = 21
        end
      end
      object rgTipo: TDBRadioGroup
        Left = 10
        Top = 232
        Width = 150
        Height = 40
        Caption = 'Tipo Pessoa:'
        Columns = 2
        DataSource = dsPesq
        Items.Strings = (
          'Fisica'
          'Juridica')
        ParentBackground = True
        TabOrder = 2
        Values.Strings = (
          'F'
          'J')
      end
      object GroupBox5: TGroupBox
        Left = 10
        Top = 5
        Width = 150
        Height = 180
        Caption = 'Foto:'
        TabOrder = 7
        object imgFoto: TImage
          Left = 2
          Top = 15
          Width = 146
          Height = 143
          Align = alClient
          ExplicitLeft = 64
          ExplicitTop = 32
          ExplicitWidth = 105
          ExplicitHeight = 105
        end
        object btnEditar: TButton
          Left = 2
          Top = 158
          Width = 146
          Height = 20
          Align = alBottom
          Caption = 'Editar'
          TabOrder = 0
          OnClick = btnEditarClick
        end
      end
      object GroupBox6: TGroupBox
        Left = 370
        Top = 233
        Width = 185
        Height = 40
        Caption = 'Inscri'#231#227'o Estadual:'
        TabOrder = 4
        object edtInscEstadual: TDBEdit
          Left = 2
          Top = 15
          Width = 181
          Height = 21
          Align = alTop
          DataSource = dsPesq
          TabOrder = 0
        end
      end
      object GroupBox7: TGroupBox
        Left = 164
        Top = 136
        Width = 500
        Height = 47
        Caption = 'Arquivo:  '
        TabOrder = 8
        object Splitter5: TSplitter
          Left = 76
          Top = 15
          Width = 10
          Height = 30
          ExplicitHeight = 28
        end
        object edtNomeArquivo: TEdit
          AlignWithMargins = True
          Left = 89
          Top = 18
          Width = 406
          Height = 24
          Align = alClient
          ReadOnly = True
          TabOrder = 0
          ExplicitHeight = 21
        end
        object edtCodigoArquivo: TEdit
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 68
          Height = 24
          Align = alLeft
          ReadOnly = True
          TabOrder = 1
          ExplicitHeight = 21
        end
      end
    end
  end
  inherited ilPadrao: TImageList
    Left = 384
    Top = 104
  end
  inherited dsPesq: TDataSource
    OnStateChange = dsPesqStateChange
  end
  inherited alPadrao: TActionList
    Left = 484
    Top = 104
  end
  inherited ilPadrao16: TImageList
    Left = 432
    Top = 104
  end
end
