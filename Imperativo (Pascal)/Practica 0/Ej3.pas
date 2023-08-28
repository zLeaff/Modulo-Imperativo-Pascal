{3.- Implementar un programa que procese las ventas de un supermercado. El supermercado
dispone de una tabla con los precios y stocks de los 1000 productos que tiene a la venta.

a) Implementar un módulo que retorne, en una estructura de datos adecuada, los tickets de las ventas.
De cada venta se lee código de venta y los productos vendidos. Las ventas finalizan con el código de
venta -1. 

De cada producto se lee código y cantidad de unidades solicitadas. 
Para cada venta, la lectura de los productos a vender finaliza con cantidad de unidades vendidas igual a 0. 
El ticket debe contener:
- Código de venta
- Detalle (código de producto, cantidad y precio unitario) de los productos que se pudieron vender. En
caso de no haber stock suficiente, se venderá la máxima cantidad posible.
- Monto total de la venta.
b) Implementar un módulo que reciba la estructura generada en el inciso a) y un código de
producto y retorne la cantidad de unidades vendidas de ese código de producto.}

program VentasSupermercado;
const
  dimF = 5;
  corte_venta = -1;
  corte_producto = 0;

type
  rango_codigo = 1..dimF;

  stock = record
    precio_unit: real;
    disp: integer;
  end;

  vector_stock = array[1.. dimF] of stock;

  producto_venta = record
    codigo_prod: rango_codigo;
    cantidad: integer;
  end;

  lista_pr_venta = ^nodo_pr_venta; //Lista para almacenar los productos vendidos

  nodo_pr_venta = record  
    elem: producto_venta;
    sig: lista_pr_venta;
  end;

  venta = record
    codigo: integer;
    productos: lista_pr_venta;
  end;

  lista_venta = ^nodo_venta; //Lista para almacenar las ventas (Codigo y productos vendidos(lista))

  nodo_venta = record
    elem: venta;
    sig: lista_venta;
  end;

  detalle = record
    codigo_prod: rango_codigo;
    cantidad: integer;
    precio_unit: real;
  end;

  lista_detalle = ^nodo_detalle; //Lista para guardar los detalles del producto

  nodo_detalle = record
    elem: detalle;
    sig: lista_detalle;
  end;

  ticket_venta = record
    codigo: integer;
    detalle: lista_detalle;
    total: real;
  end;

  lista_ticket = ^nodo_ticket;

  nodo_ticket = record
    elem: ticket_venta;
    sig: lista_ticket;
  end;

////////////////////////////////////////////////////////

procedure LeerStock(var s: stock);   //Se dispone
begin
  write('Precio unitario del producto: '); readln(s.precio_unit);
  write('Stock disponible: '); readln(s.disp);
end;

procedure CargarVectorStock(var v: vector_stock); //Se dispone
var
  s: stock;
  i: rango_codigo;
begin
  for i:= 1 to dimF do begin
    LeerStock(s);
    v[i]:= s;
  end;
end;

//Se cargan los productos vendidos (codigo y cantidad)
procedure ArmarNodoProductoVendido(var L: lista_pr_venta; p: producto_venta);
var
  aux: lista_pr_venta;
begin
  new(aux);
  aux^.elem:= p;
  aux^.sig:= L;
  L:= aux;
end;

//Se cargan las ventas (Codigo y producto vendido(codigo y cantidad))
procedure ArmarNodoVenta(var L: lista_venta; v: venta);
var
  aux: lista_venta;
begin
  new(aux);
  aux^.elem:= v;
  aux^.sig:= L;
  L:= aux;
end;


//Se cargan los detalles para el ticket (codigo producto, cantidad solicitada, precio unitario)
procedure ArmarNodoDetalle(var L: lista_detalle; d: detalle);
var
  aux: lista_detalle;
begin
  new(aux);
  aux^.elem:= d;
  aux^.sig:= L;
  L:= aux;
end;

//Se cargan los tickets (codigo venta, detalle producto, monto total)
procedure ArmarNodoTicket(var L: lista_ticket; t: ticket_venta);
var
  aux: lista_ticket;
begin
  new(aux);
  aux^.elem:= t;
  aux^.sig:= L;
  L:= aux;
end;


{
  Calcula la diferencia entre el stock disponible y la cantidad requerida
    -Si el stock no alcanza, cantidad toma el valor del stock disponible
    y el stock se setea en 0
    -Si el stock alcanza se resta cantidad en el stock disponible del producto
}
procedure ChequearStock(var v: vector_stock; codigo: rango_codigo; var cantidad: integer);
begin
  if (v[codigo].disp - cantidad) < 0 then begin
    cantidad:= v[codigo].disp;
    v[codigo].disp:= 0;
  end
  else
    v[codigo].disp:= v[codigo].disp - cantidad;
