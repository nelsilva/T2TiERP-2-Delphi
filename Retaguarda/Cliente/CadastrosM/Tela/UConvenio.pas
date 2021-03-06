{ *******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Convenio

The MIT License

Copyright: Copyright (C) 2015 T2Ti.COM

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
t2ti.com@gmail.com</p>

t2ti.com@gmail.com
@author Albert Eije (T2Ti.COM)
@version 2.0
******************************************************************************* }
unit UConvenio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ConvenioVO,
  ConvenioController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Controller;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Conv�nio')]

  TFConvenio = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditLogradouro: TLabeledEdit;
    EditContato: TLabeledEdit;
    EditBairro: TLabeledEdit;
    EditDesconto: TLabeledCalcEdit;
    EditVencimento: TLabeledDateEdit;
    EditUf: TLabeledEdit;
    EditTelefone: TLabeledMaskEdit;
    EditDataCadastro: TLabeledDateEdit;
    MemoDescricao: TLabeledMemo;
    EditNumero: TLabeledEdit;
    EditMunicipioIbge: TLabeledCalcEdit;
    EditNome: TLabeledEdit;
    EditCNPJ: TLabeledMaskEdit;
    EditEmail: TLabeledEdit;
    EditSite: TLabeledEdit;
    EditClassificacaoContabilConta: TLabeledEdit;
    EditCidade: TLabeledEdit;
    EditCep: TLabeledMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditCepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditClassificacaoContabilContaKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

  end;

var
  FConvenio: TFConvenio;

implementation

uses ULookup, Biblioteca, UDataModule, PessoaVO, PessoaController, ContabilContaVO,
  ContabilContaController, CepVO, CepController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFConvenio.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TConvenioVO;
  ObjetoController := TConvenioController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFConvenio.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFConvenio.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFConvenio.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      TController.ExecutarMetodo('ConvenioController.TConvenioController', 'Exclui', [IdRegistroSelecionado], 'DELETE', 'Boolean');
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
    TController.ExecutarMetodo('ConvenioController.TConvenioController', 'Consulta', [Trim(Filtro), Pagina.ToString, False], 'GET', 'Lista');
end;

