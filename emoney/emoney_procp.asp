<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
If (request("command") = "save") then

	memno = session("member")
	n_amount = CLng(request("n_amount"))
	n_istate = request("n_istate")
	n_memno = Trim(request("n_memno"))
	temp = Trim(request("tempuser"))
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
		'r_charge = (CLng(n_amount)*0.05)
	Else
		r_amount= CLng(n_amount)
		r_charge = (CLng(n_amount)*0.05)
	End If
	
	totalAmount = r_amount + r_charge
	
	'보유 이머니보다 신청금액이 큰지 채크
	sq1 = "select mem_rewards from mmember where mem_code = '" & memno & "' "
	If f_sql_select(db_conn, sq1, arrData) > 0 Then
			mem_rewards = CLng(arrData(0, 0)) '보유 이머니 
	End If
		
	
	
	
		If temp  = "1" Then  
			n_table = "mmember_temp"
		Else 
			n_table = "mmember"
		End If 
	
	'jsMessageBox "table " & n_table , "", "document" 		

		
	If CLng(n_amount) > CLng(mem_rewards) Then
		jsMessageBox "Payment amount is greater than Point.", "", "document" 	
	End If
	
	If CLng(totalAmount) > CLng(mem_rewards) Then
		jsMessageBox "There is not enough commission.", "", "document" 	
	End If

    sql = "update mmember set mem_rewards = mem_rewards - " & totalAmount & " " _
		& "where mem_code = '" & memno & "' " _
		& "  " _
		& "insert into mmember_rewards (rewards_mem_code, rewards_idate, rewards_no, rewards_odate, rewards_kum, rewards_istate, rewards_ostate, rewards_give_code) " _
		& "select mem_code, convert(varchar(8), getdate(), 112), " _
		& "isnull((select isnull(max(rewards_no), 0) from mmember_rewards b " _
		& "where a.mem_code = b.rewards_mem_code and b.rewards_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
		& " convert(varchar(8), getdate(), 112), -"&CLng(r_amount)&", '"&n_istate&"', '1', '" & iif(n_istate = "3", n_memno, "") & "' " _
		& "from "&n_table&" a " _
		& "where mem_code = '" & memno & "' " _
		& "update "&n_table&" set " _
		& "mem_rewards = isnull(mem_rewards,0) + " & r_amount & " " _
		& "where mem_code = '" & n_memno & "' " _
		& "and '" & n_istate & "' in ('3') "

	If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document"
	End If
	
	If n_istate = "3" Then
		ps_mem_code = ""
		ps_mem_name = ""
		sq1 = "select mem_code, mem_name from "&n_table&" where mem_code = '" & n_memno & "' "
				If f_sql_select(db_conn, sq1, arrData) > 0 Then
					ps_mem_code = arrData(0, 0) '보유 이머니 
					ps_mem_name = arrData(1, 0) '보유 이머니 
				End If
		

			sql = ""	
			sql = sql & "insert into mmember_rewards (rewards_mem_code, rewards_idate, rewards_no, rewards_odate, rewards_kum, rewards_istate, rewards_ostate, rewards_give_code) values  (" _
			& "'" & ps_mem_code & "', convert(varchar(8), getdate(), 112), " _
			& "isnull((select isnull(max(rewards_no), 0) from mmember_rewards b " _
			& "where '"&ps_mem_code&"' = b.rewards_mem_code and b.rewards_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
			& " convert(varchar(8), getdate(), 112), "&CLng(r_amount)&", '"&n_istate&"', '1' , '"&memno&"' )" 
			
			If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process5. Contact your administrator." + sql, "", "document"
			End If 
			
			'jsMessageBox "An error has occurred in the storage process5." & sql, "", "document"
	end if
	
		jsMessageBox "The data has been saved.", "../coinp.asp", "parent"
	

End If

%>
