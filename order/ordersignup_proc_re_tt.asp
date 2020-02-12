<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
If (request("command") = "save") then

	memno = session("member")
'	Verification = ""
	prod_cnt	= Trim(request("prod_cnt"))
	account 	= TRIM(request("PayAmt"))
	Point 	= TRIM(request("Point"))
	spon    = TRIM(request("n_spon_no"))
	radio    = TRIM(request("group1"))
	
	
	ps_emoney = request("e_wallet")
	ps_wallet = request("io_wallet")
'	Verification   = TRIM(request("io_wallet"))
	
	coin_ewallet = CLng(ps_emoney)
	coin_iowallet = CLng(ps_wallet)
	
	r_charge = 0
	
	if radio = "bitcoin" then    ' 비트코인 이면 
	
		bitAmt = request("bitAmt")
		bit_kum = request("bit_kum")
		bit_code = request("bit_code")
		exchange_time = request("exchange_time")
		
		sql = "update parchase_coin set gubun = '0' where mem_code = '" & memno& "' and gubun = '2' "
		
		If f_sql_modify(db_conn, sql) < 0 Then
			jsMessageBox "An error has occurred in the storage process-pcoin. Contact your administrator." , "", "document"
		End If
		
		sql = "update mmember_temp set mem_wbit_code = '" & bit_code & "' where mem_code = '" & memno& "' "
		
		If f_sql_modify(db_conn, sql) < 0 Then
			jsMessageBox "An error has occurred in the storage process-bitaddr. Contact your administrator." , "", "document"
		End If
	
		n_amount = 0
		n_point = 0
		sale_etc1_s01 = 0
		sale_etc1 = 0
		sale_yekum_s01 = 0
		sale_yekum = 0
		j = 0
		sql = ""
		order_no = "**********"
		

		'자리수 맞추는함수	
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

		new_sy = Year(DateAdd("h",6,now()))
		new_sm = Month(DateAdd("h",6,now()))
		new_sd = Day(DateAdd("h",6,now()))
		if(Len(new_sm) = 1 ) then new_sm = "0" & new_sm
		if(Len(new_sd) = 1 ) then new_sd = "0" & new_sd
		new_hour   = right("0" & hour(DateAdd("h",6,now())), 2)
		new_minute = right("0" & minute(DateAdd("h",6,now())), 2)
		new_second = right("0" & second(DateAdd("h",6,now())), 2)
		
		idate = sy &""& sm &""& sd &""& now_hour &""& now_minute &""& now_second
		odate = new_sy &""& new_sm &""& new_sd &""& new_hour &""& new_minute &""& new_second
			
		sale_date = sy & sm & sd 
		
		sq1 = "select isnull(max(sale_number), 0) from sale01_bit where sale_date = '" & sale_date & "' "

		If f_sql_select(db_conn, sq1, arrData) > 0 Then

			If  arrData(0, 0) = "0"  Then
				order_no =Trim(sale_date&"00001")
			Else
				order_no =Trim(sale_date&Format(RIGHT(arrData(0, 0),5)+1,"00000"))
				
			End If
		End If


		For i = 0 To prod_cnt - 1
			prodinfo = request("_product" & i)
			If prodinfo <> "" Then
				j = j + 1

				qty = request("n_qyt" & i)
				arrProd = Split(prodinfo, "|")

				n_amount = n_amount + CLng(qty) * CLng(arrProd(1))
				n_point = n_point + CLng(qty) * CLng(arrProd(3))
				

				sale_etc1_s01=sale_etc1 + (CLng(qty) * CLng(arrProd(2))) 'sale01 이머니
				sale_etc1=(CLng(qty) * CLng(arrProd(2)))  'sale02 이머니
				sale_yekum=0
				sale_gubun=1								
				

				
				
				sql = sql & "insert into sale02_bit(" _
				& "sale_mem_code, sale_number, sale_no, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
				& "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_o_gubun, " _
				& "sale_o_suryang, sale_ch_number, sale_ch_no, sale_pankum, sale_upkum, sale_bigo, sale_o_post, sale_o_addr1, sale_o_addr2, sale_o_tel, sale_o_name,sale_guarantee " _
				& ") values (" _
				& "'" & memno & "', '" & order_no & "', '" & j & "', '"&sale_date&"', " _
				& "'" & arrProd(0) & "', '" & arrProd(2) & "', '" & qty & "', '" & (CLng(qty) * CLng(arrProd(2))) & "', " _
				& "'" & (CLng(qty) * CLng(arrProd(3))) & "', 0, 0, '" & sale_yekum & "', '"&sale_etc1&"', 0, 0, '"&sale_gubun&"', '"&Trim(request("sale_sw"))&"', '"&Trim(request("delivery"))&"', " _
				& "0, '', 0, 0, 0, 'web"&chktime&"','"&Trim(request("n_zipno"))&"','"&Trim(request("n_addr1"))&"','"&Trim(request("n_addr2"))&"','"&Trim(request("d_tel"))&"','"&Trim(request("d_name"))&"','" & Verification & "') "
			

					
					

					
	Call f_sql_modify(db_conn,sql)
					
		

					sale_danga=CLng(arrProd(1))
					sale_suryang=sale_suryang+CLng(qty)
					sale_item=arrProd(0) 

						
			End If
		Next


			
		

		
			sq1 = "insert into sale01_bit(" _
			& "sale_mem_code, sale_name, sale_number, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
			& "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_count, " _
			& "sale_pan_kum, sale_agency_code, sale_bigo, sale_guarantee " _
			& ") VALUES ( " _
			& "'" & memno & "', N'" & session("username") & "', " _
			& "'"&order_no&"', " _
			& "'"&sale_date&"', " _
			& "'"&sale_item&"', '"&sale_danga&"', '"&sale_suryang&"', '" & n_amount & "', " _
			& "'" & n_point & "', 0, 0, '" & sale_yekum_s01 & "', '"&sale_etc1_s01&"', 0, 0, '"&sale_gubun&"', 0, 0, 0, " _
			& "'" & session("agency") & "', 'web"&chktime&"','" & Verification & "' " _
			& ")"
		


		If f_sql_modify(db_conn, sq1) < 0 Then
			jsMessageBox "An error has occurred in the storage process1. Contact your administrator." , "", "document"
		End If
		
		sql = "insert into parchase_coin ( mem_id, mem_code, amountt, bitcoin, bitexchange, gubun, hoocode, idate, odate, bit_sale_number, exchange_time " _ 
		& ")values('" &session("userid") & "','" & memno & "', '" & n_amount & "','" & bitAmt & "','" & bit_kum & "', '2', '" & spon & "','" & idate & "','" & odate & "','" & order_no & "','" & exchange_time & "') "
		
		If f_sql_modify(db_conn, sql) < 0 Then
			jsMessageBox "An error has occurred in the storage process-bitcoin. Contact your administrator." , "", "document"
		End If
		
		jsMessageBox "The data has been saved.", "../order_bit.asp", "parent"
	
	else 	' 비트코인이 아니면 
	
	
		if Verification <> "" then
			sql = "select top 1 ver_code,ver_level,ver_kum "
			sql = sql & "from cverification where ver_use = 0 and ver_chk = 1 and ver_code = '"&Verification&"' order by idx asc"
			If f_sql_select(db_conn, sql, arrData) > 0 Then
				

				ver_code = arrData(0,0)
				ver_level = arrData(1,0)
				ver_kum = arrData(2,0)
			Else
				
				response.write "<script language='javascript'>"
				response.write "alert('verification Number Not Match-"&Verification&"');"
				response.write ""
				response.write "</script>"
				response.end
			End If
			
			If Cint(ver_kum) <> CInt(account) Then
				response.write "<script language='javascript'>"
				response.write "alert('verification Number Not Match.');"
				response.write ""
				response.write "</script>"
				response.end
			End if
		end if
		
		if coin_ewallet > 0  then 
			r_charge = (CLng(coin_ewallet)*0.05)
		end if 
		
		If Trim(request("delivery")) = "1" Then 'Gcoin-1,현금-0 구분 
			'결제금액+8%차감금--삭제
			coin_ewallet=CLng(coin_ewallet)
			'coin_amount=CLng(account)

			sq1 = "select Isnull(mem_ye_kum,0), isnull(mem_rewards, 0) from mmember_temp where mem_code = '" & memno & "' "
				If f_sql_select(db_conn, sq1, arrData) > 0 Then
					emoney = CLng(arrData(0, 0)) '보유 이머니 
					iomoney = round(CLng(arrData(1, 0)),2) '보유 iowallet 
				End If
				
				if Verification = "" then 
					If coin_ewallet > 0 Then 
						If (coin_ewallet+r_charge) > (emoney) Then
							jsMessageBox "Payment amount is greater than E-wallet.", "", "docume" 	
							Response.end
						End If
					End If 
					If coin_iowallet > 0 Then 
						If coin_iowallet > (iomoney) Then
							jsMessageBox "Payment amount is greater than Point.", "", "docume" 	
							Response.end
						End If
					End If 
				end if
		 End If
		 
		 '후원인 카운트 채크
		Function hoo_Cntchk()
			sql="select count(*) from mmember where mem_hoo_code='"&spon&"' "
			hooCnt = f_sql_select(db_conn, sql, arrData)

			If arrData(0, 0) >= 2 Then
				
				'jsMessageBox "Registered sponsor is at least two people.", "", "document"
				Response.write "<script>alert('Placement check.'); </script>"
				Response.end

			End If

		End Function
		
		Call hoo_Cntchk()
		 
		n_amount = 0
		n_point = 0
		sale_etc1_s01 = 0
		sale_etc1 = 0
		sale_yekum_s01 = 0
		sale_yekum = 0
		j = 0
		sql = ""
		order_no = "**********"
		

		'자리수 맞추는함수	
		Function Format(ByVal szString, ByVal Expression)
			If Len(szString) < Len (Expression) Then
				format = Left(Expression, Len(Expression) - Len(szString)) & szString
			Else
				format = szString
			End If
		End Function 
		

		'18시이전 오늘날짜, 18시이후 내일날짜 입력
		chktime=Format(hour(now),"00")&Format(minute(now),"00")&Format(second(now),"00")
		
		If CLng(chktime) > 180000 Then
			sale_date=Replace(FormatDateTime(DateAdd("d",1,now()),2),"-","")
		Else
			sale_date=Replace(FormatDateTime(now(),2),"-","")
		End If
			sale_date=Replace(FormatDateTime(now(),2),"-","")
			
			
			
		sq1 = "insert into mmember select * from mmember_temp where mem_id = '" & session("userid") & "'"
		If f_sql_modify(db_conn, sq1) < 0 Then
			jsMessageBox "An error has occurred in the storage process-000. Contact your administrator."&session("userid") , "", "document"
		End If
		
		sq1 = "update mmember set mem_hoo_code = '" & spon & "' where mem_id = '" & session("userid") & "'"
		If f_sql_modify(db_conn, sq1) < 0 Then
			jsMessageBox "An error has occurred in the storage process-u. Contact your administrator." , "", "document"
		End If
		
		sy = Year(Date)
		sm = Month(Date)
		sd = Day(Date)

	 if(Len(sm) = 1 ) then sm = "0" & sm
	 if(Len(sd) = 1 ) then sd = "0" & sd
		
		sale_date = sy & sm & sd 
		
		sq1 = "select isnull(max(sale_number), 0) from sale01 where sale_date = '" & sale_date & "' "

		If f_sql_select(db_conn, sq1, arrData) > 0 Then

			If  arrData(0, 0) = "0"  Then
				order_no =Trim(sale_date&"00001")
			Else
				order_no =Trim(sale_date&Format(RIGHT(arrData(0, 0),5)+1,"00000"))
				
			End If
		End If


		For i = 0 To prod_cnt - 1
			prodinfo = request("_product" & i)
			If prodinfo <> "" Then
				j = j + 1

				qty = request("n_qyt" & i)
				arrProd = Split(prodinfo, "|")

				n_amount = n_amount + CLng(qty) * CLng(arrProd(1))
				n_point = n_point + CLng(qty) * CLng(arrProd(3))
				
				If Trim(request("delivery")) = "1" Then 'Gcoin-1,현금-0 구분  
					sale_etc1_s01=sale_etc1 + (CLng(qty) * CLng(arrProd(2))) 'sale01 이머니
					sale_etc1=(CLng(qty) * CLng(arrProd(2)))  'sale02 이머니
					sale_yekum=0
					sale_gubun=1								
				Else
					sale_yekum_s01=sale_yekum + (CLng(qty) * CLng(arrProd(1))) 'sale01 현금
					sale_yekum =(CLng(qty) * CLng(arrProd(1)))		'sale02 현금
					sale_etc1=0
					sale_gubun=6
					
				End If
				
				If CLng(arrProd(3)) >= 5000 Then 						' 0.5 * 10
					mem_avatar_pay = mem_avatar_pay + ((CLng(qty) * CLng(arrProd(3)))*5)
				ElseIf	CLng(arrProd(3)) >= 3000	Then 				' 0.45 * 10
					mem_avatar_pay = mem_avatar_pay + ((CLng(qty) * CLng(arrProd(3)))*4.5)
				ElseIf	CLng(arrProd(3)) >= 2000	Then 				' 0.4 * 10
					mem_avatar_pay = mem_avatar_pay + ((CLng(qty) * CLng(arrProd(3)))*4)
				ElseIf	CLng(arrProd(3)) >= 1000	Then 				' 0.35 * 10
					mem_avatar_pay = mem_avatar_pay + ((CLng(qty) * CLng(arrProd(3)))*3.5)
				Else													' 0.3 * 10
					mem_avatar_pay = mem_avatar_pay + ((CLng(qty) * CLng(arrProd(3)))*3)
				End If
				
				if coin_ewallet > 0 then 
					sql = sql & "insert into sale02(" _
					& "sale_mem_code, sale_number, sale_no, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
					& "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_o_gubun, " _
					& "sale_o_suryang, sale_ch_number, sale_ch_no, sale_pankum, sale_upkum, sale_bigo, sale_o_post, sale_o_addr1, sale_o_addr2, sale_o_tel, sale_o_name,sale_guarantee " _
					& ") values (" _
					& "'" & memno & "', '" & order_no & "', '" & j & "', '"&sale_date&"', " _
					& "'" & arrProd(0) & "', '" & arrProd(2) & "', '" & qty & "', '" & (CLng(qty) * CLng(arrProd(2))) & "', " _
					& "'" & (CLng(qty) * CLng(arrProd(3))) & "', 0, '"&sale_etc1&"', '" & sale_yekum & "', 0, 0, 0, '"&sale_gubun&"', '"&Trim(request("sale_sw"))&"', '"&Trim(request("delivery"))&"', " _
					& "0, '', 0, 0, 0, 'web"&chktime&"','"&Trim(request("n_zipno"))&"','"&Trim(request("n_addr1"))&"','"&Trim(request("n_addr2"))&"','"&Trim(request("d_tel"))&"','"&Trim(request("d_name"))&"','" & Verification & "') "
				else
					sql = sql & "insert into sale02(" _
					& "sale_mem_code, sale_number, sale_no, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
					& "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_o_gubun, " _
					& "sale_o_suryang, sale_ch_number, sale_ch_no, sale_pankum, sale_upkum, sale_bigo, sale_o_post, sale_o_addr1, sale_o_addr2, sale_o_tel, sale_o_name,sale_guarantee " _
					& ") values (" _
					& "'" & memno & "', '" & order_no & "', '" & j & "', '"&sale_date&"', " _
					& "'" & arrProd(0) & "', '" & arrProd(2) & "', '" & qty & "', '" & (CLng(qty) * CLng(arrProd(2))) & "', " _
					& "'" & (CLng(qty) * CLng(arrProd(3))) & "', 0, 0, '" & sale_yekum & "', '"&sale_etc1&"', 0, 0, '"&sale_gubun&"', '"&Trim(request("sale_sw"))&"', '"&Trim(request("delivery"))&"', " _
					& "0, '', 0, 0, 0, 'web"&chktime&"','"&Trim(request("n_zipno"))&"','"&Trim(request("n_addr1"))&"','"&Trim(request("n_addr2"))&"','"&Trim(request("d_tel"))&"','"&Trim(request("d_name"))&"','" & Verification & "') "
				
				end if

					
					

					
	Call f_sql_modify(db_conn,sql)
					
		

					sale_danga=CLng(arrProd(1))
					sale_suryang=sale_suryang+CLng(qty)
					sale_item=arrProd(0) 

						
			End If
		Next


			
		

		 if coin_ewallet > 0 then 
			sq1 = "insert into sale01(" _
			& "sale_mem_code, sale_name, sale_number, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
			& "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_count, " _
			& "sale_pan_kum, sale_agency_code, sale_bigo, sale_guarantee " _
			& ") VALUES ( " _
			& "'" & memno & "', N'" & session("username") & "', " _
			& "'"&order_no&"', " _
			& "'"&sale_date&"', " _
			& "'"&sale_item&"', '"&sale_danga&"', '"&sale_suryang&"', '" & n_amount & "', " _
			& "'" & n_point & "', 0, '"&sale_etc1_s01&"', '" & sale_yekum_s01 & "', 0, 0, 0, '"&sale_gubun&"', 0, 0, 0, " _
			& "'" & session("agency") & "', 'web"&chktime&"','" & Verification & "' " _
			& ")"
		else 
			sq1 = "insert into sale01(" _
			& "sale_mem_code, sale_name, sale_number, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
			& "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_count, " _
			& "sale_pan_kum, sale_agency_code, sale_bigo, sale_guarantee " _
			& ") VALUES ( " _
			& "'" & memno & "', N'" & session("username") & "', " _
			& "'"&order_no&"', " _
			& "'"&sale_date&"', " _
			& "'"&sale_item&"', '"&sale_danga&"', '"&sale_suryang&"', '" & n_amount & "', " _
			& "'" & n_point & "', 0, 0, '" & sale_yekum_s01 & "', '"&sale_etc1_s01&"', 0, 0, '"&sale_gubun&"', 0, 0, 0, " _
			& "'" & session("agency") & "', 'web"&chktime&"','" & Verification & "' " _
			& ")"
		
		end if


		If f_sql_modify(db_conn, sq1) < 0 Then
			jsMessageBox "An error has occurred in the storage process1. Contact your administrator." , "", "document"
		End If
		
		sql = "UPDATE cverification SET ver_use = '1'  WHERE ver_code = '"&Verification&"'"
		If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process. Contact your administrator1-1.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		Else
		End If
		sql = "UPDATE cverification  SET ver_use_code = '"&session("member")&"'  WHERE cverification.ver_code = '"&Verification&"'"
		If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process. Contact your administrator1-2.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		Else
		End if
		
		sql = "UPDATE cverification_issue  SET ver_memcode = '"&session("member")&"'  WHERE cverification_issue.ver_vercode = '"&Verification&"'"
		If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process. Contact your administrator1-3.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		Else
		End if
								
		sq1 = "select max(sale_number) from sale01 where sale_date = '" & sale_date & "' "

		If f_sql_select(db_conn, sq1, arrData) > 0 Then
			order_no = arrData(0, 0)
			sql = Replace(sql, "**********", order_no)
		Else
			jsMessageBox "An error has occurred in the storage process2. Contact your administrator.", "", "document"
		End If
		
		If Trim(request("delivery")) = "1" Then 'Gcoin-1,현금-0 구분 
			'결제금액+8%차감금--삭제
			coin_amount=CLng(n_amount)
			'coin_amount=CLng(n_amount)
			
			

			sq1 = "select Isnull(mem_ye_kum,0), isnull(mem_rewards, 0) from mmember where mem_code = '" & memno & "' "
				If f_sql_select(db_conn, sq1, arrData) > 0 Then
					emoney = CLng(arrData(0, 0)) '보유 이머니 
					iomoney = round(CLng(arrData(1, 0)),2) '보유 이머니 
				End If
				
				if Verification = "" then 
