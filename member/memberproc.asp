<!-- #Include virtual = "/myoffice/lib/db.asp" -->

<%
'Set uploadform = Server.CreateObject("SiteGalaxyUpload.Form")

If (request("command") = "info") Then
'If (uploadform("command") = "info") Then '수정

		MemNO = session("member")
		'n_id  =  TRIM(uploadform("n_id"))               
		n_name =  TRIM(request("n_name"))               
		n_jumin =  TRIM(request("n_jumin"))               
		pwd = TRIM(request("n_pass"))
		email = TRIM(request("n_email"))
		tel = TRIM(request("n_telnum"))
		hp = TRIM(request("n_cellnum"))
		post = TRIM(request("n_zipno"))
		uaddr1 = TRIM(request("n_addr1"))
		nation = Split(Trim(request("n_nation")), "|")
'		agency = TRIM(request("n_agency"))
		uaddr2 = TRIM(request("n_masternum"))										'마스터카드 번호로 사용
		bank = Split(Trim(request("n_bank_code")), "|")
		account = Trim(request("bank_number"))
		bank_name = Trim(request("bank_name"))
		mem_yekumju = Trim(request("mem_yekumju"))
		'owner = Trim(uploadform("n_owner"))
		bank_code = Split(Trim(request("n_bank_code")), "|")
		bank_number = Trim(request("bank_number"))
		n_mem_scode = Trim(request("n_mem_scode"))
		n_mem_rcode = Trim(request("n_mem_rcode"))
		n_mem_bcode = Trim(request("n_mem_bcode"))
		n_mem_acode = Trim(request("n_mem_acode"))
		n_mem_coinsw = Trim(request("n_mem_coinsw"))
		n_mem_bid = Trim(request("n_mem_bid"))
		n_mem_bid_addr = Trim(request("n_mem_bid_addr"))
		n_mem_sid = Trim(request("n_mem_sid"))
		n_mem_sid_addr = Trim(request("n_mem_sid_addr"))
		n_ename = Trim(request("n_ename"))									'닉네임 사용
		mem_bit_code = Trim(request("bit_code"))							'비트코인 주소
		n_with_scode = Trim(request("n_wbit_code"))						'비트코인 수당지급 받을 주소
		mem_ebh_code = Trim(request("ebh_code"))							'비트코인 주소

		filename		= request("input_file")
		filename_del	= request("filename_del")

		'Set FSO = CreateObject("Scripting.FileSystemObject") 
		
		sqlst = "select mem_pic from mmember where mem_code='"&MemNO&"'" 

		If f_sql_select(db_conn, sqlst, arrData) > 0 Then
			strFileName = full_path & arrData(0, 0) 'full_path lib/db.asp에 지정
		End If

		
'		if filename_del = "Y" then '파일삭제
'			If FSO.FileExists(strFileName) Then
'			FSO.deletefile(strFileName) 
'			end if 
'		end If
		
'		if(trim(filename)<>"" and not isnull(filename)) then
'			attach_file = uploadform("input_file").FilePath
'			attach_file = Mid(attach_file, InstrRev(attach_file,"\",-1,1) + 1)
'			attach_file = Replace(attach_file," ","")
'			
'			If ( Instr(attach_file, ".") <> 0 ) then 
'				'strName = Mid(attach_file, 1, InstrRev(attach_file,".",-1,1) - 1)
'				strName = MemNO
'				strExt = Mid(attach_file, InstrRev(attach_file,".",-1,1) + 1)
'			Else
'				strName = MemNO
'				strExt = ""
'			End If
'	  
'			strDir = full_path 
'			strNameExt = strName & "." & strExt
'			strFileName = strDir & strNameExt 
'			bExistCount = 1 
'		 
'			'Do While FSO.FileExists(strFileName) 
'			'	strNameExt = strName & "(" & bExistCount & ")." & strExt
'			'	strFileName = strDir & strNameExt
'			'	bExistCount = bExistCount + 1  
'			'Loop
'			uploadform("input_file").SaveAs strFileName
'			
'			'섬네일 저장
'			Set Image = Server.CreateObject("Nanumi.ImagePlus")
'				 Image.OpenImageFile strFileName
'			     Image.OverWrite = True   '덮어쓰기 여부
'			     Image.ImageFormat = "jpg"
'			     Image.Quality = 100
'			     Image.KeepAspect = false   'true면 원본 가로세로 비율대로 저장, false면 아래 이미지 사이즈대로 저장
'			     Image.ChangeSize 45, 48  'Image.width, Image.Height 이런것도 있습니다. 용도는 찾아보세요.
'			     Image.SaveFile strFileName
'			     Image.Dispose
'			     Set Image = Nothing
'
'
'
'
'			filename	=	strNameExt
'		end if

