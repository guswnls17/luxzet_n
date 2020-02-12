<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/util.asp" -->

<%
	'response.charset = "EUC-KR"
	'session.codepage = 949 

	idx				= request("idx")
	searchField		= request("searchField")
	searchValue		= request("searchValue") 
	page			= request("page") 
	flag			= request("flag")
	code			= request("code")
 


	if idx<>"" and not isnull(idx) Then
		if DBopen() = false then
			Call Sub_Display_Error("Please contact your administrator.")
		end if

		Set rs = Server.createObject("ADODB.RecordSet")
		sql = "select * from board where idx = "&idx
		rs.Open sql, Conn, 1
		 
		subject		=	rs("subject") 
		content		=	rs("content")   
		write_name	=	rs("write_name")   
		filename	=	rs("filename")  
		secret_flag	=	rs("secret_flag")  
		rs.close
		DbClose()
		

		if flag="answer" then 
			subject	=  "RE:"&subject	
			'content	= "==================================================================================="&replace(content,chr(13)&chr(10),"<br>")
			content	= ""
			filename = ""
			secret_flag = ""
		end if

		if(isnull(flag) or flag="") then flag = "edit"  
 
	else 
		write_name = session("username")
		flag = "insert" 
		if DBopen() = false then
			Call Sub_Display_Error("Please contact your administrator.")
		end if

		Set rs = Server.createObject("ADODB.RecordSet")
		sql = "select (max(idx)+1) idx from dbo.board "
		rs.Open sql, Conn, 1
		idx		=	rs("idx") 
		rs.close
		DbClose()
	end if 
%>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script type="text/javascript" src="/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<div class="col-12 overflow-auto Invest">
<form name="form" method="post" action="./customer/notice_save.asp" enctype="multipart/form-data">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="searchField" value="<%=searchField%>">
<input type="hidden" name="searchValue" value="<%=searchValue%>"> 
<input type="hidden" name="page" value="<%=page%>">   
<input type="hidden" name="code" value="<%=code%>">   

     <table class="table">
     	<colgroup>
        	<col width="15%">
            <col width="*">
        </colgroup>
          <tbody>
		  <tr>
              <th>Name</th>
              <td style="width:85%;">
				<%=write_name%>
            </tr>
          <tr>
              <th>Subject</th>
              <td>
				<input name="subject" type="text"  size="100" class="form-control col-3" value="<%=subject%>">
			  </td>
            </tr>
            <tr>
              <th>Contents</th>
              <td>
              	<textarea name="ir1" id="ir1" rows="10" cols="100"><%=content%></textarea>
              </td>
            </tr>
            <tr>
              <th>Attachments</th>
              <td>
				&nbsp;<input name="filename" type="file"  size="80"> 
				<%if filename<>"" and  not isnull(filename) then%>
					<br><a href="/_uploadf/<%=filename%>" class="community_bar_unlink_text">&nbsp;<%=filename%></a>&nbsp;&nbsp;
					<input type="checkbox" name="filename_del" value="Y">delete
				  <%end if%>
			  </td>
            </tr>
            <tr>
              <td colspan="2">
					<div class="text-center col-12">
						<div class="form-group">
							<button type="button" onclick="submitContents(form);;" class="btn btn-warning btn-lg col-lg-3 mr-3"><i class="fa fa-check"></i>Confirm</button>
							<button type="button" onclick="history.go(-1);" class="btn btn-primary btn-lg col-lg-3">Cancellation</button>
						</div>
					 </div>
              </td>
            </tr>
          </tbody>
        </table>
		  </form>
    </div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "ir1",
    sSkinURI: "../se2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});

function submitContents(elClickedObj) {

    // 에디터의 내용이 textarea에 적용된다.

    oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

 

    // 에디터의 내용에 대한 값 검증은 이곳에서

//    alert(document.getElementById("ir1").value);

 

    try {

        document.form.submit();

    } catch(e) {}
}
</script>
