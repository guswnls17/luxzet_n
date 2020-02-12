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

lxzprice   = uploadform("lxzprice")
ecpusd   = uploadform("usd")
ecpusdt  = round((Cdbl(mem_price)/Cdbl(ecpusd)),8)
tpoint        = 0

mem_bigo = ""

'자리수 맞추는 함수	
	Function Format(ByVal szString, ByVal Expression)
		If Len(szString) < Len (Expression) Then
			format = Left(Expression, Len(Expression) - Len(szString)) & szString
		Else
			format = szString
		End If
	End Function 

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
	
	pse2 = 0
	
	If table = "" Then 
		mem_use = 0
	Else 
		mem_use = 1
		pse2 = 1
	End If 
	
	sqlb = "select erc_seq, erc_amount, erc_hoocode, bit_sale_number, erc_memcode, erc_memid from purchase_erc where erc_iaddr = '"&mem_sendaddr&"' and erc_idate >= '" & odate & "' and erc_idate <= '" & idate & "' order by erc_seq "
	'mem_type = 3 ecp 
	If f_sql_select(db_conn, sqlb, arrDatab) > 0 Then	
		mem_use = 0
		If mem_type = "3" or mem_type = 3 Then 
			
			sqli = "insert into ecpcoin (price_usd, ecp_hash, ecp_type, ecp_amount, ecp_fromaddr, idate, ecp_exchange ) values ('"&mem_price&"','trans"&idate&"','ecp','"&mem_amount&"','"&mem_sendaddr&"', '"&idate&"', '"&ecpusdt&"') "
		
			If f_sql_modify(db_conn, sqli) < 0 Then
			End If
			
			sqlb = "select erc_seq, erc_amount, erc_hoocode, bit_sale_number, erc_memcode, erc_memid from purchase_erc where erc_iaddr = '"&mem_sendaddr&"' and erc_amount <= '" &mem_amount& "' and erc_odate >= '" & odate & "' and erc_check = 0 order by erc_seq "
			bseq = ""
			bhoocode = ""
			bsalenumber = ""
			ecpcoin = ""
			salecoin = 0.0
			mem_code = ""
			mem_id = ""
			
			mem_name = ""
			table = "mmember_temp"
			
	'		Response.write sqlb
			If f_sql_select(db_conn, sqlb, arrDatab) > 0 Then						'purchase_erc 해당 정보가 있을 경우 
				bseq = arrDatab(0,0)
				bhoocode = arrDatab(2,0)
				bsalenumber = arrDatab(3,0)
				ecpcoin = arrDatab(1,0)
				mem_code = arrDatab(4,0)
				mem_id = arrDatab(5,0)
				
				ecpcoin = Cdbl(ecpcoin)
				amount = Cdbl(amount)
				
				sqlst         = "select mem_code, mem_id, mem_name from mmember_temp where mem_id = '"&mem_id&"'" 
				If f_sql_select(db_conn, sqlst, arrData) > 0 Then
					mem_code = arrData(0,0)
					mem_name = arrData(2,0)
				End If 
				sqlst         = "select mem_code, mem_id, mem_name  from mmember where mem_id = '"&mem_id&"'" 
				If f_sql_select(db_conn, sqlst, arrData) > 0 Then
					mem_code = arrData(0,0)
					mem_name = arrData(2,0)
					table = "mmember"
				End If 
				
				If table = "mmember_temp" then 
					sql = "update mmember_temp set mem_hoo_code = '" & bhoocode & "' where mem_id = '"&mem_id&"'" 
					If f_sql_modify(db_conn, sql) < 0 Then
	'							jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					End If
					
					sq1 = "insert into mmember select * from mmember_temp where mem_id = '" & mem_id & "'"

					If f_sql_modify(db_conn, sq1) > 0 Then
						table = "mmember"
	'					response.write "mmember change"
	'							jsMessageBox "An error has occurred in the storage process-000. Contact your administrator." , "", "document"
					End If 
				end if 
				
				sale_date = sy & sm & sd 
				
				sq1 = "select isnull(max(sale_number), 0) from sale01 where sale_date = '" & sale_date & "' "

				If f_sql_select(db_conn, sq1, arrData) > 0 Then

					If  arrData(0, 0) = "0"  Then
						order_no =Trim(sale_date&"00001")
					Else
						order_no =Trim(sale_date&Format(RIGHT(arrData(0, 0),5)+1,"00000"))
						
					End If
				End If
					
				orderNumber = order_no
				
				sql01 = "insert into sale01(" _
					 & "sale_mem_code, sale_name, sale_number, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
					 & "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_count, " _
					 & "sale_pan_kum, sale_agency_code, sale_bigo " _
					 & ") select " _
					 & "sale_mem_code, sale_name, '" & orderNumber & "', sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
					 & "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_count, " _
					 & "sale_pan_kum, sale_agency_code, sale_bigo from sale01_bit where sale_number = '" & bsalenumber & "' "
				If f_sql_modify(db_conn, sql01) < 0 Then
	'						jsMessageBox "An error has occurred in the storage process. Contact your administrator num1.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					sqlu = "update ecpcoin set ecp_bigo = 'update fail' where ecp_hash = 'trans"&idate&"'  "
					
					If f_sql_modify(db_conn, sqlu) < 0 Then
					End If 
				Else
				
					sql02 = "insert into sale02(" _
						  & "sale_mem_code, sale_number,sale_no, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
						  & "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, " _
						  & " sale_bigo " _
						  & ") select " _
						  & "sale_mem_code,'" & orderNumber & "',sale_no, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
						  & "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, " _
						  & " sale_bigo from sale02_bit where sale_number = '" & bsalenumber & "' "
					
					If f_sql_modify(db_conn, sql02) < 0 Then
	'						jsMessageBox "An error has occurred in the storage process. Contact your administrator num1.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					Else
					
						sqlb = "update purchase_erc set erc_check = '1' , erc_txid = 'trans"&idate&"' , new_sale_number = '" & orderNumber & "' where erc_seq = '" & bseq & "' "
						If f_sql_modify(db_conn, sqlb) < 0 Then
						
						End If 
						
						sq1 = "select sale_kum from sale01_bit where sale_number = '" & bsalenumber & "' "
						sale_kum = 0
						If f_sql_select(db_conn, sq1, arrData) > 0 Then
							sale_kum = arrData(0, 0)
						End If 
						lxzAmt = round(Cdbl(lxzprice)/Cdbl(ecpusd),5)
						newlxzamount = round((Cdbl(sale_kum)/lxzAmt),4)
						
						lxzcoin_1 = Cdbl(newlxzamount) * 1.2
						
						'프로시저 호출 
						sql = "exec coin_insert @ls_code='"&mem_code&"',@ls_date='"&sale_date&"',@ld_coin='"&lxzcoin_1&"',@ls_chk='0'"

						If f_sql_modify(db_conn, sql) < 0 Then
							'jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
						End If 
						
						mem_bigo = "ecp sales"&bsalenumber

						'프로시저 호출 끝
						mem_use = 1
						pse2 = 0
					End If
				
				End If
				