'		Set FSO = nothing 

	'& " mem_bank_number = '" & account & "', " _
	'& " mem_bank_code = '" & bank & "', " _
	sql = "UPDATE mmember SET " 
	sql =sql & " mem_jumin = '" & n_jumin & "', " 
	sql =sql & " mem_pw = '" & pwd & "', "
	sql =sql & " mem_home_tel = '" & tel & "', "
	sql =sql & " mem_hp_tel = '" & hp & "', "
	sql =sql & " mem_post = '" & post & "', "
	sql =sql & " mem_addr1 = N'" & uaddr1 & "', "
	sql =sql & " mem_addr2 = N'" & uaddr2 & "', "
	sql =sql & " mem_nation = N'" & nation(0) & "', "
'	sql =sql & " mem_agency_code = '" & agency & "', "  
	sql =sql & " mem_email = '" & email & "', "
	sql =sql & " mem_bank_code = '" & bank_code(0) & "', "
	sql =sql & " mem_bank_number = '" & bank_number & "', "
	sql =sql & " mem_bank_name = N'" & bank_name & "', "
	sql =sql & " mem_yekumju = N'" & mem_yekumju & "', "
	sql =sql & " mem_scode = N'" & n_mem_scode & "', "
	sql =sql & " mem_rcode = N'" & n_mem_rcode & "', "
	sql =sql & " mem_acode = N'" & n_mem_acode & "', "
	sql =sql & " mem_bcode = N'" & n_mem_bcode & "', "
	sql =sql & " mem_coin_sw = '" & n_mem_coinsw & "', "
	sql =sql & " mem_bid = N'" & n_mem_bid & "', "
	sql =sql & " mem_bid_addr = N'" & n_mem_bid_addr & "', "
	sql =sql & " mem_sid = N'" & n_mem_sid & "', "
	sql =sql & " mem_sid_addr = N'" & n_mem_sid_addr & "', "
	sql =sql & " mem_wbit_code = N'" & n_with_scode & "', "					' 비트코인 수당지급 받을 주소 
	sql =sql & " mem_ename = N'" & n_ename & "' "					'닉네임로 사용
	sql =sql & ", mem_bit_code = '" & mem_bit_code & "' "					'비트코인 주소
	if mem_ebh_code <> "" then 
		sql =sql & ", mem_eid_addr = '" & mem_ebh_code & "' "					'ebh코인 주소
	end if
		
		if filename_del = "Y" or (trim(filename)<>"" and not isnull(filename)) then
				sql =sql & ", mem_pic = '" & filename & "' "
		end If
		
		sql =sql & " WHERE mem_code = '" & MemNO & "' "

	If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요.
	Else
		jsMessageBox "The data has been saved.", "../myaccount.asp", "parent" '저장되었습니다.
	End If

End If


If (request("command") = "idch") Then '아이디변경
	mem_id = request("mem_id")
	MemNO = session("member")

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
			sql = "UPDATE mmember_temp SET " _
			& " mem_id = '" & mem_id & "', " _
			& " mem_card_num = '1' " _
			& " WHERE mem_code = '" & MemNO & "' "
			'Response.write sql
			If f_sql_modify(db_conn, sql) < 0 Then
			
			Else
				response.write "Y|The ID has been fixed. Please login again." '아이디가 수정되었습니다. 다시로그인 해주시기 바랍니다.
			End If
		End If
		Response.end
	End If

End If


