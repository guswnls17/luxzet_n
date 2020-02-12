<%
	If session("userid") = "" Then
		response.write "<script>alert('After loging available.\n\n로그인후 이용 가능합니다.'); window.location.href='../login.asp'</script>"  
		Response.end
	End If
%>