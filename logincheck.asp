<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
id = request("n_id")
pw = request("n_pw")
n_check = request("n_check")
mode = request("mode")

sql = "select mem_pw, mem_name, mem_code, mem_jumin, mem_agency_code "
sql = sql & "from mmember "
sql = sql & "where mem_id = '" & id & "' "
sql = sql & "and mem_cancel in ('1','6')"

If f_sql_select(db_conn, sql, arrData) > 0 Then

	If arrData(0, 0) = pw Then
		session("username") = arrData(1, 0)
		session("userid") = UCase(id)
		session("member") = arrData(2, 0)
		session("juminno") = arrData(3, 0)
		session("agency") = arrData(4, 0)
	
'		sql = "select isnull(max(convert(varchar(50), 접속시간, 20)), '최초접속') from LOG_LOGIN_MYOFFICE where 아이디 = '" & Session("userid") & "' "
'		sql = sql & "INSERT INTO LOG_LOGIN_MYOFFICE (접속시간, 아이피, 아이디, 회원성명) VALUES "
'		sql = sql & "(getdate(), '" & Request.ServerVariables("REMOTE_ADDR") & "', '" & Session("userid") & "', '" & Session("username") & "')"

'		f_sql_select db_conn, sql, arrData

'		session("lastlogin") = arrData(0, 0)
		Session("lastlogin") = now()
		if n_check = "on" then
			Response.Cookies("memid")=Session("userid")
			Response.Cookies("memid").Expires=date+365 
			
			Response.Cookies("memp")=pw
			Response.Cookies("memp").Expires=date+365 
		else 
			Response.Cookies("memid")=""
			Response.Cookies("memid").Expires=date+365 
			
			Response.Cookies("memp")=""
			Response.Cookies("memp").Expires=date+365 
		end if
		
		If mode = "reg" Then
			jsMessageBox "", "/myoffice/myaccount.asp", "document"
		ElseIf mode = "homereg" Then
			jsMessageBox "", "/myoffice/myaccount.asp", "document"
		ElseIf mode = "homepage" Then
			jsMessageBox "", "/home/index.asp", "document"
		Else
			jsMessageBox "", "home.asp", "document"
		End If

		'response.end
	End If
Else
  	sql = "select mem_pw, mem_name, mem_code, mem_jumin, mem_agency_code "
	sql = sql & "from mmember_temp "
	sql = sql & "where mem_id = '" & id & "' "
	sql = sql & "and mem_cancel in ('1','6')"
	
	If f_sql_select(db_conn, sql, arrData) > 0 Then
	
		If arrData(0, 0) = pw Then
			session("username") = arrData(1, 0)
			session("userid") = UCase(id)
			session("member") = arrData(2, 0)
			session("juminno") = arrData(3, 0)
			session("agency") = arrData(4, 0)
		
	'		sql = "select isnull(max(convert(varchar(50), 접속시간, 20)), '최초접속') from LOG_LOGIN_MYOFFICE where 아이디 = '" & Session("userid") & "' "
	'		sql = sql & "INSERT INTO LOG_LOGIN_MYOFFICE (접속시간, 아이피, 아이디, 회원성명) VALUES "
	'		sql = sql & "(getdate(), '" & Request.ServerVariables("REMOTE_ADDR") & "', '" & Session("userid") & "', '" & Session("username") & "')"

	'		f_sql_select db_conn, sql, arrData

	'		session("lastlogin") = arrData(0, 0)
			Session("lastlogin") = now()
			if n_check = "on" then
				Response.Cookies("memid")=Session("userid")
				Response.Cookies("memid").Expires=date+365 
				
				Response.Cookies("memp")=pw
				Response.Cookies("memp").Expires=date+365 
			else 
				Response.Cookies("memid")=""
				Response.Cookies("memid").Expires=date+365 
				
				Response.Cookies("memp")=""
				Response.Cookies("memp").Expires=date+365 
			end if
			
			If mode = "reg" Then
				jsMessageBox "", "/myoffice/myaccount.asp", "document"
			ElseIf mode = "homereg" Then
				jsMessageBox "", "/myoffice/myaccount.asp", "document"
			ElseIf mode = "homepage" Then
				jsMessageBox "", "/home/index.asp", "document"
			Else
				jsMessageBox "", "home.asp", "document"
			End If

			'response.end
		End If
	End If
	
End If

jsMessageBox "Please verify your login information", "back", "document"
%>
