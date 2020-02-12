<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
Response.ContentType = "text/plain" 

n_id = request("n_id")
bitaddr = request("bitaddr")

sql = "UPDATE mmember  SET mem_wbit_code = '"&bitaddr&"'  WHERE mem_id = '"&n_id&"' "
If f_sql_modify(db_conn, sql) < 0 Then
	response.write "N|The ID has already been registered." '이미 등록된 아이디입니다.
Else 
	response.write "Y|The ID can be registered." '등록 가능한 아이디입니다.		
End if

%>
