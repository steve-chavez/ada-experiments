package body Command is
   -- From https://stackoverflow.com/questions/17428961/piping-to-from-ada-program-to-a-c-program
   package Pipes is
      type Pipe is private;
      function Open_Read (Command : String) return Pipe;
      procedure Close (Stream : Pipe);
      function Get (Stream : Pipe) return Interfaces.C.int;
      function End_Of_File (Item : Interfaces.C.int) return Boolean;
      function To_Character (Item : Interfaces.C.int) return Character;
      function Get_Command_Output (Command : String) return Ada.Strings.Unbounded.Unbounded_String ;
   private
      use System;
      use Interfaces.C;
      type Pipe is new Address;
   end;

   package body Pipes is
      function popen (command : char_array; mode : char_array) return Address with Import, Convention => C, External_Name => "popen";
      function pclose (stream : Address) return int with Import, Convention => C, External_Name => "pclose";
      function fgetc (stream : Address) return int with Import, Convention => C, External_Name => "fgetc";
      function Open_Read (Command : String) return Pipe is
         Mode : constant char_array := "r" & nul;
         Result : Address;
      begin
         Result := popen (To_C (Command), Mode);
         if Result = Null_Address then
            raise Program_Error with "popen error";
         end if;
         return Pipe (Result);
      end;
      procedure Close (Stream : Pipe) is
         Result : int;
      begin
         Result := pclose (Address (Stream));
         if Result = -1 then
            raise Program_Error with "pclose error";
         end if;
      end;
      function Get (Stream : Pipe) return int is
      begin
         return fgetc (Address (Stream));
      end;
      function End_Of_File (Item : int) return Boolean is
         C_EOF: constant int := -1;
      begin
         return Item = C_EOF;
      end;
      function To_Character (Item : int) return Character is (Character'Val (int'Pos (Item)));

      function Get_Command_Output (Command : String) return Ada.Strings.Unbounded.Unbounded_String is
         use Pipes;
         use Ada.Strings.Unbounded;
         P : Pipe;
         C : Interfaces.C.int;
         S : Unbounded_String;
      begin
         P := Open_Read (Command);

         loop
            C := Get (P);
            exit when End_Of_File (C);
            Append(S, To_Character (C));
         end loop;

         Close (P);

         return S;
      end;
   end;

   function Command_Response(Request : AWS.Status.Data) return AWS.Response.Data is
      use Pipes;
      use Ada.Strings.Unbounded;
      S : Unbounded_String;
   begin
      S := Get_Command_Output("fortune");
      return AWS.Response.Build("text/plain", To_String(S));
   end;
end;
