{3. Una facultad nos ha encargado procesar la información de sus alumnos de la carrera XXX.
Esta carrera tiene 30 materias. Implementar un programa con:
a. Un módulo que lea la información de los finales rendidos por los alumnos y los
almacene en dos estructuras de datos.
i. Una estructura que para cada alumno se almacenen sólo código y nota de las
materias aprobadas (4 a 10). De cada final rendido se lee el código del alumno, el
código de materia y la nota (valor entre 1 y 10). La lectura de los finales finaliza con
nota -1. 
La estructura debe ser eficiente para buscar por código de alumno.
ii. Otra estructura que almacene para cada materia, su código y todos los finales
rendidos en esa materia (código de alumno y nota).
b. Un módulo que reciba la estructura generada en i. y un código de alumno y retorne los
códigos y promedios de los alumnos cuyos códigos sean mayor al ingresado.
c. Un módulo que reciba la estructura generada en i., dos códigos de alumnos y un valor
entero, y retorne la cantidad de alumnos con cantidad de finales aprobados igual al
valor ingresado para aquellos alumnos cuyos códigos están comprendidos entre los dos
códigos de alumnos ingresados.}

program Ej3;
const
  corte_nota = -1;
  dimF = 30;

type
  rango_materias = 1..dimF;
  rango_notas = -1..10;
  rango_aprobadas = 4..10;
  
  final = record
    codigo_alu: integer;
    codigo_mat: rango_materias;
    nota: rango_notas;
  end;
  
  lista_finales = ^nodo_finales;

  nodo_finales = record
    elem: final;
    sig: lista_finales;
  end;

  vector_finales = array[rango_materias] of lista_finales;
  
  aprobadas = record
    codigo_mat: rango_materias;
    nota: rango_aprobadas;
  end;
  
  lista = ^nodo;
  
  nodo = record
    elem: aprobadas;
    sig: lista;
  end;

  alumno = record
    codigo_alu: integer;
    notas: lista;
  end;
  
  arbol = ^nodo_arbol;

  nodo_arbol = record
    elem: alumno;
    HI: arbol;
    HD: arbol;
  end;

procedure GenerarEstructuras(var a: arbol; var v: vector_finales);
  
  procedure LeerFinal(var f: final);
  begin
    // Simulamos la lectura de finales con valores aleatorios
    write('Codigo del alumno: '); readln(f.codigo_alu);
    write('Codigo de la materia: '); readln(f.codigo_mat);
    write('Nota del examen final: '); readln(f.nota);
  end;

  procedure AgregarAprobada(var L: lista; a: aprobadas);
  var
    aux: lista;
  begin
    new(aux);
    aux^.elem := a;
    aux^.sig := L;
    L := aux;
  end;

  procedure AgregarFinal(var L: lista_finales; f: final);
  var
    aux: lista_finales;
  begin
    new(aux);
    aux^.elem := f;
    aux^.sig := L;
    L := aux;
  end;

  procedure InsertarElemento(var a: arbol; var alu: alumno; ap: aprobadas);  
  begin
    if (a = nil) then begin
      new(a);
      alu.notas := nil;
      a^.elem := alu;
      a^.HI := nil;
      a^.HD := nil;
    end
    else if (alu.codigo_alu < a^.elem.codigo_alu) then
      InsertarElemento(a^.HI, alu, ap)
    else if (alu.codigo_alu > a^.elem.codigo_alu) then
      InsertarElemento(a^.HD, alu, ap)
    else
      AgregarAprobada(a^.elem.notas, ap);
  end;

var
  f: final;
  ap: aprobadas;
  alu: alumno;
  i: integer;
begin
  writeln('--- Armado de estructuras ---');
  for i := 1 to dimF do
    v[i] := nil;
  

  repeat
    LeerFinal(f);
    if (f.nota <> corte_nota) then begin
      // Si el final está aprobado (>4), se agrega a la lista
      if (f.nota >= 4) then begin
        ap.codigo_mat := f.codigo_mat;
        ap.nota := f.nota;
        AgregarAprobada(alu.notas, ap);
      end;
      alu.codigo_alu := f.codigo_alu;
      // Se agrega al final al vector de finales
      AgregarFinal(v[f.codigo_mat], f);
      // Se inserta en el árbol
      InsertarElemento(a, alu, ap);
      writeln;
    end;
  until (f.nota = corte_nota);
end;

procedure InformarCodigosPromedios(a: arbol; c: integer);

  function TotalMaterias(L: lista): integer;
  begin
    if (L = nil) then
      TotalMaterias:= 0
    else
      TotalMaterias:= 1 + TotalMaterias(L^.sig);
  end;

  function TotalNota(L: lista): integer;
  begin
    if (L = nil) then
      TotalNota:= 0
    else
      TotalNota:= L^.elem.nota + TotalNota(L^.sig);
  end;

  function Promedio(materias, notas: integer): real;
  begin
    Promedio:= notas / materias;
  end;

  procedure Procesar(a: arbol; c: integer);
  var
    notas: lista;
  begin
    if (a <> nil) then
    begin
      // Continuar por la izquierda
      if (a^.elem.codigo_alu > c) then
        Procesar(a^.HI, c);
      // Imprimir si el código del alumno es mayor a c y tiene notas
      if (a^.elem.codigo_alu > c) and (a^.elem.notas <> nil) then 
      begin
        notas:= a^.elem.notas;
        writeln('Alumno ', a^.elem.codigo_alu, '. Promedio ', Promedio(TotalMaterias(notas), TotalNota(notas)):2:2);
      end;
      // Continuar por la derecha
      Procesar(a^.HD, c);
    end;
  end;

{c. Un módulo que reciba la estructura generada en i., dos códigos de alumnos y un valor
entero, y retorne la cantidad de alumnos con cantidad de finales aprobados igual al
valor ingresado para aquellos alumnos cuyos códigos están comprendidos entre los dos
códigos de alumnos ingresados.}

//FALTA IMPLEMENTAR


begin
  writeln('--- Codigo y promedio de alumnos mayor a ', c,' ---');
  writeln;
  if (a = nil) then
    writeln('No existen codigos mayores al ingresado o el arbol esta vacio.')
  else
    Procesar(a, c);
end;

var
  a: arbol;
  v: vector_finales;
  i: integer;
begin
  a := nil; // Inicializar el árbol como vacío
  GenerarEstructuras(a, v);

  write('Ingrese codigo de alumno para evaluar: '); readln(i);
  InformarCodigosPromedios(a, i);
end.

