<!--#include file ="../lib/db.asp"-->
<!--#include file ="../lib/util.asp"-->
<%	 
	idx				= request("idx")
	searchField		= request("searchField")
	searchValue		= request("searchValue")
	page			= request("page")
	code			= request("code")
	qna_chk			= request("qna_chk") 
	if DBopen() = false then
		Call Sub_Display_Error("Please contact your administrator.")
	end if

	SQLST = " UPDATE board SET read_num=read_num + 1 WHERE idx="&idx
	Conn.Execute(SQLST)

	Set rs = Server.createObject("ADODB.RecordSet")
	sql = "select * from board where idx = "&idx
	rs.Open sql, Conn, 1	
 
	write_id	=	rs("write_id") 
	write_name	=	rs("write_name") 
	subject		=	rs("subject") 
	content		=	replace(rs("content"),chr(13)&chr(10),"<br>")
	read_num	=	rs("read_num")  
	filename	=	rs("filename")  
	step_id		=	rs("step")  
	reg_date	=	rs("reg_date")  
	secret_flag	=	rs("secret_flag")  
	question_idx=	rs("question_idx")  
	category	=	rs("category") 	  '공지사항체크
	rs.close 

	sql = "select * from board where idx = '"&question_idx&"'"
	rs.Open sql, Conn, 1
	if not rs.eof then
		question_write_id	=	rs("write_id")   
	end if
	rs.close 
 
	if secret_flag = "1" and write_id <> session("userid") and question_write_id <> session("userid") And session("userid") <> "DAONOL" then 
		if instr(Request.ServerVariables("HTTP_REFERER"),"login.asp") > 0 then
			call alertGo("You do not have read permissions.","qna.asp")
		else
			call alertBack("You do not have read permissions.")
		end if
	end if
 
