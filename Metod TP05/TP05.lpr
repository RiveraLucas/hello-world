program TP05;
uses
  crt;
const
  MAX=100;
type
  TString = string[40];
  TResol = record
    Ancho,Alto:Integer;
  end;

  TCelular = record
    NroSerie: TString;//tipo recomendado por profesor
    Marca: TString;
    Modelo: TString;
    Precio: Real;
    Procesador: TString;
    ResCamaraPrin: Real;
    ResCamaraFron: Real;
    TamanioDisplay: Real;
    ResDisplay: TResol;//Tipo de dato recomendado por el profesor
    MemoriaInt: Integer;//El profesor quiere que sea potencia de 2 y lo validemos
    MemoriaExtMax: Integer;//Lo mismo con este
    SistOp: TString;
    CapacidadBat: Integer;
    Estado: Boolean; //Tipo de dato recomendado por el profesor
  end;
  ACelular = array[1..MAX] of TCelular;

function BuscarEquipoPorNroSerie(Equipos:ACelular;N:integer;Buscado:TString):integer;
var
  Inicio,Fin,Medio:Integer;
  Encontrado:Boolean;
begin
  Inicio := 1;
  Fin := N;
  Encontrado:= False;
  while (Inicio <= Fin) and not(Encontrado) do
  begin
    Medio := (Inicio+Fin) div 2;
    if (Equipos[Medio].NroSerie = Buscado) then
    begin
       Encontrado := True;
    end
    else if (Equipos[Medio].NroSerie < Buscado) then
    begin
      Inicio := Medio + 1
    end
    else
    begin
      Fin := Medio - 1;
    end;
  end;
  if (Encontrado) then
  begin
    BuscarEquipoPorNroSerie := Medio;
  end
  else
  begin
     BuscarEquipoPorNroSerie := -1;
  end;
end;
procedure CargarEquipos (var Equipos:ACelular; var N: integer);
var
  i,
  OpcionEstado:Integer;
  Cod:TString;
  Opcion:char;
begin
  i:=N+1;
  repeat
    Write('Ingrese el Numero de Serie ->');
    ReadLn(Cod);
    while(BuscarEquipoPorNroSerie(Equipos,N,Cod)<>-1) do
    begin
      Write('El nro de serie ya existe, ingrese otro ->');
      ReadLn(Cod);
    end;
    with Equipos[i] do
    begin
      NroSerie:=Cod;
      Write('Ingrese la marca ->');
      ReadLn(Marca);
      Write('Ingrese el modelo ->');
      ReadLn(Modelo);
      Write('Ingrese el precio->');
      ReadLn(Precio);
      Write('Ingrese la resolucion de la camara principal (En Mpx)->');
      ReadLn(ResCamaraPrin);
      Write('Ingrese la resolucion de la camara frontal (En Mpx)->');
      ReadLn(ResCamaraFron);
      Write('Ingrese el tamanio del display (en pulgadas)->');
      ReadLn(TamanioDisplay);
      Write('Ingrese la resolucion del display (ancho y alto)->');
      ReadLn(ResDisplay.Ancho);
      ReadLN(ResDisplay.Alto);
      Write('Ingrese la memoria interna (En GB) ->');
      ReadLn(MemoriaInt);
      Write('Ingrese la memoria externa maxima (En GB) ->');
      ReadLn(MemoriaExtMax);
      Write('Ingrese el sistema operativo ->');
      ReadLn(SistOp);
      Write('Ingrese la capacidad de bateria (mAh) ->');
      ReadLn(CapacidadBat);
      Write('Ingrese el estado (1- EN STOCK,2- VENDIDO) ->');
      ReadLn(OpcionEstado);
      repeat
        if (OpcionEstado=1) then
        begin
           Estado := True
        end
        else if (OpcionEstado=2) then
        begin
           Estado := False
        end
        else
        begin
           Write('Estado incorrecto, ingrese nuevamente ->');
           ReadLn(OpcionEstado);
        end;
      until (OpcionEstado=1) or (OpcionEstado=2);
      inc(N);
      inc(i);
      WriteLn();
      WriteLn('Desea ingresar otro equipo? S/N ->');
      ReadLn(Opcion);
      Opcion := upCase(Opcion);
    end;
  until (Opcion='N');
end;

procedure MostrarEquipoTabla(Equipo:TCelular;y:integer);
begin
    //TODO
    Writeln('Marca: ',Equipo.Marca);
    Writeln('Modelo: ',Equipo.Modelo);
end;

procedure MostrarEquipos (Equipos:ACelular;N:integer);
var
  i:integer;
begin
  for i:=1 to N do
    MostrarEquipoTabla(Equipos[i],i+1);
end;

function MostrarMenu ():integer;
begin
  WriteLn('MENU');
  WriteLN('1- Cargar equipos');
  WriteLn('2- Mostrar equipos de una marca por modelo');
  WriteLn('3- Mostrar equipos de una marca por precio');
  WriteLn('4- Buscar equipo por numero de serie');
  WriteLn('5- Buscar equipo por precio');
  WriteLn('6- Mostrar equipos por resolucion de camara principal');
  WriteLn('7- Mostrar equipos por intervalo de precios');
  WriteLn('8- Modificar datos de equipo');
  WriteLn('9- Vender un equipo');
  WriteLn('0- Salir');
  Write('->');
  Readln(MostrarMenu);
end;

var
  Celulares:ACelular;
  N,Opcion,IndiceBuscado:integer;
  NroSerie:TString;
begin
  N:=0;
  repeat
     ClrScr;
     Opcion:=MostrarMenu();
     case Opcion of
       1:
       begin
          CargarEquipos(Celulares,N);
       end;
       2:
       begin

       end;
       3:
       begin

       end;
       4:
       begin
           Writeln('Ingrese el nro de serie a buscar ->');
           ReadLn(NroSerie);
           IndiceBuscado := BuscarEquipoPorNroSerie(Celulares,N,NroSerie);
           if (IndiceBuscado <> -1) then
           begin
              Writeln('Equipo encontrado');
              MostrarEquipoTabla(Celulares[IndiceBuscado],2);
           end
           else
           begin
             Writeln('No se encontro el equipo');
           end;
       end;
       5:
       begin

       end;
       6:
       begin

       end;
       7:
       begin

       end;
       8:
       begin

       end;
       9:
       begin

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

