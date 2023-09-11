{2. Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
h. Un módulo recursivo que reciba la estructura generada en h. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).}
program untitled;

type
  rangoDia = 1..31;
  
  rangoMes = 1..12;
  
  prestamos = record
    isbn : integer;
    nSocio : integer;
    dia: rangoDia;
    mes: rangoMes;
  end;
  
  ISB = record
    nSocio : integer;
    dia: rangoDia;
    mes: rangoMes;
  end;
  
  arbolPrestamo = ^nodo1;
  
  nodo1 = record
    elem:prestamos;
    HI:arbolPrestamo;
    HD:arbolPrestamo;
  end;
  
  
  Lista = ^puntero;
  
  puntero = record
    dato:ISB;
    sig:Lista;
  end;
  
  Libro = record
    codigo:integer; 
    list:Lista;
  end;
  
  arbolISBN = ^nodo2;
  
  nodo2 = record
    elem:Libro;
    HI:arbolISBN;
    HD:arbolISBN;
  end;
  
  elemento1 = record
    isbn:integer;
    prestamos:integer;
  end;
  
  Lista1 = ^punt1;
  
  punt1 = record
    elem:elemento1;
    sig:Lista1;
  end;

procedure  cargarArbol (var p:arbolPrestamo;var i:arbolISBN) ;
         
         procedure cargarPrestamo (var pre : prestamos);
         
         begin
           writeln('cargar isbn del libro');
           readln(pre.isbn);
           if(pre.isbn <>-1)then begin
             writeln('cargar numero del socio al que le fue prestado el libro');
             readln(pre.nSocio);
             writeln('cargar dia que fue prestado ');
             readln(pre.dia);
             writeln('cargar mes que fue prestado ');
             readln(pre.mes);
           end;
         end;
         
         procedure CargarP(var p:arbolPrestamo;pre:prestamos);
         
         
         begin
           if(p=nil)then begin
             new(p);
             p^.elem:=pre;
             p^.HI:=nil;
             p^.HD:=nil;
           end
           else if( pre.isbn < p^.elem.isbn)then 
                   CargarP(p^.HI,pre)
                else
                   CargarP(p^.HD,pre);
         end;
         
         procedure CargarI(var i:arbolISBN;pre:prestamos);
         
         
                  procedure agregar (var L:Lista ; isbn:ISB);
                  var nue:Lista;
                  begin
                    new(nue);
                    nue^.dato:=isbn;
                    nue^.sig:=L;
                    L:=nue;
                  end;
                  
                  
         VAR L:Lista;isbn:ISB;
         
         BEGIN 
           isbn.nSocio:=pre.nSocio;
           isbn.dia:=pre.dia;
           isbn.mes:=pre.mes;
           if(i=nil)then begin
             new(i);
             L:=nil;
             agregar(L,isbn);
             i^.elem.codigo:=pre.isbn;
             i^.elem.list:=L;
             i^.HI:=nil;
             i^.HD:=nil;
           end
           else if(pre.isbn = i^.elem.codigo )then
                   agregar(i^.elem.list,isbn)
                else if(pre.isbn < i^.elem.codigo )then
                        CargarI(i^.HI,pre)
                     else
                        CargarI(i^.HD,pre);
         END;
         
var
  pre:prestamos;
begin
  cargarPrestamo(pre);
  while(pre.isbn <> -1)do begin
    CargarP(p,pre);
    CargarI(i,pre);
    cargarPrestamo(pre);
  end;
end;

procedure ImprimirP (p:arbolPrestamo);
         
         procedure impP(pre:prestamos);
         begin
           writeln;
           writeln('isbn : ',pre.isbn);
           writeln('numero de socio : ',pre.nSocio);
           writeln('fecha : ',pre.dia,'/',pre.mes);
           writeln;
         end;
begin
  if(p<>nil)then begin
    ImprimirP(p^.HI);
    impP(p^.elem);
    ImprimirP(p^.HD);
  end;
end;

procedure ImprimirI(i:arbolISBN);
         
         procedure impI(lib:Libro);
                  
                  procedure impLista (L:Lista);
                  begin
                    while(L<>nil)do begin
                        writeln;
                        writeln('socio : ',L^.dato.nSocio);
                        writeln('fecha : ',L^.dato.dia , '/' ,L^.dato.mes);
                        writeln;
                        L:=L^.sig;
                    end;
                  end;
         begin
           writeln;
           writeln('isbn : ',lib.codigo);
           impLista(lib.list);
           writeln;
           writeln;
           writeln;
         end;
begin
  if(i<>nil)then begin
    ImprimirI(i^.HI);
    impI(i^.elem);
    ImprimirI(i^.HD);
  end;
end;

procedure ModuloB(p:arbolPrestamo);
         
         function Maximo(p:arbolPrestamo):INTEGER;
       
         begin
           if(p^.HD = nil)then
             Maximo:=p^.elem.isbn
           else 
             Maximo:=Maximo(p^.HD);
         end;


         
