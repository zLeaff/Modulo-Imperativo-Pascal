{Escribir un programa con:
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
menores a 100.
b. Un módulo recursivo que devuelva el máximo valor del vector.
c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector
}
program practica2punto4;
const
	dimF= 20;

type
	vectorNum = array [1..dimF] of integer;

procedure CargarVector(var v: vectorNum; i: integer);
var
	n: integer;
begin
	n:= random(100);
	if (i <> dimF) then begin
		i:=i+1;
		v[i]:=n;
		CargarVector(v, i);		
	end;
end;


procedure Imprimir(v: vectorNum);
var 
	i: integer;
begin
	for i:= 1 to dimF do 
		writeln(v[i]);
end;

procedure ValorMaximo(vec: vectorNum; var max: integer; i: integer);
begin
	if (i <> dimF) then begin
		i:= i + 1;
		
		if (vec[i] > max) then
			max:= vec[i];
		
		ValorMaximo(vec, max, i); 
	end;	
end;

procedure SumaTotal(vec: vectorNum; var res: integer; i: integer); 
begin
	if (i <> dimF) then begin
		i:= i + 1;
		res:= res + vec[i];
		SumaTotal(vec, res, i);
	end;
end;


var
	v: vectorNum;
	i, max, res: integer;
begin
	i:= 0;
	max:=-1;
	res:= 0;


	CargarVector(v, i);
	Imprimir(v);

	ValorMaximo(v, max, i);
	writeln('El valor maximo en el vector es :' , max);

	writeln('----------');

	SumaTotal(v, res, i);

	writeln('El resultado de sumar todos los elementos del vector es :' , res);

end.
