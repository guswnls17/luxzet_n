<!--#include file ="../lib/db.asp"-->
<!--#include file ="../lib/util.asp"-->
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
		owner_no	=	rs("owner_name")  
		category	=	rs("category") 	  '공지사항체크
			
			If owner_no <> "" Then
				Set rs2 = Server.createObject("ADODB.RecordSet")
				sql2 = "select mem_name from mmember where mem_id = '"&owner_no&"'"
				'Response.write sql2
				rs2.Open sql2, Conn, 1
				mem_name=rs2("mem_name")
				rs2.close
			End If
			
		rs.close
		DbClose()
		

		if flag="answer" then 
			subject	=  "RE:"&subject	
			'content	= "==================================================================================="&replace(content,chr(13)&chr(10),"<br>")
			content	= ""
			filename = ""
			secret_flag = ""
			write_name = session("username")
		end if

		if(isnull(flag) or flag="") then flag = "edit"  
 
	else 
		write_name = session("username")
		flag = "insert" 
	end if 
%>
<script language="Javascript" src="../webnote/webnote.js"></script>
<script language="javascript" src="./customer/js/board.js"></script>
<script language="Javascript">

//debuging message set
//webnote.setDebug();

//webnote config
webnote.setConfig({
//	auto_start:			false,									//페이지로딩시 페이지에 웹노트 에디터를 자동으로 생성할것인지(true: 자동생성, false: 생성안함)
	lang:				"en",									//언어셋(lang 디렉토리내에 언어셋.txt 파일이 있어야 함(ex: ko.txt)
//	base_dir:			"/webnote",								//웹노트 설치디렉토리를 직접 지정
//	css_url:			"/webnote/webnote.css",					//기본 css 파일을 직접 지정
//	icon_dir:			"/webnote/icon",						//기본 아이콘 디렉토리를 직접 지정
//	emoticon_dir:		"/webnote/emoticon",					//기본 이모티콘 디렉토리를 직접 지정
//	attach_proc:		"/webnote/webnote_attach.php",			//에디터에 이미지 즉시 업로드를 처리하는 서버스크립트를 직접 지정
//	delete_proc: 		"/webnote/webnote_attach.php",			//에디터에 즉시 업로드된 이미지 삭제를 처리하는 서버스크립트를 직접 지정(attach_proc 과 같을경우 설정 불필요)
//	use_blind:		true,									//팝업메뉴 출력 시 반투명 배경 스크린 사용여부(true:사용(기본), false: 미사용)
//	allow_dndupload:	true,									//드래그&드롭을 통한 이미지 파일 업로드 허용 여부
//	allow_dndresize:	true,									//드래그&드롭을 통한 에디터 사이즈(높이) 조절 허용 여부
//	fonts:				["굴림체","궁서체"],					//선택할 수 있는 폰트종류를 직접 정의
//	fontsizes:			["9pt","10pt"],							//선택할 수 있는 폰트사이즈를 직접 정의(단위포함)
//	lineheights:		["120%","150%","180%"],					//선택할 수 있는 줄간격을 직접 정의(단위포함)
//	emoticons:			["Nerd"],						//선택할 수 있는 이모티콘들을 직접 정의(png파일은 확장자 생략 가능하며, 그외에는 확장자까지 입력 : PNG, GIF, JPG 만 가능)
//	specialchars:		["§","☆"],								//선택할 수 있는 특수문자를 직접 정의
//	code_highlight:		true,
        //fade_popup: false,                                                        //팝업 열리기/닫히기 시 fade in/out 기능 적용 여부(사용pc 사용이 낮은경우 false로 )
        //attach_list_view: false
});

//webnote user tools set
/*
webnote.setUserTools([
    {
		name: "brick",
		text: "내아이콘1",
		content: "<div class='webnote_popup_container_top'><textarea name='mycontents' id='mycontents' style='width:98%;height:100px'></textarea></div><div class='webnote_popup_container_bottom'><input type='button' class='webnote_btn_center' value='본문에삽입' onClick='insertMyContents()'></div>",
		popup_width: 300,
		callback: brink_func
    },
    {
		name: "bricks",
		text: "내아이콘2",
		content: "<div class='webnote_popup_container_top' id='mycontents2'></div><div class='webnote_popup_container_bottom'><input type='button' class='webnote_btn_center' value='닫기' onClick='myclosepop()'></div>",
		popup_width: 400,
		callback: function() {
			brinks_func();
		}
    }
]);
*/
//webnote create callback set

