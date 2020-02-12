<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/util.asp" -->
<%	 
	idx				= request("idx")
	searchField		= request("searchField")
	searchValue		= request("searchValue")
	page			= request("page")
	code			= request("code")
	 
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

	 If IsNull(filename) Then
		filename=""
	 End If
	rs.close 
	
	sql = "select * from board where idx = '"&question_idx&"'"
	rs.Open sql, Conn, 1
	if not rs.eof then
		question_write_id	=	rs("write_id")   
	end if
	rs.close 
 
	if secret_flag = "1" and write_id <> session("userid") and question_write_id <> session("userid") And session("userid") <> "ADMIN" then 
		if instr(Request.ServerVariables("HTTP_REFERER"),"login.asp") > 0 then
			call alertGo("You do not have read permissions.","notice.asp")
		else
			call alertBack("You do not have read permissions.")
		end if
	end if
 
%>
<script language="javascript" src="./customer/js/board.js"></script>
<script>
function bd_del(form){
	if(confirm("Would you like to delete?")){
        form.submit();
	} 
}
</script>

<div class="col-12 overflow-auto Invest">
     <table class="table">
     	<colgroup>
        	<col width="15%">
            <col width="*">
        </colgroup>
          <tbody>
          <tr>
              <th>Subject</th>
              <td style="width:85%;"><p><%=subject%></p></td>
            </tr>
            <tr>
              <th>Name</th>
              <td>
				<%=write_name%>
              </td>
            </tr>
            <tr>
              <th>date</th>
              <td>
              	<%=left(reg_date,10)%>
              </td>
            </tr>
            <tr>
              <th>Attachments</th>
              <td>
				<a href="/_uploadf/<%=filename%>" class="community_bar_unlink_text">&nbsp;<%=filename%></a>&nbsp;
			  </td>
            </tr>
            <tr>
              <td colspan="2">
                   <%=content%>
              </td>
            </tr>
			<tr>
              <td colspan="2">
                   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="btn_center">
					<tr> 
					<%if session("userid") = "ADMIN" then %>	
					  <td><div align="center"><a href="notice.asp?code=<%=code%>&mode=write&idx=<%=idx%>&page=<%=page%>&searchField=<%=searchField%>&searchValue=<%=searchValue%>"  onfocus="this.blur()" class="btn_style02"><span>Modify</span></a></div></td>
					  <td>		
						<form name="form" method="post" action="./customer/notice_save.asp" enctype="multipart/form-data">
						<input type="hidden" name="xxxx" value="aaa">
						<input type="hidden" name="idx" value="<%=idx%>">
						<input type="hidden" name="flag" value="delete"> 
						<input type="hidden" name="searchField" value="<%=searchField%>">
						<input type="hidden" name="searchValue" value="<%=searchValue%>">  
						<input type="hidden" name="page" value="<%=page%>">  
						<input type="hidden" name="code" value="<%=code%>">  
						</form>	
					 <div align="center"> <a href="javascript:bd_del(form);"  onfocus="this.blur()" class="btn_style02"><span>Delete</span></div></a>
					  </td>
					<%end if%>
					  
					  <td align="center">
					  <div align="center"><a href="notice.asp?code=<%=code%>&mode=list&page=<%=page%>&searchField=<%=searchField%>&searchValue=<%=searchValue%>"  onfocus="this.blur()" class="btn_style01"><span>List</span></a></div> </td>
					</tr>
				  </table>
              </td>
            </tr>
          </tbody>
        </table>
    </div>
		
<%  DbClose()	%> 		