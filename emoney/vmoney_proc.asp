<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
If (request("command") = "save") then

	memno = session("member")
	n_amount = CLng(request("n_amount"))
	n_istate = request("n_istate")
	s_walletaddr = Trim(request("s_walletaddr"))
	s_memno = ""
	n_table = ""

	If n_istate = "3" Then
		If n_amount = "" Or CLng(n_amount) < 500 Then
			jsMessageBox "The amount must be at least 500 coin.", "", "document"
			Response.end
		End if
	Else 
		If n_amount = "" Or CLng(n_amount) < 3000 Then
			jsMessageBox "The amount must be at least 3000 coin.", "", "document"
			Response.end
		End if
	End if 
	

	If n_istate = "3" And s_walletaddr = "" Then
			jsMessageBox "There is no Send Wallet Address.", "", "document"
			Response.end

	End If
	
	If n_istate = "9" And s_walletaddr = "" Then
			jsMessageBox "There is no Send Wallet Address.", "", "document"
			Response.end

	End If
	
	'현금전환-8% 차감, 선물하기-1.5%차감 mmember_emoney 저장
	r_charge = 0
	If n_istate = "1" Then
		r_amount= (CLng(n_amount))
		r_charge = 0
	ElseIf n_istate = "3" Then
		r_amount= (CLng(n_amount))	
		r_charge = 0
	ElseIf n_istate = "9" Then
		r_amount= (CLng(n_amount))	
		r_charge = 0
	Else
		r_amount= CLng(n_amount)
	End If
	
	totalAmount = r_amount + r_charge
	
	'보유 이머니보다 신청금액이 큰지 채크
	sq1 = "select mem_bcoin  from mmember where mem_code = '" & memno & "' "
	If f_sql_select(db_conn, sq1, arrData) > 0 Then
			vmoney = CLng(arrData(0, 0)) '보유 이머니 
	End If
		
	If n_amount > vmoney Then
		jsMessageBox "Payment amount is greater than Vcoin.", "", "document" 	
	End If
	

	n_table = "mmember"
	'jsMessageBox "table " & n_table , "", "document" 		


    sql = "update mmember set mem_bcoin = mem_bcoin - " & totalAmount & " " _
		& "where mem_code = '" & memno & "' " _
		& "and '" & n_istate & "' in ('1', '2', '3','5','9') " _
		& "insert into coin_banking_his (mem_code, date, mem_name, seq, " _
		& "pay, gbn, state, bigo) " _
		& "select mem_code, convert(varchar(8), getdate(), 112), mem_name, " _
		& "isnull((select isnull(max(seq), 0) from coin_banking_his b " _
		& "where a.mem_code = b.mem_code), 0) + 1, " _
		& " (" & -r_amount & "), " _
		& "'" & n_istate & "', '0', '" & s_walletaddr & "' " _
		& "from mmember a " _
		& "where mem_code = '" & memno & "' " 
		
'	response.write sql

	If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document"
	End If
	
		jsMessageBox "The data has been saved.", "../twicecoin.asp", "parent"
	

End If

%>
