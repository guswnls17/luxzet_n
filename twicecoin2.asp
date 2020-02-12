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
	
	linkurl = "twicecoin2.asp?a=1"

    sql = "select isNull(mem_rcoin,0) , isNull(mem_acoin,0), mem_rcode " _
		& "from mmember " _
		& "where mem_code = '" & session("member") & "' "
	
	mem_rcoin = 0
	mem_acoin = 0
	mem_rcode = ""

	If f_sql_select(db_conn, sql, arrData) > 0 Then
		mem_rcoin = arrData(0, 0)
		mem_acoin = arrData(1, 0)
		mem_rcode = arrData(2, 0)
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

	if (frm.n_istate.value == '3') {
		if (parseInt(frm.n_amount.value) < 50000) {
			alert(coin_lang[35]); //신청금액은 최소한 10 $보다 커야 합니다.
			frm.n_amount.focus();
			return false;
		}
	}else{
		if (parseInt(frm.n_amount.value) < 3000) {
			alert(coin_lang[36]); //신청금액은 최소한 10 $보다 커야 합니다.
			frm.n_amount.focus();
			return false;
		}
	}
    if (parseInt(frm.per_amount.value) > parseInt('<%=mem_acoin%>')) {
        alert(coin_lang[37]); //신청금액이 전자머니잔액보다 큽니다. / 전자머니잔액을 확인해 주세요.
        frm.n_amount.focus();
        return false;
    }



	
	
    if (frm.n_istate.value == '3' && frm.s_walletaddr.value == '') {
        alert(coin_lang[38]); //전송할 상대 지갑 주소 입력 선물할 사람의 회원번호를 입력해주세요.
        frm.s_walletaddr.focus();
        return false;
    }
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
		if (confirm(coin_lang[8])) {
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
			frm.per_amount.value=parseFloat(payAmt);
		} else if(frm.n_istate.value=="4") {
			var payAmt=paystr;
			payAmt=payAmt;
			frm.per_amount.value=parseFloat(payAmt);
		} else {
			frm.per_amount.value=parseFloat(paystr);
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
<form name="frmMain" method="post" action="./emoney/vmoney_proc2.asp" onsubmit="return input_check();" target='hiddenprocess'>
<input type='hidden' name='command'>
                        <table class="table">
                        <colgroup>
                            <col width="20%">
                            <col width="80%">
                        </colgroup>
                        <tr>
                          <th class="border-0"><%=language(lan,282)%></th>
                          <td class="border-0"><%If mem_acoin <> "" Then %><%=FormatNumber(mem_acoin, 2)%><%Else%>0<% End If%> coin</td>
                        </tr>
                        <tr>
                          <th><%=language(lan,128)%></th>
                          <td>
                          <div class="form-group">
                            <select name='n_istate' onchange="use_payment();" class="form-control">
                              <option value='3'><%=language(lan,140)%></option>
<!--						<option value='1'>Cash conversion</option>
						<option value='9'>Bit Coin transmission</option>  -->
                            </select>
                          </div>
                          </td>
                        </tr>
                        <tr>
                          <th><%=language(lan,143)%></th>
                          <td>
                            <div class="form-group">
                                <div class="input-group">
                                    <input type="text" class="form-control col-md-4" name='n_amount' id='i_amount' value='' maxlength='10' onKeyUp="use_payment();">
									<input type="hidden" name='per_amount' id='per_amount' value='' />
									<button type="button" onclick="save();" class="btn btn-info ml-2"><%=language(lan,144)%></button>
                                </div>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <th><%=language(lan,130)%></th>
                          <td>
                            <div class="form-group">
                                <input type="text" name='s_walletaddr' id='s_walletaddr' value="<%=mem_rcode%>" class="form-control">
                            </div>
                          </td>
                        </tr>
                    </table>
                    </form>
                    
                </div>
            </div>
          </div>
        </div>
        <div class="row mt-4 mb-5">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg text-uppercase"><%=language(lan,23)%></h6>
          </div>
          
          <div class="card-body">
              <div class="table-responsive">
<%

	page = request("page")
	If page = "" Or page = "0" Then page = "1"

    sql = "select seq, date, addr, pay ,pdate ,gbn ,state ,bigo " _
		& " from coin_banking_his2 " _
		& "where mem_code = '" & session("member") & "' " _
		& " and  date > '20161113' " _
		& "order by date desc "

	'Response.write sql

	lngDataCnt = f_sql_select(db_conn, sql, arrData)
	
	

	
%>				  
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th><%=language(lan,73)%></th>
                      <th><%=language(lan,132)%></th>
                      <th><%=language(lan,133)%></th>
                      <th><%=language(lan,134)%></th>
                      <th><%=language(lan,135)%></th>
                      <th><%=language(lan,136)%></th>
                      <th><%=language(lan,137)%></th>
                      <th><%=language(lan,138)%></th>
                    </tr>
                  </thead>
                  <tbody>
<%
	If lngDataCnt > 0 Then 
		pageCnt = UBound(arrData, 2) + 1
	Else
		Response.write "<tr><td height='100' colspan='8'>"&language(lan,37)&"</td></tr>"
	End if
	
	For i = 0 To lngDataCnt - 1
	
	'("0" : payment coin, "1" : cash ~~, "3" : external ~~)
	Select Case arrData(5, i)
		Case "0"
			Temp = "payment coin"
		Case "1"
			Temp = "Cash conversion"
		Case "3"
			Temp = "External transmission"
		Case "5"
			Temp = "Option coin"
		Case "9"
			Temp = "BIT COIN transmission"
	End select
	
	' state( "0" : WAIT, "1" : PAYMENT)
	Select Case arrData(6, i)
		Case "0"
			Temp2 = "WAIT"
		Case "1"
			Temp2 = "PAYMENT"
	End select 
	
%>				  
              <tr>
                <td><%=lngDataCnt - i%></td>
                <td><%=arrData(0, i)%></td>
                <td><%=arrData(1, i)%></td>
                <td><%=Temp%></td>
				<td><%=Temp2%></td>
                <td><%=arrData(4, i)%></td>
                <td><%=FormatNumber(arrData(3, i),5)%></td>
                <td><%=arrData(7, i)%></td>
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

	  
<script type="text/javascript" src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript" src="/myoffice/lib/jquery.ui.datepicker-ko.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />	  