function TFConvenio.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TConvenioVO.Create;

      TConvenioVO(ObjetoVO).IdEmpresa := Sessao.Empresa.Id;
      TConvenioVO(ObjetoVO).Nome := EditNome.Text;
      TConvenioVO(ObjetoVO).Cnpj := EditCnpj.Text;
      TConvenioVO(ObjetoVO).Email := EditEmail.Text;
      TConvenioVO(ObjetoVO).Site := EditSite.Text;
      TConvenioVO(ObjetoVO).Desconto := EditDesconto.Value;
      TConvenioVO(ObjetoVO).DataVencimento := EditVencimento.Date;
      TConvenioVO(ObjetoVO).Logradouro := EditLogradouro.Text;
      TConvenioVO(ObjetoVO).Numero := EditNumero.Text;
      TConvenioVO(ObjetoVO).Bairro := EditBairro.Text;
      TConvenioVO(ObjetoVO).Cidade := EditCidade.Text;
      TConvenioVO(ObjetoVO).MunicipioIbge := EditMunicipioIbge.AsInteger;
      TConvenioVO(ObjetoVO).Uf := EditUf.Text;
      TConvenioVO(ObjetoVO).Telefone := EditTelefone.Text;
      TConvenioVO(ObjetoVO).DataCadastro := EditDataCadastro.Date;
      TConvenioVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TConvenioVO(ObjetoVO).Cep := EditCep.Text;
      TConvenioVO(ObjetoVO).ClassificacaoContabilConta := EditClassificacaoContabilConta.Text;
      TConvenioVO(ObjetoVO).Contato := EditContato.Text;

      if StatusTela = stInserindo then
      begin
        TController.ExecutarMetodo('ConvenioController.TConvenioController', 'Insere', [TConvenioVO(ObjetoVO)], 'PUT', 'Lista');
      end
      else if StatusTela = stEditando then
      begin
        if TConvenioVO(ObjetoVO).ToJSONString <> StringObjetoOld then
        begin
          TController.ExecutarMetodo('ConvenioController.TConvenioController', 'Altera', [TConvenioVO(ObjetoVO)], 'POST', 'Boolean');
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFConvenio.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := TConvenioVO(TController.BuscarObjeto('ConvenioController.TConvenioController', 'ConsultaObjeto', ['ID=' + IdRegistroSelecionado.ToString], 'GET'));
  end;

  if Assigned(ObjetoVO) then
  begin

      EditNome.Text := TConvenioVO(ObjetoVO).Nome;
      EditCnpj.Text := TConvenioVO(ObjetoVO).Cnpj;
      EditEmail.Text := TConvenioVO(ObjetoVO).Email;
      EditSite.Text := TConvenioVO(ObjetoVO).Site;
      EditDesconto.Value := TConvenioVO(ObjetoVO).Desconto;
      EditVencimento.Date := TConvenioVO(ObjetoVO).DataVencimento;
      EditLogradouro.Text := TConvenioVO(ObjetoVO).Logradouro;
      EditNumero.Text := TConvenioVO(ObjetoVO).Numero;
      EditBairro.Text := TConvenioVO(ObjetoVO).Bairro;
      EditCidade.Text := TConvenioVO(ObjetoVO).Cidade;
      EditMunicipioIbge.AsInteger := TConvenioVO(ObjetoVO).MunicipioIbge;
      EditUf.Text := TConvenioVO(ObjetoVO).Uf;
      EditTelefone.Text := TConvenioVO(ObjetoVO).Telefone;
      EditDataCadastro.Date := TConvenioVO(ObjetoVO).DataCadastro;
      MemoDescricao.Text := TConvenioVO(ObjetoVO).Descricao;
      EditCep.Text := TConvenioVO(ObjetoVO).Cep;
      EditClassificacaoContabilConta.Text := TConvenioVO(ObjetoVO).ClassificacaoContabilConta;
      EditContato.Text := TConvenioVO(ObjetoVO).Contato;

    // Serializa o objeto para consultar posteriormente se houve altera��es
    FormatSettings.DecimalSeparator := '.';
    StringObjetoOld := ObjetoVO.ToJSONString;
    FormatSettings.DecimalSeparator := ',';
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFConvenio.EditCepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditCep.Text <> '' then
      Filtro := 'CEP = ' + QuotedStr(EditCep.Text)
    else
      Filtro := 'CEP = ""';

    try
      EditCep.Clear;
      if not PopulaCamposTransientes(Filtro, TCepVO, TCepController) then
        PopulaCamposTransientesLookup(TCepVO, TCepController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCep.Text := CDSTransiente.FieldByName('CEP').AsString;
        EditLogradouro.Text := CDSTransiente.FieldByName('LOGRADOURO').AsString;
        EditBairro.Text := CDSTransiente.FieldByName('BAIRRO').AsString;
        EditCidade.Text := CDSTransiente.FieldByName('MUNICIPIO').AsString;
        EditUf.Text := CDSTransiente.FieldByName('UF').AsString;
        EditMunicipioIbge.Text := CDSTransiente.FieldByName('CODIGO_IBGE_MUNICIPIO').AsString;
      end
      else
      begin
        Exit;
        EditCep.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
end;

procedure TFConvenio.EditClassificacaoContabilContaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    if EditClassificacaoContabilConta.Text <> '' then
      Filtro := 'CLASSIFICACAO = ' + QuotedStr(EditClassificacaoContabilConta.Text)
    else
      Filtro := 'CLASSIFICACAO = ""';

    try
      EditClassificacaoContabilConta.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilContaVO, TContabilContaController) then
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditClassificacaoContabilConta.Text := CDSTransiente.FieldByName('CODIGO').AsString;
      end
      else
      begin
        Exit;
        EditClassificacaoContabilConta.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
end;
{$ENDREGION}

end.