%>
<script>
function bd_del(form){
	if(confirm("Would you like to delete?")){
        form.submit();
	} 
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
	<td height="32" align="center"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr > 
		  <td height="26" background="images/table_th_bg.gif" class="community_bar_text"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<th width="63" align="center" class="community_bar_text">Subject</th>
				<th width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></th>
				<th width="674" class="community_bar_text" align="left">&nbsp;<%=subject%></th>
			  </tr>
			</table></td>
		</tr>
		<tr> 
		  <td height="32"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<td width="65" align="center" class="community_bar_unlink_text" >Name</td>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td width="418" class="community_bar_unlink_text" align="left">&nbsp;<%=write_name%> ( <%=write_id%> )</td>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td width="54" align="center" class="community_bar_unlink_text">date</td>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td width="80" align="center" class="community_bar_unlink_text" align="left" >&nbsp;<%=left(reg_date,10)%></td>
				<!--
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td width="53" align="center" class="community_bar_unlink_text">Hits</td>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td width="65" align="center" class="community_bar_unlink_text" align="left" >&nbsp;<%=read_num%></td>
				-->
			  </tr>
			</table></td>
		</tr>
		<tr> 
		  <td height="1"  bgcolor="EBEBEB"></td>
		</tr>
		<tr> 
		  <td height="32"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<td width="65" align="center" class="community_bar_unlink_text">Attachments</td>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td width="418" class="community_list_text02" align="left"><a href="./customer/down.asp?filename=<%=Server.UrlEncode(filename)%>&fpath=<%=Server.UrlEncode(board_full_path)%>" class="community_bar_unlink_text">&nbsp;<%=filename%></a></td>
				<td width="1" align="center"></td>
				<td width="54" align="center" class="community_bar_unlink_text"></td>
				<td width="1" align="center"></td>
				<td width="80" align="center" class="community_bar_unlink_text"></td>
				<td width="1" align="center"></td>
				<td width="53" align="center" class="community_bar_unlink_text"></td>
				<td width="1" align="center"></td>
				<td width="65" align="center" class="community_bar_unlink_text"></td>
			  </tr>
			</table></td>
		</tr>
		<tr> 
		  <td height="1"  bgcolor="EBEBEB"></td>
		</tr>
		<tr> 
		  <td> <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<td height="10" colspan="3"></td>
			  </tr>
			  <tr> 
				<td width="10"></td>
				<td width="100%" class="community_bar_unlink_text" style="float:left;" align="left"><%=content%></td>
				<td width="10"></td>
			  </tr>
			  <tr> 
				<td height="10" colspan="3"></td>
			  </tr>
			</table></td>
		</tr>
		<tr> 
		  <td height="2"  bgcolor="CCCCCC"></td>
		</tr>
	  </table></td>
  </tr>
  <tr> 
	<td height="40" align="center"><div align="center"><table width="50%" border="0" cellspacing="0" cellpadding="0" class="btn_center">
		<tr><td height="20">&nbsp;</td></tr>
		<tr> 
		<%if (UCase(write_id) = UCase(session("userid")) Or UCase(session("userid")) = "DAONOL") then %>	
		  <td><div align="center"><a href="qna.asp?code=<%=code%>&mode=write&idx=<%=idx%>&page=<%=page%>&searchField=<%=searchField%>&searchValue=<%=searchValue%>&qna_chk=<%=qna_chk%>"  onfocus="this.blur()" class="btn_style02"><span>Modify</span></a></div></td>
		  <td>		
			<form name="form" method="post" action="./customer/board_save.asp"  enctype="multipart/form-data">
			<input type="hidden" name="xxxx" value="aaa">
			<input type="hidden" name="idx" value="<%=idx%>">
			<input type="hidden" name="flag" value="delete"> 
			<input type="hidden" name="searchField" value="<%=searchField%>">
			<input type="hidden" name="searchValue" value="<%=searchValue%>">  
			<input type="hidden" name="page" value="<%=page%>">  
			<input type="hidden" name="code" value="<%=code%>">  
			<input type="hidden" name="qna_chk" value="<%=qna_chk%>">  
			</form>	
		 <div align="center"> <a href="javascript:bd_del(form);"  onfocus="this.blur()" class="btn_style02"><span>Delete</span></div></a>
		  </td>
		 <%end if%>
		<% If trim(category) = "y" Then %>
		<% Else %>
		   <td align="right">
		   <div align="center"><a href="qna.asp?code=<%=code%>&mode=write&flag=answer&idx=<%=idx%>&page=<%=page%>&searchField=<%=searchField%>&searchValue=<%=searchValue%>&qna_chk=<%=qna_chk%>"  onfocus="this.blur()" class="btn_style02"><span>Answer</span></div></a>
		<% End If %>
		  <td align="center">
		  <div align="center"><a href="qna.asp?code=<%=code%>&mode=list&page=<%=page%>&searchField=<%=searchField%>&searchValue=<%=searchValue%>&qna_chk=<%=qna_chk%>"  onfocus="this.blur()" class="btn_style01"><span>List</span></a></div> </td>
		</tr>
	  </table></div></td>
  </tr>
 
  <tr> 
	<td height="40" align="right"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr> 
		  <td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr> 
		  <td width="85" height="37">▲ Next</td>
		<%
		sqlWhere = " and code = '" & code & "'"
		if searchValue <> "" then  
			sqlWhere	= sqlWhere & " and "&searchField&" like '%"&searchValue&"%' "
		end if
 
		sql = "select top 1 idx,subject,reg_date from board where step > "&step_id&" "& sqlWhere
		sql = sql & " order by step "
			
		rs.Open sql, Conn, 1
		if Not rs.Eof then 
		%>
		 <td width="503" class="community_bar_unlink_text">
		  <a href="<%=Request.ServerVariables("PATH_INFO")%>?code=<%=code%>&mode=view&idx=<%=rs("idx")%>&page=<%=page%>&searchField=<%=searchField%>&searchValue=<%=searchValue%>&qna_chk=<%=qna_chk%>" class="community_list_text"><%=rs("subject")%></a>  
		 </td>
		 <td width="150" align="center" class="community_bar_unlink_text"><%=left(rs("reg_date"),10)%></td>
		<%
		else 
			response.write "<td colspan='2' width=633 class='community_bar_unlink_text'>No Next data.</td>"
		end if
		rs.close 
		%>  
		</tr>
		<tr> 
		  <td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr> 
		  <td height="37">▼ Previous</td>		   
		<%
		sql = "select top 1 idx,subject,reg_date from board where step < "&step_id&" "& sqlWhere
		sql = sql & " order by step desc"
		rs.Open sql, Conn, 1
		if Not rs.Eof then 
		%>
	  	  <td width="503" class="community_bar_unlink_text">
		  <a href="<%=Request.ServerVariables("PATH_INFO")%>?code=<%=code%>&mode=view&idx=<%=rs("idx")%>&page=<%=page%>&searchField=<%=searchField%>&searchValue=<%=searchValue%>&qna_chk=<%=qna_chk%>" class="community_list_text">
		  <%=rs("subject")%>
		  </a>  
		  </td>
		  <td width="150" align="center" class="community_bar_unlink_text"><%=left(rs("reg_date"),10)%></td>
		<%
		else
			response.write "<td colspan='2' width=633 class='community_bar_unlink_text'>No previous data.</td>"
		end if
		rs.close
		DbClose()
		%>   
		<tr> 
		  <td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
	  </table></td>
  </tr>
</table>