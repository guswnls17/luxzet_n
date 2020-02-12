<!-- #Include virtual = "/myoffice/lib/db.asp" -->

<%
If (request("command") = "join") Then '등록
	id      = Trim(request("n_id"))
	nation  = Split(Trim(request("n_nation")), "|")
	pwd     = TRIM(Request("n_pass"))
	name    = Trim(request("n_name"))
	jumin   = Trim(request("birth1"))&Trim(request("birth2"))&Trim(request("birth3"))
	tel     = TRIM(Request("n_telnum"))
	hp      = TRIM(Request("n_cellnum"))
	post    = ""
	uaddr1  = TRIM(Request("n_addr1"))
	uaddr2  = TRIM(Request("mastercard"))
	mastercard = TRIM(Request("mastercard"))
	mem_card_num  = TRIM(request("mastercard2"))
	email   = TRIM(Request("n_email"))
	recom   = TRIM(request("n_recom_no"))
	spon    = TRIM(request("n_spon_no"))
	bank_name    = TRIM(Request("bank_name"))
	account = TRIM(request("pResult"))
	agency  = TRIM(request("n_agency"))
	bank_code  = Split(Trim(request("n_bank_code")), "|") 
	bank_number  = TRIM(request("bank_number"))
	mem_yekumju  = TRIM(request("mem_yekumju"))
	n_point	 = TRIM(request("n_point"))
	n_ewallet	 = TRIM(request("n_ewallet"))
	n_group	 = TRIM(request("group1"))

	account = Replace(account, ",", "")
	
	lxzAmt = request("lxz_kum")
	
