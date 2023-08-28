{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).
}

program Ej3;
const
  corte = -1;
  dimF = 8;

type
  rango_codigo = 1..dimF;
  rango_promedio = 0..10;

  pelicula = record
    codigo: integer;
    codigo_genero: rango_codigo;
    promedio: rango_promedio;
  end;

  lista = ^nodo;

  nodo = record
    elem: pelicula;
    sig: lista;
  end;

  vector_listas = array[rango_codigo] of lista;
  vector_codigo = array[rango_codigo] of pelicula;

procedure LeerPelicula(var p: pelicula);
begin
  write('Codigo de pelicula: '); readln(p.codigo);
  if p.codigo <> corte then begin
    write('Codigo de genero: '); readln(p.codigo_genero);
    write('Puntaje promedio: '); readln(p.promedio);
  end;
end;


//Insertar en orden de llegada
procedure ArmarNodo(var L, K: lista; p: pelicula);
var
  aux: lista;
begin
  new(aux);
  aux^.elem:= p;
  aux^.sig:= nil;
  if (L = nil) then
    L:= aux
  else
    K^.sig:= aux;
  K:= aux;
end;

procedure CargarLista(var L: vector_listas);
var
  p: pelicula;
  K: lista;
begin
  LeerPelicula(p);
  while p.codigo <> corte do begin
    ArmarNodo(L[p.codigo_genero], K, p);
    LeerPelicula(p);
  end;
end;

//Recorrer el vector de listas para calcular los maximos y agregarlos al vector por genero
procedure GenerarVectorMaximos(L: vector_listas; var v: vector_codigo);
var
  maxPromedio: rango_promedio;
  i: rango_codigo;
begin
  for i:= 1 to dimF do begin
    maxPromedio:= 0;  
    while L[i] <> nil do begin
      if L[i]^.elem.promedio > maxPromedio then begin
        maxPromedio:= L[i]^.elem.promedio;
        v[i]:= L[i]^.elem;
      end;
      L[i]:= L[i]^.sig;
    end;
  end;
end;

procedure OrdenarVector(var v: vector_codigo);
var
  i, j, p: rango_codigo;
  item: pelicula;
begin
  for i:= 1 to dimF - 1 do begin
    p:= i;
    for j:= i + 1 to dimF do
      if (v[j].promedio < v[p].promedio) then
        p:= j;
    
    item:= v[p];
    v[p]:= v[i];
    v[i]:= item;
  end;
end;

procedure MostrarMaxMin(v: vector_codigo);
begin
  writeln('Pelicula con menor puntaje del vector ordenado: ', v[1].codigo);
  writeln('Pelicula con mayor puntaje del vector ordenado: ', v[dimF].codigo);
end;

var
  L: vector_listas;
  v: vector_codigo;
  i: rango_codigo;
begin
  for i:= 1 to dimF do
    L[i]:= nil;

  CargarLista(L);
  GenerarVectorMaximos(L, v);
  OrdenarVector(v);
  for i:= 1 to dimF do
    writeln('Codigo Pelicula: ', v[i].codigo);
  MostrarMaxMin(v);
end.