'				salecoin = amount - ecpcoin
				
'				ppskum = round(salecoin*ecpusdt,2)
				
'				If salecoin > 0 Then 
'					sqlu = "update mmember set mem_ye_kum = mem_ye_kum + ("&ppskum&") where mem_id = '"&mem_id&"' "
'					If f_sql_modify(db_conn, sqlu) < 0 Then
					
'					End If
					
'					sqlu = "update mmember_temp set mem_ye_kum = mem_ye_kum + ("&ppskum&") where mem_id = '"&mem_id&"' "
'					If f_sql_modify(db_conn, sqlu) < 0 Then
					
'					End If
					
'					sql = ""	
'					sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
'					& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code, emoney_datetime, emoney_price) values ( " _
'					& "'" & mem_code & "', convert(varchar(8), getdate(), 112), " _
'					& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
'					& "where '"&mem_code&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
'					& "'"&mem_name&"', (" & ppskum & "), " _
'					& "'A', '1','', getdate(), '"&ecpusdt & "' )" 
'				
'					If f_sql_modify(db_conn, sql) < 0 Then
'					End If 
				
'				End If 
			
			End If 
			
		End If 
		
		
	End If 
	
	sqlc = "select erc_seq, erc_amount, erc_hoocode, bit_sale_number, erc_memcode, erc_memid from purchase_erc2 where erc_iaddr = '"&mem_sendaddr&"' and erc_idate >= '" & odate & "' and erc_idate <= '" & idate & "' order by erc_seq "
	'mem_type = 6 lxz 
	If f_sql_select(db_conn, sqlc, arrDatab) > 0 Then	
		mem_use = 0
		If mem_type = "6" or mem_type = 6 Then 
			
			sqli = "insert into lxzcoin (price_usd, lxz_hash, lxz_type, lxz_amount, lxz_fromaddr, idate, lxz_exchange ) values ('"&mem_price&"','trans"&idate&"','lxz','"&mem_amount&"','"&mem_sendaddr&"', '"&idate&"', '"&ecpusdt&"') "
		
			If f_sql_modify(db_conn, sqli) < 0 Then
			End If
			
			sqlb = "select erc_seq, erc_amount, erc_hoocode, bit_sale_number, erc_memcode, erc_memid from purchase_erc2 where erc_iaddr = '"&mem_sendaddr&"' and erc_amount <= '" &mem_amount& "' and erc_odate >= '" & odate & "' and erc_check = 0 order by erc_seq "
			bseq = ""
			bhoocode = ""
			bsalenumber = ""
			ecpcoin = ""
			salecoin = 0.0
			mem_code = ""
			mem_id = ""
			
			mem_name = ""
			table = "mmember_temp"
			
	'		Response.write sqlb
			If f_sql_select(db_conn, sqlb, arrDatab) > 0 Then						'purchase_erc 해당 정보가 있을 경우 
				bseq = arrDatab(0,0)
				bhoocode = arrDatab(2,0)
				bsalenumber = arrDatab(3,0)
				ecpcoin = arrDatab(1,0)
				mem_code = arrDatab(4,0)
				mem_id = arrDatab(5,0)
				
				ecpcoin = Cdbl(ecpcoin)
				amount = Cdbl(amount)
				
				sqlst         = "select mem_code, mem_id, mem_name from mmember_temp where mem_id = '"&mem_id&"'" 
				If f_sql_select(db_conn, sqlst, arrData) > 0 Then
					mem_code = arrData(0,0)
					mem_name = arrData(2,0)
				End If 
				sqlst         = "select mem_code, mem_id, mem_name  from mmember where mem_id = '"&mem_id&"'" 
				If f_sql_select(db_conn, sqlst, arrData) > 0 Then
					mem_code = arrData(0,0)
					mem_name = arrData(2,0)
					table = "mmember"
				End If 
				
				If table = "mmember_temp" then 
					sql = "update mmember_temp set mem_hoo_code = '" & bhoocode & "' where mem_id = '"&mem_id&"'" 
					If f_sql_modify(db_conn, sql) < 0 Then
	'							jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					End If
					
					sq1 = "insert into mmember select * from mmember_temp where mem_id = '" & mem_id & "'"

					If f_sql_modify(db_conn, sq1) > 0 Then
						table = "mmember"
	'					response.write "mmember change"
	'							jsMessageBox "An error has occurred in the storage process-000. Contact your administrator." , "", "document"
					End If 
				end if 
				
				sale_date = sy & sm & sd 
				
				sq1 = "select isnull(max(sale_number), 0) from sale01 where sale_date = '" & sale_date & "' "

				If f_sql_select(db_conn, sq1, arrData) > 0 Then

					If  arrData(0, 0) = "0"  Then
						order_no =Trim(sale_date&"00001")
					Else
						order_no =Trim(sale_date&Format(RIGHT(arrData(0, 0),5)+1,"00000"))
						
					End If
				End If
					
				orderNumber = order_no
				
				sql01 = "insert into sale01(" _
					 & "sale_mem_code, sale_name, sale_number, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
					 & "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_count, " _
					 & "sale_pan_kum, sale_agency_code, sale_bigo " _
					 & ") select " _
					 & "sale_mem_code, sale_name, '" & orderNumber & "', sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
					 & "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_count, " _
					 & "sale_pan_kum, sale_agency_code, sale_bigo from sale01_bit where sale_number = '" & bsalenumber & "' "
				If f_sql_modify(db_conn, sql01) < 0 Then
	'						jsMessageBox "An error has occurred in the storage process. Contact your administrator num1.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					sqlu = "update lxzcoin set lxz_bigo = 'update fail' where lxz_hash = 'trans"&idate&"'  "
					
					If f_sql_modify(db_conn, sqlu) < 0 Then
					End If 
				Else
				
					sql02 = "insert into sale02(" _
						  & "sale_mem_code, sale_number,sale_no, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
						  & "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, " _
						  & " sale_bigo " _
						  & ") select " _
						  & "sale_mem_code,'" & orderNumber & "',sale_no, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
						  & "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, " _
						  & " sale_bigo from sale02_bit where sale_number = '" & bsalenumber & "' "
					
					If f_sql_modify(db_conn, sql02) < 0 Then
	'						jsMessageBox "An error has occurred in the storage process. Contact your administrator num1.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					Else
					
						sqlb = "update purchase_erc2 set erc_check = '1' , erc_txid = 'trans"&idate&"' , new_sale_number = '" & orderNumber & "' where erc_seq = '" & bseq & "' "
						If f_sql_modify(db_conn, sqlb) < 0 Then
						
						End If 
						
						lxzcoin_1 = Cdbl(mem_amount) * 1.2

						
						'프로시저 호출 
						sql = "exec coin_insert @ls_code='"&mem_code&"',@ls_date='"&sale_date&"',@ld_coin='"&lxzcoin_1&"',@ls_chk='0'"

						If f_sql_modify(db_conn, sql) < 0 Then
							'jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
						End If 
						
						mem_bigo = "lxz sales"&bsalenumber

						'프로시저 호출 끝
						mem_use = 1
						pse2 = 0
					End If
				
				End If
				
