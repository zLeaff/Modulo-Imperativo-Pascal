{2. Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee
código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de
producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendida.
Nota: El módulo debe retornar los dos árboles.

b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.

c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.}

program Ej2;
const
  corte_prod = 0;

type
  rango_dia = 1..31;
  rango_mes = 1..12;

  fecha = record
    dia: rango_dia;
    mes: rango_mes;
    anho: integer;
  end;

  venta = record
    codigo_prod: integer;
    fecha: integer;
    unidades_vendidas: integer;
  end;

  arbol= ^nodo;

  nodo = record
    elem: venta;
    HI: arbol;
    HD: arbol;
  end;

  //Inciso B

  producto = record
    codigo_prod: integer;
    unidades_vendidas: integer;
  end;

  arbol_prod = ^nodo_prod;

  nodo_prod = record
    elem: producto;
    HI: arbol_prod;
    HD: arbol_prod;
  end;

procedure GenerarArboles(var arbol_v: arbol; var arbol_p: arbol_prod);

  {i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
  producto.}
  procedure LeerFecha(var f: fecha);
  begin
      write('Dia: '); readln(f.dia);
      write('Mes: '); readln(f.mes);
      write('Año: '); readln(f.anho);
  end;

  procedure LeerVenta(var v: venta);
  begin
    write('Codigo de producto: '); readln(v.codigo_prod);
    if v.codigo_prod <> 0 then begin
      write('Registro de fecha.');
      readln(v.fecha);
      write('Unidades vendidas: '); readln(v.unidades_vendidas);
    end;
  end;

  procedure InsertarArbolVenta (var a: arbol; v: venta);
  begin
    if (a = nil) then begin
      new(a);
      a^.elem:= v;
      a^.HI:= nil;
      a^.HD:= nil;
    end
    else if(v.codigo_prod < a^.elem.codigo_prod) then
      InsertarArbolVenta(a^.HI, v)
    else
      InsertarArbolVenta(a^.HD, v);
  end;

  {ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
  código de producto. Cada nodo del árbol debe contener el código de producto y la
  antidad total de unidades vendida}
  procedure InsertarArbolProducto(var a: arbol_prod; p:producto);
  begin
    if(a = nil) then begin
      new(a);
      a^.elem:= p;
      a^.HI:= nil;
      a^.HD:= nil;
    end
    else
      if (p.codigo_prod = a^.elem.codigo_prod) then
        a^.elem.unidades_vendidas:= a^.elem.unidades_vendidas + p.unidades_vendidas
      else
        if (p.codigo_prod < a^.elem.codigo_prod ) then
          InsertarArbolProducto(a^.HI, p)
        else
          InsertarArbolProducto(a^.HD, p);
  end;

var
  v: venta;
  p: producto;
begin
  arbol_v:= nil;
  arbol_p:= nil;

  writeln('Lectura de ventas.');
  LeerVenta(v);
  writeln;

  while (v.codigo_prod <> corte_prod) do begin
    InsertarArbolVenta(arbol_v, v);
    p.codigo_prod:= v.codigo_prod;
    p.unidades_vendidas:= v.unidades_vendidas;
    InsertarArbolProducto(arbol_p, p);
    LeerVenta(v);
    writeln;
  end;

  writeln;
end;


{b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.}
procedure InformarTotalVentas(a: arbol);  
  
  function TotalProductoB(a: arbol; c: integer): integer;
  begin
    if (a = nil) then
      TotalProductoB := 0
    else if (a^.elem.codigo_prod = c) then
      TotalProductoB := a^.elem.unidades_vendidas + TotalProductoB(a^.HI, c)
    else
      TotalProductoB := TotalProductoB(a^.HD, c);
  end;

var
  c: integer;
begin
  write('Ingrese codigo del producto para saber las unidades vendidas: '); readln(c);
  writeln('Del producto ', c, ' se vendieron ', TotalProductoB(a, c), ' unidades.');
end;
  

{c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.}
procedure InformarTotalProd(a: arbol_prod);
  
  function TotalProductoC(a: arbol_prod; c: integer): integer;
  begin
    if (a = nil) then
      TotalProductoC:= 0
    else if (a^.elem.codigo_prod = c) then
      TotalProductoC:= a^.elem.unidades_vendidas
    else if(c < a^.elem.codigo_prod) then
      TotalProductoC(a^.HI, c)
    else
      TotalProductoC(a^.HD, c);
  end;

var
  c: integer;
begin
  write('Ingrese codigo del producto para saber las unidades vendidas: '); readln(c);
  writeln('Del producto ', c, ' se vendieron ', TotalProductoC(a, c), ' unidades.');
end;

var
  a: arbol;
  b: arbol_prod;
begin
  GenerarArboles(a, b);

  InformarTotalVentas(a);
  writeln;

  InformarTotalProd(b);
  writeln;
end.
