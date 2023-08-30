program pr2p2;

type

lista = ^nodo;

nodo = record
	dato: integer;
	sig: lista;
end;

function descomponer (var n: integer): integer;
var
digito: integer;

begin


	if (n <> 0) then begin
		descomponer(n);
		digito:= n mod 10;
		n:= n div 10;
		
		descomponer:=digito;
	end;
end;

{Procedimiento para armar la lista}
procedure cargarLista (var l: lista);
var
digito, n:integer;
nuevo: lista; 


begin

writeln('ingrese un numero');
readln(n);


if (n <> 0) then begin 
	digito:= descomponer(n);
	cargarLista(l);
	new (nuevo);
         nuevo^.dato:= digito;
         nuevo^.sig:= l;
         l:= nuevo;
       end
  else l:= nil
end;


procedure imprimirLista (L: lista);
begin

if (L <> nil) then begin
	writeln('----');
	write (l^.dato);
	writeln('----');
    imprimirLista (l^.sig);
    
end;
end;

var 
L: lista;


begin
cargarLista(L);
imprimirLista(L);
end.


