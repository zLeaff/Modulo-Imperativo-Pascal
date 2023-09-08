{Escribir un programa que:
a. Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro y: 
    i. Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor. 
    ii. Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. 
    iii. Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor. 
    iv. Aumente en 1 la edad de todos los socios.
    v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
      retorne verdadero o falso.
    vi. Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el nombre lei­do y 
      retorne verdadero o falso.
    vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.
    viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.
    ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
        los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores leÃ­dos y retorne dicha cantidad. 
    x. Informe los numeros de socio en orden creciente. 
    xi. Informe los numeros de socio pares en orden decreciente.
}

Program ImperativoClase3;
const
  corte_socio = 0;

type 
  rangoEdad = 12..100;
  str20 = string [20];
  socio = record
    numero: integer;
    nombre: str20;
    edad: rangoEdad;
  end;

  arbol = ^nodoArbol;
  nodoArbol = record
    elem: socio;
    HI: arbol;
    HD: arbol;
  end;

{ Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. }
procedure GenerarArbol (var a: arbol);

  procedure LeerSocio (var s: socio);
  begin
    write ('Ingrese numero del socio: ');
    readln (s.numero);
    if (s.numero <> corte_socio) then begin
      write ('Ingrese nombre del socio: ');
      readln (s.nombre);
      write ('Ingrese edad del socio: ');
      readln (s.edad);
    end;
  end;  
  
  procedure InsertarElemento (var a: arbol; s: socio);
  begin
    if (a = nil)  then begin
      new(a);
      a^.Elem:= s; 
      a^.HI:= nil; 
      a^.HD:= nil;
    end
    else if (s.numero < a^.Elem.numero) then 
      InsertarElemento(a^.HI, s)
    else 
      InsertarElemento(a^.HD, s); 
  end;

var 
  s: socio;  
Begin
  writeln ('----- Ingreso de socios y armado del arbol ----->');
  a:= nil;
  LeerSocio (s);
  writeln;
  while (s.numero <> 0)do begin
    InsertarElemento (a, s);
    LeerSocio (s);
    writeln;
  end;
  writeln ('-----------------------------------------------');
end;

//MODULOS INDEPENDIENTES (B)

{Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor.}
procedure InformarNumeroSocioMasGrande (a: arbol);

  function NumeroMasGrande (a: arbol): integer;
  begin
    if (a = nil) then NumeroMasGrande:= -1
    else if (a^.HD = nil) then 
      NumeroMasGrande:= a^.Elem.numero
    else 
      NumeroMasGrande:= NumeroMasGrande (a^.HD);
  end;

var 
  max: integer;
begin
  writeln ('----- Informar Numero Socio Mas Grande ----->');
  max:= NumeroMasGrande (a);
  if (max = -1) then 
    writeln ('Arbol sin elementos')
  else
    writeln ('Numero de socio mas grande: ', max);
    
  writeln ('-----------------------------------------------');
end;


{ Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. }
procedure InformarDatosSocioNumeroMasChico (a: arbol);
  
  function SocioMasChico (a: arbol): arbol;
  begin
    if ((a = nil) or (a^.HI = nil))
    then SocioMasChico:= a
    else SocioMasChico:= SocioMasChico (a^.HI);
  end;

var minSocio: arbol;
begin
  writeln ('----- Informar Datos Socio Numero Mas Chico ----->');
  minSocio:= SocioMasChico (a);
  if (minSocio = nil) then 
    writeln ('Arbol sin elementos')
  else begin
    writeln ('Socio con numero mas chico: ', minSocio^.elem.numero, ' Nombre: ', minSocio^.elem.nombre, ' Edad: ', minSocio^.elem.edad);
  end;
  writeln ('-----------------------------------------------');
end;

{ Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }
procedure InformarNumeroSocioConMasEdad (a: arbol);

  procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
    if (nuevoValor >= maxValor) then begin
      maxValor := nuevoValor;
      maxElem := nuevoElem;
    end;
	end;

	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
    if (a <> nil) then begin
      actualizarMaximo(maxEdad,maxNum,a^.elem.edad,a^.elem.numero);
      numeroMasEdad(a^.hi, maxEdad,maxNum);
      numeroMasEdad(a^.hd, maxEdad,maxNum);
    end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) then 
    writeln ('Arbol sin elementos')
  else begin
    writeln;
    writeln ('Numero de socio con mas edad: ', maxNum);
    writeln;
  end;
  writeln ('-----------------------------------------------');
end;

{Aumente en 1 la edad de todos los socios.}
procedure AumentarEdad (a: arbol);
begin
  if (a <> nil) then begin
    a^.elem.edad:= a^.elem.edad + 1;
    AumentarEdad (a^.HI);
    AumentarEdad (a^.HD);
  end;
end;

{ Lea un valor entero e informe si existe o no existe un socio con ese valor. 
Debe invocar a un modulo recursivo que reciba el valor lei­do y retorne verdadero o falso. }
procedure InformarExistenciaNumeroSocio (a: arbol);

  function Buscar (a: arbol; num: integer): boolean;
  begin
    if (a = nil) then 
      Buscar:= false
    else if (a^.elem.numero = num) then 
      Buscar:= true
    else if (num < a^.elem.numero) then 
      Buscar:= Buscar (a^.HI, num)
    else 
      Buscar:= Buscar (a^.HD, num)
  end;
  
var 
  n: integer;
