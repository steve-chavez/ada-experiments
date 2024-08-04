pragma Ada_2022;
with Ada.Text_IO; use Ada.Text_IO;

procedure pointers is
  type PointerToHeapInt is access integer;
  pi: PointerToHeapInt;

  type PointerToStackInt is access all integer;
  i: aliased integer; -- allow taking a pointer
  mu: PointerToStackInt;
begin
  pi := new integer; -- allocate from the pointer's heap
  pi.all := 42;

  mu := i'access;
  mu.all :=  35;

  Put_Line ("pi: " & pi.all'Image);
  Put_Line ("mu: " & mu.all'Image);
end;
