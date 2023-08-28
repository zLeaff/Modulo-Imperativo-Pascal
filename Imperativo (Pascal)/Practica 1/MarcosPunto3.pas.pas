{
   p2punto3.pas
   
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
 rango= 1..8;
 
 pelicula = record 
   codigo:integer;
   genero:rango;
   puntaje:real;
 end;
 
 Lista =^nodo;
 nodo = record
   elem:pelicula;
   sig:Lista;
 end;
 
 vector = array [1..8] of Lista ;
 vectorMax = array [1..8] of pelicula ;

procedure cargarPelicula (var p:pelicula);
begin
  writeln('----------------------------------------------------------');
  writeln('cargar codigo de la pelicula');
  readln(p.codigo);
  if(p.codigo <>-1)then begin
    writeln('cargar genero de la pelicula');
    readln(p.genero);
    writeln('cargar puntaje de la pelicula');
    readln(p.puntaje);
  end;
end; 


procedure cargarLista (var L:Lista; p:pelicula);
var nue:Lista;
begin
  new(nue);
  nue^.elem:=p;
  nue^.sig:=L;
  L:=nue;
end;
procedure cargarVector(var v:vector);
var p:pelicula;

begin
  writeln ('comience a cargar las peliculas');
  cargarPelicula(p);
  while (p.codigo <> -1) do begin
    cargarLista(v[p.genero],p);
    cargarPelicula(p);
  end;
  writeln('se ha finalizado la lista de peliculas'); 
end;

function buscarMaximo (L:lista):pelicula;
var MAX:real;P:pelicula;

begin
  max:=0;
  while (L<> nil) do begin
    if (MAX < L^.elem.puntaje) then begin
      MAX:=L^.elem.puntaje;
      P:=L^.elem;
    end;
    L:=L^.sig;
  end; 
  buscarMaximo:= P;
end;


procedure cargarVectorMaximos (var M:vectorMax ; V:vector);
var
  i:INTEGER;maximo:pelicula;
begin
  for i:=1 to 8 do begin
    maximo:=buscarMaximo(V[i]);
    M[i]:=maximo;
  end;
end;


procedure imprimirVector(v:vector);
var i:integer;
begin
  for i:=1 to 8 do begin
    writeln('///////////////////////////////////////////');
    writeln('se imprimiran las peliculas del genero ', i);
    writeln('///////////////////////////////////////////');
    while (v[i] <> nil)do begin
      writeln('-------------------------------');
      writeln('');
      writeln('el codigo de la pelicula es : ' ,v[i]^.elem.codigo);
      writeln('');
      writeln('el puntaje de la pelicula es  : ',v[i]^.elem.puntaje:2:2);
      v[i]:=v[i]^.sig;
      writeln('');
      writeln('-------------------------------');    
    end; 
    
    
  end; 

end;

procedure imprimirVM (M:vectorMax);
var i: integer;

begin
  writeln('--------------------------------------------');
  for i:=1 to 8 do begin
    writeln('');
    writeln('el codigo de la pelicula con el puntaje mas alto del ');
    writeln('genero ', i ,' es ', M[i].codigo);
    writeln('');
    writeln('--------------------------------------------');
  end;
end;

procedure insercion (var M:vectorMax ; dl:integer);
var i,j:integer;aux:pelicula  ;

begin 
  for i:=2 to dl do begin
    aux :=M[I];
    j:=i-1;
    while (j>0) and (M[j].puntaje > aux.puntaje) do begin
      M[j+1]:=M[j];
      j:=j-1;
    end;
    M[J+1]:=aux;
   end;
end;

PROCEDURE imprimirMaxMin(M:vectorMax);
  
begin
  writeln('');
  writeln('el codigo de la pelicula con el puntaje mas alto es : ', M[8].codigo);
  writeln('');
  writeln('el codigo de la pelicula con el puntaje mas bajo es : ',M[1].codigo);
end;

 
var v:vector; M:vectorMax;

BEGIN
  
  cargarVector(v);//A)
  imprimirVector(v);
  cargarVectorMaximos(M , v);//B)
  imprimirVM(M);
  insercion(M,8);//C)
  imprimirMaxMin(M);//D)
END.
