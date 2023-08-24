{1.- Implementar un programa que procese la información de los alumnos de la Facultad de
Informática.
a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de
todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso,
cantidad de materias aprobadas (a lo sumo 36) y nota obtenida (sin contar los aplazos) en cada
una de las materias aprobadas. La lectura finaliza cuando se ingresa el número de alumno
11111, el cual debe procesarse.
b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne número
de alumno y promedio de cada alumno.
c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de
materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?}

program Ej1;
const
	corte = 11111;
	
type
	str30 = string[30];
	nota = 4..10;
	materias_aprobadas = 1..36;
	
	
	//Inciso A
	vector_aprobadas = array[materias_aprobadas] of nota;
	
	alumno = record
		nombre: str30;
		apellido: str30;
		nro_alumno: integer;
		ano_ingreso: integer;
		aprobadas: materias_aprobadas;
		notas: vector_aprobadas;
	end;

	lista_a = ^nodo_a;
	
	nodo_a = record
		elem: alumno;
		sig: lista_a;
	end;
	
	//Inciso B
	alumno_b = record 
		nro_alumno: integer;
		promedio: real;
	end;
	
	lista_b = ^nodo_b;
	
	nodo_b = record
		elem: alumno_b;
		sig: lista_b;
	end;

procedure LeerAlumno(var a: alumno);
var
	n: nota;
	i: materias_aprobadas;
begin
	write('Nombre: '); readln(a.nombre);
	write('Apellido: '); readln(a.apellido);
	write('Nùmero: '); readln(a.nro_alumno);
	write('Año de ingreso: '); readln(a.ano_ingreso);
	write('Materias aprobadas: '); readln(a.aprobadas);
	for i:= 1 to a.aprobadas do begin
		write('Nota ', i, ' de ', a.aprobadas, ': '); readln(n);
		a.notas[i]:= n;
	end;
end;

//Ingresar Adelante ListaInciso A
procedure IngresarAdelanteA(var L: lista_a; a: alumno); 
var
	aux: lista_a;
begin
	new(aux);
	aux^.elem:= a;
	aux^.sig:= L;
	L:= aux;
end;

//Ingresar Adelante ListaInciso B
procedure IngresarAdelanteB(var L: lista_b; a: alumno_b); 
var
	aux: lista_b;
begin
	new(aux);
	aux^.elem:= a;
	aux^.sig:= L;
	L:= aux;
end;

//Cargar Lista (A)
procedure CargarLista(var L: lista_a);
var
	a: alumno;
begin
	L:= nil;
	repeat
		LeerAlumno(a);
		IngresarAdelanteA(L, a);
	until (a.nro_alumno = corte);
end;

//Calculo de promedio
function Promediar(v: vector_aprobadas; dimL: materias_aprobadas): real;
var
	i: materias_aprobadas;
	total: integer;
begin
	total:= 0;
	for i:= 1 to dimL do
		total:= total + v[i];
	
	Promediar:= total/dimL;
end;


//Cargar segunda lista (INC B)
procedure CargarSegunddaLista(var K: lista_b; L: lista_a);
var
	a: alumno_b;
	dimL: materias_aprobadas;
begin
	K:= nil;
	while L <> nil do begin
		dimL:= L^.elem.aprobadas;
		a.nro_alumno:= L^.elem.nro_alumno;
		a.promedio:= Promediar(L^.elem.notas, dimL);
		IngresarAdelanteB(K, a);
		L:= L^.sig;
	end;
end;

var
	L: lista_a;
	K: lista_b;
	i: integer;
begin
	i:= 1;
	CargarLista(L);
	CargarSegunddaLista(K, L);
	
	//Prueba
	while K <> nil do begin
		writeln('Alumno nro: ', i);
		writeln('Numero de alumno: ', K^.elem.nro_alumno);
		writeln('Promedio del alumno: ', K^.elem.promedio:1:2);
		i:= i+1;
		K:= K^.sig;
	end;
end.

{
c)
Si no se sabe de antemano la cantidad de materias aprobadas y ademas se desea registrar cada aplazo
se modificaria el subrango notas:4..10 a notas:1..10 y se eliminaria el campo de aprobadas en alumno,
lo que lleva a registrar las 36 notas de cada alumno (o se leeria la cantidad de materias del alumno
con sus respectivas notas, indiferentemente si es aplazo o no)
}



