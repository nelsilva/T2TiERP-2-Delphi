inherited FDAV: TFDAV
  Left = 342
  Top = 220
  Caption = 'DAV'
  ClientWidth = 933
  ExplicitWidth = 949
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 933
    ActivePage = PaginaEdits
    ExplicitWidth = 933
    inherited PaginaGrid: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 925
      ExplicitHeight = 407
      inherited PanelGrid: TPanel
        Width = 925
        ExplicitWidth = 925
        inherited Grid: TJvDBUltimGrid
          Width = 925
        end
        inherited PanelFiltroRapido: TPanel
          Width = 925
          ExplicitWidth = 925
          inherited BotaoConsultar: TSpeedButton
            Left = 793
            ExplicitLeft = 790
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 624
            ExplicitWidth = 624
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 925
      ExplicitHeight = 407
      inherited PanelEdits: TPanel
        Width = 925
        ExplicitWidth = 925
        object BevelEdits: TBevel
          Left = 10
          Top = 12
          Width = 905
          Height = 97
          Anchors = [akLeft, akTop, akRight]
          Constraints.MinWidth = 753
        end
        object EditIdCliente: TLabeledCalcEdit
          Left = 18
          Top = 37
          Width = 61
          Height = 21
          DisplayFormat = '#'
          ParentShowHint = False
          ShowButton = False
          ShowHint = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
          OnKeyUp = EditIdClienteKeyUp
          CalcEditLabel.Width = 60
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Cliente [F1]:'
        end
        object EditNomeCliente: TLabeledEdit
          Left = 85
          Top = 37
          Width = 631
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 67
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome Cliente:'
          TabOrder = 1
        end
        object EditCpfCnpjCliente: TLabeledEdit
          Left = 722
          Top = 37
          Width = 184
          Height = 21
          TabStop = False
          Anchors = [akTop, akRight]
          EditLabel.Width = 83
          EditLabel.Height = 13
          EditLabel.Caption = 'Cpf/Cnpj Cliente:'
          TabOrder = 2
        end
        object EditValorDesconto: TLabeledCalcEdit
          Left = 658
          Top = 80
          Width = 121
          Height = 21
          Color = clInfoBk
          DisplayFormat = '###,###,##0.00'
          Anchors = [akTop, akRight]
          ReadOnly = True
          ShowButton = False
          TabOrder = 5
          DecimalPlacesAlwaysShown = False
          CalcEditLabel.Width = 76
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Valor Desconto:'
        end
        object EditValorSubTotal: TLabeledCalcEdit
          Left = 404
          Top = 80
          Width = 121
          Height = 21
          Color = clInfoBk
          DisplayFormat = '###,###,##0.00'
          Anchors = [akTop, akRight]
          ReadOnly = True
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = False
          CalcEditLabel.Width = 46
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'SubTotal:'
        end
        object EditValorTotal: TLabeledCalcEdit
          Left = 785
          Top = 80
          Width = 121
          Height = 21
          Color = clInfoBk
          DisplayFormat = '###,###,##0.00'
          Anchors = [akTop, akRight]
          ReadOnly = True
          ShowButton = False
          TabOrder = 6
          DecimalPlacesAlwaysShown = False
          CalcEditLabel.Width = 28
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Total:'
        end
        object EditTaxadesconto: TLabeledCalcEdit
          Left = 531
          Top = 80
          Width = 121
          Height = 21
          DisplayFormat = '###,###,##0.00'
          Anchors = [akTop, akRight]
          ShowButton = False
          TabOrder = 4
          DecimalPlacesAlwaysShown = False
          CalcEditLabel.Width = 76
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Taxa Desconto:'
        end
        object ComboBoxTipo: TLabeledComboBox
          Left = 18
          Top = 80
          Width = 380
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemIndex = 0
          TabOrder = 7
          Text = 'Padr'#227'o'
          Items.Strings = (
            'Padr'#227'o'
            'Farm'#225'cia'
            'Ordem de Servi'#231'o')
          ComboBoxLabel.Width = 24
          ComboBoxLabel.Height = 13
          ComboBoxLabel.Caption = 'Tipo:'
        end
        object PageControl1: TPageControl
          Left = 10
          Top = 128
          Width = 896
          Height = 259
          ActivePage = Itens
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 8
          object Itens: TTabSheet
            Caption = 'Itens'
            ExplicitWidth = 281
            ExplicitHeight = 165
            object ActionToolBar1: TActionToolBar
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 882
              Height = 24
              ActionManager = ActionManager
              BiDiMode = bdRightToLeft
              Caption = 'ActionToolBarEdits'
              Color = clMenuBar
              ColorMap.DisabledFontColor = 7171437
              ColorMap.HighlightColor = clWhite
              ColorMap.BtnSelectedColor = clBtnFace
              ColorMap.BtnSelectedFont = clBlack
              ColorMap.UnusedColor = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Orientation = boRightToLeft
              ParentBiDiMode = False
              ParentFont = False
              Spacing = 0
            end
            object GridDetalhe: TJvDBUltimGrid
              Left = 0
              Top = 30
              Width = 888
              Height = 201
              Align = alClient
              DataSource = DSDetalhe
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              OnDrawColumnCell = GridDetalheDrawColumnCell
              OnKeyDown = GridDetalheKeyDown
              TitleButtons = True
              AlternateRowColor = 15593713
              TitleArrow = True
              SelectColumnsDialogStrings.Caption = 'Select columns'
              SelectColumnsDialogStrings.OK = '&OK'
              SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
              CanDelete = False
              EditControls = <>
              RowsHeight = 17
              TitleRowHeight = 17
              SortWith = swClient
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'F'#243'rmula'
            ImageIndex = 1
            ExplicitWidth = 596
            ExplicitHeight = 289
            DesignSize = (
              888
              231)
            object MemoFormula: TMemo
              Left = 3
              Top = 11
              Width = 882
              Height = 217
              Anchors = [akLeft, akTop, akRight, akBottom]
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 933
    ExplicitWidth = 933
    inherited BotaoSair: TSpeedButton
      Left = 829
      ExplicitLeft = 826
    end
    inherited BotaoExportar: TSpeedButton
      Left = 729
      ExplicitLeft = 726
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 629
      ExplicitLeft = 626
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 519
      ExplicitLeft = 516
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 529
      ExplicitLeft = 526
    end
  end
  object CDSDetalhe: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterEdit = ControlaPersistencia
    BeforePost = CDSDetalheBeforePost
    Left = 720
    Top = 264
  end
  object DSDetalhe: TDataSource
    DataSet = CDSDetalhe
    Left = 720
    Top = 312
  end
  object ActionManager: TActionManager
    ActionBars.ShowHints = False
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end>
      end
      item
      end
      item
        Items = <
          item
            Caption = '-'
          end>
      end
      item
      end
      item
        Items = <
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end>
      end
      item
      end
      item
        Items = <
          item
            Action = ActionAtualizarTotais
            Caption = '&Atualizar Totais'
            ImageIndex = 30
          end
          item
            Caption = '-'
          end
          item
            Action = ActionExcluirItem
            Caption = '&Cancelar Item'
            ImageIndex = 10
          end
          item
            Action = ActionIncluirItem
            Caption = '&Incluir Item'
            ImageIndex = 31
          end>
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Action = ActionAtualizarTotais
            Caption = '&Atualizar Totais'
            ImageIndex = 30
          end
          item
            Action = ActionExcluirItem
            Caption = '&Cancelar Item'
            ImageIndex = 10
          end
          item
            Action = ActionIncluirItem
            Caption = '&Incluir Item'
            ImageIndex = 31
          end>
        ActionBar = ActionToolBar1
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 627
    Top = 328
    StyleName = 'Ribbon - Silver'
    object ActionIncluirItem: TAction
      Category = 'Opcoes'
      Caption = 'Incluir Item'
      ImageIndex = 31
      OnExecute = ActionIncluirItemExecute
    end
    object ActionExcluirItem: TAction
      Category = 'Opcoes'
      Caption = 'Cancelar Item'
      ImageIndex = 10
      OnExecute = ActionExcluirItemExecute
    end
    object ActionAtualizarTotais: TAction
      Category = 'Opcoes'
      Caption = 'Atualizar Totais'
      ImageIndex = 30
      OnExecute = ActionAtualizarTotaisExecute
    end
  end
end
