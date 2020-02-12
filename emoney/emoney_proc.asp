<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
If (request("command") = "save") then

	memno = session("member")
	n_amount = CLng(request("n_amount"))
	n_istate = request("n_istate")
	n_memno = Trim(request("n_memno"))
	s_memno = ""
	n_table = ""

	If n_amount = "" Or CLng(n_amount) < 100 Then
		jsMessageBox "The amount must be at least 100$.", "", "document"
		Response.end
	End if

	If n_istate = "3" And n_memno >= "" Then
		sq1 = "select a.mem_code, (select mem_code from mmember where mem_code = a.mem_code) from mmember_temp a where a.mem_code = '" & n_memno & "' "
		If f_sql_select(db_conn, sq1, arrData) > 0 Then
			n_memno = arrData(0, 0)
			s_memno = arrData(1, 0)
		Else
			jsMessageBox "There is no registered member number.", "", "document"
			Response.end
		End If
	End If
	
	'현금전환-8% 차감, 선물하기-1.5%차감 mmember_emoney 저장
	r_charge = 0
	If n_istate = "1" Then
		r_amount= (CLng(n_amount))
		r_charge = (CLng(n_amount)*0.05)
	ElseIf n_istate = "3" Then
		r_amount= (CLng(n_amount))	
		r_charge = (CLng(n_amount)*0.05)
	Else
		r_amount= CLng(n_amount)
		r_charge = (CLng(n_amount)*0.05)
	End If
	
'	r_charge = (CLng(n_amount)*0.2)
	
	totalAmount = r_amount + r_charge
	
	'보유 이머니보다 신청금액이 큰지 채크
	sq1 = "select mem_ye_kum from mmember where mem_code = '" & memno & "' "
	If f_sql_select(db_conn, sq1, arrData) > 0 Then
			emoney = CLng(arrData(0, 0)) '보유 이머니 
	End If
		
	
	
		If LEN(s_memno)  > 6 Then 
			n_table = "mmember"
		Else 
			n_table = "mmember_temp"
		End If 
	
	'jsMessageBox "table " & n_table , "", "document" 		
	
	If CLng(n_amount) > CLng(emoney) Then
		jsMessageBox "Payment amount is greater than E-wallet.", "", "document" 	
	End If
	
	If CLng(totalAmount) > CLng(emoney) Then
		jsMessageBox "There is not enough commission.", "", "document" 	
	End If


    sql = "update mmember set mem_ye_kum = mem_ye_kum - " & totalAmount & " " _
		& "where mem_code = '" & memno & "' " _
		& " " _
		& "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_charge, emoney_no, " _
		& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code, emoney_datetime) " _
		& "select mem_code, convert(varchar(8), getdate(), 112), " & r_charge & ", " _
		& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
		& "where a.mem_code = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
		& "mem_name, (" & -r_amount & "), " _
		& "'" & n_istate & "', '" & iif(n_istate = "0", "1", "2") & "', '" & iif(n_istate = "3", n_memno, "") & "', getdate() " _
		& "from "&n_table&" a " _
		& "where mem_code = '" & memno & "' " _
		& "update "&n_table&" set " _
		& "mem_ye_kum = mem_ye_kum + " & r_amount & " " _
		& "where mem_code = '" & n_memno & "' " _
		& "and '" & n_istate & "' in ('3') "

	If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document"
	End If
	
	If n_istate = "0" Then
		
		

			sql = "update mmember set mem_rewards = isNull(mem_rewards,0) + " & r_amount & " " _
				& "where mem_code = '" & session("member") & "' " 
			
			If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process_r. Contact your administrator." + sql, "", "document"
			End If 
			
			'jsMessageBox "An error has occurred in the storage process5." & sql, "", "document"
	End if
	
	If n_istate = "3" Then
		ps_mem_code = ""
		ps_mem_name = ""
		sq1 = "select mem_code, mem_name from "&n_table&" where mem_code = '" & n_memno & "' "
				If f_sql_select(db_conn, sq1, arrData) > 0 Then
					ps_mem_code = arrData(0, 0) '보유 이머니 
					ps_mem_name = arrData(1, 0) '보유 이머니 
				End If
		

			sql = ""	
			sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
			& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code) values  (" _
			& "'" & ps_mem_code & "', convert(varchar(8), getdate(), 112), " _
			& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
			& "where '"&ps_mem_code&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
			& "N'"&ps_mem_name&"', (" & r_amount & "), " _
			& "'3', '1','" & n_memno & "' )" 
			
			If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process5. Contact your administrator." + sql, "", "document"
			End If 
			
			'jsMessageBox "An error has occurred in the storage process5." & sql, "", "document"
	end if
	
		jsMessageBox "The data has been saved.", "../coin.asp", "parent"
	

End If

%>
