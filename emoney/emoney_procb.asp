<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
If (request("command") = "save") then

	memno = session("member")
	n_amount = CLng(request("n_amount"))
	n_istate = request("n_istate")


	If n_amount = "" Or CLng(n_amount) < 1 Then
		jsMessageBox "The amount must be at least 1$.", "", "document"
		Response.end
	End if


	
	'현금전환-8% 차감, 선물하기-1.5%차감 mmember_emoney 저장
	r_charge = 0
	If n_istate = "1" Then
		r_amount= (CLng(n_amount))
		'r_charge = (CLng(n_amount)*0.1)
	ElseIf n_istate = "3" Then
		r_amount= (CLng(n_amount))	
	Else
		r_amount= CLng(n_amount)
	End If
	
	'보유 이머니보다 신청금액이 큰지 채크
	sq1 = "select mem_bcoin from mmember where mem_code = '" & memno & "' "
	If f_sql_select(db_conn, sq1, arrData) > 0 Then
			bmoney = CLng(arrData(0, 0)) '보유 이머니 
	End If
		
	If n_amount > bmoney Then
		jsMessageBox "Payment amount is greater than Gcoin.", "", "document" 	
	End If



    sql = "update mmember set mem_bcoin = mem_bcoin - " & n_amount & " " _
		& "where mem_code = '" & memno & "' " _
		& "and '" & n_istate & "' in ('1', '2', '3') " _
		& "insert into coin_banking_his (mem_code, seq, mem_name, date, " _
		& "pay, gbn, state) " _
		& "select mem_code,  " _
		& "isnull((select isnull(max(seq), 0) from coin_banking_his b " _
		& " ), 0) + 1,  " _
		& "mem_name, convert(varchar(8), getdate(), 112), (" & -r_amount & "), " _
		& "'" & n_istate & "', '0' " _
		& "from mmember a " _
		& "where mem_code = '" & memno & "' "  

	If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator."&sql, "", "document"
	End If
	

	
		jsMessageBox "The data has been saved.", "../bcoin.asp", "parent"
	

End If

%>
