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
e. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.
f. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
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

    arbol = ^nodo

    nodo = record
      elem: alumno;
      HI: arbol;
      HD: arbol;
    end;

procedure CargarArbol(a: arbol);

  procedure LeerFinales(var f: finales);
  begin
  end;

  procedure CargarFinales(var L: lista_notas);
  var
    f: finales;
  begin
    writeln('Codigo de examen: '); readln(f.codigo);
    if (f.codigo <> corte_materia) then begin
      writeln('Nota de examen: '); readln(f.nota);
      AgregarAdelante(L, f);
      CargarFinales(L);
  end;

  procedure AgregarAdelante(var L: lista_notas, f: finales);
  var
    aux: lista_notas;
  begin
    new(aux);
    aux^.elem:= f;
    aux^.sig:= L;
    L:= aux;
  end;
  