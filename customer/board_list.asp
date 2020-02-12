<!-- #Include virtual = "/lib/db.asp" -->
<!-- #Include virtual = "/lib/function.asp" -->
<!-- #Include virtual = "/header.asp" -->
<script type="text/javascript" src="/lib/httpRequest.js"></script>
<script type='text/javascript' src='/lib/jslib.js'></script>

<script type="text/javascript" src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript" src="/lib/jquery.ui.datepicker-ko.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
<script language="JavaScript" type="text/JavaScript">
        $(document).ready(function(){

            $("#i_sdate").datepicker({
                showOn: "button", //이미지로 사용 , both : 엘리먼트와 이미지 동시사용
                buttonImage: "assets/img/date-img.png", //버튼으로 사용할 이미지 경로
                buttonImageOnly: true //이미지만 보이기
            });

            $("#i_edate").datepicker({
                showOn: "button", //이미지로 사용 , both : 엘리먼트와 이미지 동시사용
                buttonImage: "assets/img/date-img.png", //버튼으로 사용할 이미지 경로
                buttonImageOnly: true //이미지만 보이기
            });

        });
		function gopopal(p_date, su_gubun){
		 var popUrl = "popallowance.asp?p_date="+p_date+"&su_gubun="+su_gubun;	//팝업창에 출력될 페이지 URL
			var popOption = "width=985px, height=780px, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
//			window.open(popUrl,"",popOption);
		}
</script>