If (request("command") = "join") Then '등록

	id = Trim(request("n_id"))
	nation = Split(Trim(request("n_nation")), "|")
	pwd = TRIM(Request("n_pass"))
	name = Trim(request("n_name"))
	jumin = Trim(request("n_jumin"))
	tel = TRIM(Request("n_telnum"))
	hp = TRIM(Request("n_cellnum"))
	post = TRIM(Request("n_zipno"))
	uaddr1 = TRIM(Request("n_addr1"))
	uaddr2 = TRIM(Request("n_addr2"))
	agency = Trim(request("n_agency"))
	email = TRIM(Request("n_email"))
	recom = Trim(request("n_recom_no"))
	spon = Trim(request("n_spon_no"))
	bank = Trim(Request("n_bank"))
	account = Trim(request("n_account"))
	owner = Trim(request("n_owner"))
	
		
	Function  flevelcount(recom) '레벨카운트
		sql="select count(*) from mmember where mem_choo_code='"&recom&"'"
		lngCnt = f_sql_select(db_conn, sql, arrData)

		If arrData(0, 0) > 0 Then
			flevelcount=arrData(0, 0)+1 
		Else
			flevelcount=1
		End If

	End Function
	

	'자리수 맞추는함수	
	Function Format(ByVal szString, ByVal Expression)
		If Len(szString) < Len (Expression) Then
			format = Left(Expression, Len(Expression) - Len(szString)) & szString
		Else
			format = szString
		End If
	End Function 
	
	'회원번호
	Function fmem_code()
		sql="select count(*),max(mem_code) from mmember where substring(mem_code,1,8)='KR00"&Mid(Year(Now()),3,4)&format(Month(Now()),"00")&"'"
		lngCnt = f_sql_select(db_conn, sql, arrData)

		If arrData(0, 0) > 0 Then
			a_codeAdd=Mid(arrData(1, 0),9,4)+1
			a_codeAdd2=format(a_codeAdd, "0000") 
			'mem_code=Left(arrData(1, 0),2)&a_codeAdd2
			mem_code="KR00"&Mid(Year(Now()),3,4)&format(Month(Now()),"00")&a_codeAdd2
		Else
			mem_code="KR00"&Mid(Year(Now()),3,4)&format(Month(Now()),"00")&"0001"
		End If
		fmem_code=mem_code
	End Function
	
	'후원인 카운트 채크
	Function hoo_Cntchk()
		sql="select count(*) from mmember where mem_hoo_code='"&spon&"' "
		hooCnt = f_sql_select(db_conn, sql, arrData)

		If arrData(0, 0) >= 2 Then
			
			'jsMessageBox "Registered sponsor is at least two people.", "", "document"
			Response.write "<script>alert('Registered sponsor is at least two people.'); parent.document.getElementById('bg_bok').style.backgroundColor='red'; parent.document.frmMain.n_spon_nm.focus(); </script>"
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
	mem_cancel		   = "6"
	
			
		sql = "exec up_choo_cdown @ls_memcode='"&fmem_code&"',@mem_choocode='"&recom&"'"
		'Response.write sql
		'Response.end
		If f_sql_modify(db_conn, sql) < 0 Then
			jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		End If 

		sql = "exec up_hoo_hdown @ls_memcode='"&fmem_code&"',@mem_hoocode='"&spon&"'"
		'Response.write sql
		'Response.end
		If f_sql_modify(db_conn, sql) < 0 Then
			jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
		End If 

	sql = "insert into mmember(" _
		& "mem_code, mem_gubun, mem_date, mem_name, mem_jumin, mem_choo_code, mem_hoo_code, mem_level_code, mem_level_count, " _
		& "mem_up_ab, mem_dn_acode, mem_dn_bcode, mem_post, mem_addr1, mem_addr2, mem_home_tel, mem_hp_tel, mem_agency_code, " _
		& "mem_bank_code, mem_bank_number, mem_yekumju, mem_email, mem_pan_kum, mem_nu_kum, mem_avatar_pay, mem_avatar_kum, " _
		& "mem_avatar_cnt, mem_up_jum, mem_ye_kum, mem_passwd, mem_id, mem_pw, mem_off_num, mem_card_num, mem_nation, " _
		& "mem_cancel, mem_bigo " _
		& ") VALUES ('" & fmem_code & "',  " _
		& "'"&mem_gubun&"', '"&mem_date&"', N'" & name & "', '" & jumin & "', '" & recom & "', '" & spon & "', '"&mem_level_code&"', '"&mem_level_count&"', " _
		& "'', '', '', " _
		& "'" & post & "', N'" & uaddr1 & "', N'" & uaddr2 & "', '" & tel & "', '" & hp & "', '" & mem_agency_code & "', '" & bank & "', " _
		& "'" & account & "', N'" & owner & "', '" & email & "', 0, 0, 0, 0, 0, 0, 0, '', '" & id & "', '" & pwd & "', '0', '', " _
		& "'" & nation(0) & "', '"&mem_cancel&"', 'web"&chktime&"' " _
		& ")"

	If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator.", "", "document" '저장 처리 중 오류가 발생하였습니다. 관리자에 문의하세요
	Else
			
			If request("mode") = "homereg" Then
				jsMessageBox "The data has been successfully saved.", "../logincheck.asp?mode=homereg&n_id="&id&"&n_pw="&pwd, "parent" '저장되었습니다.
			ElseIf request("mode") = "reg" Then
				jsMessageBox "The data has been successfully saved.", "../register.asp", "parent"
			Else
				jsMessageBox "The data has been saved.", "../logincheck.asp?mode=reg&n_id="&id&"&n_pw="&pwd, "parent" '저장되었습니다.
			End If
	
	End If

End If

%>
