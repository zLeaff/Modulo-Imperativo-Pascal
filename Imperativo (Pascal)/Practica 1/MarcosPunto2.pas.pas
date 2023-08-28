{
   p2punto2.pas
   
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
  oficina = record 
    codigo : integer;
    dni: integer;
    expensas: real;
  end;
  
  vector = array [1..300] of oficina ;
  
procedure cargarOficina(var o:oficina);
begin
  writeln('cargar codigo de la oficina');
  readln(o.codigo);
  if (o.codigo <> -1) then begin
    writeln('cargar dni del propietario de la oficna');
    readln(o.dni);
    writeln('cargar el valor de las expensas');
    readln(o.expensas);
  end;
  writeln('se ha cargado correctamente la oficina');
end;

procedure CargarVector(var V:vector ;var dl: integer ) ;
var o:oficina ; i:integer;

begin
  i:=0;
  cargarOficina(o);
  while (i< 300) and (o.codigo <> -1)do begin
     i:=i+1;
     v[i]:=o;
     cargarOficina(o);
  end;
  
  dl:=i;
end;
procedure imprimirVector(V:vector;dl:integer);
var i :integer;
begin
  for i:=1 to dl do begin
     writeln('--------------------');
     writeln(' ');
     writeln('codigo de la oficina : ' ,v[i].codigo);
     writeln('dni del propietario de la oficina : ', v[i].dni);
     writeln('valor de la expensas de la oficina : ',v[i].expensas:5:2);
     writeln(' ');
     writeln('--------------------');
    
  end;
    
  
end;

procedure insercion(v:vector ; dl:integer);
var i,j:integer; aux:oficina ;

begin

  for i:=2 to dl do begin
    aux:= v[i];
    j:=i-1;
    while (j > 0) and (v[j].codigo > aux.codigo) do begin
      v[j+1]:=v[j];
      j:=j-1;
    end;
    v[j+1]:=aux;
  end;
  writeln ('se imprime el vector ordenado por insercion');
  imprimirVector(V,dl);
end;


procedure seleccion(v:vector;dl:integer);
var i,j,pos:integer; aux:oficina;
begin
  for i:=1 to dl-1 do begin
     pos:=i;
     for j:=i+1 to dl do
       if (v[j].codigo < v[pos].codigo) then
         pos:=j; 
     aux:=v[i];
     v[i]:=v[pos];
     v[pos]:= aux;
   end;
   writeln ('se imprime el vector ordenado por seleccion');
  imprimirVector(V,dl);
end;
var V:vector; dl : integer;
BEGIN
	
	CargarVector(V ,dl);//A)
	imprimirVector(V,dl);
    seleccion(V,dl);//C)
    insercion(V,dl);//B)
    
END.