end;

function CalcularMonto(precio: real; cantidad: integer): real;
begin
  CalcularMonto:= precio * cantidad;
end;


{
  Lectura de los productos vendidos (codigo de producto / cantidad)
    -Llamado al procedimiento ChequearStock para manipular cantidad
    -Se incrementa el monto sumandole el resultado de la funcion CalcularMonto
      -Retorna precio * la cantidad de productos
}
procedure RegistrarProductoVenta(var p: producto_venta; var v_stock: vector_stock; var monto: real);
begin
  write('Codigo de producto: '); readln(p.codigo_prod);
  write('Cantidad solicitada: '); readln(p.cantidad);
  ChequearStock(v_stock, p.codigo_prod, p.cantidad);  
  monto:= monto + CalcularMonto(v_stock[p.codigo_prod].precio_unit, p.cantidad);
end;

function GenerarDetalleTicket (codigo: rango_codigo; cantidad: integer; precio: real): detalle;
var
  d: detalle;
begin
  d.codigo_prod:= codigo;
  d.cantidad:= cantidad;
  d.precio_unit:= precio;

  GenerarDetalleTicket:= d;
end;

{
    -Carga de productos vendidos en una lista
      -Se declara L:= nil para manejar una lista por venta
      -Se declara K:= nil para manejar un detalle por venta
      -LLamado al modulo RegistrarProductoVenta
        -Lectura productos vendidos
        -Manejo del monto total de la venta
      -Corte de control. Se corta la creacion de la lista cuando la cantidad de productos
      es igual a 0. Caso contrario se crea el nodo de productos vendidos y se crea el nodo de detalle
      -Llamado al modulo RegistrarProductoVenta para volver a evaluar el bucle
}
procedure ProcesarProducto(var L: lista_pr_venta; var K: lista_detalle; var v_stock: vector_stock; var monto: real);
var
  p: producto_venta;
  d: detalle;
begin
  L:= nil;
  K:= nil;
  RegistrarProductoVenta(p, v_stock, monto);
  while p.cantidad > corte_producto do begin
    d:= GenerarDetalleTicket(p.codigo_prod, p.cantidad, v_stock[p.codigo_prod].precio_unit);
    ArmarNodoDetalle(K, d);
    ArmarNodoProductoVendido(L, p);
    RegistrarProductoVenta(p, v_stock, monto);
  end;
end;

{
  Creacion de lista de tickets
    -Se declara L:= nil para un ticket con venta unico
    -Se evalua el codigo de venta
    -Corte de control. Se corta la creacion de la lista de ventas cuando el codigo
    sea igual a -1. Caso contrario se hace un llamado al modulo ProcesarProducto
    para armar la lista de productos por venta y generar los detalles.
    -Se asignan valores al tipo de dato ticket_venta 
      -Se arma el nodo con los datos del ticket
    -Se crea el nodo y se vuelve a evaluar el bucle
}
procedure RegistrarVentas (var L: lista_ticket; var v_stock: vector_stock);
var
  ticket: ticket_venta;
  v: venta;
  K: lista_detalle;
  monto: real;
begin
  L:= nil;
  write('Ingrese codigo de venta(-1 para finalizar): '); readln(v.codigo);
  while v.codigo <> corte_venta do begin
    monto:= 0;
    ProcesarProducto(v.productos, K, v_stock, monto);
    ticket.codigo:= v.codigo;
    ticket.detalle:= K;
    ticket.total:= monto;
    ArmarNodoTicket(L, ticket);
    write('Ingrese codigo de venta(-1 para finalizar): '); readln(v.codigo);
  end;
end;

function CalcularUnidadesVendidas(L: lista_ticket; codigo: rango_codigo): integer;
var
  K: lista_detalle;
  total: integer;
begin
  total:= 0;
  while L <> nil do begin
    K:= L^.elem.detalle;
    while K <> nil do begin
      if K^.elem.codigo_prod = codigo then
        total:= total + K^.elem.cantidad;
      K:= K^.sig;
    end;
    L:= L^.sig;
  end;
  CalcularUnidadesVendidas:= total;
end;

var
  L: lista_ticket;
  v_stock: vector_stock;
  codigo: rango_codigo;
begin
  CargarVectorStock(v_stock);
  RegistrarVentas(L, v_stock);

  write('Ingrese codigo del producto para buscar: '); readln(codigo);
  writeln('Se vendieron para el producto ', codigo, ' ', CalcularUnidadesVendidas(L, codigo), ' unidades');
end.

