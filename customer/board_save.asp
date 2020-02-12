<!--#include file ="../lib/db.asp"-->
<!--#include file ="../lib/util.asp"-->
<!--#include file ="./loginchk.asp"-->
<%
	
	if DBopen() = false then
		Call Sub_Display_Error("Please contact your database connection error manager.") 
	end If
  
	Set uploadform = Server.CreateObject("SiteGalaxyUpload.Form")
	'UploadForm.CodePage = "65001"

	'Response.end

	full_path		= board_full_path

	idx				= uploadform("idx") 
	flag			= uploadform("flag") 
	searchField		= uploadform("searchField")
	searchValue		= uploadform("searchValue") 
	page			= uploadform("page")
	code			= uploadform("code")
	
    if isNull2(flag) then flag = request("flag") 
	if isNull2(code) then code = "qna"

	if flag="edit" then
		On error resume Next
		Conn.BeginTrans
 
		subject			= Special_Filter(uploadform("subject"))
		content			= Special_Filter(uploadform("content"))
		  	 
		secret_flag		= uploadform("secret_flag")
		if secret_flag <> "1" then secret_flag = "0"
		filename		= uploadform("filename")
		filename_del	= uploadform("filename_del")

		Set FSO = CreateObject("Scripting.FileSystemObject") 
		set Rs1 = Server.CreateObject("ADODB.RecordSet")
		sqlst = "select * from board where idx='"&idx&"'" 
		Rs1.Open sqlst,Conn,3 
		strFileName = full_path & Rs1("filename")
		write_id = Rs1("write_id")
	 
		if session("userid") <> write_id and session("userid") <> "DAONOL" then call alertBack("NO! Modify!!")

		if filename_del = "Y" then 
			If FSO.FileExists(strFileName) Then
			FSO.deletefile(strFileName) 
			end if 
		end if

		set Rs1 = nothing
 
		if(trim(filename)<>"" and not isnull(filename)) then
		 
			If FSO.FileExists(strFileName) Then
				FSO.deletefile(strFileName) 
			end if
			 
			attach_file = uploadform("filename").FilePath
			attach_file = Mid(attach_file, InstrRev(attach_file,"\",-1,1) + 1)
			attach_file = Replace(attach_file," ","")

			If ( Instr(attach_file, ".") <> 0 ) then 
			strName = Mid(attach_file, 1, InstrRev(attach_file,".",-1,1) - 1)
			strExt = Mid(attach_file, InstrRev(attach_file,".",-1,1) + 1)
			Else
			strName = attach_file
			strExt = ""
			End If
	  
			strDir = full_path 
			strNameExt = strName & "." & strExt
			strFileName = strDir & strNameExt 
			bExistCount = 1 
		 
			Do While FSO.FileExists(strFileName) 
				strNameExt = strName & "(" & bExistCount & ")." & strExt
				strFileName = strDir & strNameExt
				bExistCount = bExistCount + 1  
			Loop
			
			uploadform("filename").SaveAs strFileName
			filename	=	strNameExt
		end if

		Set FSO = nothing 


		SQLST = " UPDATE board SET  subject='"&subject&"', content='"&content&"' ,secret_flag='"&secret_flag&"' "
		if filename_del = "Y" or (trim(filename)<>"" and not isnull(filename)) then
		SQLST =SQLST & ",filename = '"& filename &"'"		
		end if
		SQLST = SQLST & " WHERE code='"& code &"' and idx="&idx
	 
		Conn.Execute(SQLST)
		response.write Err.description	

		if Err.Number <> 0 then
			Conn.RollbackTrans
			Err.Clear
			Call Sub_Display_Error("Edit Error")
		else
			Conn.CommitTrans
			Err.Clear

			response.write "<script>window.location.href='../qna.asp?code="&code&"&idx="&idx&"&page="&page&"&searchField="&searchField&"&searchValue="&searchValue&"&qna_chk="&qna_chk&"';</script>" 
		end if 

	elseif  flag = "answer" then	

		On error resume Next
		Conn.BeginTrans

		Set rs = Server.createObject("ADODB.RecordSet")
 
			
		sql = "select write_id,owner_name,step,depth,question_idx from board where idx = "&idx
		rs.Open sql, Conn, 1
		step_id1	= rs("step") 
		depth		= rs("depth")
			If rs("question_idx") = 0 Then
				owner_name	= rs("write_id")
			Else
				owner_name	= rs("owner_name")
			End If
		rs.close()
		Set rs=Nothing 

		Set rs = Server.createObject("ADODB.RecordSet")
		sql = "select max(step) as st2 from board where code='"& code &"' and step < "&step_id1
		rs.Open sql, Conn, 1 
		step_id2=rs("st2")

		If IsNull(step_id2) Then step_id2 = 0.5

		step_id  = (step_id1+step_id2)/2 

		rs.close()
		Set rs=Nothing
		
		depth		=	depth+1
		question_idx=	idx
  
		write_name		= Special_Filter(uploadform("write_name"))
		subject			= Special_Filter(uploadform("subject"))
		content			= Special_Filter(uploadform("content"))
		secret_flag		= uploadform("secret_flag")
 		if secret_flag <> "1" then secret_flag = "0"


		filename		= uploadform("filename")
	 
		if(trim(filename)<>"" and not isnull(filename)) then
			attach_file = uploadform("filename").FilePath
			attach_file = Mid(attach_file, InstrRev(attach_file,"\",-1,1) + 1)
			attach_file = Replace(attach_file," ","")

			If ( Instr(attach_file, ".") <> 0 ) then 
			strName = Mid(attach_file, 1, InstrRev(attach_file,".",-1,1) - 1)
			strExt = Mid(attach_file, InstrRev(attach_file,".",-1,1) + 1)
			Else
			strName = attach_file
			strExt = ""
			End If
	  
			strDir = full_path 
			strNameExt = strName & "." & strExt
			strFileName = strDir & strNameExt 
			bExistCount = 1 
			Set FSO = CreateObject("Scripting.FileSystemObject")
			Do While FSO.FileExists(strFileName) 
				strNameExt = strName & "(" & bExistCount & ")." & strExt
				strFileName = strDir & strNameExt
				bExistCount = bExistCount + 1  
			Loop
			 
			Set FSO = Nothing  
			uploadform("filename").SaveAs strFileName
			filename	=	strNameExt
		end if
 
 

		SQLST = "INSERT INTO board (write_id,write_name,subject,content,filename,step,depth,question_idx,secret_flag,code,owner_name) VALUES  "
		SQLST = SQLST & " ('"& session("userid") &"','"& session("username") &"','"&subject&"','"&content&"','"&filename&"','"&step_id&"',"&depth&","&question_idx&",'"&secret_flag&"','"&code&"','"&owner_name&"') " 
		Conn.Execute(SQLST) 
		response.write Err.description
		if Err.Number <> 0 then
			Conn.RollbackTrans 
			Err.Clear
			Call Sub_Display_Error("Answer Error")
		else
			Conn.CommitTrans
			Err.Clear
			response.write "<script>window.location.href='../qna.asp?code="& code &"&page="&page&"&searchField="&searchField&"&searchValue="&searchValue&"&qna_chk="&qna_chk&"';</script>" 
		end if
	elseif flag = "delete" then

		On error resume Next
		Conn.BeginTrans

		set Rs1 = Server.CreateObject("ADODB.RecordSet")
		sqlst = "select * from board where idx='"&idx&"'"
		Rs1.Open sqlst,Conn,3
 
		strFileName = full_path & Rs1("filename")
		write_id	= Rs1("write_id")
		
		if (session("userid") <> write_id and session("userid") <> "DAONOL") then call alertBack("NO! Modify!!")


		Set FSO = CreateObject("Scripting.FileSystemObject") 
			If FSO.FileExists(strFileName) Then
			FSO.deletefile(strFileName) 
			end if
		Set FSO = nothing 
		set Rs1 = nothing

		SQLST = " DELETE From board WHERE code='"& code &"' and idx="&idx
		Conn.Execute(SQLST)
		response.write Err.description
		if Err.Number <> 0 then
			Conn.RollbackTrans
			Err.Clear
			Call Sub_Display_Error("Delete Error")
		else
			Conn.CommitTrans
			Err.Clear
			response.write "<script>window.location.href='../qna.asp?code="& code &"&page="&page&"&searchField="&searchField&"&searchValue="&searchValue&"&qna_chk="&qna_chk&"';</script>" 
		end if
	elseif  flag = "insert" then	
 
		On error resume Next
		Conn.BeginTrans
  
		Set rs = Server.createObject("ADODB.RecordSet")

		sql = "select max(step) as st from board where code='"& code &"'" 
		rs.Open sql, Conn, 1  

		If not isNull(rs("st")) Then 
			max_id = rs("st")
		else
			max_id = 0
		End If  
		step_id   = max_id + 1  
		rs.close
		Set rs=Nothing

		depth			= 0 
		question_idx	= 0 
		
		owner_no		= Special_Filter(uploadform("owner_no"))
		write_name		= Special_Filter(uploadform("write_name"))
		subject			= Special_Filter(uploadform("subject"))
		content			= Special_Filter(uploadform("content"))
		secret_flag		= uploadform("secret_flag")
		
		notice			= Special_Filter(uploadform("notice"))
			If notice = "" Then
				notice = "null"
			Else
				notice = "'"&notice&"'"
			End If

 		if secret_flag <> "1" then secret_flag = "0"
		filename		= uploadform("filename")


		if(trim(filename)<>"" and not isnull(filename)) then
			attach_file = uploadform("filename").FilePath
			attach_file = Mid(attach_file, InstrRev(attach_file,"\",-1,1) + 1)
			attach_file = Replace(attach_file," ","")

			If ( Instr(attach_file, ".") <> 0 ) then 
			strName = Mid(attach_file, 1, InstrRev(attach_file,".",-1,1) - 1)
			strExt = Mid(attach_file, InstrRev(attach_file,".",-1,1) + 1)
			Else
			strName = attach_file
			strExt = ""
			End If
	  
			strDir = full_path 
			strNameExt = strName & "." & strExt
			strFileName = strDir & strNameExt 
			bExistCount = 1 
			Set FSO = CreateObject("Scripting.FileSystemObject")
			Do While FSO.FileExists(strFileName) 
				strNameExt = strName & "(" & bExistCount & ")." & strExt
				strFileName = strDir & strNameExt
				bExistCount = bExistCount + 1  
			Loop
			 
			Set FSO = Nothing  
			uploadform("filename").SaveAs strFileName
			filename	=	strNameExt

		end if
 

		SQLST = "INSERT INTO board (write_id,write_name,subject,content,filename,step,depth,question_idx,secret_flag,code,owner_name,category) VALUES  "
		SQLST = SQLST & " ('"& session("userid") &"','"& session("username") &"','"&subject&"','"&content&"','"&filename&"','"&step_id&"',"&depth&","&question_idx&",'"&secret_flag&"','"&code&"','"&owner_no&"',"&notice&") "
		'Response.write SQLST
		'Response.end
		Conn.Execute(SQLST)  
		response.write Err.description
		if Err.Number <> 0 then
			Conn.RollbackTrans
			Err.Clear
			Call Sub_Display_Error("Insert Error")
		else
			Conn.CommitTrans
			Err.Clear
			response.write "<script>window.location.href='../qna.asp?code="&code&"';</script>" 
		end if
	end if
	DBclose()
%>