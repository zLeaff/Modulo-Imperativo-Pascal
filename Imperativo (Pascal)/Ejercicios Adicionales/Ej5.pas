{5. Realizar el punto a) del ejercicio anterior, pero sabiendo que todos los reclamos de un
mismo DNI se leen de forma consecutiva (no significa que vengan ordenados los DNI).

// 4. Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
//
}

program Ej5;
const
  corte = -1;

type
  rango_tipo = 1..5;

  reclamo = record
    codigo: integer;
    dni: integer;
    anho: integer;
    tipo: rango_tipo;
  end;

  lista_reclamos = ^nodo_reclamos;

  nodo_reclamos = record
    elem: reclamo;
    sig: lista_reclamos;
  end;

  nodo = record
    dni: integer;
    reclamos: lista_reclamos;
    cantidad: integer;
  end;

  arbol_reclamo = ^nodo_arbol;

  nodo_arbol = record
    elem: nodo;
    HI: arbol_reclamo;
    HD: arbol_reclamo;
  end;

procedure GenerarArbol(var a: arbol_reclamo);
  
  procedure LeerReclamo(var r: reclamo);
  begin
    write('Codigo del reclamo: '); readln(r.codigo);
    if (r.codigo <> corte) then begin
      write('DNI del usuario: '); readln(r.dni);
      write('Año de reclamo: '); readln(r.anho);
      write('Tipo de reclamo(1-5): '); readln(r.tipo);
    end;
  end;
  
  procedure AgregarAdelante(var L: lista_reclamos; r: reclamo);
  var
    aux: lista_reclamos;
  begin
    new(aux);
    aux^.elem:= r;
    aux^.sig:= L;
    L:= aux;
  end;

  procedure InsertarElemento(var a: arbol_reclamo; n:nodo);
  begin
    if (a = nil) then begin
      new(a);
      a^.elem:= n;
      a^.HI:= nil;
      a^.HD:= nil;
    end
    else begin
      if (n.dni < a^.elem.dni) then
        InsertarElemento(a^.HI, n)
      else
        InsertarElemento(a^.HD, n);
    end;
  end;

var
  n: nodo;
  r: reclamo;
begin
  LeerReclamo(r);
  while (r.codigo <> corte) do begin
    n.dni:= r.dni;
    n.cantidad:= 0;
    n.reclamos:= nil;
    while (r.codigo <> corte) and (r.dni = n.dni) do begin
      n.cantidad:= n.cantidad + 1;
      AgregarAdelante(n.reclamos, r);
      LeerReclamo(r);
    end;
    InsertarElemento(a, n);
  end;
end;

//Falta implementar resto del programa
//Es exactamente igual al Ej4
