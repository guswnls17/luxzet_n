<%@CodePage = 65001%>
<%
Response.CharSet  = "UTF-8"
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "cache-control", "no-staff"
Response.Expires  = -1

Dim Conn

session.timeout = 60

CompanyName = "dottchain"
CompanyEName = "dottchain"
'무통장
bankinfo="Bank "
bankname=" &nbsp;&nbsp;&nbsp;Account Holder : <Br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"

url_full_path = "\myoffice\_upload\chart\"	
full_path = Request.ServerVariables("APPL_PHYSICAL_PATH")&url_full_path

'오늘 23시 ~ 23시59분, 오늘 00시 ~ 03시까지 채크
'If (datediff("N", date&" 23:00", now()) >= 0 And datediff("N", date&" 23:59", now()) < 0) Or (datediff("N", date&" 00:00", now()) >= 0 And datediff("N", date&" 02:00", now()) < 0) Then'
'	Response.write "<script>alert('Server Scans 11:00 p.m. ~ 2:00 a.m.\n\n매일 오후11시 ~ 오전2시 까지 서버 점검중입니다.'); location.href='/myoffice/login.asp'; </script>"
'	session.timeout = 1
'	DBclose()
'	Response.end
'End If

'db_conn = "Provider=SQLOLEDB.1;" _
'		& "Persist Security Info=False;" _
'		& "User ID=gbi;" _
'		& "pwd=gbi2015;" _
'		& "Initial Catalog=gbi;" _
'		& "Data Source=14.49.38.167"

'db_conn = "Provider=SQLOLEDB.1;" _
'		& "Persist Security Info=False;" _
'		& "User ID=plusasw;" _
'		& "pwd=plusasw1219;" _
'		& "Initial Catalog=plusprofit;" _
'		& "Data Source=198.12.148.61"
		
db_conn = "Provider=SQLOLEDB.1;" _
		& "Persist Security Info=False;" _
		& "User ID=dott;" _
		& "pwd=dott2020#;" _
		& "Initial Catalog=dott;" _
		& "Data Source=107.180.77.203"

'pz_conn = "Provider=SQLOLEDB.1;" _
'		& "Persist Security Info=False;" _
'		& "User ID=sa;" _
'		& "pwd=iape))7));" _
'		& "Initial Catalog=POSTZIP;" _
'		& "Data Source=121.78.112.109"


debug_mode = "on"

If pagesize = "" Then pagesize = 20
sUsrAgent = UCase(Request.ServerVariables("HTTP_USER_AGENT"))

If InStr(sUsrAgent, "ANDROID") > 0 Then
	pagesize = 3
ElseIf InStr(sUsrAgent, "IPAD") Or InStr(sUsrAgent, "IPHONE") Then
	pagesize = 3
Else
	pagesize = 6
End If

TimeOut = 3600

Server.ScriptTimeout = TimeOut

Public Function DBopen()

	Set Conn = Server.CreateObject("ADODB.Connection") 
	ConnectionString = db_conn
	Conn.ConnectionString = ConnectionString
	Conn.ConnectionTimeout = 36000
	Conn.Open
	
	If Err <> 0 Then
	DBopen = FALSE
	Else
	DBopen = True
	End If

End Function

Public Function DBclose()
	
	Conn.Close
	set Conn = nothing	
End Function

'인젝션방지
Server.Execute("/myoffice/lib/sql_injection.asp")

