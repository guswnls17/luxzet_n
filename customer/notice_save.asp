<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/util.asp" -->
<%

	 dim FileSize, fileSaveDir, Upload, getfile, upname,name1,name2
     
    set Upload=server.createobject("ABCUpload4.XForm")'XForm객체 생성
    'Set Upload = Server.CreateObject("ABCUpload4.XForm")  
    Upload.Maxuploadsize = 1024*1024*20  '최대 파일 사이즈 지정
    Upload.AbsolutePath = True '절대 경로로 접근
    Upload.Overwrite = True '같은 파일 있을 때 덮어쓰기 가능으로 설정
    fileSaveDir = server.mappath("../") & "\_uploadf\" 'upload 패스
	abDir = "/_uploadf/"
 
    Upload.CodePage = 65001 'euc-kr로 인코딩 한글텍스트와 파일이름을 받기위함.
	
	idx				= Upload("idx") 
	flag			= Upload("flag") 
	searchField		= Upload("searchField")
	searchValue		= Upload("searchValue") 
	page			= Upload("page")
	code			= Upload("code")
	
	if isNull2(flag) then flag = Upload("flag") 
	if isNull2(code) then code = "notice"
	
	if flag="edit" then
		
		subject			= Upload("subject")(1)
		content			= Upload("ir1")(1)
		
		secret_flag		= Upload("secret_flag")
		if secret_flag <> "1" then secret_flag = "0"
 
		
'		if session("userid") <> write_id and session("userid") <> "ADMIN" then call alertBack("NO! Modify!!")

		Set getfile = Upload("filename")(1)
		filename_del	= Upload("filename_del")
		filename = ""
		if(not isnull(getfile)) then
			Dim fso, fldr
			SET fso = CreateObject("Scripting.FileSystemObject") '파일시스템 오브젝트 생성
			 
			IF NOT(fso.FolderExists(fileSaveDir)) Then ' 폴더가 없으면
				SET fldr = fso.CreateFolder(fileSaveDir) '폴더 생성
			END IF
			SET fso = NOTHING  '오브젝트 생성 해제
			
			'XField객체를 생성하여 파일가져오기 (input file name을 써준다.)
			'파일이름이 같으니 (1)(2)등의 인덱스 요소를 사용.
			
			If getfile.FileExists Then '업로드된 파일이 있으면
				name1 = getfile.RawFileName '파일이름 설정 후
				getfile.Save fileSaveDir&name1 ' 파일 저장  
				filename = name1
'				response.write fileSaveDir&name1
			End If
		end if 
		
		  	 
		sql = " UPDATE board SET  subject=N'"&subject&"', content=N'"&content&"' ,secret_flag='"&secret_flag&"' " 
		if filename_del = "Y" or ( not isnull(getfile)) then
			sql = sql & ",filename = '"& filename &"'"		
		end if 
		sql = sql & " WHERE code='"& code &"' and idx="&idx
		
'		response.write sql
		If f_sql_modify(db_conn, sql) < 0 Then
			jsMessageBox language(lan,174), "", "document"
			response.write "<script>window.location.href='../notice.asp?code="& code &"'</script>"  
		End If
		
		response.write "<script>window.location.href='../notice.asp?code="&code&"&idx="&idx&"&page="&page&"&searchField="&searchField&"&searchValue="&searchValue&"';</script>" 
		
	end if	

	
	if flag = "delete" then
		if isNull2(idx) then idx = request("idx") 
		
'		if (session("userid") <> write_id and session("userid") <> "ADMIN") then call alertBack("NO! Modify!!")
		
		
		
		sql = " DELETE From board WHERE code='"& code &"' and idx="&idx
		If f_sql_modify(db_conn, sql) < 0 Then
			jsMessageBox language(lan,174), "", "document"
			response.write "<script>window.location.href='../notice.asp?code="& code &"'</script>"  
		End If
		
		response.write "<script>window.location.href='../notice.asp?code="& code &"'</script>"  
	
	end if
	if  flag = "insert" then	
	
		sq1 = "select max(step) as st from board where code='"& code &"'" 
		If f_sql_select(db_conn, sq1, arrData) > 0 Then
			max_id	= arrData(0, 0)
		End If
		
		If isNull(max_id) Then 
			max_id = 0
		End If  
		
		step_id   = max_id + 1 
		
		depth			= 0 
		question_idx	= 0 
 
		write_name		= Upload("write_name")
		subject			= Upload("subject")(1)
		content			= Upload("ir1")(1)
		secret_flag		= Upload("secret_flag")
 		if secret_flag <> "1" then secret_flag = "0"
		
		Set getfile1 = Upload("filename")(1)
		filename_del	= Upload("filename_del")
		filename = ""
		if(not isnull(getfile1)) then
			Dim fsoi, fldri
			SET fsoi = CreateObject("Scripting.FileSystemObject") '파일시스템 오브젝트 생성
			 
			IF NOT(fsoi.FolderExists(fileSaveDir)) Then ' 폴더가 없으면
				SET fldri = fsoi.CreateFolder(fileSaveDir) '폴더 생성
			END IF
			SET fsoi = NOTHING  '오브젝트 생성 해제
			
			'XField객체를 생성하여 파일가져오기 (input file name을 써준다.)
			'파일이름이 같으니 (1)(2)등의 인덱스 요소를 사용.
			
			If getfile1.FileExists Then '업로드된 파일이 있으면
				name1 = getfile1.RawFileName '파일이름 설정 후
				getfile1.Save fileSaveDir&name1 ' 파일 저장  
				filename = name1
'				response.write fileSaveDir&name1
			End If
		end if 
		
		sql = "INSERT INTO board (write_id,write_name,subject,content,filename,step,depth,question_idx,secret_flag,code) VALUES  " 
		sql = sql & " ('"& session("userid") &"','"& session("username") &"',N'"&subject&"',N'"&content&"','"&filename&"','"&step_id&"',"&depth&","&question_idx&",'"&secret_flag&"','"&code&"') "
		
		If f_sql_modify(db_conn, sql) < 0 Then
			jsMessageBox language(lan,174), "", "document"
			response.write "<script>window.location.href='../notice.asp?code="& code &"'</script>"  
		End If
		
		response.write "<script>window.location.href='../notice.asp?code="&code&"';</script>" 
	
	end if
	
%>