begin
  writeln ('----- Informar Existencia Numero Socio ----->');
  write ('Ingrese numero de socio a buscar: '); readln (n);
  if (Buscar (a, n)) then 
    writeln ('El numero ', n, ' existe.')
  else 
    writeln ('El numero ', n, ' no existe.');
  writeln ('-----------------------------------------------');
end;

{vi. Lea un nombre e informe si existe o no existe un socio con ese valor. 
Debe invocar a un modulo recursivo que reciba el nombre lei­do y retorne verdadero o falso.}
procedure InformarExistenciaNombreSocio(a: arbol);

  function Buscar(a: arbol; nombre: str20): boolean;
  begin
    if(a = nil) then     
      Buscar:= false
    else if (a^.elem.nombre = nombre) then
      Buscar:= true
    else begin
      Buscar(a^.HI, nombre);
      Buscar(a^.HD, nombre);
    end;
  end;

var
  nombre: str20;
begin
  writeln ('----- Informar Existencia Nombre Socio ----->');
  write('Ingrese nombre de socio a buscar: '); readln(nombre);
  if (Buscar(a, nombre)) then
    writeln('El socio de nombre ', nombre, ' existe.')
  else
    writeln('El nombre ', nombre, ' no se encuentra registrado.')
end;

{vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.}
procedure InformarCantidadSocios(a: arbol);

  function RecorrerContar(a: arbol): integer;
  begin
    if (a <> nil) then
      RecorrerContar:= 1 + RecorrerContar(a^.HI) + RecorrerContar(a^.HD)
    else
      RecorrerContar:= 0;
  end;

begin 
  writeln('Cantidad total de socios: ', RecorrerContar(a));
end;

{viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.}
procedure InformarPromedioDeEdad(a: arbol);

  function CantidadSocios(a: arbol): integer;
  begin
    if(a = nil) then
      CantidadSocios:= 0
    else
      CantidadSocios:= CantidadSocios(a^.HI) + CantidadSocios(a^.HD) + 1;
  end;

    function TotalEdad(a: arbol): integer;
    begin
      if (a = nil) then
        TotalEdad:= 0
      else
        TotalEdad:= TotalEdad(a^.HI) + TotalEdad(a^.HD) + a^.elem.edad;
    end;

    function Promedio(a: arbol): real;
    begin
      if (a = nil) then
        Promedio:= 0
      else
        Promedio:= (TotalEdad(a) / CantidadSocios(a))
    end;

begin
  if (a = nil) then
    writeln('Arbol vacio.')
  else
    writeln('Promedio de edad entre los socios: ', Promedio(a):1:2);
end;


{ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol 
cuyo numero de socio se encuentra entre los dos valores ingresados. 
Debe invocar a un modulo recursivo que 
reciba los dos valores leÃ­dos y retorne dicha cantidad.}
procedure InformarCantidadSociosEnRango(a: arbol);

  function SociosEnRango(a: arbol; inf, sup: integer): integer;
  begin
    if(a = nil) then
      SociosEnRango:= 0
    else if (a^.elem.numero >= inf) and (a^.elem.numero <= sup) then
        SociosEnRango:= 1 + SociosEnRango(a^.HI, inf, sup) + SociosEnRango(a^.HD, inf, sup)
    else if (a^.elem.numero < inf) then
        SociosEnRango:= SociosEnRango(a^.HD, inf, sup)
    else if (a^.elem.numero > sup) then
        SociosEnRango:= SociosEnRango(a^.HI, inf, sup);
  end;

var
  inf, sup: integer;
begin
  writeln('----- Rango de socios -----');
  writeln('Ingrese el limite inferior del rango: '); readln(inf);
  writeln('Ingrese el limite superior del rango: '); readln(sup);
  if (SociosEnRango(a, inf, sup) = 0) then
    writeln('Arbol vacio.')
  else
    writeln('Cantidad de socios en el rango [', inf, ';', sup, ']:', SociosEnRango(a, inf, sup));
end;

{x. Informe los numeros de socio en orden creciente.}
procedure InformarNumerosSociosOrdenCreciente(a: arbol);
  
  procedure Creciente(a: arbol);
  begin
    if (a <> nil) then begin
      Creciente(a^.HI);
      writeln(a^.elem.numero);
      Creciente(a^.HD);
    end;
  end;

begin
  writeln('----- Lectura orden creciente -----');
  Creciente(a);
end;

{xi. Informe los numeros de socio pares en orden decreciente.}
procedure InformarNumerosSociosOrdenDecreciente(a: arbol);
  
  procedure Decreciente(a: arbol);
  begin
    if (a <> nil) then begin
      Decreciente(a^.HD);
      writeln(a^.elem.numero);
      Decreciente(a^.HI);
    end;
  end;

begin
  writeln('----- Lectura orden decreciente -----');
  Decreciente(a);
end;

var
	a: arbol;
Begin
  //Implementados
  GenerarArbol (a);
  InformarNumeroSocioMasGrande (a);
  InformarDatosSocioNumeroMasChico (a);
  InformarNumeroSocioConMasEdad (a);
  AumentarEdad (a);
  InformarExistenciaNumeroSocio (a);
  
  // A implementar
  InformarExistenciaNombreSocio (a);
  InformarCantidadSocios (a);
  InformarPromedioDeEdad (a);
  InformarCantidadSociosEnRango (a);
  InformarNumerosSociosOrdenCreciente (a);
  InformarNumerosSociosOrdenDecreciente (a);   
End.
