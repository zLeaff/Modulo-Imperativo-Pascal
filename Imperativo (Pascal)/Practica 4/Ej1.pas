{1. Implementar un programa modularizado para una librería que:
a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados la cantidad total de
unidades vendidas y el monto total. De cada venta se lee código de venta, código del
producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las
ventas finaliza cuando se lee el código de venta -1.
b. Imprima el contenido del árbol ordenado por código de producto.
c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.
d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.
e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).}

program Ej1;
const
  corte_venta = -1;

type
  venta = record
    codigo_venta: integer;
    codigo_prod: integer;
    cantidad: integer;
    precio_unit: real;
  end;

  prod_vendido = record
    codigo_prod: integer;
    cantidad_total: integer;
    monto_total: real;
  end;

  arbol = ^nodo;

  nodo = record
    elem: prod_vendido;
    HI: arbol;
    HD: arbol;
  end;


{a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados la cantidad total de
unidades vendidas y el monto total. De cada venta se lee código de venta, código del
producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las
ventas finaliza cuando se lee el código de venta -1.}
procedure GenerarArbol(var a: arbol);
  
  procedure LeerVenta(var v: venta);
  begin
    write('Codigo de venta: '); readln(v.codigo_venta);
    if (v.codigo_venta <> corte_venta) then begin
      write('Codigo del producto: '); readln(v.codigo_prod);
      write('Cantidad vendida: '); readln(v.cantidad);
      write('Precio unitario: '); readln(v.precio_unit);
    end;
  end;

  procedure InsertarElemento(var a: arbol; v: venta);
  var
    p: prod_vendido;
  
    Procedure ProcesarProducto(var p: prod_vendido; v: venta);
    begin
      p.codigo_prod:= v.codigo_prod;
      p.cantidad_total:= v.cantidad;
      p.monto_total:= v.cantidad * v.precio_unit;
    end;
  
  begin
    if (a = nil) then begin
      new(a);
      ProcesarProducto(p, v);
      a^.elem:= p;
      a^.HI:= nil;
      a^.HD:= nil;
    end
    else if (v.codigo_prod = a^.elem.codigo_prod) then begin
      a^.elem.cantidad_total:= a^.elem.cantidad_total + v.cantidad;
      a^.elem.monto_total:= a^.elem.monto_total + (v.cantidad * v.precio_unit);
    end
    else if (v.codigo_prod < a^.elem.codigo_prod) then
      InsertarElemento(a^.HI, v)
    else
      InsertarElemento(a^.HD, v);
  end;

var
  v: venta;
begin
  writeln('--- Ingreso de ventas y armado de arbol ---');
  writeln;
  a:= nil;
  LeerVenta(v);
  while (v.codigo_venta <> corte_venta) do begin
    InsertarElemento(a, v);
    writeln;
    LeerVenta(v);
  end;
  writeln;
end;

{b. Imprima el contenido del árbol ordenado por código de producto.}
procedure ImprimirArbol(a: arbol);
  
  procedure Imprimir(a: arbol);
  begin
    if (a <> nil) then begin
      if (a^.HI <> nil) then Imprimir(a^.HI);
      writeln('Codigo producto: ', a^.elem.codigo_prod, '. Cantidad Unidades: ', a^.elem.cantidad_total, '. Monto total: $', a^.elem.monto_total:2:2);
      if(a^.HD <> nil) then Imprimir(a^.HD);
    end;
  end;

begin
  writeln('--- Impresion de arbol ---');
  if (a = nil) then
    writeln('Arbol vacio.')
  else
    Imprimir(a);
  writeln;
end;

{c. Contenga un módulo que reciba la estructura generada en el punto a
y retorne el código de producto con mayor cantidad de unidades vendidas.}
procedure InformarCodigoMasVendido(a: arbol);
  
  procedure ActualizarMax(var max_cant, max_codigo: integer; cant_nueva, codigo_nuevo: integer);
  begin
    if (cant_nueva > max_cant) then begin
      max_cant:= cant_nueva;
      max_codigo:= codigo_nuevo;
    end;
  end;
  
  procedure Procesar(a: arbol; var max_cant, max_codigo: integer);
  begin
    if (a <> nil) then begin
      ActualizarMax(max_cant, max_codigo, a^.elem.cantidad_total, a^.elem.codigo_prod);
      Procesar(a^.HI, max_cant, max_codigo);
      Procesar(a^.HD, max_cant, max_codigo);
    end;
  end;
  
var
  max_cant, max_codigo: integer;
begin
  writeln('--- Producto con mas ventas ---');
  max_cant:= -1;
  Procesar(a, max_cant, max_codigo);
  if (max_cant = -1) then
    writeln('Arbol vacio.')
  else
    writeln('Codigo con el producto de mas ventas: ', max_codigo);
  writeln;
end;

{d. Contenga un módulo que reciba la estructura generada en el punto a y un código de producto y 
retorne la cantidad de códigos menores que él que hay en la estructura.}
procedure InformarCodigosInferiores(a: arbol);
  
  function CodigosEnRango(a: arbol; cod_limite: integer): integer;
  begin
    if (a = nil) then
      CodigosEnRango:= 0
    else if (a^.elem.codigo_prod < cod_limite) then
      CodigosEnrango:= 1 + CodigosEnRango(a^.HI, cod_limite) + CodigosEnRango(a^.HD, cod_limite)
    else if (a^.elem.codigo_prod >= cod_limite ) then
      CodigosEnRango:= CodigosEnRango(a^.HI, cod_limite)
    else
      CodigosEnRango:= CodigosEnRango(a^.HD, cod_limite);
  end;

var
  cod_limite: integer;
  cant: integer;
begin
  writeln('--- Cantidad de codigos menores al enviado ---');
  write('Ingrese codigo limite: '); readln(cod_limite);
  cant:= CodigosEnRango(a, cod_limite);
  if (cant = 0) then
    writeln('El arbol esta vacio o no hay elementos en el rango.')
  else
    writeln('Cantidad de codigos menores a ', cod_limite, ': ', cant);
  writeln;
end;

{e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de producto y retorne el monto total entre todos los códigos de productos 
comprendidos entre los dos valores recibidos (sin incluir).}
procedure InformarTotalRango(a: arbol);
  
  function MontoEnRango(a: arbol; inf, sup: integer): real;
  begin
    if(a = nil) then
      MontoEnRango:= 0
    else if (a^.elem.codigo_prod > inf) and (a^.elem.codigo_prod < sup) then
      MontoEnRango:= a^.elem.monto_total + MontoEnRango(a^.HI, inf, sup) + MontoEnRango(a^.HD, inf, sup)
    else if (a^.elem.codigo_prod <= inf) then
      MontoEnRango:= MontoEnRango(a^.HD, inf, sup)
    else if (a^.elem.codigo_prod >= sup) then
      MontoEnRango:= MontoEnRango(a^.HI, inf, sup);
  end;

var
  inf, sup: integer;
  total: real;
begin
  writeln('--- Monto total en rango ---');
  writeln;
  write('Ingrese codigo para limite inferior: '); readln(inf);
  write('Ingrese codigo para limite superior: '); readln(sup);
  total:= MontoEnRango(a, inf, sup);
  if (total = 0) then
    writeln('Arbol vacio.')
  else
    writeln('El monto total de los codigos en el rango (', inf, ';', sup, ') es de $', total:2:2);
  writeln;
end;

var
  a: arbol;
begin
  GenerarArbol(a);
  ImprimirArbol(a);
  InformarCodigoMasVendido(a);
  InformarCodigosInferiores(a);
  InformarTotalRango(a);
end.
