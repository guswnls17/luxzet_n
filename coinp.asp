<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->
<!--#include file="header.asp" -->
<%
	'response.write "<script>alert('Sorry! 현재 작업중으로 사용하실수 없습니다.'); history.back();</script>"
	menu1 = "전자머니"
	menu2 = "현금신청"

	n_sdate = request("n_sdate")
	n_edate = request("n_edate")

	If n_sdate = "" Then 
		n_sdate = year(Date-8) & "-" & Right("00" & month(Date-8), 2) & "-" & Right("00" & day(date-8), 2)
	End if
	If n_edate = "" Then 
		n_edate = year(Date-1) & "-" & Right("00" & month(Date-1), 2) & "-" & Right("00" & day(date-1), 2)
	End if
	
	linkurl = "coinp.asp?a=1"

    sql = "select mem_up_jum, isNull(mem_rewards,0) " _
		& "from mmember " _
		& "where mem_code = '" & session("member") & "' "
	
	shoppoint = 0
	point = 0

	If f_sql_select(db_conn, sql, arrData) > 0 Then
		shoppoint = arrData(0, 0)
		point = arrData(1, 0)
	End If
	
	 sql = "select Top 1 emoney_idate " _
		& "from mmember_emoney " _
		& "where emoney_mem_code = '" & session("member") & "' order by emoney_idate desc, emoney_no desc"
	
	Chkweek= 0
	If f_sql_select(db_conn, sql, arrData) > 0 Then
		emoney_idate = arrData(0, 0)
		'주중 한번 사용가능 한지 채크한다. 일요일 ~ 토요일
		Chkweek=DateDiff("ww",Now,left(emoney_idate,4)&"-"&Mid(emoney_idate,5,2)&"-"&Right(emoney_idate,2))
		
	End If
	'Response.write Chkweek

%>
<script type='text/javascript'>
function input_check(){
    var frm = document.frmMain;

    if (frm.n_amount.value == '') {
        alert(coin_lang[10]); //신청금액을 입력해주세요.
        frm.n_amount.focus();
        return false;
    }

    if (isNaN(frm.n_amount.value)) {
        alert(coin_lang[11]); //신청금액은 숫자로 입력해주세요.
        frm.n_amount.focus();
        return false;
    }

    if (parseInt(frm.n_amount.value) < 100) {
        alert(coin_lang[12]); //신청금액은 최소한 10 $보다 커야 합니다.
        frm.n_amount.focus();
        return false;
    }

	
	if ((parseInt(frm.n_amount.value) % 100) != 0) {
        alert(coin_lang[13]); //신청금액은 최소한 10 $보다 커야 합니다.
        frm.n_amount.focus();
        return false;
    }

    if (parseInt(frm.per_amount.value) > parseInt('<%=point%>')) {
        alert(coin_lang[14]+"\r\n\n"+coin_lang[15]); //신청금액이 전자머니잔액보다 큽니다. / 전자머니잔액을 확인해 주세요.
        frm.n_amount.focus();
        return false;
    }


	/*if (parseInt(frm.n_amount.value) > parseInt('<%'=(emoney*0.5)%>')) {
        alert("This amount is larger than 50% E-Wallet balance.\r\n\n신청금액이 Gcoin잔액 50%보다 큽니다."); //신청금액이 전자머니잔액 50%보다 큽니다.
        frm.n_amount.focus();
        return false;
    }
	

	if (parseInt('<%'=Chkweek%>') >= 0 ) {
        alert("You can apply once during the week.\r\n\n주중 한번만 신청 가능합니다."); //주중 한번만 신청 가능합니다.
        frm.n_amount.focus();
        return false;
    }*/

    /*if (parseInt('<%=emoney%>') - parseInt(frm.per_amount.value) < 10000 ) {
        alert("Balance must be at least 10,000G.\r\nPlease reduce the amount."); //전자머니잔액은 만원이상 남아야 합니다.\r\n신청금액을 줄여 주세요.
        frm.n_amount.focus();
        return false;
    }*/
	
	
    if (frm.n_istate.value == '4' && frm.n_memno.value == '') {
        alert(coin_lang[16]); //선물할 사람의 회원번호를 입력해주세요.
        frm.n_amount.focus();
        return false;
    }
	/*
	if (frm.n_istate.value == '5' || frm.n_istate.value == '8') {
		if (parseInt(frm.n_amount.value) < 500) {
			alert("Applications must specify the amount to 500 units."); //신청금액은 최소한 10 $보다 커야 합니다.
			frm.n_amount.focus();
			return false;
		}
    }
	*/
	//alert(frm.n_memno.value);
//	if(frm.n_memno.value == '') {
//		alert("Please enter your membership number of the person you want to send a gift.");
//		return false;
//	}

	return true;
}

