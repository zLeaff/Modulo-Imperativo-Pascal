{1.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto, los
almacene en un vector con dimensión física igual a 10 y retorne el vector.
b. Un módulo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector..
d. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.
e. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne una lista con los caracteres leídos.
f. Un módulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en el
mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en e) e imprima los valores de
la lista en orden inverso al que están almacenados.}

program Ej1;
const
	dimF = 10;
type
	rango = 1..dimF
	vector = array [rango] of char;

	listaCar = ^nodo;

	nodo = record
		dato: char;
		sig: listaCar;
	end;

procedure cargarVector (var v: vector; var dimL: integer);
var 
	car : char;
begin
	writeln('Ingrese el caracter');
	readln(car);

	if (car <>) and (dimL < dimF) then begin
		dimL:= dimL + 1;
		v[dimL] := car;
		cargarVector(v, dimL);
	end;
end;

procedure iniciarCarga (var v: vector; var dimL: integer);
begin
	dimL:= 0;
	cargarVector(v, dimL);
end;

procedure imprimirVector(v: vector, dimL: integer);
begin
	if (dimL > 0) then begin
		imprimirVector(v, dimL -1);
		writeln(v[dimL]);
	end;
end;












