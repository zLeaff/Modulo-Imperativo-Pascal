{
   sip2punto4.pas
   
   Copyright 2023 Marcos <Marcos@DESKTOP-109G219>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}


program untitled;

type
   rango = 1..8 ;
   producto =record 
     codigo : integer;
     rubro : rango ;
     precio: real;
   end;
   
   
   
   Lista = ^nodo;
   
   nodo = record
     elem: producto;
     sig:Lista;
   end;
   
   vector = array [rango] of Lista;
   
   rubro3 = array [1..30] of producto;
   
procedure cargarProducto(var p:producto);
begin
  writeln('-------------------------');
  writeln('cargar precio del producto');
  readln(p.precio);
  if(p.precio <> 0)then begin
    writeln('cargar codigo del producto');
    readln(p.codigo);
    writeln('cargar rubro');
    readln(p.rubro);
  end;
end;

procedure cargarL(VAR L:Lista ; p:producto);
var nue , act , ant :Lista ;

begin
  new (nue) ; nue^.elem:=p;
  act:=L ; ant:=L; 
  while (act <> nil) and(act^.elem.codigo < p.codigo)do begin
    ant:= act;
    act:=act^.sig;
  end;
  if(act = ant)then
    L:=nue
  else
    ant^.sig:= nue;
  nue^.sig:=act;
end; 

procedure cargarvector (var v:vector);
var  p:producto;
begin
  cargarProducto(p);
  while (p.precio <> 0)do begin
    cargarL(v[p.rubro],p);//insertar ordenado 
    cargarProducto(p);
  end;
end;


procedure imprimirVector (v:vector);
var i:rango;
begin
  for i:=1 to 8 do begin
    
    writeln('---------------------');
    writeln('producto de rubro :', i);
    writeln(' ');
    while (v[i] <> nil) do begin
      writeln('////////////////////////////');
      writeln('codigo de producto: ', v[i]^.elem.codigo);
      writeln('precio del producto: ',v[i]^.elem.precio:10:3);
      writeln('');
      v[i]:=v[i]^.sig;
    end;
  end;
end; 
procedure imprimir (r:rubro3 ; dl :integer);
var i: integer;
begin
  writeln('-----------------------------');
  writeln('productos del rubro 3 : ');
  writeln('------------------------------');
  for i:=1 to dl do begin
    writeln('');
    writeln('codigo de producto : ',r[i].codigo);
    writeln('precio del producto : ',r[i].precio:10:3);
    writeln('');
    writeln('//////////////////////////////////////////////');
  end;
end;
procedure generarvector(var r :rubro3 ; v:vector;var dl:integer); 
var i:integer;
begin 
  i:=1;
  while (i<= 30)and (v[3] <> nil) do begin  
    r[i]:=v[3]^.elem;
    v[3]:=v[3]^.sig;
    i:=i+1;
  end;
  if (i>30) then
    dl:=30
  else
    dl:=i-1;
    
  imprimir(r,dl);
end;

procedure insercion (var r : rubro3 ; dl :integer);
var i,j:integer ; aux: producto ;
begin
   for i:= 2 to dl do begin
     aux := r[i] ;
     j:=i-1;
     while (j> 0) and (r[j].precio > aux.precio) do begin
       r[j+1]:= r[j];
       j:=j-1;
     end;
     r[j+1]:=aux;
     
     end;
end; 

function promedio (r:rubro3 ; dl:integer):real;
var
 i:integer; acumulador:real;
begin
  acumulador:=0;
  for i:=1 to dl do 
    acumulador:= acumulador + r[i].precio;
  acumulador:= acumulador / i;
  promedio:= acumulador
end;

var v:vector;r:rubro3;dl:integer;
BEGIN
  cargarvector(v);//A)
  imprimirVector(v);//B)
  generarvector(r,v,dl);//C)
  insercion(r,dl);//D)
  writeln('se imprimiran los productos del rubro 3 n forma ordena de menos a mayor');
  imprimir(r,dl);//E)
  writeln('el promedio del precio de los productos del rubro 3 es :' , promedio(r,dl):10:3);
END.