function save()
{
	if (input_check()) {
		if (confirm(coin_lang[17])) {
			document.frmMain.command.value = "save";
			document.frmMain.submit();
		}
	}
}

function use_payment() {
	var frm = document.frmMain;
	var paystr=document.getElementById('i_amount').value*1;
	
	if(paystr >= 10) {

		if(frm.n_istate.value=="1") 
		{
			var payAmt=paystr;
			payAmt=payAmt;
			persent.innerHTML="(Cash conversion: "+parseInt(payAmt)+"$)";
			frm.per_amount.value=parseInt(payAmt);
		} else if(frm.n_istate.value=="4") {
			var payAmt=paystr;
			payAmt=payAmt;
			persent.innerHTML="(Gift giving: "+parseInt(payAmt)+"$)";
			frm.per_amount.value=parseInt(payAmt);
		} else {
			persent.innerHTML="";
			frm.per_amount.value=parseInt(paystr);
		}
	}
}


</script>

<!-- Begin Page Content -->
      <div class="container-fluid">
      	<div class="row">
      <div class="col-lg-12">
        <div class="card p-4">
            <div class="card-search-body">
            	<form name="frmMain" method="post" action="./emoney/emoney_procp.asp" onsubmit="return input_check();" target='hiddenprocess'>
<input type='hidden' name='command'>
                    <table class="table">
                	<colgroup>
                    	<col width="20%">
                        <col width="80%">
                    </colgroup>
                	<tbody><tr>
                	  <th class="border-0"><%=language(lan,264)%></th>
                	  <td class="border-0">$<%If point <> "" Then %><%=FormatNumber(point, 2)%><%Else%>0<% End If%></td>
                	</tr>
                	<tr>
                	  <th><%=language(lan,142)%></th>
                	  <td>
                      <div class="form-group">
                        <select name='n_istate' onchange="use_payment();" class="form-control">
                	      <option value='3'><%=language(lan,151)%></option>  
                        </select>
                      </div>
	                  </td>
                	</tr>
                	<tr>
                	  <th><%=language(lan,129)%></th>
                	  <td>
                      	<div class="form-group">
                            <div class="input-group">
								<input type="text" name='n_amount' id='i_amount' value='' maxlength='10' onKeyUp="use_payment();" class="form-control col-md-4">
								<input type="hidden" name='per_amount' id='per_amount' value='' />
                                <button type="button" onclick="save();" class="btn btn-info ml-2"><%=language(lan,144)%></button>
                            </div>
                        </div>
                      </td>
                	</tr>
					<tr>
                	  <th><%=language(lan,151)%></th>
                	  <td>
                      	<div class="form-group">
                            <div class="input-group">
								<input type='text' class="form-control col-md-4" name='n_memno' id='i_memno' value='' onclick='window.open("./organize/membersearchWallet.asp?no=frmMain.n_memno&nm=frmMain.n_memname&organ=<%=organ%>", "", "width=520,height=455,scrollbars=no,status=no,menubar=no");' readonly>
								<input type='text' class="form-control col-md-4" name='n_memname' id='i_memname' onclick='window.open("./organize/membersearchWallet.asp?no=frmMain.n_memno&nm=frmMain.n_memname&organ=<%=organ%>", "", "width=520,height=455,scrollbars=no,status=no,menubar=no");' readonly>
								<input type='hidden' name='tempuser' id="tempuser" value=''>
								<button type="button" onclick='window.open("./organize/membersearchWallet.asp?no=frmMain.n_memno&nm=frmMain.n_memname&organ=<%=organ%>", "", "width=520,height=455,scrollbars=no,status=no,menubar=no");' class="btn btn-info ml-2"><%=language(lan,246)%></button>
                            </div>
                        </div>
                      </td>
                	</tr>
                </tbody></table>
                </form>
                
            </div>
        </div>
      </div>
    </div>
        <div class="row mt-4 mb-5">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg text-uppercase"><%=language(lan,264)%></h6>
          </div>
          
          <div class="card-body">
              <div class="table-responsive">
