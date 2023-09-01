program practica2Punto3;

{3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.
}

type 

lista = ^nodo;

nodo = record
	dato: integer;
	sig: lista;
end;


procedure CargarLista(var l: lista);
var
	nue: lista;
	num: integer;
begin
	Randomize;
	num:= random(11);
	if (num <> 0) then begin
		cargarLista(l);
		new (nue);
    nue^.dato:= num;
    nue^.sig:= l;
    l:= nue;
  end
	else l:= nil
end;

procedure ImprimirListaMismoOrden(l: lista);
begin
  if (l<> nil) then begin
    writeln (' ', l^.dato);
    ImprimirListaMismoOrden (l^.sig);
  end;
end;


procedure Minimo(l: lista; var min: integer);


begin
	if (l <> nil) then begin
		if (l^.dato > min) then
			min:= l^.dato;
		l:= l^.sig;
		minimo(l, min);
		end;
	end;

procedure Maximo(l: lista; var max: integer);

begin
	if (l <> nil) then begin
		if (l^.dato < max) then 
			max := l^.dato;
		l:= l^.sig;
		Maximo(l, max);
	end;
end; 


procedure VerdaderoFalso(l: lista; preg: integer;  var TF: boolean);

begin
	if (l <> nil) and (TF <> true) then begin
		if (preg = l^.dato) then 
			TF:= true;
		l:= l^.sig;
		VerdaderoFalso(l, preg, TF);
	end;
end;

var
min, max, preg: integer;
res: boolean;
l: lista;

begin
	
	CargarLista(l);
	ImprimirListaMismoOrden(l);
	min:= -1;
	max:= 999;
	res:= false;
	Minimo(l, min);
	writeln('El numero minimo de la lista es : ', min);
	writeln('-------');
	Maximo(l, max);
	writeln('El numero maximo de la lista es : ', max);
	writeln('------');
	writeln('Ingrese el numero que quiere saber si esta en la lista');
	readln(preg);
	VerdaderoFalso(l, preg, res);
	writeln('------');
	if (res = true) then
		writeln('El numero buscado esta en la lista')
	else
		writeln('El numero buscado no esta en la lista');
	end.










