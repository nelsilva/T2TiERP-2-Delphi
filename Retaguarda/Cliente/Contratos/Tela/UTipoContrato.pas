{ *******************************************************************************
Title: T2Ti ERP
Description: Janela de Cadastro dos Tipos de Contrato - M�dulo Gest�o de Contratos

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

The author may be contacted at:
t2ti.com@gmail.com

@author Albert Eije (alberteije@gmail.com)
@version 2.0
******************************************************************************* }
unit UTipoContrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, Controller;

type
  [TFormDescription(TConstantes.MODULO_CONTRATOS, 'Tipo de Contrato')]

  TFTipoContrato = class(TFTelaCadastro)
    EditNome: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    BevelEdits: TBevel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    { Public declarations }
    procedure GridParaEdits; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FTipoContrato: TFTipoContrato;

implementation

uses TipoContratoController, TipoContratoVo, NotificationService;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFTipoContrato.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TTipoContratoVO;
  ObjetoController := TTipoContratoController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFTipoContrato.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFTipoContrato.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFTipoContrato.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      TController.ExecutarMetodo('TipoContratoController.TTipoContratoController', 'Exclui', [IdRegistroSelecionado], 'DELETE', 'Boolean');
      Result := TController.RetornoBoolean;
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TController.ExecutarMetodo('TipoContratoController.TTipoContratoController', 'Consulta', [Trim(Filtro), Pagina.ToString, False], 'GET', 'Lista');
end;

function TFTipoContrato.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TTipoContratoVO.Create;

      TTipoContratoVO(ObjetoVO).IdEmpresa := Sessao.Empresa.Id;
      TTipoContratoVO(ObjetoVO).Nome := EditNome.Text;
      TTipoContratoVO(ObjetoVO).Descricao := MemoDescricao.Text;

      if StatusTela = stInserindo then
      begin
        TController.ExecutarMetodo('TipoContratoController.TTipoContratoController', 'Insere', [TTipoContratoVO(ObjetoVO)], 'PUT', 'Lista');
      end
      else if StatusTela = stEditando then
        if TTipoContratoVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        begin
          TController.ExecutarMetodo('TipoContratoController.TTipoContratoController', 'Altera', [TTipoContratoVO(ObjetoVO)], 'POST', 'Boolean');
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFTipoContrato.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := TTipoContratoVO(TController.BuscarObjeto('TipoContratoController.TTipoContratoController', 'ConsultaObjeto', ['ID=' + IdRegistroSelecionado.ToString], 'GET'));
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TTipoContratoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TTipoContratoVO(ObjetoVO).Descricao;

    // Serializa o objeto para consultar posteriormente se houve altera��es
    FormatSettings.DecimalSeparator := '.';
    StringObjetoOld := ObjetoVO.ToJSONString;
    FormatSettings.DecimalSeparator := ',';
  end;
end;
{$ENDREGION}

end.