<%

	page = request("page")
	If page = "" Or page = "0" Then page = "1"

    sql = "select rewards_idate, rewards_no, " _
		& "case rewards_istate when '2' then 'Sales' when '3' then 'Gift' when '0' then 'Stock conversion' " _
		& " when '5' then 'Bitcoin conversion' when '7' then 'Sales' when '8' then 'Ethereum conversion' when '9' then 'LXZ conversion' else '' end, " _
		& "case rewards_ostate when '1' then 'Use' when '2' then 'Hold' when '9' then 'Error' when '0' then 'Unused' else '' end, " _
		& "rewards_odate, isnull(rewards_kum,0) from mmember_rewards " _
		& "where rewards_mem_code = '" & session("member") & "' " _
		& " and  rewards_idate > '20161113' " _
		& "order by rewards_idate , rewards_no  "

	'Response.write sql

	lngDataCnt = f_sql_select(db_conn, sql, arrData)
	
	

	
%>				  
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th><%=language(lan,73)%></th>
						<th><%=language(lan,133)%></th>
						<th><%=language(lan,132)%></th>
						<th><%=language(lan,128)%></th>
						<th><%=language(lan,134)%></th>
						<th><%=language(lan,136)%></th>
						<th><%=language(lan,137)%></th>
                    </tr>
                  </thead>
                  <tbody>
                    <%
	If lngDataCnt > 0 Then 
		pageCnt = UBound(arrData, 2) + 1
	Else
		Response.write "<tr><td height='100' colspan='7'>"&language(lan,37)&"</td></tr>"
	End if
	
	For i = 0 To pageCnt - 1
%>				  
              <tr>
                <td><%=lngDataCnt - ((page - 1) * pagesize) - i%></td>
                <td><%=arrData(0, i)%></td>
                <td><%=arrData(1, i)%></td>
                <td><%=arrData(2, i)%></td>
                <td><%=arrData(3, i)%></td>
                <td><%=arrData(4, i)%></td>
                <td><%=arrData(5, i)%></td>
              </tr>
<%	Next    %>	
                  </tbody>
                </table>
              </div>
            </div>
        </div>
      </div>
    </div>
      </div>
      <!-- /.container-fluid --> 
      
    </div>
    <!-- End of Main Content --> 
    
  </div>
  <!-- End of Content Wrapper --> 
  
</div>
<!-- End of Page Wrapper --> 

<!-- Scroll to Top Button--> 
<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i> </a> 

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
        <button class="close" type="button" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
      </div>
      <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
      <div class="modal-footer">
        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
        <a class="btn btn-primary" href="login.html">Logout</a> </div>
    </div>
  </div>
</div>
   
  <iframe name='hiddenprocess' style='display:none'></iframe>  
    <!--#include file="footer.asp"-->
	 <!-- Page level plugins -->
  <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  
  <!-- Page level custom scripts -->
  <script src="/js/demo/datatables-demo.js"></script>