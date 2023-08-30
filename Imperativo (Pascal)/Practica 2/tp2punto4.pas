program practica2punto4;

{Escribir un programa con:
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
menores a 100.
b. Un módulo recursivo que devuelva el máximo valor del vector.
c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector
}

const

df= 20;

type

vectorNum = array [1..df] of integer;

procedure cargarVector (var v: vectorNum; i: integer);

var 
n: integer;

begin

	n:= random(100);
	if (i <> df) then begin
		i:=i+1;
		v[i]:=n;
		cargarVector(v, i);
		
	end;
end;


procedure imprimir (v: vectorNum);
var i: integer;

begin

for i:= 1 to df do 
	writeln(v[i]);
end;


procedure valorMaximo (vec: vectorNum; var max: integer; i: integer);

begin

	if (i <> df) then begin
		i:= i + 1;
		
		if (vec[i] > max) then
			max:= vec[i];
		
		valorMaximo(vec, max, i); 
	end;
	
end;

procedure sumaTotal (vec: vectorNum; var res: integer; i: integer); 

begin
	if (i <> df) then begin
		i:= i + 1;
		res:= res + vec[i];
		sumaTotal(vec, res, i);
	end;
end;
	

var
v: vectorNum;
i, max, res: integer;

begin
i:= 0;
max:=-1;
res:= 0;


cargarVector(v, i);
imprimir(v);

valorMaximo(v, max, i);
writeln('El valor maximo en el vector es :' , max);

writeln('----------');

sumaTotal(v, res, i);

writeln('El resultado de sumar todos los elementos del vector es :' , res);

end.
