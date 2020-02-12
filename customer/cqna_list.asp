<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/util.asp" -->
<%
	if DBopen() = false then
		Call Sub_Display_Error("Please contact your database connection error manager.")
	end if

	code	= request("code")

	if isNull2(code) then code = "qna"

	searchField = request("searchField")
	searchValue = request("searchValue") 
  
	Set rs1 = Server.CreateObject("ADODB.RecordSet")

	sqlOrderby	= " order by idx desc"
	
	If session("member") = "0000000000" Then 
		sqlWhere	= " WHERE code = '" & code & "'"
	Else 
		sqlWhere	= " WHERE code = '" & code & "' and write_id = '" & session("member") & "'"
	End If 
'	sqlWhere	= " WHERE code = '" & code & "'"

	if searchValue <> "" then 	 
		sqlWhere	= sqlWhere&  " and "&searchField&" like N'%"&searchValue&"%' "  
	end if
  

	const PAGE_SIZE  = 15				'//page size					  
	page = request("page")

	if isNull2(page) Then
		page = 1
	End if

	sqlst = " SELECT COUNT(*) FROM boardq " & sqlWhere
	 
	Rs1.Open sqlst,Conn,3
	
	'// totalRecord : 전체 레코드카운트, totalPage : 전체 페이지 카운트
	totalRecord = Rs1(0) 
	totalPage = int((totalRecord - 1) / PAGE_SIZE) + 1
	Rs1.Close
	
	 
	start_rownum = ((page-1) * PAGE_SIZE) + 1   '처음 비교할 번호 
	end_rownum = start_rownum + (PAGE_SIZE-1)    


	sqlst = " SELECT TOP " & end_rownum &" * FROM boardq  " & sqlWhere & sqlOrderby 
	Rs1.Open sqlst,Conn,3
	'response.write SQLST

	if not Rs1 is nothing then
		Rs1.PageSize=PAGE_SIZE
		if totalPage > 0 then Rs1.Absolutepage = page
	end If 
%>

<div class="col-12">
    	<!-- Search Widget -->
        <div class="card mb-2">
          <div class="card-body">
            <div class="input-group">
 <form name="frmMain" method="post" class="form-group input-group" action="<%=Request.ServerVariables("PATH_INFO")%>">
				<input type="hidden" name="code" value="<%=code%>">				
              <div class="col-4 pl-0">
              <select name="searchField" class="custom-select">
					<option value="subject" <%=selected("subject",searchField)%>>subject</option>
				  <option value="content" <%=selected("content",searchField)%>>Contents</option>
              </select>
              </div>
              <input type="text" class="form-control" name="searchValue" value="<%=searchValue%>" >
              <span class="input-group-btn">
                <button class="btn btn-secondary" onclick="document.frmMain.submit();" type="button">Go!</button>
              </span>
              </form>
            </div>
          </div>
        </div>
    </div>
  	<div class="col-12 overflow-auto">
    <table class="table table-bordered table-hover badge-light text-center">
      <thead>
        <tr>
          <th>No</th>
          <th>Subject</th>
          <th>Name</th>
          <th>Date</th>
        </tr>
      </thead>
      <tbody>
<% 	
		
	If not Rs1.Eof Then 					
		num = totalRecord - Cint((page-1) * PAGE_SIZE)
		Do While Not Rs1.Eof
			view_page = Get_viewPage(Conn,Rs1("write_id"),Rs1("secret_flag"),Rs1("idx"),Rs1("question_idx"))   
%>	  
		
            <tr>
              <td><%=num%></td>
              <td><%If Rs1("question_idx") <> 0 Then%> <%For j=1 To Rs1("depth") Step 1%> &nbsp;&nbsp; <%next%> <img src="./images/board/customer_re_icon.gif" alt="reply" width="34" height="21" border="0" align="absmiddle"> 
                  <%end if%> <a href="<%=view_page%>" class="community_list_text" onFocus="this.blur();"><%=Rs1("subject")%></a></td>
              <td><%=Rs1("write_name")%></td>
			  <td><%=left(Rs1("reg_date"),10)%></td>  
              </tr>
<%	Rs1.MoveNext 
			num = num - 1
			Loop 
			 
		else 
			  response.write "<tr>"
			  response.write "	<td height=100 align=center colspan='4'>"
			  response.write "	<div align='center'> No registered content.</div>"
			  response.write "	</td>"
			  response.write "</tr>"
		End If    %>
		  <tr> 
			<td height="40" colspan='4'><div align="center"><a href="support.asp?mode=write&code=<%=code%>"  onfocus="this.blur()" class="btn_style02" ><span>Writing</span></a></div>
			  <!--img src="images/board/btn_writer.gif" alt="글쓰기" width="76" height="31" border="0"></a-->
			</td>
		  </tr>
      </tbody>
    </table>
    </div>
    <!-- Pagination -->
    <!-- #Include virtual = "/myoffice/common/paging.asp" -->

<%
Function Get_viewPage(byRef conn,write_id,secret_flag,idx,question_idx)   

	if session("userid") <> "" then
		sql = "select * from boardq where code = '"&code&"' and idx = '"&question_idx&"'"
		'Response.write sql
		Set nRs = conn.Execute(sql)
		if not nRs.Eof Then  
			question_write_id	=	nRs("write_id")   	 
		end if			 	 
		Set nRs = nothing 

		if (secret_flag = "1" and write_id <> session("member") and question_write_id <> session("member") And session("member") <> "0000000000") then 
			Get_viewPage = "javascript:alert('You do not have read permissions.');"
		else
			Get_viewPage = "support.asp?idx=" & idx & "&code="&code&"&mode=view&page=" & page & "&searchField=" & searchField & "&searchValue=" & searchValue
		end if	
	else
		Get_viewPage = "javascript:alert('Please login.');location.href='../login.asp';"
	end if

End Function   

DBclose()
%>