var Max:integer;

begin
  Max:=Maximo(p);
  writeln('el isbn mas grande es : ' , Max);
end;


procedure ModuloC(i:arbolISBN);

         function Minimo(i:arbolISBN):INTEGER;
         begin
           if(i = nil)then
             Minimo:=i^.elem.codigo
           else
             Minimo:=Minimo(i^.HI);
         end;
         
var Min:integer;

begin
    Min:=Minimo(i);
    writeln('el isbn mas chico es : ' , Min);
end;

procedure ModuloD(p:arbolPrestamo);
         
         procedure buscarPrestamos (p:arbolPrestamo;socio:integer;var cant:integer);
         begin
           if(p<>nil)then begin
             if(p^.elem.nSocio = socio)then
               cant:=cant+1; 
             buscarPrestamos(p^.HI,socio,cant);
             buscarPrestamos(p^.HD,socio,cant);
           end;
         end;
         
var cant,socio:integer;

begin
  cant:=0;
  writeln('ingrese un numero de socio');
  readln(socio);
  buscarPrestamos(p,socio,cant);
  writeln('al socio ', socio , ' se le han prestado ',cant,' libros');
end;


procedure ModuloF(p:arbolPrestamo);
         
         procedure ArmarEstructura(p:arbolPrestamo;var L:Lista1);
         
                   procedure CargarLista1 (var L:Lista1;p:arbolPrestamo);
                   
                            procedure agregarAtras(var L:Lista1;isbn:integer);
                            var nue:Lista1;
                            begin
                              new(nue);
                              nue^.elem.isbn:=isbn;
                              nue^.elem.prestamos:=1;
                              nue^.sig:=L;
                              L:=nue;
                            end;
                            
                   var aux:Lista1;
                   begin
                     aux:=L;
                     while(aux <> nil)and (aux^.elem.isbn <> p^.elem.isbn)do 
                        aux:=aux^.sig;
                     if(aux = nil)then 
                        agregarAtras(L,p^.elem.isbn)
                     else
                        aux^.elem.prestamos:=aux^.elem.prestamos + 1 ;
                   end;
         
         begin
           if(p<>nil)then begin
             CargarLista1(L,p);
             ArmarEstructura(p^.HI,L);
             ArmarEstructura(p^.HD,L);
           end;
         end;

         procedure ModuloH(L:Lista1);
         begin
           while(L<>nil)do begin
             writeln;
             writeln('isbn del libro : ' , L^.elem.isbn);
             writeln('cantidad de veces que se presto ese libro : ' , L^.elem.prestamos);
             writeln;
             L:=L^.sig;
           end;
         end;
         
var L:Lista1;
begin
  L:=nil;
  ArmarEstructura(p,L);
  writeln('-------moduloH------->');
  writeln;
  ModuloH(L);
  writeln;
end;


procedure ModuloI (p:arbolPrestamo);
          
          procedure buscarPrestamos(p:arbolPrestamo;var contador:integer;r1,r2:integer);
          
          begin 
            if(P<>nil)then 
              if(p^.elem.isbn > r1)and(p^.elem.isbn < r2)then begin
                  contador:= contador + 1;
                  buscarPrestamos(p^.HI,contador,r1,r2);
                  buscarPrestamos(p^.HD,contador,r1,r2);
              end
              else if(P^.elem.isbn < r1)then
                      buscarPrestamos(p^.HI,contador,r1,r2)
                    else
                      buscarPrestamos(p^.HD,contador,r1,r2);
          end;      
          

var r1,r2,aux:integer;
begin
  writeln('ingresar rango de isbn');
  readln(r1);readln(r2);
  aux:=0;
  buscarPrestamos(p,aux,r1,r2);
  writeln('la cantidad de prestamos realizados en este rango de isbn es  : ' ,aux);
end;
var p:arbolPrestamo;i:arbolISBN;

BEGIN
	cargarArbol(p,i);
	if(p<>nil) then begin
	  writeln('-------------------Arbol de Prestamos----------------->');
	  writeln;
	  ImprimirP(p);
	  writeln('-------moduloB------->');
	  writeln;
	  ModuloB(p);
	  writeln;
	  writeln('-------moduloD------->');
	  writeln;
	  ModuloD(p);
	  writeln;
	  writeln('-------moduloF------->');
	  writeln;
	  ModuloF(p);
	  writeln;
	  writeln('-------moduloI------->');
	  writeln;
	  ModuloI(p);
	  writeln;
	end;
	
    if(i<>nil)then begin
      writeln('-------------------Arbol de ISBN---------------------->');
      writeln;
	  ImprimirI(i);
	  writeln('-------moduloC------->');
	  writeln;
	  {ModuloC(i);}
	  
	end;
END.
