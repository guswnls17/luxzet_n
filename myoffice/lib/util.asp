<%  
	board_full_path			= Request.ServerVariables("APPL_PHYSICAL_PATH")&"myoffice\_upload\" '첨부파일경로

	Sub mailsend(byVal write_Name,byVal from_Email,byVal to_Email, byVal mailTitle, byVal str) 
	
		Const cdoSendUsingMethod = _ 
		"http://schemas.microsoft.com/cdo/configuration/sendusing" 
		'Const cdoSendUsingPort = 2 
		Const cdoSMTPServer = _ 
		"http://schemas.microsoft.com/cdo/configuration/smtpserver" 
		Const cdoSMTPServerPort = _ 
		"http://schemas.microsoft.com/cdo/configuration/smtpserverport" 
		Const cdoSMTPConnectionTimeout = _ 
		"http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout" 
		Const cdoSMTPAccountName = _ 
		"http://schemas.microsoft.com/cdo/configuration/smtpaccountname" 
		Const cdoSMTPAuthenticate = _ 
		"http://schemas.microsoft.com/cdo/configuration/smtpauthenticate" 
		Const cdoBasic = 1 
		Const cdoSendUserName = _ 
		"http://schemas.microsoft.com/cdo/configuration/sendusername" 
		Const cdoSendPassword = _ 
		"http://schemas.microsoft.com/cdo/configuration/sendpassword" 

		Dim objConfig ' As CDO.Configuration 
		Dim objMessage ' As CDO.Message 
		Dim Fields ' As ADODB.Fields 

		' Get a handle on the config object and it's fields 
		Const cdoSendUsingPort = 1
		set iMsg = CreateObject("CDO.Message")
		set iConf = CreateObject("CDO.Configuration")
		Set Flds = iConf.Fields
		Flds.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
		Flds.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
		Flds.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost" 
		Flds.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "C:\Inetpub\mailroot\Pickup"
		Flds.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10 
		Flds.Update