function f_sql_select_page(conn, sql, ByRef page, ByRef arrData)

	arrData = Null
	f_sql_select_page = -1

	On Error Resume next

	Set db = Server.CreateObject( "ADODB.Connection" )
	db.Open conn
	db.commandtimeout = TimeOut

	If Err.number = 0 then

		Set rs = server.CreateObject("adodb.recordset")
		rs.cursortype = 3
		rs.cursorlocation = 3
		rs.locktype = 3
		rs.open sql, db

		If Err.number = 0 then
			If rs.eof Then
				f_sql_select_page = 0
			Else
				rowcount = rs.recordcount
				rs.pagesize = pagesize
				pagecount = rs.pagecount
				If CLng(pagecount) < CLng(page) Then page = pagecount
				rs.absolutepage = page

				colcnt = rs.fields.count
				If rowcount < pagesize * page Then
					rowcnt = rowcount - (pagesize * Fix(rowcount / pagesize))
				Else
					rowcnt = pagesize
				End If
				
				colcnt = colcnt - 1
				rowcnt = rowcnt - 1
				
				ReDim arrData(colcnt, rowcnt)

				For i = 0 To rowcnt
					For j = 0 To colcnt
						arrData(j, i) = rs(j)
					Next
					rs.movenext
				Next

				f_sql_select_page = rowcount
			End If
		Else
			If debug_mode = "on" Then response.write sql & "<br>" & Err.description
		End If

		rs.close
		Set rs = nothing

	Else
		f_sql_select_page = -2
	End if
	db.close
	Set db = nothing

	On Error goto 0
End function

function f_sql_select(conn, sql, ByRef arrData)

	arrData = Null
	f_sql_select = -1

	On Error Resume next

	Set db = Server.CreateObject( "ADODB.Connection" )
	db.Open conn
	db.commandtimeout = TimeOut

	If Err.number = 0 then

		Set rs = db.execute(sql)

		If Err.number = 0 then
			If rs.eof Then
				f_sql_select = 0
			else
				arrData = rs.GetRows
				f_sql_select = UBound(arrData, 2) + 1
			End If
		Else
			If debug_mode = "on" Then response.write sql & "<br>" & Err.description
		End If

		rs.close
		Set rs = nothing

	Else
		f_sql_select = -2
	End if
	db.close
	Set db = nothing

	On Error goto 0
End function

function f_sql_modify(conn, sql)

	f_sql_modify = -1

	On Error Resume next
	
	Set db = Server.CreateObject( "ADODB.Connection" )
	db.Open conn
	db.commandtimeout = TimeOut

	If Err.number = 0 then

		db.execute sql

		If Err.number = 0 then
			f_sql_modify = 0
		Else
			If debug_mode = "on" Then response.write sql & "<br>" & Err.description
		End If
	End if

	db.close
	Set db = nothing

	On Error goto 0
End Function

function GetLength(strText)
	dim nByteLen, nIdx, nLenIdx, nTextLenth

	if isnull(strText) then
		GetLength = 0
		exit function
	end if

	nByteLen = 0
	nTextLenth = len(strText)

	nIdx = 1

	for nLenIdx = 1 to nTextLenth
		if asc(mid(strtext, nIdx, 1)) < 0 then
			nByteLen = nByteLen + 2
		else
			nByteLen = nByteLen + 1
		end if
		nIdx = nIdx + 1
	next
	GetLength = nByteLen
end function

function SetLengthNew(strText, cutCount, replaceStr)
	dim nIdx, nLenIdx, strResult
	nIdx = 1

	strText = Replace(strText, Chr(9), "")

	if GetLength(strText) > cutCount Then
		strResult = ""
		for nLenIdx = 0 to cutCount
'			response.write "[" & asc(mid(strText, nIdx, 1)) & ":" & strResult & "]"
			if asc(mid(strText, nIdx, 1)) < 0 then
				if nLenIdx = cutCount - 1 then
					exit for
				end if
				nLenIdx = nLenIdx + 1
			end if
			strResult = strResult & mid(strText, nIdx, 1)
			nIdx = nIdx + 1
		next
		strResult = strResult & replaceStr
	Else
'		If Trim(strText) = "" Then strResult = "[제목없음]" Else 
		strResult = strText
	end if
	SetLengthNew = strResult
end function

