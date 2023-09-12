{3. Un supermercado requiere el procesamiento de sus productos. De cada producto se
conoce código, rubro (1..10), stock y precio unitario. Se pide:
a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. La lectura finaliza con el código de producto igual a -1.
b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
de producto y retorne si dicho código existe o no para ese rubro.
c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.
d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
ingresados.}

program ej3;
const
  corte_prod = -1;

type
  rango_rubro = 1..10;

  producto = record
    codigo_prod: integer;
    rubro: rango_rubro;
    stock: integer;
    precio_unit: real;
  end;

  arbol = ^nodo;

  nodo = record
    elem: producto;
    HI: arbol;
    HD: arbol;
  end;

  vector_rubro = array[rango_rubro] of arbol;


{a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. La lectura finaliza con el código de producto igual a -1.}
procedure GenerarVector(var v: vector_rubro);
  
  procedure LeerProducto(var p: producto);
  begin
    write('Codigo de producto: '); readln(p.codigo_prod);
    if (p.codigo_prod <> corte_prod) then begin
      write('Rubro del producto: '); readln(p.rubro);
      write('Stock: '); readln(p.stock);
      write('Precio unitario: $'); readln(p.precio_unit);
    end;
  end;

  procedure InsertarElemento(var a: arbol; p: producto);
  begin
    if (a = nil) then begin
      new(a);
      a^.elem:= p;
      a^.HI:= nil;
      a^.HD:= nil;
    end
    else if (p.codigo_prod <= a^.elem.codigo_prod) then
      InsertarElemento(a^.HI, p)
    else
      InsertarElemento(a^.HD, p);
  end;
    
var
  p: producto;
begin
  writeln('--- Lectura de producto ---');
  LeerProducto(p);
  while(p.codigo_prod <> corte_prod) do begin
    InsertarElemento(v[p.rubro], p);
    LeerProducto(p);
  end;
  writeln;
end;


{b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
de producto y retorne si dicho código existe o no para ese rubro.}
procedure ModuloB(v: vector_rubro; rubro: rango_rubro; codigo: integer);
  
  function Buscar(a: arbol; codigo: integer): boolean;
  begin
    if (a = nil) then
      Buscar:= false
    else if (codigo = a^.elem.codigo_prod) then
      Buscar:= true
    else if (codigo < a^.elem.codigo_prod) then
      Buscar:= Buscar(a^.HI, codigo)
    else
      Buscar:= Buscar(a^.HD, codigo)
  end;

begin
  writeln('--- Busqueda del codigo', codigo, ' en el rubro', rubro, ' ---');
  if (Buscar(v[rubro], codigo)) then
    writeln('El codigo existe para ese rubro.')
  else
    writeln('El codigo no existe para ese rubro.');
  writeln;
end;

{c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.}
procedure ModuloC(v: vector_rubro);

  function EncontrarMaximo(a: arbol): producto;
  begin
    if (a = nil) then begin
      EncontrarMaximo.codigo_prod:= -1;
      EncontrarMaximo.stock:= 0;
    end
    else if (a^.HD <> nil) then
      EncontrarMaximo:= EncontrarMaximo(a^.HD)
    else
      EncontrarMaximo:= a^.elem;
  end;

var
  i: rango_rubro;
  maximoProducto: producto;
begin
  writeln('--- Producto con mayor codigo en cada rubro ---');
  writeln;
  for i := 1 to 10 do
  begin
    maximoProducto := EncontrarMaximo(v[i]);
    if (maximoProducto.codigo_prod = -1) then
      writeln('Rubro ', i, ' vacio.')
    else
      writeln('Codigo mas grande del rubro ', i, '. Codigo: ', maximoProducto.codigo_prod, ' Stock: ', maximoProducto.stock);
  end;
end;

{d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
ingresados.}
procedure ModuloD(v: vector_rubro; codigo1, codigo2: integer);

  function ContarProductosEnRango(a: arbol; codigo1, codigo2: integer): integer;
  begin
    if a = nil then
      ContarProductosEnRango := 0
    else if (a^.elem.codigo_prod >= codigo1) and (a^.elem.codigo_prod <= codigo2) then
      ContarProductosEnRango := 1 + ContarProductosEnRango(a^.HI, codigo1, codigo2) + ContarProductosEnRango(a^.HD, codigo1, codigo2)
    else if (a^.elem.codigo_prod < codigo1) then
      ContarProductosEnRango := ContarProductosEnRango(a^.HD, codigo1, codigo2)
    else
      ContarProductosEnRango := ContarProductosEnRango(a^.HI, codigo1, codigo2);
  end;

var
  i: rango_rubro;
  cantidad: integer;
begin
  writeln('--- Cantidad de productos en rango de códigos ---');
  writeln;
  for i := 1 to 10 do
  begin
    cantidad := ContarProductosEnRango(v[i], codigo1, codigo2);
    writeln('Rubro ', i, ': Cantidad de productos en el rango: ', cantidad);
  end;
end;

var
  v: vector_rubro;
  rubro, codigo, codigo1: integer;
begin
  GenerarVector(v);
  writeln;

  write('Ingrese rubro: '); readln(rubro);
  write('Ingrese codigo de producto: '); readln(codigo);
  ModuloB(v, rubro, codigo);
  writeln;

  ModuloC(v);
  writeln;

  write('Ingrese el primer código: '); readln(codigo);
  write('Ingrese el segundo código: '); readln(codigo1);
  ModuloD(v, codigo, codigo1);
end.
