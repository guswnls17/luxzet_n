<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
Response.ContentType = "text/plain" 

mem_id = request("userid")
mem_txid = request("txid")
mem_amount = request("amount")

if IsEmpty(mem_id) then 
	response.write "fail - There is no userid." '등록 가능한 아이디입니다.
	Response.end
end if 

if IsEmpty(mem_txid) then 
	response.write "fail - There is no txid." '등록 가능한 아이디입니다.
	Response.end
end if 

if IsEmpty(mem_amount) then 
	response.write "fail - There is no amount." '등록 가능한 아이디입니다.
	Response.end
end if 


 response.write "OK" '등록 가능한 아이디입니다.


'If f_sql_select(db_conn, "select * from mmember_temp where mem_id = '" & mem_id & "'", arrData) > 0 Then
'	response.write "N|The ID has already been registered." '이미 등록된 아이디입니다.
'Else
'	response.write "Y|The ID can be registered." '등록 가능한 아이디입니다.
'End if

%>
