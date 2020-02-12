<%
' ===========================
' injection 처리
' ===========================
injection_filter  = "<script|delete from|drop table|drop column|alter table|alter column|;--|declare @|exec(|set @|; --|char(|varchar("



Function f_injection(query_string)

      query_string = LCase(query_string)
      f_injection = false

      injection_filter_arr = split(injection_filter,"|")
      injection_filter_cnt = Ubound(injection_filter_arr)

      for j = 0 to injection_filter_cnt

       if InStr(1,query_string,injection_filter_arr(j),1) > 0 Then

	        f_injection = true

				'Response.Write "<font color=red>죄송합니다.<br>"
		    'Response.Write "특수문자나 명령어들은 서버에 전달할 수 없습니다. (필터링된 문자 : <font color=blue>"& injection_filter_arr(j) &"</font>)<br>"
			'Call objXML_Log(injection_filter_arr(j),query_string)
	     '   Response.End

        exit for
       end if
      next
End function


	'post체크
	For each item in REQUEST.FORM

		For i=1 to REQUEST.FORM(item).Count

			If  REQUEST.FORM(item)(i) <> "" Then
				If f_injection(REQUEST.FORM(item)(i)) = true then
					post_check = true
					exit for
				End if
			End if
		Next
	Next

'cookie체크
	For each item in REQUEST.COOKIES
		For i=1 to REQUEST.COOKIES(item).Count

			If  REQUEST.COOKIES(item)(i) <> "" Then
'				Response.Write REQUEST.COOKIES(item)(i)
				If f_injection(REQUEST.COOKIES(item)(i)) = true then
					cookie_check = true
					exit for
				End if
			End if
		Next
	Next

'get체크
     inj_qs = Request.ServerVariables("QUERY_STRING")

    If inj_qs <> "" Then
	    get_check = f_injection(unescape(inj_qs))
	End if

	if post_check = true or get_check = True Or cookie_check = True Then
	'	Response.Write("<script language=""javascript"" type=""text/javascript""> alert(""SQL INJECTION으로 의심되는 문장이 삽입되어 있습니다.\n\n이전페이지로 이동합니다.""); history.go (-1); </script>")
		Response.End
	End if

%>