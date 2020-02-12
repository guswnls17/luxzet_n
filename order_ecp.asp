<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->
<!--#include file="header.asp" -->
<style>
@media (max-width: 700px) {
	.hasDatepicker{width:100px !important}
}
</style>
<script language="JavaScript" type="text/JavaScript">
        $(document).ready(function(){

            $("#i_sdate").datepicker({
                showOn: "button", //이미지로 사용 , both : 엘리먼트와 이미지 동시사용
                buttonImage: "img/calendar.png", //버튼으로 사용할 이미지 경로
                buttonImageOnly: true //이미지만 보이기
            });

            $("#i_edate").datepicker({
                showOn: "button", //이미지로 사용 , both : 엘리먼트와 이미지 동시사용
                buttonImage: "img/calendar.png", //버튼으로 사용할 이미지 경로
                buttonImageOnly: true //이미지만 보이기
            });

            $("img.ui-datepicker-trigger").attr("style","margin-left:5px; vertical-align:middle; cursor:pointer;"); 
			
			

        });
</script>
<%
	menu1 = "주문현황"
	menu2 = "주문조회"

	n_sdate = request("n_sdate")
	n_edate = request("n_edate")

	If n_sdate = "" Then 
		n_sdate = year(Date)-1 & "-" & Right("00" & month(Date), 2) & "-" & Right("00" & day(date-1), 2)
	End if
	If n_edate = "" Then 
		n_edate = year(Date) & "-" & Right("00" & month(Date), 2) & "-" & Right("00" & day(date), 2)
	End if

	linkurl = request.serverVariables("path_info")&"?n_sdate=" & n_sdate & "&n_edate=" & n_edate

%>

<!-- Begin Page Content -->
      <div class="container-fluid">
      	<div class="row">
      <div class="col-lg-12">
        <div class="card p-4">
        	<div class="text-md font-weight-bold">Date of Order</div>
            <div class="card-search-body">
            	<form name="frmMain" method="post" action="<%=request.serverVariables("path_info")%>">
                    <div class="form-group mt-4">
                        <div class="input-group">
                            <input name="n_sdate" id="i_sdate" value="<%=n_sdate%>" readonly class="form-control col-md-4">
                            <p class="m-2 ml-3 mr-3"> ~ </p>
                            <input name="n_edate" id="i_edate" value="<%=n_edate%>" readonly class="form-control col-md-4">
                            <button type="button" onclick="document.frmMain.submit();" class="btn btn-info ml-2">Inquiry</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
      </div>
    </div>
        <div class="row mt-4">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg">Order History (ECPcoin)</h6>
            </div>
          <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>No</th>
                      <th>Date of Order</th>
                      <th>Amount</th>
                      <th>ECPCoin</th>
                      <th>Coin exchange</th>
                      <th>Receive ECP Address</th>
					  <th>Sender ECP Address</th>
					  <th>Expiry Date</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <%
	
	n_sdate=Replace(n_sdate,"-","")
	n_edate=Replace(n_edate,"-","")

	page = request("page")
	If page = "" Or page = "0" Then page = "1"

    'sql    = "EXEC sp_회원_매출조회 '" & n_sdate & "', '" & n_edate & "', '" & Session("member") & "'"
	 sql   ="select	a.erc_idate, a.s_amount, a.erc_amount, erc_exchange, a.erc_addr, a.erc_iaddr,"
	 sql = sql& "a.erc_exchange, a.erc_hoocode, a.erc_odate, "
	 sql = sql& "case a.erc_check	when '0' then 'Stand by' "
	 sql = sql& "			when '1' then 'Complete' "
	 sql = sql& "			when '2' then 'Cancel' else '' end "
	 sql = sql& "from	purchase_erc a "
	 sql = sql& " where	left(a.erc_idate,8) between '" & n_sdate & "' and '" & n_edate & "'"
	 sql = sql& " and	a.erc_memcode = '" & session("member") & "' order by erc_seq desc "
	 'sql = sql& " and	a.sale_gubun = '1' "
	'Response.write sql

	lngDataCnt = f_sql_select(db_conn, sql, arrData)

If lngDataCnt > 0 Then 
		pageCnt = UBound(arrData, 2) + 1
	Else
		
		Response.write "<tr><td height='100' colspan='9'>No inquired Data.</td></tr>"
	End if

	For i = 0 To lngDataCnt - 1
	
	
	idate = left(arrData(0, i),4) & "-" & mid(arrData(0, i),5,2) & "-" & mid(arrData(0, i),7,2) & " " & mid(arrData(0, i),9,2) & ":" & mid(arrData(0, i),11,2)
	odate = left(arrData(8, i),4) & "-" & mid(arrData(8, i),5,2) & "-" & mid(arrData(8, i),7,2) & " " & mid(arrData(8, i),9,2) & ":" & mid(arrData(8, i),11,2)
%>				  
                   <tr>
						<td><%=lngDataCnt - ((page - 1) * pagesize) - i%></td>
						<td><%=idate%></td>
						<td><%=FormatNumber(arrData(1, i), 0)%></td>
						<td><%=FormatNumber(arrData(2, i), 4)%></td>
						<td><%=FormatNumber(arrData(3, i), 5)%></td>
						<td><%=arrData(4, i)%></td>
						<td><%=arrData(5, i)%></td>
						<td><%=odate%></td>
						<td><%=arrData(9, i)%></td>
					  </tr>
<%	Next %>
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

  <!--#include file="footer.asp"-->
  <!-- Page level plugins -->
  <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  
  <!-- Page level custom scripts -->
  <script src="/js/demo/datatables-demo_desc.js"></script>

	  
<script type="text/javascript" src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript" src="/myoffice/lib/jquery.ui.datepicker-ko.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />	  