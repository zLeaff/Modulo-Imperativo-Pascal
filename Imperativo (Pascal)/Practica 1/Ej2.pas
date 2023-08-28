{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}

program Ej2;
const
  corte = -1;
  dimF = 300;

type
  rango = 1..dimF;

  oficina = record
    codigo: integer;
    dni: integer;
    valor: real;
  end;

  vector_oficina = array[rango] of oficina;

procedure LeerOficina(var o: oficina);
begin
  write('Codigo de oficina: '); readln(o.codigo);
  if o.codigo <> corte then begin
    write('Dni del propietario: '); readln(o.dni);
    write('Valor de expensa: $'); readln(o.valor);
  end;
end;

procedure CargarVector(var v: vector_oficina; var dimL: rango);
var
  o: oficina;
begin
  LeerOficina(o);
  while (dimL < dimF) and (o.codigo <> corte) do begin
    v[dimL]:= o;
    dimL:= dimL + 1;
    LeerOficina(o);
  end;
end;

procedure CargarVectorOrdenado(var v: vector_oficina; dimL: integer);
var
  i, j: rango;
  elem: oficina;
begin
  for i:= 2 to dimL do begin
    elem:= v[i];
    j:= i-1;
    while(j > 0) and (v[j].codigo > elem.codigo) do begin
      v[j+1]:= v[j];
      j:= j-1;
    end;
    v[j+1]:= elem;
  end;
end;

procedure OrdenarVector(var v: vector_oficina; dimL: rango);
var
  i, j, p: rango;
  item: oficina;
begin
  for i:= 1 to dimL - 1 do begin
    p:= i;
    for j:= i+1 to dimL do
      if v[j].codigo < v[p].codigo then
        p:= j;
    
    item:= v[p];
    v[p]:= v[i];
    v[i]:= item;
  end;
end;

var
  v: vector_oficina;
  dimL: rango;
begin
  dimL:= 1;
  CargarVector(v, dimL);
  OrdenarVector(v, dimL);
  //CargarVectorOrdenado(v);
end.