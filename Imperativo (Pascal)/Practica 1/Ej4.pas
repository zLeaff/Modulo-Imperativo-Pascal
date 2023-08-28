{4.- Una librería requiere el procesamiento de la información de sus productos. De cada
producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
métodos vistos en la teoría.
e. Muestre los precios del vector resultante del punto d).
f. Calcule el promedio de los precios del vector resultante del punto d).
}

program Ej4;
const
  dimF = 30;
  corte = 0;

type
  rango = 1..8 ;

  producto =record 
    codigo: integer;
    rubro: rango ;
    precio: real;
  end;

  lista = ^nodo;
  
  nodo = record
    elem: producto;
    sig: lista;
  end;
  
  vector = array [rango] of lista;
  
  rubro3 = array [1..dimF] of producto;

procedure CargarProducto(var p:producto);
begin
  writeln('Cargar precio del producto');
  readln(p.precio);
  if(p.precio <> corte)then begin
    writeln('Cargar codigo del producto: ');
    readln(p.codigo);
    writeln('Cargar rubro: ');
    readln(p.rubro);
  end;
end;

procedure cargarL(var L:lista ; p:producto);
var 
  nue, act, ant: lista ;
begin
  new (nue); 
  nue^.elem:=p;
  act:=L; 
  ant:=L;

  while (act <> nil) and(act^.elem.codigo < p.codigo)do begin
    ant:= act;
    act:=act^.sig;
  end;

  if(act = ant)then
    L:=nue
  else
    ant^.sig:= nue;
  nue^.sig:=act;
end; 

procedure CargarVector(var v: vector);
var  
  p: producto;
begin
  CargarProducto(p);
  while (p.precio <> 0)do begin
    cargarL(v[p.rubro],p);//insertar ordenado 
    CargarProducto(p);
  end;
end;


procedure ImprimirVector(v: vector);
var 
  i: rango;
begin
  for i:=1 to 8 do begin 
    writeln('Producto de rubro :', i);
    writeln(' ');
    while (v[i] <> nil) do begin
      writeln('Codigo de producto: ', v[i]^.elem.codigo);
      writeln('Precio del producto: ',v[i]^.elem.precio:10:3);
      writeln('');
      v[i]:=v[i]^.sig;
    end;
  end;
end;

procedure Imprimir(r:rubro3 ; dl :integer);
var i: integer;
begin
  writeln('Productos del rubro 3: ');
  for i:=1 to dl do begin
    writeln('');
    writeln('Codigo de producto: ', r[i].codigo);
    writeln('Precio del producto: ', r[i].precio:10:3);
  end;
end;

procedure GenerarVector(var r :rubro3 ; v:vector;var dl:integer); 
var 
  i: integer;
begin 
  i:=1;
  while (i<= 30)and (v[3] <> nil) do begin  
    r[i]:=v[3]^.elem;
    v[3]:=v[3]^.sig;
    i:=i+1;
  end;
  if (i>30) then
    dl:=30
  else
    dl:=i-1;
    
  Imprimir(r,dl);
end;

procedure Insercion(var r: rubro3; dl: integer);
var 
  i, j: integer; 
  aux: producto;
begin
  for i:= 2 to dl do begin
    aux := r[i];
    j:=i-1;
    while (j> 0) and (r[j].precio > aux.precio) do begin
      r[j+1]:= r[j];
      j:=j-1;
    end;
    r[j+1]:=aux;
    end;
end; 

function Promedio(r: rubro3; dl: integer): real;
var
  i: integer; 
  acumulador: real;
begin
  acumulador:=0;
  for i:=1 to dl do 
    acumulador:= acumulador + r[i].precio;
  acumulador:= acumulador / i;
  Promedio:= acumulador
end;

var 
  v:vector;
  r:rubro3;
  dl:integer;
begin
  CargarVector(v);//A)
  ImprimirVector(v);//B)
  GenerarVector(r,v,dl);//C)
  Insercion(r,dl);//D)
  writeln('Se imprimiran los productos del rubro 3 n forma ordena de menos a mayor');
  Imprimir(r,dl);//E)
  writeln('El promedio del precio de los productos del rubro 3 es :' , promedio(r,dl):10:3);
end.