'					If coin_amount > (emoney+iomoney) Then
'						jsMessageBox "Payment amount is greater than coin.", "", "docume" 	
'					End If
				end if 
			ps_mem_code = ""
			ps_mem_name = ""
			sq1 = "select mem_code, mem_name from mmember where mem_code = '" & memno & "' "
				If f_sql_select(db_conn, sq1, arrData) > 0 Then
					ps_mem_code = arrData(0, 0) '보유 이머니 
					ps_mem_name = arrData(1, 0) '보유 이머니 
				End If
			
				if Verification = "" then 
'					If coin_amount > (emoney+iomoney) Then
'						jsMessageBox "Payment amount is greater than coin.", "", "docume" 	
'					End If
				end if
				
				sq1 = "select Isnull(mem_ye_kum,0), isnull(mem_rewards, 0) from mmember where mem_code = '" & memno & "' "
				If f_sql_select(db_conn, sq1, arrData) > 0 Then
					emoney = CLng(arrData(0, 0)) '보유 이머니 
					iomoney = CDbl(arrData(1, 0)) '보유 이머니 
				End If
				
				If coin_iowallet > iomoney Then 
					coin_iowallet = iomoney
				End If 
				
			'mem_avatar_pay = CLng(Point) * 5
			mem_avatar_kum = CLng(Point) * 0.1
			sql = ""	
			sql = sql & "update mmember set mem_ye_kum = mem_ye_kum - " & (CLng(coin_ewallet)+CLng(r_charge)) & " , mem_rewards = mem_rewards - " & coin_iowallet & "  "_
			& "where mem_code = '" & memno & "' " 
			If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process3. Contact your administrator."&sql, "", "docume"
			End If 
			
			sql = ""	
			sql = sql & "update mmember_temp set mem_ye_kum = mem_ye_kum - " & coin_ewallet & " , mem_rewards = mem_rewards - " & coin_iowallet & "  "_
			& "where mem_code = '" & memno & "' " 
			If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process3. Contact your administrator."&sql, "", "docume"
			End If 
			
			if coin_ewallet > 0 then 
				sql = ""	
				sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
				& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code) values ( " _
				& "'" & ps_mem_code & "', convert(varchar(8), getdate(), 112), " _
				& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
				& "where '"&ps_mem_code&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
				& "'"&ps_mem_name&"', -(" & CLng(coin_ewallet) & "), " _
				& "'2', '1','' )" 
			
				If f_sql_modify(db_conn, sql) < 0 Then
					jsMessageBox "An error has occurred in the storage process4. Contact your administrator." & sql, "", "docume"
				End If 
				
				
				
	'			cash_code="001"
	'			sql = sql & "insert into sale_cash(" _
	'			& "cash_mem_code, cash_sale_number, cash_number, cash_no, cash_kum, cash_gubun, cash_date, cash_code, cash_bigo " _
	'			& ") values (" _
	'			& "'" & memno & "', '" & order_no & "', 'e-wallet', '1','" & coin_ewallet & "','1', convert(varchar(8), getdate(), 112),'"&cash_code&"','' " _
	'			& ") "
	'			If f_sql_modify(db_conn, sql) < 0 Then
	'				jsMessageBox "An error has occurred in the storage process4-1. Contact your administrator.", "", "docume"
	'			End If
				
			end if
			
			if coin_iowallet > 0 then 
				sql = ""	
				sql = "insert into mmember_rewards (" _
				& "rewards_mem_code, rewards_idate, rewards_no, rewards_odate, rewards_kum, rewards_istate, rewards_ostate) " _
				& " select mem_code, convert(varchar(8), getdate(), 112), " _
				& " isnull((select isnull(max(rewards_no), 0) from mmember_rewards b " _
				& " where a.mem_code = b.rewards_mem_code and b.rewards_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
				& " convert(varchar(8), getdate(), 112), -"&CLng(coin_iowallet)&", '7', '1' " _
				& " from mmember a " _
				& " where mem_code = '"&ps_mem_code&"' "

				If f_sql_modify(db_conn, sql) < 0 Then
					jsMessageBox "An error has occurred in the storage process5. Contact your administrator.", "", "docume"
				End If
				
	'			etc1_code="002"
	'			sql = sql & "insert into sale_etc1(" _
	'			& "etc1_mem_code, etc1_sale_number, etc1_number, etc1_no, etc1_kum, etc1_gubun, etc1_date, etc1_code, etc1_bigo " _
	'			& ") values (" _
	'			& "'" & memno & "', '" & order_no & "', 'io-wallet', '1','" & coin_iowallet & "','1', convert(varchar(8), getdate(), 112),'"&etc1_code&"','' " _
	'			& ") "
	'			If f_sql_modify(db_conn, sql) < 0 Then
	'				jsMessageBox "An error has occurred in the storage process5-1. Contact your administrator.", "", "docume"
	'			End If
				
				
			end if

		Else
			bank_code="088"
			sql = ""	
			sql = sql & "insert into sale_bank(" _
			& "bank_mem_code, bank_sale_number, bank_number, bank_no, bank_kum, bank_gubun, bank_date, bank_code, bank_bigo " _
			& ") values (" _
			& "'" & memno & "', '" & order_no & "', '" & bankinfo & "', '1','" & n_amount & "','1', convert(varchar(8), getdate(), 112),'"&bank_code&"','"&Trim(request("in_name"))&"/"&Trim(request("n_zipno"))&"/"&Trim(request("n_addr1"))&" "&Trim(request("n_addr2"))&"/"&Trim(request("d_name"))&"' " _
			& ") "
			If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process4. Contact your administrator.", "", "docume"
			End If
		End If

			jsMessageBox "The data has been saved.", "../order.asp", "parent"
	end if  


End If

%>
