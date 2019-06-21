program LoliBlink;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this },
  GPIO, Crt, SysUtils;

var
  BinaryOut: TBinaryOutput;
  Status: Boolean;
  x: Char;

begin
  BinaryOut := TBinaryOutput.Create(nil);
  try
    BinaryOut.Address := 17;
    Status := False;
    x := #0;
    WriteLn('A LED at GPIO port 17 should blink now with about 1 Hz');
    WriteLn('Press "q" to exit!');
    repeat
      if KeyPressed then x := ReadKey;
      Status := not Status;
      BinaryOut.Value := Status;
      Sleep(500)
    until x = 'q';
  finally
    BinaryOut.Value := False;
    BinaryOut.Free
  end;
end.

