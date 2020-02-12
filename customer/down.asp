<%@CodePage = 65001%>
<%
	response.charset = "UTF-8"
	'session.codepage = 65001 


file	= Request.querystring("filename")

fpath	= Request.querystring("fpath")  
'Response.write fpath&file
'Response.end
Response.ContentType = "application/unknown" 
If Instr(strUA, "MSIE 5.5") > 0 Then
  Response.AddHeader "Content-Disposition","filename=" & Server.URLPathEncode(file)
Else
  Response.AddHeader "Content-Disposition","attachment; filename=" & Server.URLPathEncode(file)  
End If 
Set objStream = Server.CreateObject("ADODB.Stream")  
objStream.Open 
objStream.Type = 1 
objStream.LoadFromFile fpath & file 
download = objStream.Read
Response.BinaryWrite download  
Set objstream = nothing  %>  