with System;
with Interfaces.C;
with Ada.Strings.Unbounded;
with AWS.Response;
with AWS.Status;

package Command is
   function Command_Response (Request: AWS.Status.Data) return AWS.Response.Data;
end Command;
