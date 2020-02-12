<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
Response.ContentType = "text/plain" 

lxzprice   = TRIM(request("lxz")) 
ecpusd   = TRIM(request("ecpusd")) 

btcwon   = TRIM(request("btcwon"))    
           
userid = TRIM(request("userid"))               
amount     = TRIM(request("amount"))
txid   = TRIM(request("txid")) 

'자리수 맞추는 함수	
	Function Format(ByVal szString, ByVal Expression)
		If Len(szString) < Len (Expression) Then
			format = Left(Expression, Len(Expression) - Len(szString)) & szString
		Else
			format = szString
		End If
	End Function 
	
sy = Year(Date)
sm = Month(Date)
sd = Day(Date)

 if(Len(sm) = 1 ) then sm = "0" & sm
 if(Len(sd) = 1 ) then sd = "0" & sd	
 now_hour   = right("0" & hour(now), 2)
now_minute = right("0" & minute(now), 2)
now_second = right("0" & second(now), 2)

odate = sy &""& sm &""& sd &""& now_hour &""& now_minute &""& now_second

sqlst         = "select mem_code, mem_id, mem_name from mmember_temp where mem_id = '"&userid&"'" 
'Response.write sqlst
mem_code = ""
mem_name = ""
account = ""
table = "mmember_temp"

If f_sql_select(db_conn, sqlst, arrData) > 0 Then
			mem_code = arrData(0,0)
			account = arrData(1,0)
			mem_name = arrData(2,0)
End If 		
	

'Response.write   "no mmember_temp "
sqlst         = "select mem_code, mem_id, mem_name  from mmember where mem_id = '"&userid&"'" 
If f_sql_select(db_conn, sqlst, arrData) > 0 Then
	mem_code = arrData(0,0)
	account = arrData(1,0)
	mem_name = arrData(2,0)
	table = "mmember"
End If 

If mem_code <> "" Then
		
	sql = "select * from bitcoin where bit_txid = '"&txid&"'" 
'	Response.write sql
	If f_sql_select(db_conn, sql, arrData) = 0 Then
		sqli = "insert into bitcoin (bit_id, bit_amount, bit_txid, bit_coin, bit_exchange ) values ('"&account&"',("&amount&"*"&btcwon&"),'"&txid&"',"&amount&","&btcwon&") "
		
		If f_sql_modify(db_conn, sqli) < 0 Then
		End If
		
		sqlb = "select seq, amountt, hoocode, bit_sale_number, bitcoin, bitexchange from parchase_coin where mem_id = '"&account&"' and bitcoin <= '" &amount& "' and odate >= '" & odate & "' and gubun = 2 order by seq "
		bseq = ""
		bhoocode = ""
		bsalenumber = ""
		bitcoin = ""
		salecoin = 0.0
'		Response.write sqlb
		If f_sql_select(db_conn, sqlb, arrDatab) > 0 Then						'parchase_coin 해당 정보가 있을 경우 
			bseq = arrDatab(0,0)
			bhoocode = arrDatab(2,0)
			bsalenumber = arrDatab(3,0)
			bitcoin = arrDatab(4,0)
			
			bitcoin = Cdbl(bitcoin)
			amount = Cdbl(amount)
			btcwon = Cdbl(arrDatab(5,0))
			
			
			
			If table = "mmember_temp" then 
				sql = "update mmember_temp set mem_hoo_code = '" & bhoocode & "' where mem_id = '"&account&"'" 
				If f_sql_modify(db_conn, sql) < 0 Then
'							jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
				End If
				
				sq1 = "insert into mmember select * from mmember_temp where mem_id = '" & account & "'"

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
				
					sqlb = "update parchase_coin set gubun = '1' , bit_txid = '" & txid & "', odate = '" & odate & "' , new_sale_number = '" & orderNumber & "' where seq = '" & bseq & "' "
					If f_sql_modify(db_conn, sqlb) < 0 Then
					
					End If 
					
					sq1 = "select sale_kum from sale01_bit where sale_number = '" & bsalenumber & "' "
					sale_kum = 0
					If f_sql_select(db_conn, sq1, arrData) > 0 Then
						sale_kum = arrData(0, 0)
					End If 
					lxzAmt = round(Cdbl(lxzprice)/Cdbl(ecpusd),5)
					newlxzamount = round((Cdbl(sale_kum)/lxzAmt),4)

					lxzproc = Cdbl(newlxzamount) * 1.2
					
					'프로시저 호출 
					sql = "exec coin_insert @ls_code='"&mem_code&"',@ls_date='"&sale_date&"',@ld_coin='"&lxzproc&"',@ls_chk='0'"

					If f_sql_modify(db_conn, sql) < 0 Then
						'jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					End If 
					
				End If
			
			End If
			
			salecoin = amount - bitcoin
'			Response.write salecoin & ":" & amount & ":" & bitcoin
			If salecoin > 0 Then 
				sqlu = "update mmember set mem_ye_kum = IsNULL( mem_ye_kum, 0 ) + ("&salecoin&"*"&btcwon&") where mem_id = '"&account&"' "
'				Response.write sqlu
				If f_sql_modify(db_conn, sqlu) < 0 Then
				
				End If
				
				sqlu = "update mmember_temp set mem_ye_kum = IsNULL( mem_ye_kum, 0 ) + ("&salecoin&"*"&btcwon&") where mem_id = '"&account&"' "
'				Response.write sqlu
				If f_sql_modify(db_conn, sqlu) < 0 Then
				
				End If
				
				sql = ""	
				sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
				& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code, emoney_datetime, emoney_price) values ( " _
				& "'" & mem_code & "', convert(varchar(8), getdate(), 112), " _
				& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
				& "where '"&mem_code&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
				& "'"&mem_name&"', ("&salecoin&"*"&btcwon&"), " _
				& "'A', '1','', getdate(), '"&btcwon & "' )" 
	'			Response.write sql
			
				If f_sql_modify(db_conn, sql) < 0 Then
					'jsMessageBox "An error has occurred in the storage process4. Contact your administrator." & sql, "", "docume"
				End If 
			
			End If 
			
			response.write "OK" '등록 가능한 아이디입니다.
		Else
		
			sqlu = "update "&table&" set mem_ye_kum = IsNULL( mem_ye_kum, 0 ) + ("&amount&"*"&btcwon&") where mem_id = '"&account&"' "
'			Response.write sqlu
			If f_sql_modify(db_conn, sqlu) < 0 Then
				sqlu = "update bitcoin set bit_bigo = 'update fail' where bit_txid = '"&txid&"'  "
				
				If f_sql_modify(db_conn, sqlu) < 0 Then
				End If 
			End If
			
			sql = ""	
			sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
			& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code, emoney_datetime, emoney_price) values ( " _
			& "'" & mem_code & "', convert(varchar(8), getdate(), 112), " _
			& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
			& "where '"&mem_code&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
			& "'"&mem_name&"', (" & amount&"*"&btcwon & "), " _
			& "'5', '1','', getdate(), '"&btcwon & "' )" 
'			Response.write sql
		
			If f_sql_modify(db_conn, sql) < 0 Then
'				jsMessageBox "An error has occurred in the storage process4. Contact your administrator." & sql, "", "docume"
			End If 
			
			response.write "OK" '등록 가능한 아이디입니다.
		End if
		
'		response.write "fail - There is no amount." '등록 가능한 아이디입니다.
		
	Else 
		response.write "fail - no insert." '등록 가능한 아이디입니다.
	End if 
else 
	response.write "fail - no user." '등록 가능한 아이디입니다.
End If  

%>
