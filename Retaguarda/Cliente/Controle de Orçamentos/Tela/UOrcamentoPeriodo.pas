{ *******************************************************************************
Title: T2Ti ERP
Description: Janela para consultar os per�odos de or�amento

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

@author Albert Eije
@version 2.0
******************************************************************************* }

unit UOrcamentoPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, OrcamentoPeriodoVO, OrcamentoPeriodoController,
  Atributos, Constantes, LabeledCtrls;

type
  [TFormDescription(TConstantes.MODULO_ORCAMENTO, 'Per�odos do Or�amento')]

  TFOrcamentoPeriodo = class(TFTelaCadastro)
    procedure FormCreate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ControlaBotoes; override;
  end;

var
  FOrcamentoPeriodo: TFOrcamentoPeriodo;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFOrcamentoPeriodo.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TOrcamentoPeriodoVO;
  ObjetoController := TOrcamentoPeriodoController.Create;

  inherited;
end;

procedure TFOrcamentoPeriodo.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFOrcamentoPeriodo.GridDblClick(Sender: TObject);
begin
//
end;
{$ENDREGION}

end.
