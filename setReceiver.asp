<!-- #Include virtual = "/myoffice/lib/db.asp" -->

<%

Response.ContentType = "text/plain" 
Set uploadform = server.createobject("ABCUpload4.XForm")'XForm객체 생성

mem_id = uploadform("id")
mem_tdatei = uploadform("tdatei")
mem_sendaddr = uploadform("sendaddr")
mem_receaddr = uploadform("receaddr")
mem_amount = uploadform("amount")
mem_price = uploadform("price")
mem_type = uploadform("type")
mem_use = uploadform("use")
mem_krw_list = uploadform("krw_list")
mem_trades_list = uploadform("trades_list")
tpoint        = 0

If LEN(mem_amount) > 0 And LEN(mem_price) > 0 And LEN(mem_sendaddr) > 0 And LEN(mem_receaddr) > 0 Then
		tpoint = Cdbl(mem_amount) * (Cdbl(mem_price)/ 1300)
	End If 
	
	If LEN(mem_type) < 1 Then 
	  mem_type = "0"
	End If 
	
	If LEN(mem_use) < 1 Then 
	  mem_use = "0"
	End If 
	
	table = ""
	name = ""
	sqlst         = "select mem_id, mem_name  from mmember_temp where mem_id = '"&mem_id&"'" 
	If f_sql_select(db_conn, sqlst, arrData) > 0 Then
		table = "mmember_temp"
		name = arrData(1,0)
	End If 
	
	sqlst         = "select mem_id, mem_name  from mmember where mem_id = '"&mem_id&"'" 
	If f_sql_select(db_conn, sqlst, arrData) > 0 Then
		table = "mmember"
		name = arrData(1,0)
	End If 
	
	
	
	sy = Year(Date)
	sm = Month(Date)
	sd = Day(Date)

	 if(Len(sm) = 1 ) then sm = "0" & sm
	 if(Len(sd) = 1 ) then sd = "0" & sd
	 
	  now_hour   = right("0" & hour(now), 2)
	now_minute = right("0" & minute(now), 2)
	now_second = right("0" & second(now), 2)

	new_sy = Year(DateAdd("h",-6,now()))
	new_sm = Month(DateAdd("h",-6,now()))
	new_sd = Day(DateAdd("h",-6,now()))
	if(Len(new_sm) = 1 ) then new_sm = "0" & new_sm
	if(Len(new_sd) = 1 ) then new_sd = "0" & new_sd
	new_hour   = right("0" & hour(DateAdd("h",-6,now())), 2)
	new_minute = right("0" & minute(DateAdd("h",-6,now())), 2)
	new_second = right("0" & second(DateAdd("h",-6,now())), 2)
	
	idate = sy &""& sm &""& sd &""& now_hour &""& now_minute &""& now_second
	odate = new_sy &""& new_sm &""& new_sd &""& new_hour &""& new_minute &""& new_second
	
	If table = "" Then 
		mem_use = 0
	Else 
		mem_use = 1
	End If 
	
	sqlb = "select erc_seq, erc_amount, erc_hoocode, bit_sale_number, erc_memcode, erc_memid from purchase_erc2 where erc_iaddr = '"&mem_sendaddr&"' and erc_idate >= '" & odate & "' and erc_idate <= '" & idate & "' order by erc_seq "
	
	If f_sql_select(db_conn, sqlb, arrDatab) > 0 Then	
		mem_use = 0
	End If 
	
	sqlc = "select erc_seq, erc_amount, erc_hoocode, bit_sale_number, erc_memcode, erc_memid from purchase_erc where erc_iaddr = '"&mem_sendaddr&"' and erc_idate >= '" & odate & "' and erc_idate <= '" & idate & "' order by erc_seq "
	
	If f_sql_select(db_conn, sqlc, arrDatab) > 0 Then	
		mem_use = 0
	End If 
	
	
	
	
	
'	If tpoint > 0  And LEN(mem_id) > 0 Then 
	If 1=1 Then 
		sql = "insert into mmember_trans(" _
		& "trans_id, trans_date, trans_saddr, trans_raddr, trans_amount, trans_price, trans_point, trans_check, trans_use, trans_memo " _
		& ") VALUES ('" & mem_id & "',  " _
		& "'"&mem_tdatei&"', '"&mem_sendaddr&"', '"&mem_receaddr&"','"&mem_amount&"','"&mem_price&"','"&tpoint&"','"&mem_type&"','"&mem_use&"', '' " _
		& ")"

		If f_sql_modify(db_conn, sql) < 0 Then
			response.write "Trans Insert Fail" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		Else 
			If mem_use=1 Then 
				sql = "insert into mmember_rewards (" _
				& "rewards_mem_code, rewards_idate, rewards_no, rewards_odate, rewards_kum, rewards_istate, rewards_ostate) " _
				& " select mem_code, convert(varchar(8), getdate(), 112), " _
				& " isnull((select isnull(max(rewards_no), 0) from mmember_rewards b " _
				& " where a.mem_code = b.rewards_mem_code and b.rewards_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
				& " convert(varchar(8), getdate(), 112), "&tpoint&", '"&mem_type&"', '"&mem_use&"' " _
				& " from "&table&" a " _
				& " where mem_id = '"&mem_id&"' "

				If f_sql_modify(db_conn, sql) < 0 Then
				End If
				
				
			
				sql = "UPDATE "&table&" SET mem_rewards = IsNULL( mem_rewards, 0 ) + "&tpoint&"  WHERE mem_id = '"&mem_id&"'"
				If f_sql_modify(db_conn, sql) < 0 Then
					response.write "Member update Fail" '저장 실패
				Else 
					response.write "success" '성공
				End if
			Else 
				response.write "success" '성공
			End If 
		End If
	Else 
		response.write "Check the Data1" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
	End If 


%>
