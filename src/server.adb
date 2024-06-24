with Ada.Text_IO; use Ada.Text_IO;
with AWS.Default;
with AWS.Server;
with Command;

procedure Server is
    WS   : AWS.Server.HTTP;
    Port : Positive         := 9000;
    Name : String           := "Fortune";
begin
    Put_Line(Name & " server running on port" & Port'Image);
    AWS.Server.Start(WS, Name,
                     Max_Connection => 1,
                     Port => Port,
                     Callback => Command.Command_Response'Access);
    AWS.Server.Wait(AWS.Server.Forever);
    AWS.Server.Shutdown(WS);
end;
