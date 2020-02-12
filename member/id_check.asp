<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
Response.ContentType = "text/plain" 

mem_id = request("mem_id")

If f_sql_select(db_conn, "select * from mmember where mem_id = '" & mem_id & "'", arrData) > 0 Then
	response.write "N|The ID has already been registered." '이미 등록된 아이디입니다.
Else
	response.write "Y|The ID can be registered." '등록 가능한 아이디입니다.
End if
'Response.write mem_id
%>