'  Set iMsg.Configuration = iConf

	'	Set objMessage = Server.CreateObject("CDO.Message") 

		Set iMsg.Configuration = iConf  
		mail_content = str 
		With iMsg 
		.To = to_Email 
		.From = write_Name & " <"&from_Email&">" 
		.Subject = mailTitle
		.HTMLBody = mail_content
		.Send 
		End With 
		 

		Set Fields = Nothing 
		Set iMsg = Nothing 
		Set iConf = Nothing 

	End Sub 

	Function IIf(i,j,k)
		If i Then IIf = j Else IIf = k
	End Function

	Function Text2Html(str)
		Dim Html
		Html = Replace(str,"&lt;","<")
		Html = Replace(Html,"&gt;",">")
		Html = Replace(Html,"&amp;","&")
		Text2Html = Html
	End Function
	 

	Function Html2Text(str)
		Dim Text
		Text = Replace(str,"&","&amp;")
		Text = Replace(Text,"<","&lt;")
		Text = Replace(Text,">","&gt;")
		Text = Replace(Text,chr(13)&chr(10),"<br>")	
		Text = Replace(Text,chr(32),"&nbsp;")
		Html2Text = Text
	End Function

	Function CON_UTF8(str)
		response.charset="utf-8" 
		Session.codepage="65001"
		Response.codepage="65001"
		CON_UTF8 = str
	End Function
	Function paging(btn_prev02,btn_prev,btn_next,btn_next02,Filename)
		Dim blockpage
		blockpage = Int((page-1)/10) * 10 + 1 
	
		response.write "<table border='0' cellspacing='0' cellpadding='0'>"
		response.write "  <tr>"
		response.write		"<td width='17' class='community_bar_unlink_text'>"

		if totalPage > 0 then
			If blockpage = 1 Then 
				Response.Write btn_prev02
			Else 
				Response.Write "<a href=" &Filename& "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& blockpage-10 &">"&btn_prev02&"</a>" 
			End If 
		response.write		"</td>"
		response.write		"<td width='42' class='community_bar_unlink_text'>"	
			If page <> 1 Then 
				Response.Write "<a href="& Filename & "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& page-1 &">"&btn_prev&"</a>" 
			Else
				Response.Write btn_prev
			End If
		response.write		"</td>"			
		response.write		"<td>&nbsp;"
			Dim i
			i = 1 
			Do Until i > 10 Or blockpage > totalPage 
				If blockpage = int(page) Then 
					response.write "<font color=#000000> <b>"& blockpage &"</b> </font>"
				Else
					Response.Write " <a href="& Filename & "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& blockpage &" ><font color=#000000>"& blockpage &"</font></a> "
				End If  
				blockpage = blockpage + 1 
				i = i + 1 
			Loop 
		response.write		"&nbsp</td>"
		response.write		"<td width='42' align=right class='community_bar_unlink_text'>"	
			If Cint(page) <> Cint(totalPage) Then
					Response.Write "<a href="& Filename & "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& page+1 &">"&btn_next&"</a>" 
			Else
				Response.Write btn_next
			End If
		response.write		"</td>"
		response.write		"<td width='17' align=right class='community_bar_unlink_text'>"	
			If blockpage > totalPage Then 
				Response.Write btn_next02
			Else 
					Response.Write "</a></font><a href="& Filename & "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& blockpage &">"&btn_next02&"</a>" 
			End If
		end if	
		response.write		"</td>"
		response.write	"</tr>"
		response.write	"</table>"

	End Function

 
	Function paging02(btn_prev02,btn_prev,btn_next,btn_next02,Filename)
		Dim blockpage
		blockpage = Int((page-1)/10) * 10 + 1 
	
		response.write "<table border='0' cellspacing='0' cellpadding='0'>"
		response.write "  <tr>"
		response.write		"<td width='27' height='12' class='community_bar_unlink_text' style='border:none;'>"

		if totalPage > 0 then
			If blockpage = 1 Then 
				Response.Write btn_prev02
			Else 
				Response.Write "<a href=" &Filename& "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& blockpage-10 &"  class='main_text_url_s'>"&btn_prev02&"</a>" 
			End If 
		response.write		"</td>"
		response.write		"<td width='27' class='community_bar_unlink_text' style='border:none;'>"	
			If page <> 1 Then 
				Response.Write "<a href="& Filename & "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& page-1 &"  class='main_text_url_s'>"&btn_prev&"</a>" 
			Else
				Response.Write btn_prev
			End If
		response.write		"</td>"			
		response.write		"<td class='community_bar_unlink_text' style='border:none;'>"
			Dim i
			i = 1 
			Do Until i > 10 Or blockpage > totalPage 
				if i > 1 then response.write " | "
				If blockpage = int(page) Then 
					response.write "<a href='#' class='main_text_url_s'><b>"& blockpage &"</b></a>"
				Else
					Response.Write " <a href="& Filename & "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& blockpage &" class='main_text_url_s'>"& blockpage &"</a> "
				End If  
				blockpage = blockpage + 1 
				i = i + 1 
			Loop 
		response.write		"</td>"
		response.write		"<td  width='27' align='right' class='community_bar_unlink_text' style='border:none;'>"	
			If Cint(page) <> Cint(totalPage) Then
					Response.Write "<a href="& Filename & "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& page+1 &"  class='main_text_url_s'>"& btn_next &"</a>" 
			Else
				Response.Write btn_next
			End If
		response.write		"</td>"
		response.write		"<td width='27' align='right' class='community_bar_unlink_text' style='border:none;'>"	
			If blockpage > totalPage Then 
				Response.Write btn_next02
			Else 
					Response.Write "</a></font><a href="& Filename & "searchField=" &searchField& "&searchValue=" &searchValue& "&page="& blockpage &"  class='main_text_url_s'>"&trim(btn_next02)&"</a>" 
			End If
		end if	
		response.write		"</td>"
		response.write	"</tr>"
		response.write	"</table>"

	End Function
	

	Function StringCheck(str)
		StringCheck = str
		StringCheck = replace(StringCheck,"'","&#39")
		StringCheck = replace(StringCheck,"""","&#34")
		StringCheck = Replace(StringCheck, "&", "&amp;")
		StringCheck = Replace(StringCheck, "<", "&lt;")
		StringCheck = Replace(StringCheck, ">", "&gt;")
		'StringCheck = Replace(StringCheck, "'", "''")
		StringCheck = Replace(StringCheck, "|", "&#124;")
	End Function


	Function Special_Filter(str)
		Special_Filter = trim(str)		
		Special_Filter = replace(str,"'","''") 
	End Function



	Function eregi_replace(text, findchr, replace) 
	 
		on error resume next 
		Dim eregObj: 
		Set eregObj = New RegExp: 
		eregObj.Pattern = findchr: '//패턴 설정 
		eregObj.IgnoreCase = True: '//대소문자 구분 여부 
		eregObj.Global = True: '//전체 문서에서 검색 
		eregi_replace = eregObj.Replace(text, replace): 
		'//Replace String 
		if err then 
		'Response.Write err.Description 
		end if 
		On Error goto 0
	End Function '

'//IS NULL? Yes: Return true No: return false
'----------------------------------------------------------------
	Function isNull2(str)
		str = trim(str)
		if(len(str)<=0 or isNull(str) or str=null or str=NULL) then
			isNull2 = true
		else
			isNull2 = false
		end if
	End Function

'// Debugging 용
'----------------------------------------------------------------
	function pr(str)
		response.write str & "<br>"
	end function

'// Alert띄우고 페이지 이동 
'----------------------------------------------------------------
	sub alertGo(myStr,url)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	alert("""&myStr&""");"&vbCr)
		Response.Write("	document.location.href = '" & url &"'" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'// Alert띄우고 Back
'----------------------------------------------------------------
	sub alertBack(myStr)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	alert("""&myStr&""");"&vbCr)
		Response.Write("	history.back();" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'//Alert 없이 단순 페이지 이동
'//---------------------------------------------------------------
	sub justGo(url)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	document.location.href = '" & url &"'" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'// Alert띄우고 Opener를 reload하고 페이지 이동
'----------------------------------------------------------------
	sub alertReloadGo(myStr, url)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	alert("""&myStr&""");"&vbCr)
		Response.Write("	opener.location.reload();"&vbCr)
		Response.Write("	document.location.href = '" & url &"'" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub
	
'// Alert띄우고 Opener를 reload하고 Close
'----------------------------------------------------------------
	sub alertReloadClose(myStr)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	alert("""&myStr&""");"&vbCr)
		Response.Write("	opener.location.reload();"&vbCr)
		Response.Write("	window.close();" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'// Alert없이 Opener를 reload하고 Close
'----------------------------------------------------------------
	sub openerReloadClose()
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	opener.location.reload();"&vbCr)
		Response.Write("	window.close();" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'// Alert과 함께 Opener를 이동 하고 Close
'----------------------------------------------------------------
	sub alertCloseOpenerGo(myStr,url)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	alert("""&myStr&""");"&vbCr)
		Response.Write("	opener.location.href=""" & url &""";"&vbCr)
		Response.Write("	window.close();" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'// Alert없이 Opener를 이동 하고 Close
'----------------------------------------------------------------
	sub closeOpenerGo(url)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	opener.location.href=""" & url &""";"&vbCr)
		Response.Write("	window.close();" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'// Alert띄운다
'----------------------------------------------------------------
	sub alert(myStr)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	alert("""&myStr&""");"&vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'// Alert띄우고 Close
'----------------------------------------------------------------
	sub alertClose(myStr)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	alert("""&myStr&""");"&vbCr)
		Response.Write("	window.close();" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end
	end sub

'// 종합옵션
'-------------------------------------------------------
	sub getLocationHerf(glocation,alert,ghistory)
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		if alert <> "" then Response.Write("	alert("""&alert&""");"&vbCr)
		if glocation <> "" then Response.Write("	location.href="""&glocation&""";" &vbCr)
		if ghistory <> "" then Response.Write("	history.go("&ghistory&");" &vbCr)
		Response.Write("</script>"&vbCr)
		response.end 
	end sub


	function alertHistoryGo(msg) 
		Response.Write(vbCr&"<script language=javascript>"&vbCr)
		Response.Write("	alert("""&msg&""");"&vbCr)
		Response.Write("	history.go(-1);" &vbCr)			 
		Response.Write("</script>"&vbCr) 
		Response.end
	end function

 

'// 한글을 포함 str의 byte 수 계산 (return str's byte value)
'----------------------------------------------------------------
	Function nLeft(str, strcut)
		Dim bytesize, nLeft_count
		bytesize = 0
		For nLeft_count = 1 to len(str)
			if asc(mid(str, nLeft_count, 1)) > 0 then
				bytesize = bytesize + 1
			Else
				bytesize = bytesize + 2
			End if
			if strcut >= bytesize then nLeft = nLeft & mid(str,nLeft_count, 1)    
		Next
		if len(str) > len(nLeft) then nLeft = left(nLeft, len(nLeft)-2) &".."
	End Function
 
'// 두 문자를 비교해 같으면 "selected"를 리턴하는 함수  (콤보박스나 라디오버튼의 선택시 사용)
'// isNull2(str2) 부분 추가
'----------------------------------------------------------------
	Function selected(str1, str2)
		str1 = trim(str1)
		if isNull2(str1) then
			selected=""
		elseIf isNull2(str2) then
			selected=""
		elseIf cstr(str1) = cstr(str2) Then
			selected = "selected"
		Else
			selected = ""
		End If
	End Function


'// 두 문자를 비교해 같으면 "checked"를 리턴하는 함수 (콤보박스나 라디오버튼의 선택시 사용)
'// isNull2(str2) 부분 추가
'----------------------------------------------------------------
	Function checked(str1, str2)
		str1 = trim(str1)
		if isNull2(str1) then
			checked=""
		elseIf isNull2(str2) then
			checked=""
		elseIf cstr(str1) = cstr(str2) Then
			checked = "checked"
		Else
			checked = ""
		End If
	End Function

'// 두 문자를 비교해 같으면 ""를 리턴하는 함수 (스타일 사용시 디스플레이 안할 때 사용)
'----------------------------------------------------------------
	Function none(str1, str2)
		str1 = trim(str1)
		if isNull2(str1) then
			none="none"
		elseIf isNull2(str2) then
			none="none"
		elseIf cstr(str1) = cstr(str2) Then
			none = ""
		Else
			none = "none"
		End If
	End Function
 
 
'// 숫자 n을 입력받아 앞에 0을 채워 x글자로 만들어 리턴함
'-----------------------------------------------------------------
	Function int2StrFixed(n, x)
			Dim i, Str 
			Str = n
			for i=1 to x-len(n)
				Str = "0" & Str
			next

			'For i=1 to x-2
			'	Str = str& "0"
			'Next
			'If n<10 Then
			'	Str = Str & "0" & CStr(n)
			'Else
			'	Str = Str & CStr(n)
			'End If
			int2StrFixed = Str
	End Function
 
	
	Function limited(sString,limit_byte)

		Dim i, iLen, sCh, iRet', limit_byte
		'limit_byte = 90 '제한 바이트 수
		iRet = 0
		limited = ""
		iLen = Len(sString)

		For i = 1 to iLen
			sCh = Mid(sString, i, 1)    
			iRet = iRet + 1
			' maybe unicode(two byte)
			If (Asc(sCh) > 0) and (Asc(sCh) < 127) Then 
				iRet = iRet + 1
			Else
				iRet = iRet + 2
			End If
			
			If iRet > limit_byte then
				limited = limited + " .."
				Exit For
			else		
				limited = limited + sCh
			end if
		Next 
	End Function

	Function nlen(sString,limit_len)
   
		if len(sString) > limit_len then
			nlen = left(sString,limit_len) & ".."
		else
			nlen = sString
		end if
 
	End Function

	Function limitedByte(sString)

		Dim i, iLen, sCh, iRet', limit_byte
		'limit_byte = 90 '제한 바이트 수
		iRet = 0 
		iLen = Len(sString)

		For i = 1 to iLen
			sCh = Mid(sString, i, 1)    
			iRet = iRet + 1
			' maybe unicode(two byte)
			If (Asc(sCh) > 0) and (Asc(sCh) < 127) Then 
				iRet = iRet + 1
			Else
				iRet = iRet + 2
			End If 
		Next 
		limitedByte = iRet
	End Function
 

	Function Get_ArrayValue(arrayName ,vkey)  
		dim key
		if(isnull(vkey)) then vkey = ""  
		for each key in arrayName 
			if vkey = key(0) then 
				Get_ArrayValue = key(1) 
			end if 
		next  
	End Function

	Function Get_ArrayKey(arrayName,vValue)  
		dim key
		if(isnull(vValue)) then vValue = "" 
		for each key in arrayName 
			if vValue = key(1) then 
				Get_ArrayKey = key(0) 
			end if 
		next  
	End Function
	
	'이름,아이디 등을 자리수 만큼 감춘다
	function FillStringRight( cString, iLength, cFillString )
		  If iLength >= Len(cString) then
			 cutstr=right(cString,iLength)
			 
			 FillStringRight=Replace(cString,cutstr,cFillString)
			 'FillStringRight=cutstr
		 End If
	end Function


	Function ArraySelectDisplay(arrayName,objname,objvalue,init_txt) 
		dim tdisplay		
		tdisplay = "<select name='" & objname & "' class='form_exchange02'>"&chr(13)
		if init_txt<> "" then tdisplay = tdisplay & "<option value=''>" & init_txt &"</option>"&chr(13)
		for each key in arrayName 
			tdisplay = tdisplay & "	<option value='" & key(0) & "' " & selected(key(0),objvalue) & ">" & key(1) & "</option>"&chr(13)
		next  
		tdisplay = tdisplay & "</select>"&chr(13)
		ArraySelectDisplay = tdisplay
	End Function

	Function RandomName() 
       Randomize
       code =  Int(rnd() * 100000000)      
	   RandomName = code	
	End Function
  

	Function URLDecode(Expression)
	Dim strSource, strTemp, strResult, strchr       
	Dim lngPos, AddNum, IFKor       
	strSource = Replace(Expression, "+", " ")       
		For lngPos = 1 To Len(strSource)
			AddNum = 2           
			strTemp = Mid(strSource, lngPos, 1)           
			If strTemp = "%" Then                
				If lngPos + AddNum < Len(strSource) + 1 Then                   
					strchr = CInt("&H" & Mid(strSource, lngPos + 1, AddNum))                  
					If strchr > 130 Then                        
						AddNum = 5                      
						IFKor = Mid(strSource, lngPos + 1, AddNum)                      
						IFKor = Replace(IFKor, "%", "")                      
						strchr = CInt("&H" & IFKor )                  
					End If
					strResult = strResult & Chr(strchr)                  
					lngPos = lngPos + AddNum               
				End If           
			Else
				strResult = strResult & strTemp           
			End If       
		Next
	URLDecode = strResult   
	End Function    


function fntEncodingUrl ( str )    
	Dim i    
	Dim m    
	Dim code    
	code = ""    
	for i=1 to len(str)    
		m = mid(str,i,1)    
		code = code & hex(asc(m))   
	next    
	fntEncodingUrl = code    
end function 


	SUB Sub_Display_Error(strMessage)
%>
	<br><br><br><br>
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<table align="center" cellspacing="0" border="0" width="500">
	<tr>
		<th  width="500" height="40" valign="middle">
		 이전 화면으로 되돌아 가십시요. 
		</th>
	</tr>
	<tr>
		<td  width="500" height="20" valign="middle" align="center">
			 <br><%= strMessage%> 
			<br>&nbsp;
		</td> 
	</tr>
	<tr>
		<td align="center" width="500" height="60" valign="bottom">
			<form name="huga_back">
				<a href="javascript:history.back()"> 이전화면 </a>
			</form>
		</td>
	</tr>
	</table>
<%
	Response.End
	End Sub
%>
