{**
 * LibreDTE
 * Copyright (C) SASCO SpA (https://sasco.cl)
 *
 * Este programa es software libre: usted puede redistribuirlo y/o modificarlo
 * bajo los términos de la GNU Lesser General Public License (LGPL) publicada
 * por la Fundación para el Software Libre, ya sea la versión 3 de la Licencia,
 * o (a su elección) cualquier versión posterior de la misma.
 *
 * Este programa se distribuye con la esperanza de que sea útil, pero SIN
 * GARANTÍA ALGUNA; ni siquiera la garantía implícita MERCANTIL o de APTITUD
 * PARA UN PROPÓSITO DETERMINADO. Consulte los detalles de la GNU Lesser General
 * Public License (LGPL) para obtener una información más detallada.
 *
 * Debería haber recibido una copia de la GNU Lesser General Public License
 * (LGPL) junto a este programa. En caso contrario, consulte
 * <http://www.gnu.org/licenses/lgpl.html>.
 *}

 {
  Desarrollado por Sigisfredo Belmar Cadiz http://stna.cl
 }

unit Api_Libre_Dte;

interface

uses
  System.SysUtils, System.Classes,REST.Client,System.JSON,REST.Types;

const url = 'https://libredte.cl/api/';

type LibreDTE = class
     private
        FHistricoPost,
        FHistoricoGets:TstringList;
        Rest:TRESTClient;
        Request:TRESTRequest;
     public
           constructor Create(hash:string);
           destructor Destroy; override;
           function Post(funcion:string;datos:TJSONObject):TJSONObject;
           function Get(funcion:string;datos:TJSONObject):TJSONObject;
           property hitorico_gets:TstringList read FHistoricoGets;
           property hitorico_post:TstringList read FHistricoPost;
     end;

implementation

{ LibreDTE }

constructor LibreDTE.Create(hash:string);
begin
     FHistricoPost:=TStringList.Create;
     FHistoricoGets:=TStringList.Create;
end;

destructor LibreDTE.Destroy;
begin
  inherited;
  FreeAndNil(FHistricoPost);
  FreeAndNil(FHistoricoGets);
end;

function LibreDTE.Get(funcion: string; datos: TJSONObject): TJSONObject;
begin
    Rest:=TRESTClient.Create(url+funcion);
    Request:=TRESTRequest.Create(Rest);
    Rest.ContentType := 'application/x-www-form-urlencoded';
    Request.AcceptCharset := 'utf-8';
    Request.Method := TRESTRequestMethod.rmGet;
    Request.ClearBody;

    Request.AddBody(datos.ToString, ctAPPLICATION_JSON);
    FHistoricoGets.Add(datos.ToString);
    Request.Execute;

    FreeAndNil(Request);
    FreeAndNil(Rest);
end;

function LibreDTE.Post(funcion: string; datos: TJSONObject): TJSONObject;
begin
    Rest:=TRESTClient.Create(url+funcion);
    Request:=TRESTRequest.Create(Rest);
    Rest.ContentType := 'application/x-www-form-urlencoded';
    Request.AcceptCharset := 'utf-8';
    Request.Method := TRESTRequestMethod.rmPOST;
    Request.ClearBody;

    Request.AddBody(datos.ToString, ctAPPLICATION_JSON);
    FHistricoPost.add(datos.ToString);
    Request.Execute;

    FreeAndNil(Request);
    FreeAndNil(Rest);
end;

end.
