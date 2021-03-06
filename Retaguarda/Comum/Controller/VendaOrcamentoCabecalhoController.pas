{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado � tabela [VENDA_ORCAMENTO_CABECALHO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2016 T2Ti.COM                                          
                                                                                
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
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 2.0                                                                    
*******************************************************************************}
unit VendaOrcamentoCabecalhoController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB,  Windows, Forms, Controller, Rtti,
  Atributos, VO, Generics.Collections, VendaOrcamentoCabecalhoVO;

type
  TVendaOrcamentoCabecalhoController = class(TController)
  private
    class var FDataSet: TClientDataSet;
  public
    class procedure Consulta(pFiltro: String; pPagina: String; pConsultaCompleta: Boolean = False);
    class function ConsultaLista(pFiltro: String): TObjectList<TVendaOrcamentoCabecalhoVO>;
    class function ConsultaObjeto(pFiltro: String): TVendaOrcamentoCabecalhoVO;

    class procedure Insere(pObjeto: TVendaOrcamentoCabecalhoVO);
    class function Altera(pObjeto: TVendaOrcamentoCabecalhoVO): Boolean;

    class function Exclui(pId: Integer): Boolean;

    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;
    class procedure TratarListaRetorno(pListaObjetos: TObjectList<TVO>);
  end;

implementation

uses UDataModule, T2TiORM, VendaOrcamentoDetalheVO;

class procedure TVendaOrcamentoCabecalhoController.Consulta(pFiltro: String; pPagina: String; pConsultaCompleta: Boolean);
var
  Retorno: TObjectList<TVendaOrcamentoCabecalhoVO>;
begin
  try
    Retorno := TT2TiORM.Consultar<TVendaOrcamentoCabecalhoVO>(pFiltro, pPagina, pConsultaCompleta);
    TratarRetorno<TVendaOrcamentoCabecalhoVO>(Retorno);
  finally
  end;
end;

class function TVendaOrcamentoCabecalhoController.ConsultaLista(pFiltro: String): TObjectList<TVendaOrcamentoCabecalhoVO>;
begin
  try
    Result := TT2TiORM.Consultar<TVendaOrcamentoCabecalhoVO>(pFiltro, '-1', True);
  finally
  end;
end;

class function TVendaOrcamentoCabecalhoController.ConsultaObjeto(pFiltro: String): TVendaOrcamentoCabecalhoVO;
begin
  try
    Result := TT2TiORM.ConsultarUmObjeto<TVendaOrcamentoCabecalhoVO>(pFiltro, True);
  finally
  end;
end;

class procedure TVendaOrcamentoCabecalhoController.Insere(pObjeto: TVendaOrcamentoCabecalhoVO);
var
  UltimoID: Integer;
  OrcamentoPedidoVendaDetEnumerator: TEnumerator<TVendaOrcamentoDetalheVO>;
begin
  try
    UltimoID := TT2TiORM.Inserir(pObjeto);

    // Lista Or�amento Pedido Detalhe
    OrcamentoPedidoVendaDetEnumerator := pObjeto.ListaVendaOrcamentoDetalheVO.GetEnumerator;
    try
      with OrcamentoPedidoVendaDetEnumerator do
      begin
        while MoveNext do
        begin
          Current.IdVendaOrcamentoCabecalho := UltimoID;
          TT2TiORM.Inserir(Current);
        end;
      end;
    finally
      FreeAndNil(OrcamentoPedidoVendaDetEnumerator);
    end;

    Consulta('ID = ' + IntToStr(UltimoID), '0');
  finally
  end;
end;

class function TVendaOrcamentoCabecalhoController.Altera(pObjeto: TVendaOrcamentoCabecalhoVO): Boolean;
var
  OrcamentoPedidoVendaDetEnumerator: TEnumerator<TVendaOrcamentoDetalheVO>;
begin
  try
    Result := TT2TiORM.Alterar(pObjeto);

    // Lista Or�amento Pedido Detalhe
    try
      OrcamentoPedidoVendaDetEnumerator := pObjeto.ListaVendaOrcamentoDetalheVO.GetEnumerator;
      with OrcamentoPedidoVendaDetEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Result := TT2TiORM.Alterar(Current)
          else
          begin
            Current.IdVendaOrcamentoCabecalho := pObjeto.Id;
            Result := TT2TiORM.Inserir(Current) > 0;
          end;
        end;
      end;
    finally
      FreeAndNil(OrcamentoPedidoVendaDetEnumerator);
    end;

  finally
  end;
end;

class function TVendaOrcamentoCabecalhoController.Exclui(pId: Integer): Boolean;
var
  ObjetoLocal: TVendaOrcamentoCabecalhoVO;
begin
  try
    ObjetoLocal := TVendaOrcamentoCabecalhoVO.Create;
    ObjetoLocal.Id := pId;
    Result := TT2TiORM.Excluir(ObjetoLocal);
    TratarRetorno(Result);
  finally
    FreeAndNil(ObjetoLocal)
  end;
end;

class function TVendaOrcamentoCabecalhoController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class procedure TVendaOrcamentoCabecalhoController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class procedure TVendaOrcamentoCabecalhoController.TratarListaRetorno(pListaObjetos: TObjectList<TVO>);
begin
  try
    TratarRetorno<TVendaOrcamentoCabecalhoVO>(TObjectList<TVendaOrcamentoCabecalhoVO>(pListaObjetos));
  finally
    FreeAndNil(pListaObjetos);
  end;
end;

initialization
  Classes.RegisterClass(TVendaOrcamentoCabecalhoController);

finalization
  Classes.UnRegisterClass(TVendaOrcamentoCabecalhoController);

end.
