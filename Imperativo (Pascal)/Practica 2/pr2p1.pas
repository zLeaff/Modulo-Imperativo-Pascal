program punto1Practica2

type 

vector = array [1..10] of char;

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

if (car <>) and (dimL < 10) then begin
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












