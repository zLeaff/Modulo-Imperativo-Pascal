{3. Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y los almacene en
una estructura de datos. De cada alumno se lee legajo, DNI, año de ingreso y los códigos y
notas de los finales rendidos. La estructura generada debe ser eficiente para la búsqueda por
número de legajo. La lectura de los alumnos finaliza con legajo 0 y para cada alumno el ingreso
de las materias finaliza con el código de materia -1.
b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso de
aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande.
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
f. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.
g. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program Ej3;
const
  corte_legajo = 0;
  corte_materia = -1;

type
  rango_nota = 1..10;

  finales = record
    codigo: integer;
    nota: rango_nota;
  end;

  lista_notas = ^nodo_notas;

  nodo_notas = record
    elem: finales;
    sig: lista_notas;
  end;

  alumno = record
    legajo: integer;
    dni: integer;
    anho_ingreso: integer;
    notas: lista_notas;
    end;

    arbol = ^nodo;

    nodo = record
      elem: alumno;
      HI: arbol;
      HD: arbol;
    end;

{a. Un módulo que lea información de alumnos de Taller de Programación y los almacene en
una estructura de datos. De cada alumno se lee legajo, DNI, año de ingreso y los códigos y
notas de los finales rendidos. La estructura generada debe ser eficiente para la búsqueda por
número de legajo. La lectura de los alumnos finaliza con legajo 0 y para cada alumno el ingreso
de las materias finaliza con el código de materia -1.}
procedure GenerarArbol(var a: arbol);
  
  procedure LeerAlumno(var a: alumno);
    
    procedure AgregarAdelante(var L: lista_notas; f: finales);
    var
      aux: lista_notas;
    begin
      new(aux);
      aux^.elem:= f;
      aux^.sig:= L;
      L:= aux;
    end;
    
    procedure CargarFinales(var L: lista_notas);
    var
      f: finales;
    begin
      write('Codigo de examen: '); readln(f.codigo);
      if (f.codigo <> corte_materia) then begin
        write('Nota del examen: '); readln(f.nota);
        AgregarAdelante(L, f);
        CargarFinales(L^.sig);
      end;
    end;
  
  begin
    write('Numero de legajo: '); readln(a.legajo);
    if (a.legajo <> corte_legajo) then begin
      write('Dni: '); readln(a.dni);
      write('Año de ingreso: '); readln(a.anho_ingreso);
      writeln('--Carga de notas del alumno--');
      a.notas:= nil;
      CargarFinales(a.notas);
    end;
  end;
  ////
  ////
  procedure InsertarNodoArbol(var a: arbol; alu: alumno);
  begin
    if (a = nil) then begin
      new(a);
      a^.elem:= alu;
      a^.HI:= nil;
      a^.HD:= nil;
    end
    else begin
      if(alu.legajo < a^.elem.legajo) then
        InsertarNodoArbol(a^.HI, alu)
      else
        InsertarNodoArbol(a^.HD, alu)
    end;
  end;

var
  alu: alumno;
begin
  a:= nil;
  LeerAlumno(alu);
  while (alu.legajo <> corte_legajo) do begin
    InsertarNodoArbol(a, alu);
    LeerAlumno(alu);
  end;
end;

{b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso de
aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.}
procedure InformarDni(a: arbol);

  procedure RecorrerArbol(a: arbol; legajo: integer);
  begin
    if (a <> nil) then begin
      if (a^.elem.legajo < legajo) then 
        writeln('DNI: ', a^.elem.dni, ' Año de ingreso: ', a^.elem.anho_ingreso);
      RecorrerArbol(a^.HI, legajo);
      if (a^.elem.legajo < legajo) then
        RecorrerArbol(a^.HD, legajo);
    end;
  end;

var
  legajo: integer;
begin
  writeln('----- Buscar alumnos menor al legajo ingresado -----');
  write('Ingrese legajo limite: '); readln(legajo);
  if (a = nil) then
    writeln('Arbol vacio.')
  else
    RecorrerArbol(a, legajo);
  
  writeln;
end;

{c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande.}
procedure InformarLegajoMax(a: arbol);

  function Maximo(a: arbol): integer;
  begin
    if (a = nil)then
      Maximo:= 0
    else if (a^.HD = nil) then
      Maximo:= a^.elem.legajo
    else
      Maximo:= Maximo(a^.HD);
  end;

begin
  writeln('----- Legajo mas grande -----');
  if (Maximo(a) = 0) then
    writeln('Arbol vacio.')
  else
    writeln('El legajo mas grande es ', Maximo(a));
  writeln;
end;

{d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.}
procedure InformarDNIMax(a: arbol);

  procedure ActualizarMaximo(var dni_max: integer; dni_nuevo: integer);
  begin
    if (dni_nuevo >= dni_max) then
      dni_max:= dni_nuevo
  end;

  procedure RecorrerActualizar(a: arbol; var dni_max: integer);
  begin
    if (a <> nil) then begin
      ActualizarMaximo(dni_max, a^.elem.dni);
      RecorrerActualizar(a^.HI, dni_max);
      RecorrerActualizar(a^.HD, dni_max);
    end;
  end;

var
  dni_max: integer;
begin
  dni_max:= -1;
  writeln('----- Dni mas grande -----');
  RecorrerActualizar(a, dni_max);
  if (dni_max = -1) then
    writeln('Arbol vacio.')
  else
    writeln('Dni mas grande: ', dni_max);
    writeln;
end;

{e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.}
procedure InformarLegajosImpar(a: arbol);

  function EsImpar(legajo: integer): boolean;
  begin
    EsImpar:= (legajo MOD 2 <> 0);
  end;

  function CalcularImpares(a: arbol): integer;
  begin
    if (a = nil) then
      CalcularImpares:= 0
    else begin 
      if (EsImpar(a^.elem.legajo)) then
        CalcularImpares:= 1 + CalcularImpares(a^.HI) + CalcularImpares(a^.HD)
      else
        CalcularImpares:= CalcularImpares(a^.HI) + CalcularImpares(a^.HD);
    end;
  end;
var
  impares: integer;
begin
  writeln('----- Cantidad de legajos impares -----');
  impares:= CalcularImpares(a);
  if (impares = 0) then
    writeln('El arbol esta vacio o no existen legajos impares.')
  else
    writeln('Cantidad de legajos impares: ', impares);
    writeln;
end;

{e. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.}
procedure InformarLegajoPromedio(a: arbol);

  procedure CalcularFinales(L: lista_notas; var notas: integer; var materias: integer);
  begin
    if (L <> nil) then begin
      notas:= notas + L^.elem.nota;
      materias:= materias + 1;
      CalcularFinales(L^.sig, notas, materias);
    end;
  end;

  function Promedio(notas: integer; materias: integer): real;
  begin
    Promedio:= notas / materias;
  end;

  procedure ActualizarMaximo(var promedio_max: real; promedio_actual: real; var legajo_max: integer; legajo_actual: integer);
  begin
    if (promedio_actual > promedio_max) then begin
      promedio_max:= promedio_actual;
      legajo_max:= legajo_actual;
    end;
  end;

  procedure Procesar(a: arbol; var promedio_max: real; var legajo_max: integer);
  var
    notas, materias: integer;
  begin
    notas:= 0;
    materias:= 0;
    if (a <> nil) then begin
      CalcularFinales(a^.elem.notas, notas, materias);
      ActualizarMaximo(promedio_max, Promedio(notas, materias), legajo_max, a^.elem.legajo);
      Procesar(a^.HI, promedio_max, legajo_max);
      Procesar(a^.HD, promedio_max, legajo_max);
    end;
  end;

var
  promedio_max: real;
  legajo_max: integer;
begin
  writeln('----- Datos del alumno con mejor promedio -----');
  if (a = nil) then
    writeln('Arbol vacio.')
  else begin
    Procesar(a, promedio_max, legajo_max);
    writeln('Legajo: ', legajo_max, '. Promedio: ', promedio_max:1:2);
  end;
  writeln;
end;

{f. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}
procedure InformarDestacados(a: arbol; n: integer);

  procedure CalcularFinales(L: lista_notas; var notas: integer; var materias: integer);
  begin
    if (L <> nil) then begin
      notas:= notas + L^.elem.nota;
      materias:= materias + 1;
      CalcularFinales(L^.sig, notas, materias);
    end;
  end;

  function Promedio(notas: integer; materias: integer): real;
  begin
    Promedio:= notas / materias;
  end;

  procedure Procesar(a: arbol; n: integer);
  var
    notas, materias: integer;
    prom: real;
  begin
    notas:= 0;
    materias:= 0;
    if (a <> nil) then begin
      CalcularFinales(a^.elem.notas, notas, materias);
      prom:= Promedio(notas, materias);
      if (prom > n) then
        writeln('Legajo: ', a^.elem.legajo, '. Promedio: ', prom:1:2);
      Procesar(a^.HI, n);
      Procesar(a^.HD, n);
    end;
  end;

begin
  writeln('----- Alumnos que superan el promedio de ', n, ' -----');
  writeln;
  if(a = nil) then
    writeln('Arbol vacio.')
  else
    Procesar(a, n);
end;

var
  a: arbol;
  n: integer;
begin
  GenerarArbol(a);
  InformarDni(a);
  InformarLegajoMax(a);
  InformarDniMax(a);
  InformarLegajosImpar(a);
  InformarLegajoPromedio(a);

  write('Ingrese un valor para evaluar los promedios por encima de ese valor: ');
  readln(n);
  InformarDestacados(a, n);
end.
