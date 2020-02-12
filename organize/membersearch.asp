<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%
Response.Expires = -1 
%>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>::LUXZET::</title>
<link rel="stylesheet" href="/css/sb-admin-3.css">
<link rel="stylesheet" href="/css/popstyle.css">
<%

Session.CodePage = 65001
Response.ChaRset = "UTF-8"

	search = request("n_search")
	no = request("no")
	nm = request("nm")
	organ = request("organ")
	
	'response.write no
%>
<script type='text/javascript'>

function submit_check(){
    var frm = document.frmMain;
    var n_search = frm.n_search.value;

    if (n_search == '') {
        alert("Please enter your member name you want to search."); //검색할 회원명을 입력해주세요.
        frm.n_search.focus();
        return false;
    }

	return true;
}

function submit()
{
	if (submit_check()) document.frmMain.submit();
}

function MoveEnter(vals) {	
	if(event.keyCode == 13){
	    if(vals=="search"){
			submit();
			return;
		}
	}
}

function select_member(no, nm)
{
	opener.<%=no%>.value = no;
	opener.<%=nm%>.value = nm;
	window.close();
}

</script>
</head>

<body onLoad='document.frmMain.n_search.focus();'>
  <div class="container popup">
  	<div class="row">
    	<div class="col-lg-12">
        	<h4 class="p-3">by Members Search <a href="" class="float-right d-block" onclick="javascript:window.close()"><i class="fa fa-times"></i></a></h4>
            <div class="cardsearch">
            	<form name="frmMain" method="post" action="membersearch.asp" onsubmit="return submit_check();">
<input type='hidden' name='no' value='<%=no%>'>
<input type='hidden' name='nm' value='<%=nm%>'>
<input type='hidden' name='organ' value='<%=organ%>'>
					<input type="text" placeholder="Member's Name/Code Number" value="<%=search%>" name="n_search" id="i_search" class="w-75">
                    <a href="javascript:submit();"class="btn-chk">Search</a>
                </form>
            </div>
            <div class="table">
            	<table class="w-100">
                	<colgroup>
                    	<col width="35%">
                        <col width="30%">
                        <col width="35%">
                    </colgroup>
                	<thead>
                    	<tr>
                    	  <td>Member's Code Number</td>
						  <td>Member's Name</td>
						  <td>Birthday</td>
                    	</tr>
                    </thead>
                </table>
                <div class="table-body">
                	<table class="w-100">
                    	<colgroup>
                            <col width="37%">
                            <col width="30%">
                            <col width="34%">
                        </colgroup>
                    	<tbody>
						<%
If search > "" then
	if organ = "spon" then 
		wheres = " and a.mem_code in (select down_down from mem_hdown where down_member = '"& Session("member") &"') "
	else
		wheres = " and a.mem_code in (select down_down from mem_cdown where down_member = '"& Session("member") &"') "
	end if 
    sql = "select	a.mem_code, a.mem_id, a.mem_name, left(a.mem_jumin,6) as mem_jumin	from	mmember a where	( a.mem_name like N'%" & search & "%' or a.mem_id = '" &search & "') " & wheres
    'sql = "SP_회원_검색_조직 '" & session("member") & "', '" & search & "', '" & organ & "'"

	'Response.write sql

	lngCnt = f_sql_select(db_conn, sql, arrData)

	For i = 0 To lngCnt - 1
%>
			<tr style = "cursor:pointer;" onClick = 'select_member("<%=arrData(0, i)%>", "<%=arrData(1, i)%>");'>
				<td><%=arrData(0, i)%></td>
				<td><%=arrData(1, i)%></td>
				<td><%=Left(arrData(2, i), 8)%></td>
            </tr>
<%
	Next
End if
%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
  </div>
  

</body>
</html>