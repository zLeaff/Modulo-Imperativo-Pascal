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

  Procedure LeerSocio (var s: socio);
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
  
  Procedure InsertarElemento (var a: arbol; s: socio);
  Begin
    if (a = nil) 
    then begin
      new(a);
      a^.Elem:= s; 
      a^.HI:= nil; 
      a^.HD:= nil;
    end
    else if (s.numero < a^.Elem.numero) 
      then InsertarsElemento(a^.HI, s)
      else InsertarsElemento(a^.HD, s); 
  End;

var 
  s: socio;  
Begin
  writeln;
  writeln ('----- Ingreso de socios y armado del arbol ----->');
  writeln;

  a:= nil;
  LeerSocio (s);
  while (s.numero <> 0)do begin
    InsertarElemento (a, s);
    writeln;
    LeerSocio (s);
  end;

  writeln;
  writeln ('-----------------------------------------------');
  writeln;
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
  else begin
    writeln ('Numero de socio mas grande: ', max);
  end;
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
    writeln ('Socio con numero mas chico: ', minSocio^.elem.numero, ' Nombre: ', minSocio^.elem.nombre, ' Edad: ', minSocio^.dato.edad);
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
    a^.dato.edad:= a^.dato.edad + 1;
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
      Buscar(a^.HI);
      Buscar(a^.HD)
    end;

var
  nombre: str20;
begin
  writeln ('----- Informar Existencia Nombre Socio ----->')
  write('Ingrese nombre de socio a buscar: '); readln(n);
  if (Buscar(a, nombre)) then
    writeln('El socio de nombre ', nombre, ' existe.')
  else
    writeln('El nombre ', nombre, ' no se encuentra registrado.')
end;

{vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.}

{viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.}

var a: arbol; 
Begin
  GenerarArbol (a);
  InformarNumeroSocioMasGrande (a);
  InformarDatosSocioNumeroMasChico (a);
  InformarNumeroSocioConMasEdad (a);
  AumentarEdad (a);
  InformarExistenciaNumeroSocio (a);
  InformarExistenciaNombreSocio (a);
    {InformarCantidadSocios (a);
    InformarPromedioDeEdad (a);
    InformarCantidadSociosEnRango (a);
    InformarNumerosSociosOrdenCreciente (a);
    InformarNumerosSociosOrdenDeCreciente (a);
  }   
End.
