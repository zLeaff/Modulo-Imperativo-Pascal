{2.- Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número
leído, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo
recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe
imprimir 2 5 6}
program Ej2;

procedure Dividendo(n: integer; var d: integer);
begin	
	if n >= d*10 then begin
		d:= d*10;
		Dividendo(n, d);
	end;
end;

procedure Descomponer(var n: integer; var d: integer);
var
	digito: integer;
begin
	if (d <> 0) then begin
		digito:= n DIV d;
		n:= n - (digito * d);
		d:= d DIV 10;
		write(digito, ' ');		
		Descomponer(n, d);
	end;
end;

procedure LeerNumero(var n: integer);
var
	d: integer;
begin
	write('Ingrese un numero: '); readln(n);
	if (n <> 0) then begin
		d:= 1;
		Dividendo(n, d);
		Descomponer(n, d);
		writeln('');
		LeerNumero(n);
	end;
end;

var
	n: integer;
begin
	LeerNumero(n);
end.


