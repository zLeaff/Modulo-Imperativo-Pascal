{2.- Implementar un programa que procese información de propiedades que están a la venta
en una inmobiliaria.
Se pide:
a) Implementar un módulo para almacenar en una estructura adecuada, las propiedades
agrupadas por zona. Las propiedades de una misma zona deben quedar almacenadas
ordenadas por tipo de propiedad. Para cada propiedad debe almacenarse el código, el tipo de
propiedad y el precio total. De cada propiedad se lee: zona (1 a 5), código de propiedad, tipo
de propiedad, cantidad de metros cuadrados y precio del metro cuadrado. La lectura finaliza
cuando se ingresa el precio del metro cuadrado -1.
b) Implementar un módulo que reciba la estructura generada en a), un número de zona y un tipo de
propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido}

program Ej2;

const
  corte = -1;

type
  rango_zona = 1..5;
  str30 = string[30];

  //Inciso A
  propiedad = record
    zona: rango_zona;
    codigo: integer;
    tipo: str30;
    m_cuadrados: integer;
    precio_m_cuadrado: real;
  end;

  info_propiedad = record
    codigo: integer;
    tipo: str30;
    precio_total: real;
  end;

  lista = ^nodo;

  nodo = record
    elem: info_propiedad;
    sig: lista;
  end;

  //Inciso B
  lista_b = ^nodo_b;

  nodo_b = record
    elem: integer;
    sig: lista_b
  end;

  vector_listas = array[rango_zona] of lista;

procedure LeerPropiedad(var p: propiedad);
begin
  write('Zona: '); readln(p.zona);
  write('Codigo: '); readln(p.codigo);
  write('Tipo de propiedad: '); readln(p.tipo);
  write('Metros cuadrados: '); readln(p.m_cuadrados);
  write('Precio por metro cuadrado: $'); readln(p.precio_m_cuadrado);
end;

procedure IngresarOrdenado(var L: lista; p: info_propiedad);
var
  actual, nuevo, anterior: lista;
begin
  new(nuevo);
  nuevo^.elem := p;
  actual := L;
  anterior := L;

  while (actual <> nil) and (p.tipo > actual^.elem.tipo) do
  begin
    anterior := actual;
    actual := actual^.sig;
  end;

  if (actual = anterior) then
    L := nuevo
  else
    anterior^.sig := nuevo;

  nuevo^.sig := actual;
end;

function calcularPrecioTotal(p: propiedad): real;
begin
  calcularPrecioTotal := p.m_cuadrados * p.precio_m_cuadrado;
end;

procedure CargarLista(var L: vector_listas);
var
  p: propiedad;
  info_p: info_propiedad;
begin
  LeerPropiedad(p);
  while p.m_cuadrados <> corte do begin
    info_p.codigo := p.codigo;
    info_p.tipo := p.tipo;
    info_p.precio_total := calcularPrecioTotal(p);
    IngresarOrdenado(L[p.zona], info_p);
    LeerPropiedad(p);
  end;
end;

//INCISO B
procedure CargarListaB(var L: lista_b; c: integer);
var
  aux: lista_b;
begin
  new(aux);
  aux^.elem:= c;
  aux^.sig:= L;
  L:= aux;
end;

procedure BuscarPropiedades(var K: lista_b; L: vector_listas; zona: rango_zona; tipo: str30);
begin
  K:= nil;
  while L[zona] <> nil do
  begin
    if L[zona]^.elem.tipo = tipo then begin
      CargarListaB(K, L[zona]^.elem.codigo);
    end;
    L[zona] := L[zona]^.sig;
  end;
end;

var
  L: vector_listas;
  K: lista_b;
  zona: rango_zona;
  tipo_propiedad: str30;
begin
  for zona := 1 to 5 do
    L[zona] := nil;

  CargarLista(L);


  writeln('Buscar propiedades.');
  // zona y tipo de propiedad para inciso B por teclado
  writeln('Ingrese la zona: '); readln(zona);
  writeln('Ingrese el tipo de propiedad: '); readln(tipo_propiedad);

  BuscarPropiedades(K, L, zona, tipo_propiedad);

  writeln('Propiedades en la Zona ', zona, ' de tipo ', tipo_propiedad, ':');
  while K <> nil do
  begin
    writeln('Code: ',K^.elem);
    K :=K^.sig;
  end;
end.

