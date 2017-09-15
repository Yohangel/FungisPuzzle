program FungisPuzzle;
uses crt,dos;
type

matriz = array [1..6,1..6] of integer ;

var ma : matriz; o:boolean; A:text;
procedure logo;
begin
    TextColor(white);
    gotoxy(10,2);write('  ______                 _       _____               _      ');
    gotoxy(10,3);write(' |  ____|               (_)     |  __ \             | |     ');
    gotoxy(10,4);write(' | |__ _   _ _ __   __ _ _ ___  | |__) _   _ _______| | ___ ');
    gotoxy(10,5);write(' |  __| | | | `_ \ / _\`| / __| |  ___| | | |_  |_  | |/ _ \');
    gotoxy(10,6);write(' | |  | |_| | | | | (_| | \__ \ | |   | |_| |/ / / /| |  __/');
    gotoxy(10,7);write(' |_|   \__,_|_| |_|\__, |_|___/ |_|    \__,_/___/___|_|\___|');
    gotoxy(10,8);write('                    __/ |                                   ');
    gotoxy(10,9);write('                   |___/                                    ');
end;
procedure dibujarm (var mm : matriz; max:integer);
var
i,f,c,j,w,z,cantMov,ss: integer ;
comp: matriz;
v:boolean;
teclam:char;
h,m,s,se,hb,mb,sb,seb : word;
procedure mostrar (mm : matriz);
var
k,l,i : integer;

begin
for k:=1 to max do
begin
     for i:=1 to max do
     begin
     write(chr(205),chr(205),chr(205),chr(205),chr(205),chr(203));
     end;
     writeln;
     for l:=1 to max do
     begin
     if ((mm [k,l]) < 10) and ((mm [k,l]) > 0)  then
         write (chr(00),'  ',mm [k,l],' ',chr(186))
     else if ((mm [k,l]) >= 10)  then
         write (chr(00),' ',mm [k,l],' ',chr(186))
     else if ((mm [k,l]) = 0)  then
         write (chr(00),'    ',chr(186));
     end;
     writeln;
end;
     for i:=1 to max do
     begin
     write(chr(205),chr(205),chr(205),chr(205),chr(205),chr(202));
     end;
     writeln;
     l:=1;
     for i:=1 to max do
     begin
     gotoxy(1,l);
     write(chr(203));
     l:=(l+2);
     end;
     l:=2;
     for i:=1 to max do
     begin
     gotoxy(1,l);
     write(chr(186));
     l:=(l+2);
     end;
     writeln;
     gotoxy (1,1);
     write('FungisPuzzle');
     gotoxy (1,max*3);
     writeln('Pulsa 0 para rendirte');
end;
begin

for i:= 0 to ((max*max)-1) do
begin
   f:= random (max) + 1;
   c:= random (max) + 1;
   j:=1;
   v:=true;
    repeat
          begin
          if (mm[f,c]=j) then
             begin
             f:= random (max) + 1;
             c:= random (max) + 1;
             j:=0;
             end;
          if j=(max*max) then
             v:=false;
          j:=j+1;
          end;
    until (v=false);
    mm[f,c] := i;
end;
for i:=1 to max do
begin
     for j:=1 to max do
     begin
          if (mm[i,j]=0) then
          begin
          w:= i;
          z:= j;
          end;
     end;
end;
mostrar (ma);
cantMov:=0;
ss:=0;
for i:=1 to max do
begin
     for j:=1 to max do
     begin
          comp[i,j]:= ss;
          ss:= ss+1;
     end;
end;
v:=false;
gettime(hb,mb,sb,seb); {Obtengo hora de inicio}
repeat
teclam := ' ';
if keypressed then
teclam:=readkey;
for i:=1 to max do
begin
     for j:=1 to max do
     begin
          if (comp[i,j]=mm[i,j]) then
          v:=true
          else
          begin
          v:=false; j:=max; i:=max;
          end;
     end;
end;
    if (teclam = #75) and (z > 1) then {Flecha izquierda}
       begin
       mm[w,z]:= mm[w,z-1];
       mm[w,z-1] := 0;
       z:= z-1;
       cantMov:= cantMov + 1;
       clrscr;
       mostrar (ma);
       end;
    if (teclam = #77) and (z < max) then {Flecha derecha}
       begin
       mm[w,z]:= mm[w,z+1];
       mm[w,z+1] := 0;
       z:= z+1;
       cantMov:= cantMov + 1;
       clrscr;
       mostrar (ma);
       end;
    if (teclam = #72) and (w > 1) then {Flecha arriba}
       begin
       mm[w,z]:= mm[w-1,z];
       mm[w-1,z] := 0;
       w:= w-1;
       cantMov:= cantMov + 1;
       clrscr;
       mostrar (ma);
       end;
    if (teclam = #80) and (w < max) then {Flecha abajo}
       begin
       mm[w,z]:= mm[w+1,z];
       mm[w+1,z] := 0;
       w:= w+1;
       cantMov:= cantMov + 1;
       clrscr;
       mostrar (ma);
       end;
       GetTime(h,m,s,se);  {Obtengo hora actual}
until ((v=true) or (teclam='0'));
gotoxy(22,10);
if (h>hb) then
   h:=h-hb
else
   h:=hb-h;
if (m>mb) then
   m:=m-mb
else
   m:=mb-m;
if (s>sb) then
   s:=s-sb
else
   s:=sb-s;
clrscr;
Window(1,1,80,25);
if v=true then
begin
logo;
gotoxy(15,13);
writeln('¡FELICITACIONES, HAS COMPLETADO EL NIVEL CON EXITO!');
gotoxy(21,15);
writeln('Total de tiempo obtenido: ',h:2,':',m:2,':',s:2); {Muestro la diferencia de tiempo o tiempo transcurrido}
gotoxy(25,17);
writeln('Cantidad de movimientos: ',cantMov);
end
else
begin
logo;
gotoxy(33,13);
writeln('¡GAME OVER!');
gotoxy(21,15);
writeln('Total de tiempo obtenido: ',h:2,':',m:2,':',s:2); {Muestro la diferencia de tiempo o tiempo transcurrido}
gotoxy(25,17);
writeln('Cantidad de movimientos: ',cantMov);
end;
gotoxy(26,19);
writeln('Pulsa una tecla para salir');
readln;
 END;
procedure SeleccionarNivel;
    var teclab:char; ob:boolean; opb:integer;
    procedure Centrarb(Sb:String);  {Procedimiento para centrar el menu}
    var xb:integer;
    begin
    xb:=wherey;
    gotoxy(39-(Length(Sb) DIV 2),xb);
    if (WhereY = opb) and (opb >= 13) then
       TextColor(red)
    else if (opb >= 13) then
       TextColor(white);
    write(sb);
    writeln;
    end;
    begin
    ob:=false;
    opb:=13;
    repeat
    cursoroff;
    TextBackground(0);
    clrscr;
    logo;
    gotoxy(1,13);
    Centrarb('FACIL');
    Centrarb('MEDIO');
    Centrarb('AVANZADO');
    Centrarb('VOLVER AL MENU');
    gotoXY(29,opb);
    teclab:=readkey;
    if (teclab = #72) and (opb > 13) then {Flecha arriba}
       begin
       opb:= opb-1;
       end;
    if (teclab = #80) and (opb < 16) then {Flecha abajo}
       begin
       opb:= opb+1;
       end;
    if teclab = #13 then {Tecla enter}
       begin
            case opb of {Seleccionar opcion del menu}
            13 : begin ob := true; o := true; clrscr; Window(31,10,60,30);dibujarm (ma, 3); end;
            14 : begin ob := true; o := true; clrscr; Window(28,9,60,30);dibujarm (ma, 4); end;
            15 : begin ob := true; o := true; clrscr; Window(25,8,60,30);dibujarm (ma, 5); end;
            16 : ob := true;
            end;
       end;
    until ob = true;
    end;
procedure creditos;
    procedure Centrarc(Sc:String);  {Procedimiento para centrar}
    var xc:integer;
    begin
    xc:=wherey;
    gotoxy(39-(Length(Sc) DIV 2),xc);
    TextColor(white);
    write(sc);
    writeln;
    end;
begin
    clrscr;
    logo;
    gotoxy(1,13);
    Centrarc('PROGRAMADOR:');
    Centrarc('YOHANGEL RAMOS');
    gotoxy(1,19);
    Centrarc('Pulsa una tecla para volver al menu');
    readkey;
end;
procedure instrucciones;
    procedure Centrarc(Sc:String);  {Procedimiento para centrar}
    var xc:integer;
    begin
    xc:=wherey;
    gotoxy(39-(Length(Sc) DIV 2),xc);
    TextColor(white);
    write(sc);
    writeln;
    end;
begin
    clrscr;
    logo;
    gotoxy(1,13);
    Centrarc('Instrucciones:');
    Centrarc('Debes ordenar los numeros en orden creciente en el menor tiempo y');
    Centrarc('menor cantidad de movimientos posibles dejando el espacio en blanco');
    Centrarc('de primero, para mover el espacio en blanco en el tablero se usan ');
    Centrarc('las flechas del teclado');
    writeln;
    gotoxy(1,19);
    Centrarc('Pulsa una tecla para volver al menu');
    readkey;
end;
procedure animacion;
var i,j,k,c:integer; d:boolean; t:char;
begin
k:= 3;
d:= false;
repeat
ClrScr;
NormVideo;
TextColor(White);
gotoxy(2, 1);
writeln('Pulsa "F" para volver al menu');
c:=(random(2) + 12);
HighVideo;
TextColor(c);
gotoxy(k, 3);
for i:=1 to 28 do
    begin
    if i <= 13 then
        write(' ')
    else if i > 13  then
        write('@');
    end;

gotoxy(k, 4);
for i:=1 to 29 do
    begin
    if i <= 12 then
        write(' ')
    else
         write('@');
    end;

for j:=5 to 6 do
    begin
    gotoxy(k, j);
    for i:=1 to 32 do
    begin
        if i <= 8 then
           write(' ')
        else if (i>8) and (i<=15) then
           write('@')
        else if (i>15) and (i<=24) then
           write(' ')
        else
           write('@');
    end;
end;

for j:=7 to 8 do
    begin
    gotoxy(k, j);
    for i:=1 to 36 do
    begin
        if i <= 4 then
           write(' ')
        else if (i>4) and (i<=12) then
           write('@')
        else if (i>12) and (i<=28) then
           write(' ')
        else
           write('@');
    end;
end;

for j:=9 to 10 do
    begin
    gotoxy(k, j);
    for i:=1 to 36 do
    begin
        if i <= 4 then
           write(' ')
        else if (i>4) and (i<=8) then
           write('@')
        else if (i>8) and (i<=32) then
           write(' ')
        else
           write('@');
    end;
end;

for j:=11 to 12 do
    begin
    gotoxy(k, j);
    for i:=0 to 38 do
    begin
     if i=0 then
        write(' ')
     else if i <= 8 then
           write('@')
        else if (i>8) and (i<=30) then
           write(' ')
        else
           write('@');
    end;
end;

gotoxy(k, 13);
for i:=0 to 38 do
begin
     if i=0 then
        write(' ')
     else if i <= 4 then
        write('@')
     else if (i>4) and (i<=34) then
          write(' ')
     else
         write('@');
end;

gotoxy(k, 14);
for i:=0 to 38 do
begin
     if i=0 then
        write(' ')
     else if (i <= 4) and (i>=1) then
        write('@')
     else if (i>4) and (i<=6) then
          write(' ')
     else if (i>6) and (i<=32) then
         write('@')
     else if (i>32) and (i<=34) then
         write(' ')
     else
         write('@');
end;

for j:=15 to 16 do
    begin
    gotoxy(k, j);
    for i:=1 to 38 do
    begin
        if i <= 1 then
           write(' ')
        else if (i>1) and (i<=12) then
           write('@')
        else if (i>12) and (i<=15) then
           write(' ')
        else if (i>15) and (i<=18) then
           write('@')
        else if (i>18) and (i<=21) then
           write(' ')
        else if (i>21) and (i<=24) then
           write('@')
        else if (i>24) and (i<=27) then
           write(' ')
        else
           write('@');
    end;
end;
gotoxy(k, 17);
    for i:=1 to 36 do
    begin
        if i <= 3 then
           write(' ')
        else if (i>3) and (i<=11) then
           write('@')
        else if (i>11) and (i<=15) then
           write(' ')
        else if (i>15) and (i<=18) then
           write('@')
        else if (i>18) and (i<=21) then
           write(' ')
        else if (i>21) and (i<=24) then
           write('@')
        else if (i>24) and (i<=28) then
           write(' ')
        else
           write('@');
    end;

for j:=18 to 21 do
    begin
    gotoxy(k, j);
    for i:=1 to 32 do
    begin
        if i <= 7 then
           write(' ')
        else if (i>7) and (i<=11) then
           write('@')
        else if (i>11) and (i<=28) then
           write(' ')
        else
           write('@');
    end;
end;

gotoxy(k, 22);
for i:=1 to 29 do
begin
     if i <= 10 then
        write(' ')
     else
         write('@');
end;

gotoxy(k, 23);
for i:=1 to 29 do
begin
     if i <= 10 then
        write(' ')
     else
         write('@');
end;
if d=false then
   k:=k+1
else
    begin
    k:=k-1;
    end;
if k=40 then
   begin
   d:=true;
   end;
if k=1 then
   begin
   d:=false;
   end;
delay(10);
sound(820);
delay(20);
if keypressed then
t:=readkey;
until (t='f');
NormVideo;
end;
procedure MenuPrincipal;{Procedimiento para el menu principal del juego}
var tecla:char; op:integer;
    procedure Centrar(S:String);  {Procedimiento para centrar el menu}
    var x:integer;
    begin
    x:=wherey;
    gotoxy(39-(Length(S) DIV 2),x);
    if (WhereY = op) and (op >= 13) then
       TextColor(red)
    else if (op >= 13) then
       TextColor(white);
    write(s);
    writeln;
    end;

begin
o:=false;
op:=13;
repeat
    TextBackground(0);
    clrscr;
    logo;
    gotoxy(1,13);
    Centrar('INICIAR JUEGO');
    Centrar('INSTRUCCIONES');
    Centrar('ANIMACION');
    Centrar('CREDITOS ');
    Centrar('SALIR');
    gotoXY(29,op);
    tecla:=readkey;
    if (tecla = #72) and (op > 13) then {Flecha arriba}
       begin
       op:= op-1;
       end;
    if (tecla = #80) and (op < 17) then {Flecha abajo}
       begin
       op:= op+1;
       end;
    if tecla = #13 then {Tecla enter}
       begin
            case op of {Seleccionar opcion del menu}
            13 : SeleccionarNivel;
            14 : instrucciones;
            15 : animacion;
            16 : creditos;
            17 : o := true;
            end;
       end;
until o = true;
end;

begin
assign(A,'C:\Documents and Settings\Admin\Mis documentos\A.txt');
cursoroff;
MenuPrincipal;
end.