function GetLengthU(strText)
	dim nByteLen, nIdx, nLenIdx, nTextLenth

	if isnull(strText) then
		GetLength = 0
		exit function
	end if

	nByteLen = 0
	nTextLenth = len(strText)

	nIdx = 1

	for nLenIdx = 1 to nTextLenth
		if asc(mid(strtext, nIdx, 1)) = 0 Or asc(mid(strtext, nIdx, 1)) = 1 then
			nByteLen = nByteLen + 2
		else
			nByteLen = nByteLen + 1
		end if
		nIdx = nIdx + 1
	next
	GetLengthU = nByteLen
end function

function SetLengthNewU(strText, cutCount, replaceStr)
	dim nIdx, nLenIdx, strResult
	nIdx = 1

	strText = Replace(strText, Chr(9), "")

	if GetLengthU(strText) > cutCount Then
		strResult = ""
		for nLenIdx = 0 to cutCount
'			response.write "[" & asc(mid(strText, nIdx, 1)) & ":" & strResult & "]"
			if asc(mid(strtext, nIdx, 1)) = 0 Or asc(mid(strtext, nIdx, 1)) = 1 then
				if nLenIdx = cutCount - 1 then
					exit for
				end if
				nLenIdx = nLenIdx + 1
			end if
			strResult = strResult & mid(strText, nIdx, 1)
			nIdx = nIdx + 1
		next
		strResult = strResult & replaceStr
	Else
'		If Trim(strText) = "" Then strResult = "[제목없음]" Else 
		strResult = strText
	end if
	SetLengthNewU = strResult
end function

function textEncode(strText)
	textEncode = Replace(strText, "'", "''")
end Function

function textDecode(strText)
	strText = Replace(strText, " ", "&nbsp; ")
	strText = Replace(strText, Chr(13) & Chr(10), "<br>")
	textDecode = strText
end Function

Function Replace_enter(s)

	Dim t

	If not IsNull(s) Then
	
		t = Replace(s,chr(13) & chr(10),"<br>")
		
	End If

	Replace_enter = t
	
End Function


Function ReReplace_squoto(s)

	Dim t

	If not IsNull(s) Then
		
		t = Replace(s,"`","'")
		
	End If

	ReReplace_squoto = t
	
End Function


Function Replace_spacebar(s)

	Dim t

	If not IsNull(s) Then
		
		t = Replace(s," ","&nbsp;")
		
	End If

	Replace_spacebar = t
	
End Function


Public Sub jsMessageBox(Message, Url, target)
    Response.Write "<script type='text/javascript'>"
    If Message <> "" Then Response.Write "alert('" & Message & "');"
	If Url = "back" Then 
	    Response.Write "history.back();"
	Elseif Url <> "" then
		Response.Write target & ".location.href = '" & Url & "'"
	End if
    Response.Write "</script>"
    Response.End
End Sub

Function checkbox(value)
	checkbox = ""
	If value = "Y" then	checkbox = " checked"
End function

Function checkbox2(value1, value2)
	checkbox = ""
	If value1 = value2 then	checkbox = " checked"
End function

Function option_select(value1, value2)
	option_select = ""
	If value1 = value2 then	option_select = " selected"
End function

Function iif(condition, a, b)
	If condition Then
		iif = a
	Else
		iif = b
	End if
End function

%>
<%
	la = Request.Cookies("lan")
	If request("langu") = "CHN" Then
		la = 1
	Elseif request("langu") = "USA" Then
		la = 0
	Elseif request("langu") = "KOR" Then
		la = 2
	Elseif request("langu") = "JAP" Then
		la = 3
	End If

	If la = "" Then
		la = 0
		response.cookies("lan") = la
		response.cookies("lan").Expires=date+365
		la = Request.Cookies("lan")
	End if
	If la >= 0 then
		response.cookies("lan") = la
		response.cookies("lan").Expires=date+365
	End If
	
	lan =  la
%>
<!-- #Include virtual = "/myoffice/lib/lang.asp" -->