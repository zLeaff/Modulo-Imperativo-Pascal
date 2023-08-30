{
   tp2puntop3.pas
   
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

 Lista = ^nodo ;
 
 nodo = record
   elem:integer;
   sig:Lista;
  end;
  
procedure CargarLista(var L: Lista);
var nue:Lista; x:integer;

begin
   Randomize;
   x:=random(11); 
   if (x <> 0 ) then begin
     CargarLista(L);
     new(nue) ; nue^.sig:=L; L:=nue;
     nue^.elem:= x;
   end;
end;


procedure LeerListaRecursiva1(L:Lista);
  
begin
  if (L<>nil)then begin
    writeln('/',L^.elem,'/');
    L:=L^.sig;
    LeerListaRecursiva1(L);
  end
  else writeln('final de la lista recursiva 1');
end;


procedure Maximo(L:Lista ;VAR m:integer);

begin
  if (L<>nil)then begin
    if(m< L^.elem)then
      m:=L^.elem;
    L:=L^.sig;
    Maximo(L,m);
  end;
end;

procedure Minimo(L:Lista ;VAR n:integer);

begin
  if (L<>nil)then begin
    if(n> L^.elem)then
      n:=L^.elem;
    L:=L^.sig;
    Minimo (L,n);
  end;
end;

procedure VoF (L:Lista;p:integer;var x:boolean);
begin
  if (L<>nil) and (x <> true )then
    if(p = L^.elem)then
      x:= true ;
    L:=L^.sig;
    VoF(L,p,x);
end;

var L:Lista;m,n,p:integer;x:boolean;

BEGIN

  CargarLista(L);
  //cLista(L);
  LeerListaRecursiva1(L);
  m:=-1;
  Maximo(L,m);
  writeln('el numero maximo de la lista es : ', m);
  n:=111;
  Minimo(L,n);
  writeln('el numero minimo de la lista es : ', n);
  writeln('ingrese el valor que desea buscar en la lista');
  readln(p);
  x:=false;
  VoF(L,p,x);
  if(x = true)then
    writeln('el elemento se encuentra en la lista')
  else 
    writeln('el elemento no se encuentra en la lista');
END.

