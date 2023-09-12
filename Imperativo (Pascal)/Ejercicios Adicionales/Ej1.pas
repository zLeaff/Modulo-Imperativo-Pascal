{1. El administrador de un edificio de oficinas, cuenta en papel, con la información del pago
de las expensas de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se debe leer, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación -1.
b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no
se encontró la oficina.
d) Un módulo recursivo que retorne el monto total de las expensas.}

program Ej1;
const
  corte_cod = -1;
  dimF = 10;

type
  oficina = record
    codigo_id: integer;
    dni_prop: integer;
    expensa: real;
  end;

  vector_oficinas = array[1..dimF] of oficina;

{a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se debe leer, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación -1.}
procedure GenerarVectorDesordenado (var v: vector_oficinas; var dimL: integer);
  
  procedure LeerOficina(var o: oficina);
  begin
    write('Codigo de identificacion de la oficina: '); readln(o.codigo_id);
    if (o.codigo_id <> corte_cod) then begin
      write('DNI del propietario: '); readln(o.dni_prop);
      write('Precio de la expensa: $'); readln(o.expensa);
    end;
  end;

  procedure CargarVector(var v: vector_oficinas; var dimL: integer);
  var
    o: oficina;
  begin
    if (dimL < dimF) then begin
      LeerOficina(o);
      writeln;
      if (o.codigo_id <> corte_cod) then begin
        dimL:= dimL + 1;
        v[dimL]:= o;
        CargarVector(v, dimL);
      end;
    end;
  end;

begin
  writeln('--- Carga Vector ---');
  CargarVector(v, dimL);
end;

{b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.}
procedure OrdenarVector(var v: vector_oficinas; dimL: integer);
var
  i, j, k: integer;
  item: oficina;
begin
  for i:= 1 to dimL - 1 do begin
    j:= i;
    for k:= i + 1 to dimL  do
      if v[k].codigo_id < v[j].codigo_id then
        j:= k;

    item:= v[j];
    v[j]:= v[i];
    v[i]:= item;
  end;  
end;

{c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no
se encontró la oficina.}
function Dicotomica(v: vector_oficinas; dimL: integer; cod: integer): integer;
var
  pri, ult, medio: integer;
begin
  pri:= 1; 
  ult:= dimL; 
  medio:= (pri + ult) div 2;

  while(pri <= ult) and (cod <> v[medio].codigo_id) do begin
    if (cod < v[medio].codigo_id) then
      ult:= medio - 1
    else
      pri:= medio + 1;
    medio:= (pri + ult) div 2;
  end;

  if (pri <= ult) and (cod = v[medio].codigo_id) then
    Dicotomica:= medio
  else
    Dicotomica:= 0;
end;

{d) Un módulo recursivo que retorne el monto total de las expensas.}
function TotalExpensas(v: vector_oficinas; dimL, indice : integer): real;
begin
  if indice > dimL then
    TotalExpensas:= 0
  else
    TotalExpensas:= v[indice].expensa + TotalExpensas(v, dimL, indice + 1);
end;

var
  v: vector_oficinas;
  i, dimL, pos: integer;
begin
  dimL:= 0;

  GenerarVectorDesordenado(v, dimL);
  writeln('-- Vector desordenado --');
  for i:= 1 to dimL do
    writeln(v[i].expensa:2:2);

  writeln;

  OrdenarVector(v, dimL);
  writeln('-- Vector ordenado --');
  for i:= 1 to dimL do
    writeln(v[i].expensa:2:2);
  writeln;

  writeln('-- Busqueda Dicotomica --');
  write('Ingrese codigo para iniciar busqueda dicotomica: '); readln(i);
  pos:= Dicotomica(v, dimL, i);
  writeln('El codigo ingresado se encuentra en la posicion ', pos, ' del vector.');

  writeln('El valor total de las expensas en el vector es de: $', TotalExpensas(v, dimL, 1):2:2);
end.