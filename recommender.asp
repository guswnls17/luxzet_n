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
<title>::<%=language(lan,0)%>::</title>
<link rel="stylesheet" href="/css/sb-admin-2.css">
<link rel="stylesheet" href="/css/popstyle.css">
</head>
<script type='text/javascript'>
function submit_check(){
    var frm = document.frmMain;
    var n_search = frm.n_search.value;

    if (n_search == '') {
        alert('Please check the name');
        frm.n_search.focus();
        return false;
    }

	return true;
}

function submit(obj)
{
	location.href = "?mem_name="+obj+"&gubun="+'<%=request("gubun")%>';
}

function MoveEnter(vals) {	
	if(event.keyCode == 13){
	 
	 location.href = "?mem_name="+vals+"&gubun="+'<%=request("gubun")%>';

	}
}

function select_result(num,uid,uname,agency,gubun,count){
	if(gubun == "a"){
		
		opener.document.frmMain.n_recom_nm.value = uname;
		opener.document.frmMain.n_recom_no.value = num;
		window.close();
	}else{
		if(count > 1 ){
			alert("There are two or more sponsors");
		}else{
			opener.document.frmMain.n_spon_nm.value = uname;
			opener.document.frmMain.n_spon_no.value = num;
	//		opener.setSelected(agency);
			window.close();
		}
	}
}

</script>
<%

If request("n_search") <> "" Then
	scarch_name = request("n_search")
End If

If request("mem_name") <> "" Then
	scarch_name = request("mem_name")
End If


If scarch_name = "" Then
		sql = "select  mem_code, mem_id, mem_name, mem_jumin  "
		sql = sql & "from mmember "
		sql = sql & "where mem_name = '" & scarch_name & "' or mem_id = '"& scarch_name & "'"
else
		sql = "select  mem_code, mem_id, mem_name, mem_jumin , (select count(mem_hoo_code)  from mmember where mem_hoo_code = a.mem_code) "
		sql = sql & "from mmember a "
		sql = sql & "where a.mem_name like N'%" & scarch_name & "%' or a.mem_id =  '"& scarch_name & "'"
End If

%>
<body onLoad='document.frmMain.n_search.focus();'>
  <div class="container popup">
  	<div class="row">
    	<div class="col-lg-12">
        	<h4 class="p-3">by Members Search <a href="" class="float-right d-block" onclick="javascript:window.close()"><i class="fa fa-times"></i></a></h4>
            <div class="cardsearch">
            	<form name='frmMain' method='post' action='recommender.asp'>
<input type='hidden' name='no' value=''>
<input type='hidden' name='nm' value=''>
<input type='hidden' name='gubun' value='<%=request("gubun")%>'>
                	<input type="text" value='<%=scarch_name%>' name='n_search' id='i_search' class="w-75">
                    <a href="javascript:submit(document.frmMain.n_search.value);"class="btn-chk"><%=language(lan,246)%></a>
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
                    	  <th><%=language(lan,247)%></th>
                          <th><%=language(lan,248)%></th>
                          <th><%=language(lan,249)%></th>
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
				page = request("page")

				If page = "" Then
					page = 1
				End if
				'Response.write sql
				lngDataCnt = f_sql_select(db_conn, sql, arrData)

					If lngDataCnt > 0 Then 
							pageCnt = UBound(arrData, 2) + 1
						Else
							
							Response.write "<tr><td height='100' colspan='3'>"&language(lan,196)&"</td></tr>"
						End if

						For i = 0 To pageCnt - 1
				%>
           <tr style = "cursor:pointer;" onClick = 'select_result("<%=arrData(0, i)%>", "<%=arrData(1, i)%>","<%=arrData(2, i)%>","<%=arrData(3, i)%>","<%=request("gubun")%>","<%=arrData(4, i)%>");'>
              <td><%=arrData(0, i)%></td>
              <td><%=arrData(1, i)%></td>
              <td><%=arrData(2, i)%></td>
            </tr>

				<%		
						Next 				
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