<%
	if DBopen() = false then
		Call Sub_Display_Error("Please contact your database connection error manager.")
	end if

	code	= request("code")

	if isNull2(code) then code = "qna"

	searchField = request("searchField")
	searchValue = request("searchValue") 
	qna_chk = request("qna_chk") 

	Set Rs1 = Server.CreateObject("ADODB.RecordSet")

	sqlOrderby	= " order by category desc, step desc"

	sqlWhere	= " WHERE code = '" & code & "'   "
	
	If UCase(session("userid")) <> "admin" Then
		sqlWhere	= sqlWhere&   " and ((write_id='"&session("userid")&"' or owner_name='"&session("userid")&"') or (code = '" & code & "' and category='y')) "
	Else
		If qna_chk = "Y" Then	 
			sqlWhere	= sqlWhere& " and ( idx in (SELECT question_idx FROM board WHERE code = '"&code&"' and  depth='1') or depth= '1') "
		ElseIf  qna_chk = "N" Then	 
			sqlWhere	= sqlWhere& " and category is null and idx  not in (SELECT question_idx FROM board WHERE code = '"&code&"' AND depth='1') and depth='0' "
		Else
			sqlWhere	= sqlWhere& ""
		End If
	End If
	
	if searchValue <> "" then 	 
		sqlWhere	= sqlWhere&  " and "&searchField&" like '%"&searchValue&"%' "  
	end if
  

	const PAGE_SIZE  = 15				'//page size					  
	page = request("page")

	if isNull2(page) Then
		page = 1
	End if

	sqlst = " SELECT COUNT(*) FROM board " & sqlWhere
	Rs1.Open sqlst,Conn,3
	
	'// totalRecord : 전체 레코드카운트, totalPage : 전체 페이지 카운트
	totalRecord = Rs1(0) 
	totalPage = int((totalRecord - 1) / PAGE_SIZE) + 1
	Rs1.Close
	
	 
	start_rownum = ((page-1) * PAGE_SIZE) + 1   '처음 비교할 번호 
	end_rownum = start_rownum + (PAGE_SIZE-1)    


	sqlst = " SELECT TOP " & end_rownum &" * FROM board  " & sqlWhere & sqlOrderby 
	Rs1.Open sqlst,Conn,3
	'response.write SQLST

	if not Rs1 is nothing then
		Rs1.PageSize=PAGE_SIZE
		if totalPage > 0 then Rs1.Absolutepage = page
	end If 
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  
  <form name="form" method="post" action="<%=Request.ServerVariables("PATH_INFO")%>">
    <input type="hidden" name="code" value="<%=code%>">
    <tr> 
      <td> 
        <!--검색 시작 -->
        <table width="100%" border="0" cellspacing="0" cellpadding="0" valign="center" >
          <tr> 
            <td width="131"><img src="images/board/community_b_left.gif" alt="notice" width="131" height="77"></td>
            <td valign="top" background="images/board/community_b_middle.gif"  style="padding:20 0 0 0"> 
              <!--검색폼 시작 -->
              <table width="100%" border="0" cellspacing="0" cellpadding="0" valign="center">
                <tr valign="center"> 
                  <td width="55"> <select name="searchField" class="select3" style='height:25px;' >
                      <option value="subject" <%=selected("subject",searchField)%>>subject</option>
                      <option value="content" <%=selected("content",searchField)%>>Contents</option>
					  <option value="write_name" <%=selected("write_name",searchField)%>>Name</option>
					  <option value="write_id" <%=selected("write_id",searchField)%>>WebID</option>
                    </select> </td>
                  <td align="center"><input  name="searchValue" type="text"   style='height:25px;' value="<%=searchValue%>" size="70"> 
                  </td>
                  <td width="200" align="center"><!--<input type="image" src="images/board/community_search_btn.gif" alt="검색" width="51" height="22" border="0" align="absmiddle">-->
				  	<a href="javascript:document.form.submit();" class="btn_style03"><span>Find</span></a>

				  </td>
				  <% If UCase(session("userid")) = "admin" Then %>
				  <td align="right">
					<select name="qna_chk" class="select3" style='height:25px;' Onchange="form.submit();" > 
					 <option value="" <%=selected("",qna_chk)%> >Complete list</option>
 					 <option value="N" <%=selected("N",qna_chk)%> >No answer</option>  
					 <option value="Y" <%=selected("Y",qna_chk)%>  >Complete answers</option>   
					</select>
				 </td>
				 <% End If%>
                </tr>
              </table>
              <!--검색폼 끝 -->
            </td>
            <td width="34"><img src="images/board/community_b_right.gif" width="34" height="77"></td>
          </tr>
          <tr> </tr>
        </table>
        <!--검색 끝 -->
      </td>
    </tr>
  </form>
  <tr> 
    <td height="30" align="center">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr > 
          <td height="30" background="images/table_th_bg.gif" class="community_bar_text"><table width="100%" height="25" border="0" cellspacing="0" cellpadding="0" >
              <tr align="center"> 
                <th width="52" ><div align="left">No</div></td>
                <th width="1"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
                <th width="385" ><div align="center">Subject</div></td>
                <th width="1"><img src="images/board/community_b_line.gif" width="1" height="10"></td
				>
                <th width="150" ><div align="center">Name</div></td>
                <th width="1"><img src="images/board/community_b_line.gif" width="1" height="10"></td
				>
                <th width="110" ><div align="center">Date</div></td>
                <th width="1"><img src="images/board/community_b_line.gif" width="1" height="10"></td
				>
                <!--<th width="69" ><div align="left">Hits</div></td>-->
              </tr>
            </table></td>
        </tr>
        <%
		If not Rs1.Eof Then 					
			num = totalRecord - Cint((page-1) * PAGE_SIZE)
			Do While Not Rs1.Eof
				view_page = Get_viewPage(Conn,Rs1("write_id"),Rs1("secret_flag"),Rs1("idx"),Rs1("question_idx"))   
		%>
         <tr> 
          <td height="35"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr> 
                <td width="53" align="center" class="community_bar_unlink_text"><%=num%></td>
                <td width="315" align="left" class="community_bar_unlink_text">
				    <% if Trim(Rs1("category")) = "y" then %> 
					<b>[Notice]
					<% end if %> 
				  <%If Rs1("question_idx") <> 0 Then%> <%For j=1 To Rs1("depth") Step 1%> &nbsp;&nbsp; <%next%> <img src="images/board/customer_re_icon.gif" alt="reply" width="34" height="21" border="0" align="absmiddle"> 
                  <%end if%> <a href="<%=view_page%>" class="community_list_text" onFocus="this.blur();"><%=Rs1("subject")%></a></b></td>
                <td width="51" align="center"> <% if Rs1("secret_flag") = "1" then %> <img src="images/board/icon_key.gif" alt="key" width="13" height="16" border="0" align="absmiddle"> 
                  <% end if %> </td>
                <td width="150" align="center" class="community_bar_unlink_text"><%=Rs1("write_name")%> <%If Rs1("write_id") <> "admin" Then%> (<%=Rs1("write_id")%>)<% End If%></td>
                <td width="110" align="center" class="community_bar_unlink_text"><%=left(Rs1("reg_date"),10)%></td>
                <!--<td width="69" align="center" class="community_bar_unlink_text"><%'=Rs1("read_num")%></td>-->
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="1"  bgcolor="EBEBEB"></td>
        </tr>
        <%
			Rs1.MoveNext 
			num = num - 1
			Loop 
			 
		else 
			  response.write "<tr>"
			  response.write "	<td height=100 align=center class='community_bar_unlink_text'>"
			  response.write "	<div align='center'> No registered content.</div>"
			  response.write "	</td>"
			  response.write "</tr>"
			  response.write " <tr valign='top' bgcolor='#E1E1E1'>" 
			  response.write "  <td height='1'><img src='images/board/blank.gif' width='1' height='1'></td>"
			  response.write "</tr>"
		End If 
		%>
      </table>
	  
	  </td>
  </tr>
  <tr> 
    <td height="35" class="community_bar_unlink_text"><div align="center"> <%if(totalRecord>0) then%> <%call paging02("<img src='images/board/btn_list_pprev.gif'   border='0' align='absmiddle'>","&nbsp;<img src='images/board/btn_list_prev.gif' border='0' align='absmiddle'>","<img src='images/board/btn_list_next.gif' border='0' align='absmiddle'>&nbsp;","<img src='images/board/btn_list_nnext.gif' border='0' align='absmiddle'>",Request.ServerVariables("PATH_INFO")&"?code="&code&"&qna_chk=" & qna_chk &"&")%> <%end if%> </div></td>
  </tr>
  <% 'If session("userid") = "admin" Then %> 
  <tr> 
    <td height="40"><div align="center"><a href="qna.asp?mode=write&code=<%=code%>"  onfocus="this.blur()" class="btn_style02" ><span>Writing</span></a></div>
      <!--img src="images/board/btn_writer.gif" alt="글쓰기" width="76" height="31" border="0"></a-->
    </td>
  </tr>
  <% 'End If %>
</table>

<%
Function Get_viewPage(byRef conn,write_id,secret_flag,idx,question_idx)   

	if session("userid") <> "" then
		sql = "select * from board where code = '"&code&"' and idx = '"&question_idx&"'"
		'Response.write sql
		Set nRs = conn.Execute(sql)
		if not nRs.Eof Then  
			question_write_id	=	nRs("write_id")   	 
		end if			 	 
		Set nRs = nothing 

		if (secret_flag = "1" and write_id <> session("userid") and question_write_id <> session("userid") And session("userid") <> "admin") then 
			Get_viewPage = "javascript:alert('You do not have read permissions.');"
		else
			Get_viewPage = "qna.asp?idx=" & idx & "&code="&code&"&mode=view&page=" & page & "&searchField=" & searchField & "&searchValue=" & searchValue & "&qna_chk=" & qna_chk 
		end if	
	else
		Get_viewPage = "javascript:alert('Please login.');location.href='../login.asp';"
	end if

End Function   

DBclose()
%>