<!-- #include virtual = "/myoffice/lib/db.asp" -->
<%
Response.ContentType = "text/plain" 


memno = Trim(request("memno"))

sql = "sp_회원_조직조회_상세3 '" & memno & "'"

lngDataCnt = f_sql_select_page(db_conn, sql, page, arrData)
If lngDataCnt > 0 Then 
	response.write "Members number: " & memno & Chr(13) & Chr(10)
	response.write "Join date: " & arrData(0, 0) & Chr(13) & Chr(10)
	'response.write "Sponsor: " & arrData(2, 0) & "(" & arrData(1, 0) & ")" & Chr(13) & Chr(10)
	response.write "Placement: " & arrData(4, 0) & "(" & arrData(3, 0) & ")" & Chr(13) & Chr(10)
	response.write "Order amount: " & FormatNumber(arrData(5, 0), 0) & Chr(13) & Chr(10)
	response.write "Order PV: " & FormatNumber(arrData(6, 0), 0) & Chr(13) & Chr(10)
	response.write "affiliated order amount: " & FormatNumber(arrData(7, 0), 0) & Chr(13) & Chr(10)
	response.write "affiliated order PV: " & FormatNumber(arrData(8, 0), 0) & Chr(13) & Chr(10)
End If

%>