</script>
<!--<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">-->
<form name="form" method="post" action="./customer/board_save.asp" enctype="multipart/form-data">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="searchField" value="<%=searchField%>">
<input type="hidden" name="searchValue" value="<%=searchValue%>"> 
<input type="hidden" name="page" value="<%=page%>">   
<input type="hidden" name="code" value="<%=code%>">   
  <tr> 
	<td height="30" align="center"> <table width="100%" border="0" cellspacing="0" cellpadding="0" >
		<tr> 
		  <td height="2"  bgcolor="7E7E7E"></td>
		</tr>
		<tr > 
		  <td height="31"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<th width="80" align="center" >Name</th>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td style="padding:0 0 0 15" align="left" > 
				&nbsp;<%=write_name%>
				</td>
			  </tr>
			</table></td>
		</tr>
		<% If session("userid") = "DAONOL" Then %>
		<tr> 
		  <td height="1"  bgcolor="EBEBEB"></td>
		</tr>
		 <tr> 
		  <td height="31"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<th width="80" align="center" >Members ID</th>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td style="padding:0 0 0 15" align="left" class="community_bar_text"> 
				<input name="owner_name" type="text" class="community_bar_text" style='height:25px;'  value="<%=mem_name%>" <% If trim(category) = "y" Then  %> disabled <%End If%> readonly onclick='window.open("./organize/membersearch.asp?no=form.owner_no&nm=form.owner_name", "", "width=520,height=455,scrollbars=no,status=no,menubar=no");' >
				<input name="owner_no" type="hidden" value="<%=owner_no%>"> 
				<a href='#' onclick='window.open("./organize/membersearch.asp?no=form.owner_no&nm=form.owner_name", "", "width=520,height=455,scrollbars=no,status=no,menubar=no");' class="btn_style03"><span>Members search</span></a>

				<input name="notice" type="checkbox" class="community_bar_text" value="y" style='height:25px;' onclick="javascript:if(document.form.notice.checked) { document.form.owner_name.disabled = true; } else {document.form.owner_name.disabled = false;  }" <% If trim(category) = "y" Then  %> checked <%End If%> > Notice

				</td>
			  </tr>
			</table></td>
		</tr>
		<% End If %>
		<tr> 
		  <td height="1"  bgcolor="EBEBEB"></td>
		</tr>
		<tr > 
		  <td height="31"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<th width="80" align="center" >subject</th>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td style="padding:0 0 0 15" align="left">&nbsp;<input name="subject" type="text"  size="100" style='height:25px;' value="<%=subject%>">
				&nbsp;&nbsp;
				<input type="checkbox" name="secret_flag" value="1" <%=checked(secret_flag,"1")%> > Secret<!--비밀글-->
				</td>
			  </tr>
			</table></td>
		</tr>
		 
		<tr> 
		  <td height="1"  bgcolor="EBEBEB"></td>
		</tr>
		<tr> 
		  <td height="29"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<th width="80" align="center" >Contents</th>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td style="padding:0 0 0 15">  <textarea id="content" name="content"  editor="webnote" tools="deny:" cols="28" rows="15" style="width:90%;height:300px;"><%=content%></textarea> 
				</td>
			  </tr>
			</table></td>
		</tr>
		<tr> 
		  <td height="1"  bgcolor="EBEBEB"></td>
		</tr>
		<!--
		<tr> 
		  <td height="31"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				<th width="80" align="center" >Attachments</th>
				<td width="1" align="center"><img src="images/board/community_b_line.gif" width="1" height="10"></td>
				<td style="padding:0 0 0 15" align="left"> 
				&nbsp;<input name="filename" type="file"  size="80"> 
				<%'if filename<>"" and  not isnull(filename) then%>
					<br><a href="./customer/down.asp?filename=<%'=Server.UrlEncode(filename)%>&fpath=<%'=Server.UrlEncode(board_full_path)%>">&nbsp;<%'=filename%></a>&nbsp;&nbsp;
					<input type="checkbox" name="filename_del" value="Y">delete
				  <%'end if%>
				</td>
			  </tr>
			</table></td>
		</tr>
		<tr> 
		  <td height="2"  bgcolor="CCCCCC"></td>
		</tr>
		-->
	  </table></td>
  </tr>
  <tr> 
	<td height="40" align="center"><div align="center"><a href="javascript:form_chk(form)"  onfocus="this.blur()" class="btn_style02"><span>Registration</span></a> 
	  <a href="javascript:history.go(-1)"  onfocus="this.blur()" class="btn_style01"><span>Cancellation</span></a></div> 
	</td>
  </tr>
</table>
</form>