'	If n_group = "ewallet" then 
'		Response.write "<script>alert('ewallet : "&n_group & ":" & n_ewallet & ":" & n_point &"'); </script>"
'		Response.end
'	Else 
'		Response.write "<script>alert('point : "&n_group & ":" & n_ewallet & ":" & n_point &"'); </script>"
'		Response.end
'	End If

	Function  flevelcount(recom) '레벨카운트
		sql="select count(*) from mmember where mem_choo_code='"&recom&"'"
		lngCnt = f_sql_select(db_conn, sql, arrData)

		If arrData(0, 0) > 0 Then
			flevelcount=arrData(0, 0)+1 
		Else
			flevelcount=1
		End If

	End Function
	

	'자리수 맞추는 함수	
	Function Format(ByVal szString, ByVal Expression)
		If Len(szString) < Len (Expression) Then
			format = Left(Expression, Len(Expression) - Len(szString)) & szString
		Else
			format = szString
		End If
	End Function 
	
	'회원번호
	Function fmem_code()
		sql="select count(*),max(mem_code) from mmember_temp where substring(mem_code,1,6)='00"&Mid(Year(Now()),3,4)&format(Month(Now()),"00")&"'"
		lngCnt = f_sql_select(db_conn, sql, arrData)

		If arrData(0, 0) > 0 Then
			a_codeAdd=Mid(arrData(1, 0),7,4)+1
			a_codeAdd2=format(a_codeAdd, "0000") 
			'mem_code=Left(arrData(1, 0),2)&a_codeAdd2
			mem_code="00"&Mid(Year(Now()),3,4)&format(Month(Now()),"00")&a_codeAdd2
		Else
			mem_code="00"&Mid(Year(Now()),3,4)&format(Month(Now()),"00")&"0001"
		End If
		fmem_code=mem_code
	End Function
	

	mem_ver_code = fmem_code
	
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

	'추천인이 없으면 본사코드로
	If recom = "" Then
		mem_choo_code="0000000000"
	Else
		mem_choo_code=recom
	End If

	'18시이전 오늘날짜, 18시이후 내일날짜 입력
	chktime=Format(hour(now),"00")&Format(minute(now),"00")&Format(second(now),"00")
	
	If CLng(chktime) > 180000 Then
		mem_date=Replace(FormatDateTime(DateAdd("d",1,now()),2),"-","")
	Else
		mem_date=Replace(FormatDateTime(now(),2),"-","")
	End If

	mem_gubun=1
	mem_level_code     = "001"  '직급코드
	mem_level_count	   = flevelcount(recom) '단계
	mem_agency_code	   = agency '"0001" '센타코드 테이블은 "cagency" 조인은 "agency_code"(센타코드)
	mem_cancel		   = "1"
		
	If f_sql_select(db_conn, "select visa_mem_code from mmember_visa where visa_state = 0 and visa_card_number = '" & mastercard & "'", arrData) > 0 Then
		visa_mem_code = arrData(0,0)
	else
	'	response.write "<script language='javascript'>"
	'	response.write "alert('Card Number Not Match');"
	'	response.write "history.back();"
	'	response.write "</script>"
	'	response.end
	End If
	
	If f_sql_select(db_conn, "select isnull(mem_rewards, 0), isnull(mem_ye_kum, 0) from mmember where mem_code = '" & session("member") & "'", arrData) > 0 Then
		n_point = arrData(0,0)
		n_ewallet = arrData(1,0)
	End If 

	r_charge = 0
	r_charge = (CLng(account)*0.2)
	If n_group = "ewallet" then 
		If CLng(n_ewallet) < CLng(account) + CLng(r_charge) Then
			response.write "<script language='javascript'>"
			response.write "alert('account to Big1.');"
			response.write "history.back();"
			response.write "</script>"
			response.end
		End if
	Else 
		If CLng(n_point) < CLng(account) Then
			response.write "<script language='javascript'>"
			response.write "alert('account to Big2.');"
			response.write "history.back();"
			response.write "</script>"
			response.end
		End if
	End If
	
	
		
	sql = "select count(*) From mem_hdown where down_down = '"&spon&"'"
	If f_sql_select(db_conn, sql, arrData) > 2 Then
		response.write "<script language='javascript'>"
		response.write "alert('Cannot insert duplicate Sponsor');"
		response.write "history.back();"
		response.write "</script>"
		response.end
	End If
	
	If f_sql_select(db_conn, "select * from mmember_temp where mem_id = '" & id & "'", arrData) > 0 Then
			response.write "<script language='javascript'>"
			response.write "alert('The ID has already been registered.');"
			response.write "history.back();"
			response.write "</script>"
			response.end
		End If
	
	sql = "insert into mmember_temp(" _
		& "mem_code, mem_gubun, mem_date, mem_name, mem_jumin, mem_choo_code, mem_hoo_code, mem_level_code, mem_level_count, " _
		& "mem_up_ab, mem_dn_acode, mem_dn_bcode, mem_post, mem_addr1, mem_addr2, mem_home_tel, mem_hp_tel, mem_agency_code, " _
		& "mem_bank_code, mem_bank_name, mem_bank_number, mem_yekumju, mem_email, mem_pan_kum, mem_nu_kum, mem_avatar_pay, mem_avatar_kum, " _
		& "mem_avatar_cnt, mem_up_jum, mem_ye_kum, mem_passwd, mem_id, mem_pw, mem_off_num, mem_card_num, mem_nation, " _
		& "mem_cancel, mem_bigo,regdate, mem_off_tel " _
		& ") VALUES ('" & mem_ver_code & "',  " _
		& "'"&mem_gubun&"', replace(convert(varchar(10),sysdatetime()),'-',''), N'" & name & "', '" & jumin & "', '" & recom & "', '" & spon & "', '"&ver_level&"', '"&mem_level_count&"', " _
		& "'', '', '', " _
		& "'" & post & "', N'" & uaddr1 & "', N'" & uaddr2 & "', '" & tel & "', '" & hp & "', '" & mem_agency_code & "', '" & bank_code(0) & "', N'" & bank_name & "'," _
		& "'" & bank_number & "', N'" & mem_yekumju & "', '" & email & "', 0, 0, '0', '0', 0, 0, 0, '', '" & id & "', '" & pwd & "', '0', '', " _
		& "'"&nation(0)&"', '"&mem_cancel&"', 'web"&chktime&"',sysdatetime() , '' " _
		& ")"

	If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
	End If
	

	sq1 = "insert into mmember select * from mmember_temp where mem_id = '" & id & "'"
	
	If f_sql_modify(db_conn, sq1) < 0 Then
		jsMessageBox "An error has occurred in the storage process-000. Contact your administrator." & id , "", "document"
	Else
		sql = "select item_code ,item_mem_kum ,item_sale_kum,item_pv_kum "
			sql = sql & "from citem "
			sql = sql & "where item_mem_kum = '" & account & "' and item_bigo='1' "

			item_mem_kume = 0
			item_mem_kumr = 0
			If f_sql_select(db_conn, sql, arrData) > 0 Then
				item_code = arrData(0, 0)
				item_mem_kum = arrData(1, 0)
				item_sale_kum = arrData(2, 0)
				item_pv_kum = arrData(3, 0)
			End if
			
			If n_group = "ewallet" then 
				item_mem_kume = item_mem_kum
			Else 
				item_mem_kumr = item_mem_kum
			End If

			m = CStr(Month(Date()))
			d = CStr(day(Date()))
			If Len(m) = 1 Then
				m = "0"&CStr(m)
			End If
				
			If Len(m) = 1 Then
				d = "0"&CStr(d)
			End If
				
			cRnd = Int((10000 * Rnd) + 1) 
			getdate = CStr(Year(Date())) + CStr(m) + CStr(d)
			orderNumber = CStr(CInt(cRnd)) + CStr("0")
			
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
				
			orderNumber = order_no
			
			sql = "insert into sale01(" _
			& "sale_mem_code, sale_name, sale_number, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
			& "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, sale_count, " _
			& "sale_pan_kum, sale_agency_code, sale_bigo " _
			& ") VALUES ('" & mem_ver_code & "',  " _
			& "'"&name&"', '"&orderNumber&"', replace(convert(varchar(10),sysdatetime()),'-',''), '" & item_code & "', '" & item_mem_kum & "', '1', '"&item_sale_kum * 1&"', '"&item_pv_kum&"', " _
			& "'', '"&item_mem_kume&"', '', " _
			& "'"&item_mem_kumr&"', 0,0, 1, 0, 0, 0, " _
			& "'', '' " _
			& ")"
			If f_sql_modify(db_conn, sql) < 0 Then
				jsMessageBox "An error has occurred in the storage process. Contact your administrator num1.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
			Else
				sql = "insert into sale02(" _
				& "sale_mem_code, sale_number,sale_no, sale_date, sale_item, sale_danga, sale_suryang, sale_kum, sale_pvkum, " _
				& "sale_cash, sale_card, sale_yekum, sale_etc1, sale_etc2, sale_etc3, sale_gubun, sale_sw, " _
				& " sale_bigo " _
				& ") VALUES ('" & mem_ver_code & "'  " _
				& ", '"&orderNumber&"',1, replace(convert(varchar(10),sysdatetime()),'-',''), '" & item_code & "', '" & item_mem_kum & "', '1', '"&item_sale_kum * 1&"', '"&item_pv_kum&"', " _
				& "'', '"&item_mem_kume&"', '', " _
				& "'"&item_mem_kumr&"', 0,0, 1, 0, " _
				& " '' " _
				& ")"
				
				If f_sql_modify(db_conn, sql) < 0 Then
					jsMessageBox "An error has occurred in the storage process. Contact your administrator num2.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
				End If
				
				If n_group = "ewallet" then 
					sql = "UPDATE mmember  SET mem_ye_kum = mem_ye_kum - "&(CLng(account) + CLng(r_charge))&"  WHERE mem_code = '"&session("member")&"'"
					If f_sql_modify(db_conn, sql) < 0 Then
							jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					End if
					
					' 신규회원 코드 조회
					sq1 = "select mem_code, mem_name from mmember where mem_id = '" & id & "' "
					If f_sql_select(db_conn, sq1, arrData) > 0 Then
						ps_mem_code = arrData(0, 0) '신규회원 code 
						ps_mem_name = arrData(1, 0) '신규회원 name
					End If
					
					sql = ""	
					sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
					& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code) values ( " _
					& "'" & session("member") & "', convert(varchar(8), getdate(), 112), " _
					& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
					& "where '"&session("member")&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
					& "'"&session("username")&"', -"&CLng(item_mem_kum)&", " _
					& "'7', '1','' )" 
				
					If f_sql_modify(db_conn, sql) < 0 Then
						jsMessageBox "An error has occurred in the storage process4. Contact your administrator." & sql, "", "docume"
					End If 
					
					sql = ""	
					sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
					& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code) values ( " _
					& "'" & ps_mem_code & "', convert(varchar(8), getdate(), 112), " _
					& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
					& "where '"&ps_mem_code&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
					& "'"&ps_mem_name&"', "&CLng(item_mem_kum)&", " _
					& "'2', '1','' )" 
				
					If f_sql_modify(db_conn, sql) < 0 Then
						jsMessageBox "An error has occurred in the storage process4. Contact your administrator." & sql, "", "docume"
					End If 
					
					sql = ""	
					sql = sql & "insert into mmember_emoney (emoney_mem_code, emoney_idate, emoney_no, " _
					& "emoney_mem_name, emoney_kum, emoney_istate, emoney_ostate, emoney_give_code) values ( " _
					& "'" & ps_mem_code & "', convert(varchar(8), getdate(), 112), " _
					& "isnull((select isnull(max(emoney_no), 0) from mmember_emoney b " _
					& "where '"&ps_mem_code&"' = b.emoney_mem_code and b.emoney_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
					& "'"&ps_mem_name&"', -"&CLng(item_mem_kum)&", " _
					& "'7', '1','' )" 
				
					If f_sql_modify(db_conn, sql) < 0 Then
						jsMessageBox "An error has occurred in the storage process4. Contact your administrator." & sql, "", "docume"
					End If 

				Else 
					sql = "UPDATE mmember  SET mem_rewards = mem_rewards - "&account&"  WHERE mem_code = '"&session("member")&"'"
					If f_sql_modify(db_conn, sql) < 0 Then
							jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
					End if
					
					' 신규회원 코드 조회
					sq1 = "select mem_code, mem_name from mmember where mem_id = '" & id & "' "
					If f_sql_select(db_conn, sq1, arrData) > 0 Then
						ps_mem_code = arrData(0, 0) '신규회원 code 
						ps_mem_name = arrData(1, 0) '신규회원 name
					End If
					
					sql = ""	
					sql = "insert into mmember_rewards (" _
					& "rewards_mem_code, rewards_idate, rewards_no, rewards_odate, rewards_kum, rewards_istate, rewards_ostate) " _
					& " select mem_code, convert(varchar(8), getdate(), 112), " _
					& " isnull((select isnull(max(rewards_no), 0) from mmember_rewards b " _
					& " where a.mem_code = b.rewards_mem_code and b.rewards_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
					& " convert(varchar(8), getdate(), 112), -"&CLng(item_mem_kum)&", '7', '1' " _
					& " from mmember a " _
					& " where mem_code = '"&session("member")&"' "

					If f_sql_modify(db_conn, sql) < 0 Then
						jsMessageBox "An error has occurred in the storage process5. Contact your administrator.", "", "docume"
					End If
					
					sql = ""	
					sql = "insert into mmember_rewards (" _
					& "rewards_mem_code, rewards_idate, rewards_no, rewards_odate, rewards_kum, rewards_istate, rewards_ostate) " _
					& " select mem_code, convert(varchar(8), getdate(), 112), " _
					& " isnull((select isnull(max(rewards_no), 0) from mmember_rewards b " _
					& " where a.mem_code = b.rewards_mem_code and b.rewards_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
					& " convert(varchar(8), getdate(), 112), "&CLng(item_mem_kum)&", '2', '1' " _
					& " from mmember a " _
					& " where mem_code = '"&ps_mem_code&"' "

					If f_sql_modify(db_conn, sql) < 0 Then
						jsMessageBox "An error has occurred in the storage process5. Contact your administrator.", "", "docume"
					End If
					
					sql = ""	
					sql = "insert into mmember_rewards (" _
					& "rewards_mem_code, rewards_idate, rewards_no, rewards_odate, rewards_kum, rewards_istate, rewards_ostate) " _
					& " select mem_code, convert(varchar(8), getdate(), 112), " _
					& " isnull((select isnull(max(rewards_no), 0) from mmember_rewards b " _
					& " where a.mem_code = b.rewards_mem_code and b.rewards_idate = convert(varchar(8), getdate(), 112)), 0) + 1, " _
					& " convert(varchar(8), getdate(), 112), -"&CLng(item_mem_kum)&", '7', '1' " _
					& " from mmember a " _
					& " where mem_code = '"&ps_mem_code&"' "

					If f_sql_modify(db_conn, sql) < 0 Then
						jsMessageBox "An error has occurred in the storage process5. Contact your administrator.", "", "docume"
					End If
				End If 
				
				
				plxzAmt = round(Cdbl(account)/Cdbl(lxzAmt),4)

				lxzproc = Cdbl(plxzAmt) * 1.2
				
				'프로시저 호출 
				sql = "exec coin_insert @ls_code='"&mem_ver_code&"',@ls_date='"&sale_date&"',@ld_coin='"&lxzproc&"',@ls_chk='0'"

				If f_sql_modify(db_conn, sql) < 0 Then
					'jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
				End If 

				'프로시저 호출 끝

					jsMessageBox "New Member Saved.", "memberadd.asp", "parent"

			End if

	End If
	
End If

%>
