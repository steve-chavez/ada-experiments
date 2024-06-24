# Ada Experiments

### Fortune Server

Server that outputs the `fortune` command output:

```console
$ nix-shell
$ make server
$ ./bin/server
Fortune server running on port 9000

$ curl localhost:9000
The life which is unexamined is not worth living.
                -- Plato
```

### Program that prints itself

```console
$ nix-shell
$ make printself
$ ./bin/printself
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
```
