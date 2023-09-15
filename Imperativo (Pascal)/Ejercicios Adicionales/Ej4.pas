{4. Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
reclamos efectuados por ese DNI.
c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
los reclamos realizados en el año recibido.}

Program Ej4;
const
  corte = -1;

type
  rango_tipo = 1..5;

  reclamo = record
    codigo: integer;
    dni: integer;
    anho: integer;
    tipo: rango_tipo;
  end;

  lista_reclamos = ^nodo_reclamos;

  nodo_reclamos = record
    elem: reclamo;
    sig: lista_reclamos;
  end;

  nodo = record
    dni: integer;
    reclamos: lista_reclamos;
    cantidad: integer;
  end;

  arbol_reclamo = ^nodo_arbol;

  nodo_arbol = record
    elem: nodo;
    HI: arbol_reclamo;
    HD: arbol_reclamo;
  end;

procedure ArmarArbol(var a: arbol_reclamo);
  
  procedure LeerReclamo(var r: reclamo);
  begin
    write('Codigo del reclamo: '); readln(r.codigo);
    if (r.codigo <> corte) then begin
      write('DNI del usuario: '); readln(r.dni);
      write('Año de reclamo: '); readln(r.anho);
      write('Tipo de reclamo(1-5): '); readln(r.tipo);
    end;
  end;

  procedure AgregarAdelante(var L: lista_reclamos; r: reclamo);
  var
    aux: lista_reclamos;
  begin
    new(aux);
    aux^.elem:= r;
    aux^.sig:= L;
    L:= aux;
  end;

  procedure InsertarElemento(var a: arbol_reclamo; n: nodo; r: reclamo);
  begin
    if (a = nil) then begin
      new(a);
      n.reclamos:= nil;
      a^.elem:= n;
      a^.HI:= nil;
      a^.HD:= nil;
    end
    else begin
      if(n.dni = a^.elem.dni) then begin
        a^.elem.cantidad:= a^.elem.cantidad + 1;
        AgregarAdelante(a^.elem.reclamos, r);
      end
      else if (n.dni < a^.elem.dni) then
        InsertarElemento(a^.HI, n, r)
      else
        InsertarElemento(a^.HD, n, r)
    end;
  end;

var
  r: reclamo;
  n: nodo;
begin
  writeln('--- Armado de arbol ---');
  a:= nil;
  LeerReclamo(r);
  while (r.codigo <> corte) do begin
    n.dni:= r.dni;
    InsertarElemento(a, n, r);
    LeerReclamo(r);
  end;
  writeln;
end;

{b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
reclamos efectuados por ese DNI.}
procedure RetornarCantidad(a: arbol_reclamo; var n: integer);

  function Cantidad(a: arbol_reclamo): integer;
  begin
    if(a = nil) then
      Cantidad:= 0
    else if (n = a^.elem.dni) then
      Cantidad:= a^.elem.cantidad
    else if (n < a^.elem.dni) then
      Cantidad:= Cantidad(a^.HI)
    else
      Cantidad:= Cantidad(a^.HD);
  end;

begin
  n:= Cantidad(a);
end;

{c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.}
procedure RetornarCantidadRango(a: arbol_reclamo; dni1, dni2: integer; var cant: integer);
  
  function Cantidad(a: arbol_reclamo; dni1, dni2: integer): integer;
  begin
    if (a = nil) then
      Cantidad:= 0
    else if (dni1 < a^.elem.dni) and (dni2 > a^.elem.dni) then
      Cantidad:= a^.elem.cantidad + Cantidad(a^.HI, dni1, dni2) + Cantidad(a^.HD, dni1, dni2)
    else if (a^.elem.dni <= dni1) then
      Cantidad:= Cantidad(a^.HD, dni1, dni2)
    else
      Cantidad:= Cantidad(a^.HI, dni1, dni2)
  end;

begin
  writeln('--- Cantidad de reclamos entre dni ', dni1, ' y dni ', dni2, ' ---');
  cant:= Cantidad(a, dni1, dni2);
end;


{d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
los reclamos realizados en el año recibido.}
procedure RetornarCodigos(a: arbol_reclamo; anho: integer);

  procedure RecorrerLista(L: lista_reclamos; anho: integer);
  begin
    if (L <> nil) then begin
      if (L^.elem.anho = anho) then
        writeln(L^.elem.codigo);
      L:= L^.sig;
    end;
  end;
  
  procedure ProcesarCodigos(a: arbol_reclamo; anho: integer);
  begin
    if (a <> nil) then begin
      ProcesarCodigos(a^.HI, anho);
      RecorrerLista(a^.elem.reclamos, anho);
      ProcesarCodigos(a^.HD, anho);
    end;
  end;

begin
  writeln('--- Se retornaran los codigos de reclamo del año ', anho, ' ---' );
  ProcesarCodigos(a, anho);
  writeln;
end;


var
  a: arbol_reclamo;
  anho, n, dni1, dni2, cant: integer;
begin
  ArmarArbol(a);

  write('Ingrese DNI para saber la cantidad de reclamos: '); readln(n);
  RetornarCantidad(a, n);

  write('Ingrese DNI para establecer rango inferior: '); readln(dni1);
  write('Ingrese DNI para establecer rango superior: '); readln(dni2);
  RetornarCantidadRango(a, dni1, dni2, cant);

  write('Ingrese año para devolver sus codigos de reclamo: '); readln(anho);
  RetornarCodigos(a, anho);
end.
