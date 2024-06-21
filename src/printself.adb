with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Source_Info;

procedure printself is
    F : File_Type;
begin
    Open (F, In_File, "src/" & GNAT.Source_Info.File);

    while not End_Of_File (F) loop
       Put_Line (Get_Line (F));
    end loop;

    Close(F);
end;
