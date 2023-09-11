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
  
  //
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
  
  //
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
      //Random para agilizar la carga
      write('Codigo del alumno: '); f.codigo_alu:= 1 + Random(30);writeln(f.codigo_alu);
      write('Codigo de la materia: '); f.codigo_mat:= 1 + Random(30); writeln(f.codigo_mat);
      write('Nota del examen final: '); readln(f.nota);
    end;

    procedure AgregarAprobada(var L: lista; a: aprobadas);
      var
        aux: lista;
      begin
        new(aux);
        aux^.elem:= a;
        aux^.sig:= L;
        L:= aux;
      end;

    procedure Procesar(var alu: alumno; var v: vector_finales; var a: aprobadas; f: final);
      
      procedure AgregarFinal(var L: lista_finales; f: final);
      var
        aux: lista_finales;
      begin
        new(aux);
        aux^.elem:= f;
        aux^.sig:= L;
        L:= aux;
      end;
      
    begin
      writeln;
      if (f.nota <> corte_nota) then begin
        //Si el final esta aprobado (>4), se agrega a la lista
        if (f.nota >= 4) then begin
          a.codigo_mat:= f.codigo_mat;
          a.nota:= f.nota;
          if (alu.notas <> nil) then
            AgregarAprobada(alu.notas, a)
          else begin
            alu.notas:= nil;
            AgregarAprobada(alu.notas, a);
          end;
        end;
      
        //Se agrega al final al vector de finales
        AgregarFinal(v[f.codigo_mat], f);
        writeln;
      end;
    end;
    
    procedure InsertarElemento(var a: arbol; alu: alumno; ap: aprobadas);  
    begin
      if(a = nil) then begin
        new(a);
        a^.elem:= alu;
        a^.elem.notas:= nil;
        a^.HI:= nil;
        a^.HD:= nil;
      end
      else if (a^.elem.codigo_alu = alu.codigo_alu) then
        AgregarAprobada(a^.elem.notas, ap)
      else if (alu.codigo_alu < a^.elem.codigo_alu) then
        InsertarElemento(a^.HI, alu, ap)
      else
        InsertarElemento(a^.HD, alu, ap);
    end;

var
  i: integer;
  f: final;
  ap: aprobadas;
  alu: alumno;
begin
  writeln('--- Armado de estructuras ---');
  for i:=1 to dimF do
    v[i]:= nil;
  
  writeln;
  LeerFinal(f);
  writeln();
  while(f.nota <> corte_nota) do begin
    Procesar(alu, v, ap, f);
    InsertarElemento(a, alu, ap);
    LeerFinal(f);
    writeln;
  end;
end;

procedure ImprimirListaFinales(L: lista_finales);
begin
  while L <> nil do begin
    writeln('Materia: ', L^.elem.codigo_mat, ' Nota: ', 
    L^.elem.nota);
    L:= L^.sig;
  end;
end;

procedure ImprimirAlumno(a: alumno);
var
  temp: lista;
begin
  writeln('Alumno ', a.codigo_alu);
  temp:= a.notas;
  while (a.notas <> nil) do begin
    writeln('Nota: ', temp^.elem.nota);
    temp:= temp^.sig;
  end;
end;

procedure ImprimirArbol(a: arbol);
begin
	if (a <> nil) then begin
		ImprimirArbol(a^.HI);
		ImprimirAlumno(a^.elem);
		ImprimirArbol(a^.HD);
	end;
end;



var
  a: arbol;
  v: vector_finales;
  i: integer;
begin
  GenerarEstructuras(a, v);
  {ImprimirArbol(a);}

  for i:= 1 to dimF do
    ImprimirListaFinales(v[i]);
end.
