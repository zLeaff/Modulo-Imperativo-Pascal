{Se desea procesar la información de las ventas de productos de un comercio (como máximo 50). 
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el día de la venta, código del producto (entre 1 y 15) y cantidad vendida
(como máximo 99 unidades). El código y el dia deben generarse automáticamente (random) y la cantidad se debe leer. El ingreso de las ventas finaliza con el día de venta 0 
(no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos valores que se ingresan como parámetros. 
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).
}

program Ej1;
const 
  dimF = 50;
  corte = 0;

type 
  dias = 0..31;
  rango_producto = 1..15; // Corregido para evitar 0
  rango_unidad = 1..99;
  rango_venta = 0..dimF;
  
  venta = record
    dia: dias;
    codigoP: rango_producto;
    cantidad: rango_unidad;
  end;
  
  vector = array [1..dimF] of venta;
  
  lista = ^nodo;
  
  nodo = record
    elem: venta;
    sig: lista;
  end;

procedure AlmacenarInformacion(var v: vector; var dimL: rango_venta); 
  procedure LeerVenta(var v: venta);
  begin
    Randomize;
    write('Dia: ');
    v.dia := random(32);
    writeln(v.dia);
    if (v.dia <> corte) then begin
      write('Codigo de producto: ');
      v.codigoP := random(15) + 1;
      writeln(v.codigoP);
      write('Ingrese cantidad (entre 1 y 99): ');
      readln(v.cantidad);
    end;
  end;
var 
  unaVenta: venta;
begin
  dimL := 0;
  LeerVenta(unaVenta);
  while (unaVenta.dia <> corte) and (dimL < dimF) do begin
    dimL := dimL + 1;
    v[dimL] := unaVenta;
    LeerVenta(unaVenta);
  end;
end;

procedure ImprimirVector(v: vector; dimL: rango_venta);
var
  i: integer;
begin
  write('         -');

  for i := 1 to dimL do
    write('-----');
  writeln;
  write('  Codigo:| ');
  for i := 1 to dimL do begin
    if (v[i].codigoP <= 9) then
      write('0');
    write(v[i].codigoP, ' | ');
  end;

  write('Cantidad:| ');
  for i := 1 to dimL do begin
    if (v[i].cantidad <= 9) then
      write('0');
    write(v[i].cantidad, ' | ');
  end;
    
  write('         -');
  for i := 1 to dimL do
    write('-----');
  writeln;
  writeln;
end;

procedure Ordenar(var v: vector; dimL: rango_venta);
var 
  i, j, pos: rango_venta; 
  item: venta;		
begin
  for i := 1 to dimL - 1 do begin
    pos := i;
    for j := i + 1 to dimL do 
      if (v[j].codigoP < v[pos].codigoP) then
        pos := j;

    item := v[pos];   
    v[pos] := v[i];   
    v[i] := item;
  end;
end;

procedure Eliminar(var v: vector; var dimL: rango_venta; valorInferior, valorSuperior: rango_producto);
var 
  i, j: rango_venta;
begin
  i := 1;
  j := 1;
  while i <= dimL do begin
    if (v[i].codigoP >= valorInferior) and (v[i].codigoP <= valorSuperior) then
      i := i + 1
    else begin
      v[j] := v[i];
      i := i + 1;
      j := j + 1;
    end;
  end;
  dimL := j - 1;
end;

procedure AgregarAdelante(var L: lista; v: venta);
var
  aux: lista;
begin
  new(aux);
  aux^.elem := v;
  aux^.sig := L;
  L := aux;
end;

procedure GenerarLista(v: vector; dimL: rango_venta; var L: lista);
var 
  i: rango_venta;
begin
  L := nil;
  for i := 1 to dimL do 
    if v[i].codigoP mod 2 = 0 then 
      AgregarAdelante(L, v[i]);
end;

procedure ImprimirLista(L: lista);
begin
  while L <> nil do begin
    writeln('Dia: ', L^.elem.dia, ' | Codigo: ', L^.elem.codigoP, ' | Cantidad: ', L^.elem.cantidad);
    L := L^.sig;
  end;
end;

var 
  v: vector;
  dimL: rango_venta;
  valorInferior, valorSuperior: rango_producto;
  L: lista;
begin
  AlmacenarInformacion(v, dimL);
  writeln;
  if (dimL = 0) then 
    writeln('--- Vector sin elementos ---')
  else begin
    writeln('--- Vector ingresado --->');
    ImprimirVector(v, dimL);
    writeln('--- Vector ordenado --->');
    Ordenar(v, dimL);
    ImprimirVector(v, dimL);
    write('Ingrese valor inferior: '); readln(valorInferior);
    write('Ingrese valor superior: '); readln(valorSuperior);
    Eliminar(v, dimL, valorInferior, valorSuperior);
    if (dimL = 0) then 
      writeln('--- Vector sin elementos, luego de la eliminacion ---')
    else begin
      writeln('--- Vector luego de la eliminacion --->');
      ImprimirVector(v, dimL);
      GenerarLista(v, dimL, L);
      if (L = nil) then 
        writeln('--- Lista sin elementos ---')
      else begin
        writeln('--- Lista obtenida --->');
        ImprimirLista(L);
      end;
    end;
  end;
End.