'				salecoin = amount - ecpcoin
				
'				ppskum = round(salecoin*ecpusdt,2)
				
'				If salecoin > 0 Then 
'					sqlu = "update mmember set mem_ye_kum = mem_ye_kum + ("&ppskum&") where mem_id = '"&mem_id&"' "
'					If f_sql_modify(db_conn, sqlu) < 0 Then
					
'					End If
					
'					sqlu = "update mmember_temp set mem_ye_kum = mem_ye_kum + ("&ppskum&") where mem_id = '"&mem_id&"' "
'					If f_sql_modify(db_conn, sqlu) < 0 Then
					
'					End If
					
'					sql = ""	
'					sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
'					& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code, emoney_datetime, emoney_price) values ( " _
'					& "'" & mem_code & "', convert(varchar(8), getdate(), 112), " _
'					& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
'					& "where '"&mem_code&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
'					& "'"&mem_name&"', (" & ppskum & "), " _
'					& "'A', '1','', getdate(), '"&ecpusdt & "' )" 
'				
'					If f_sql_modify(db_conn, sql) < 0 Then
'					End If 
				
'				End If 
			
			End If 
			
		End If 
		
	End If 
	
	
	
	
	
'	If tpoint > 0  And LEN(mem_id) > 0 Then 
	If 1=1 Then 
		sql = "insert into mmember_trans(" _
		& "trans_id, trans_date, trans_saddr, trans_raddr, trans_amount, trans_price, trans_point, trans_check, trans_use, trans_memo " _
		& ") VALUES ('" & mem_id & "',  " _
		& "'"&mem_tdatei&"', '"&mem_sendaddr&"', '"&mem_receaddr&"','"&mem_amount&"','"&mem_price&"','"&tpoint&"','"&mem_type&"','"&mem_use&"', '"&mem_bigo&"' " _
		& ")"

		If f_sql_modify(db_conn, sql) < 0 Then
			response.write "Trans Insert Fail" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		Else 
			If pse2=1 Then 
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
