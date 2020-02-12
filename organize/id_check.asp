<!-- #Include virtual = "/lib/db.asp" -->
<%
Response.ContentType = "text/plain" 

mem_id = request("mem_id")


If f_sql_select(db_conn, "select * from mmember_temp where mem_id = '" & mem_id & "'", arrData) > 0 Then
	response.write language(lan,182) '이미 등록된 아이디입니다.
Else
	If f_sql_select(db_conn, "select * from mmember where mem_id = '" & mem_id & "'", arrData) > 0 Then
		response.write language(lan,182) '이미 등록된 아이디입니다.
	Else 
		response.write language(lan,183) '등록 가능한 아이디입니다.
	End If 
End if
'Response.write mem_id
%>
