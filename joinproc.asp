<!-- #Include virtual = "/myoffice/lib/db.asp" -->

<%
Randomize
If (request("command") = "info") Then '수정

		MemNO   = session("member")
		'n_id   = TRIM(request("n_id"))               
		n_name  = TRIM(request("n_name"))               
		n_jumin = TRIM(request("n_jumin"))               
		pwd     = TRIM(request("n_pass"))
		email   = TRIM(request("n_email"))
		tel     = TRIM(request("n_telnum"))
		hp      = TRIM(request("n_cellnum"))
		post    = TRIM(request("n_zipno"))
		uaddr1  = TRIM(request("n_addr1"))
		uaddr2  = TRIM(request("n_addr2"))
		bank    = Trim(request("n_bank"))
		account = Trim(request("n_account"))
		owner   = Trim(request("n_owner"))
		

		filename		  = request("input_file")
		filename_del	= request("filename_del")

		Set FSO       = CreateObject("Scripting.FileSystemObject") 
		
		sqlst         = "select mem_pic from mmember where mem_code='"&MemNO&"'" 

		If f_sql_select(db_conn, sqlst, arrData) > 0 Then
			strFileName = full_path & arrData(0, 0) 'full_path lib/db.asp에 지정
		End If
		
		if filename_del = "Y" then '파일삭제
			If FSO.FileExists(strFileName) Then
			FSO.deletefile(strFileName) 
			end if 
		end If
		
		if(trim(filename)<>"" and not isnull(filename)) then
			attach_file = request("input_file").FilePath
			attach_file = Mid(attach_file, InstrRev(attach_file,"\",-1,1) + 1)
			attach_file = Replace(attach_file," ","")
			
			If ( Instr(attach_file, ".") <> 0 ) then 
				'strName  = Mid(attach_file, 1, InstrRev(attach_file,".",-1,1) - 1)
				strName   = MemNO
				strExt    = Mid(attach_file, InstrRev(attach_file,".",-1,1) + 1)
			Else
				strName   = MemNO
				strExt    = ""
			End If
	  
			strDir = full_path 
			strNameExt  = strName & "." & strExt
			strFileName = strDir & strNameExt 
			bExistCount = 1 
		 
			'Do While FSO.FileExists(strFileName) 
			'	strNameExt  = strName & "(" & bExistCount & ")." & strExt
			'	strFileName = strDir & strNameExt
			'	bExistCount = bExistCount + 1  
			'Loop
			request("input_file").SaveAs strFileName
			
			'섬네일 저장
			Set Image = Server.CreateObject("Nanumi.ImagePlus")
				 Image.OpenImageFile strFileName
			     Image.OverWrite = True   '덮어쓰기 여부
			     Image.ImageFormat = "jpg"
			     Image.Quality = 100
			     Image.KeepAspect = false   'true면 원본 가로세로 비율대로 저장, false면 아래 이미지 사이즈대로 저장
			     Image.ChangeSize 45, 48  'Image.width, Image.Height 이런것도 있습니다. 용도는 찾아보세요.
			     Image.SaveFile strFileName
			     Image.Dispose
			     Set Image = Nothing




			filename	=	strNameExt
		end if

		Set FSO = nothing 

  	'& " mem_bank_number = '" & account & "', " _
  	'& " mem_bank_code = '" & bank & "', " _
  	sql = "UPDATE mmember SET " 
  	sql = sql & " mem_jumin = '" & n_jumin & "', " 
  	sql = sql & " mem_pw = '" & pwd & "', "
  	sql = sql & " mem_home_tel = '" & tel & "', "
  	sql = sql & " mem_hp_tel = '" & hp & "', "
  	sql = sql & " mem_post = '" & post & "', "
  	sql = sql & " mem_addr1 = N'" & uaddr1 & "', "
  	sql = sql & " mem_addr2 = N'" & uaddr2 & "', "
  	sql = sql & " mem_email = '" & email & "' "
  		
  	if filename_del = "Y" or (trim(filename)<>"" and not isnull(filename)) then
  			sql =sql & ", mem_pic = '" & filename & "' "
  	end If
  	
  	sql =sql & " WHERE mem_code = '" & MemNO & "' "
  
  	If f_sql_modify(db_conn, sql) < 0 Then
  		jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요.
  	Else
  		jsMessageBox "The data has been saved.", "./myaccount_re.asp", "parent" '저장되었습니다.
  	End If

End If

	If (request("command") = "idch") Then '아이디변경
		mem_id  = request("mem_id")
		MemNO   = session("member")
	  
		If f_sql_select(db_conn, "select * from mmember where mem_id = '" & mem_id & "'", arrData) > 0 Then
			response.write "N|The ID has already been registered." '이미 등록된 아이디입니다.
			Response.end
		Else
			sql = "UPDATE mmember SET " _
			& " mem_id = '" & mem_id & "', " _
			& " mem_card_num = '1' " _
			& " WHERE mem_code = '" & MemNO & "' "
			'Response.write sql
			If f_sql_modify(db_conn, sql) < 0 Then
				response.write "N|An error has occurred in the storage process. Contact your administrator." '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요.
			Else
				response.write "Y|The ID has been fixed. Please login again." '아이디가 수정되었습니다. 다시로그인 해주시기 바랍니다.
			End If
			Response.end
		End If

	End If

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
	'bank    = TRIM(Request("n_bank"))
	account = TRIM(request("pResult"))
	owner   = TRIM(request("Verification"))
	verification   = TRIM(request("Verification"))
	agency  = TRIM(request("n_agency"))
	bank_code  = Split(Trim(request("n_bank_code")), "|") 
	bank_name  = TRIM(request("n_bank_name"))
	bank_number  = TRIM(request("bank_number"))
	mem_yekumju  = TRIM(request("mem_yekumju"))
	mem_bit_code = Trim(request("bit_code"))



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

		sql = "select * From mem_cdown where down_down = '"&recom&"'"
		If f_sql_select(db_conn, sql, arrData) > 0 Then
			'response.write "<script language='javascript'>"
			'response.write "alert('Cannot insert duplicate Placement');"
			'response.write "history.back();"
			'response.write "</script>"
			'response.end
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

		'sql = "exec up_choo_cdown @ls_memcode='"&fmem_code&"',@mem_choocode='"&recom&"'"
		'Response.write sql
		'Response.end
		'If f_sql_modify(db_conn, sql) < 0 Then
			'jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		'End If 

		'sql = "exec up_hoo_hdown @ls_memcode='"&fmem_code&"',@mem_hoocode='"&spon&"'"
		'Response.write sql
		'Response.end
		'If f_sql_modify(db_conn, sql) < 0 Then
		'	jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		'End If 

sql = "insert into mmember_temp(" _
		& "mem_code, mem_gubun, mem_date, mem_name, mem_jumin, mem_choo_code, mem_hoo_code, mem_level_code, mem_level_count, " _
		& "mem_up_ab, mem_dn_acode, mem_dn_bcode, mem_post, mem_addr1, mem_addr2, mem_home_tel, mem_hp_tel, mem_agency_code, " _
		& "mem_bank_code, mem_bank_name, mem_bank_number, mem_yekumju, mem_email, mem_pan_kum, mem_nu_kum, mem_avatar_pay, mem_avatar_kum, " _
		& "mem_avatar_cnt, mem_up_jum, mem_ye_kum, mem_passwd, mem_id, mem_pw, mem_off_num, mem_card_num, mem_nation, " _
		& "mem_cancel, mem_bigo,regdate, mem_off_tel,mem_bit_code " _
		& ") VALUES ('" & mem_ver_code & "',  " _
		& "'"&mem_gubun&"', replace(convert(varchar(10),sysdatetime()),'-',''), N'" & name & "', '" & jumin & "', '" & recom & "', '" & spon & "', '"&ver_level&"', '"&mem_level_count&"', " _
		& "'', '', '', " _
		& "'" & post & "', N'" & uaddr1 & "', N'" & uaddr2 & "', '" & tel & "', '" & hp & "', '" & mem_agency_code & "', '" & bank_code(0) & "', N'" & bank_name & "'," _
		& "'" & bank_number & "', N'" & mem_yekumju & "', '" & email & "', 0, 0, '0', '0', 0, 0, 0, '', '" & id & "', '" & pwd & "', '0', '', " _
		& "'"&nation(0)&"', '"&mem_cancel&"', 'web"&chktime&"',sysdatetime() , '"&owner&"' , '"&mem_bit_code&"'" _
		& ")"

		'response.write sql

		If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
	Else
	
			setpoint = 0
			sqlst         = "select IsNull(sum(trans_point),0)  from mmember_trans where trans_id = '"&id&"' and trans_use = '0' " 
			If f_sql_select(db_conn, sqlst, arrData) > 0 Then
				setpoint = arrData(0, 0)
			End If 
			
			If setpoint <> 0 Then 
				
				sqlst2         = "UPDATE mmember_temp SET  mem_rewards = " & setpoint & " where mem_id = '"&id&"' " 
				
				If f_sql_modify(db_conn, sqlst2) < 0 Then
					jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요.
				End If
			End If 
			
			sql = "select mem_pw, mem_name, mem_code, mem_jumin, mem_agency_code, mem_choo_code, mem_hoo_code "
			sql = sql & "from mmember_temp "
			sql = sql & "where mem_id = '" & id & "' "
			sql = sql & "and mem_cancel in ('1','6')"

			If f_sql_select(db_conn, sql, arrData) > 0 Then


					session("username") = arrData(1, 0)
					session("userid") = UCase(id)
					session("member") = arrData(2, 0)
					session("juminno") = arrData(3, 0)
					session("agency") = arrData(4, 0)
				
					session("lastlogin") = now()

					jsMessageBox "", "./home.asp", "document"

					'response.end

			End If
	End If
End If

%>
