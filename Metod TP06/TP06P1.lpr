program TP06P1;
uses
    crt;
const
  MAX=100;
type
  TNombre = String[50];
  TProducto = record
    NroVenta : Integer;
    NombreLote : TNombre;
    CostoLote : Real;
  end;
  AProductos = Array[1..MAX] of TProducto;


(*-------------------------------ORDENACIONES---------------------------------*)

procedure Intercambiar(var X:TProducto;var Y:TProducto);
var
  Temp:TProducto;
begin
  Temp:=X;
  X:=Y;
  Y:=Temp;
end;

//seleccion
procedure OrdenarPorPrecioDesc(var Productos:AProductos; var N:integer);
var
 i, j,Minimo: Integer;
begin
   for i := 1 to N - 1 do
   begin
     Minimo:=i;
     for J := (I + 1) to N Do
       if (Productos[j].CostoLote > Productos[Minimo].CostoLote) then
           Minimo:=j;
       Intercambiar(Productos[i],Productos[Minimo]);
   end
end;


(*------------------------CARGA Y UNION DE VECTORES-------------------------*)


procedure CargarVentas (var lista:AProductos;var N:integer);
var
 i,CodigoError:integer;
 opcion:char;
 CosteLoteString:TNombre;

begin
   I:=N+1;
   repeat
       with lista[i] do
       begin
          NroVenta:=i;//nro de venta se genera automaticamente
          Writeln('Venta Nro. ',i);
          Write('Ingrese el nombre del lote -> ');
          ReadLn(NombreLote);
          Write('Ingrese el costo del lote -> ');
          ReadLn(CosteLoteString);
          Val(CosteLoteString,CostoLote,CodigoError);
          while (CodigoError<>0) do
          begin
            write('Coste incorrecto, por favor ingrese un valor real->');
            ReadLn(CosteLoteString);
            Val(CosteLoteString,CostoLote,CodigoError);
          end;
       end;
      inc(N);
      inc(i);

      WriteLn();
      WriteLn('Desea ingresar otra venta? S/N ->');
      ReadLn(Opcion);
      Opcion := upCase(Opcion);
   until Opcion='N';
end;


(*------------------------MUESTRAS POR PANTALLA-----------------------------*)

procedure MostrarCabecera();
begin
  Write('Nro Venta');GotoXY(20,1);
  Write('Nombre Lote');GotoXY(40,1);
  Writeln('Costo Lote');
end;

procedure MostrarVentaTabla(Producto:TProducto;y:integer);
begin
  with Producto do
  begin
    Write(NroVenta);GotoXY(20,y);
    Write(NombreLote);GotoXY(40,y);
    WriteLn(CostoLote:5:2);
  end;
end;

procedure MostrarVentas (Lista:AProductos;N:integer);
var
  i:integer;
begin
   MostrarCabecera();
   for i:=1 to n do
   begin
    MostrarVentaTabla(Lista[i],i+1);
   end;
end;

procedure MostrarListasFusionadas(var v1,v2:AProductos; N1,N2:integer);
var
  v3:AProductos;
  i,j,k,z,N3:integer;
begin
  i := 1; j:=1 ; k := 1;
  if(N1>= 2) and (N2>=2) then
  OrdenarPorPrecioDesc(v1,n1);
  OrdenarPorPrecioDesc(v2,n2);
  while (i<=N1) and (j<=N2) do
  begin
     if (v1[i].CostoLote> v2[j].CostoLote) then
     begin
       v3[k] := v1[i];
       i:= i+1;
     end
     else
     begin
       v3[k] := v2[j];
       j:= j+1;
     end;
     k:=k+1;
  end;
  if (i>N1) then
    for z:=j to N2 do
    begin
      v3[k]:=v2[z];
      k:=k+1;
    end
  else
    for z:=i to N1 do
    begin
      v3[k]:=v2[z];
      k:=k+1;
    end;
  N3:=N1+N2;
  MostrarVentas(V3,N3);
end;

function MostrarMenu ():integer;
begin
  WriteLn('MENU');
  WriteLN('1- Cargar ventas de lista 1 o lista 2');
  WriteLn('2- Mostrar ventas de lista 1 o lista 2');
  WriteLn('3- Fusionar listas en una sola');
  WriteLn('0- Salir');
  Write('->');
  Readln(MostrarMenu);
end;


(*-------------------------------PRINCIPAL---------------------------------*)

var
  Lista1,Lista2:AProductos;
  N1,N2:integer;
  Opcion:integer;
begin
 N1:=0;
 N2:=0;
 repeat
    ClrScr;
    Opcion:=MostrarMenu();
    case Opcion of
      1:
      begin
          Writeln('Que lista desea cargar? 1 o 2?');
          ReadLn(Opcion);
          while (opcion<>1) and (Opcion<>2) do
          begin
            Writeln('opcion incorrecta, debe ser 1 o 2');
            ReadLn(Opcion);
          end;
          if (opcion=1) then
              CargarVentas(Lista1,N1)
          else
              CargarVentas(Lista2,N2);
      end;
      2:
      begin
         Writeln('Que lista desea mostrar? 1 o 2?');
          ReadLn(Opcion);
          while (opcion<>1) and (Opcion<>2) do
          begin
            Writeln('opcion incorrecta, debe ser 1 o 2');
            ReadLn(Opcion);
          end;
          if (opcion=1) then
          begin
              ClrScr;
              MostrarVentas(Lista1,N1)
          end
          else
          begin
              ClrScr;
              MostrarVentas(Lista2,N2);
          end;
      end;
      3:
      begin
        ClrScr;
        MostrarListasFusionadas(lista1,lista2,n1,n2);
      end;
      0:writeln('Fin del programa');
      else
        writeln('Opcion incorrecta');
    end;
    WriteLn;
    write('Presione una tecla para continuar...');
    ReadKey;
 until Opcion=0;
end.
