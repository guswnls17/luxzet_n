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
	menu1 = "수당현황"
	menu2 = "수당조회"

	n_sdate = request("n_sdate")
	n_edate = request("n_edate")
	n_type = request("n_type")

	If n_sdate = "" Then 
		n_sdate = year(Date-7) & "-" & Right("00" & month(Date-7), 2) & "-" & Right("00" & day(date-7), 2)
	End if
	If n_edate = "" Then 
		n_edate = year(Date) & "-" & Right("00" & month(Date), 2) & "-" & Right("00" & day(date), 2)
	End if
	If n_type = "" Then n_type = "0"

	linkurl = request.serverVariables("path_info")&"?n_sdate=" & n_sdate & "&n_edate=" & n_edate & "&n_type=" & n_type

	page = request("page")
	If page = "" Or page = "0" Then page = "1"

%>	  

<!-- Begin Page Content -->
      <div class="container-fluid">
      	<div class="row">
      <div class="col-lg-12">
        <div class="card p-4">
        	<div class="text-md font-weight-bold"><%=language(lan,35)%></div>
            <div class="card-search-body">
            	<form name="frmMain" method="post" action="<%=request.serverVariables("path_info")%>">
                    <div class="form-group mt-4">
                        <div class="input-group">
                            <input name="n_sdate" id="i_sdate" value="<%=n_sdate%>" readonly class="form-control col-md-4">
                            <p class="m-2 ml-3 mr-3"> ~ </p>
                            <input name="n_edate" id="i_edate" value="<%=n_edate%>" readonly  class="form-control col-md-4">
                            <button type="button" onclick="document.frmMain.submit();" class="btn btn-info ml-2"><%=language(lan,36)%></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
      </div>
    </div>
        <div class="row mt-4 mb-5">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg text-uppercase"><%=language(lan,31)%></h6>
          </div>
          
          <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th><%=language(lan,73)%></th>
                      <th><%=language(lan,99)%></th>
                      <th><%=language(lan,100)%></th>
                      <th><%=language(lan,101)%></th>
					  <th><%=language(lan,105)%></th>
					  
                      <th><%=language(lan,102)%></th>
                      <th><%=language(lan,103)%></th>
                      
<!--                      <th><%=language(lan,104)%></th>
                      <th><%=language(lan,108)%></th>   -->
                      <th><%=language(lan,106)%></th>
<!--                      <th><%=language(lan,107)%></th>   -->
                    </tr>
                  </thead>
                  <tbody>
<% 	
		
	n_sdate=Replace(n_sdate,"-","")
	n_edate=Replace(n_edate,"-","")

If n_type = "0" Then 

	  sql =		"SELECT "
	 sql = sql& " temp_give_pay.temp_date,   "
	 sql = sql& " sum(Isnull(temp_give_pay.temp_sudang10, 0)) temp_sudang10, " 'Referral   Bonus
	 sql = sql& " sum(Isnull(temp_give_pay.temp_sudang20, 0)) temp_sudang20, " 'Referral Rollup Bonus
	 sql = sql& " sum(Isnull(temp_give_pay.temp_sudang30, 0)) temp_sudang30, " 'Team Bonus  Bonus
	 sql = sql& " sum(Isnull(temp_give_pay.temp_sudang40, 0)) temp_sudang40, " 'Matching Bonus
	 sql = sql& " sum(Isnull(temp_give_pay.temp_sudang90, 0)) temp_sudang90, " '
	 sql = sql& " sum(Isnull(temp_give_pay.temp_sudang80, 0)) temp_sudang80, " '
	 sql = sql& " sum(Isnull(temp_give_pay.temp_dnpay, 0)) temp_dnpay, " 		'Deduct 
	 sql = sql& " sum(Isnull(temp_give_pay.temp_sudang10, 0)) + sum(Isnull(temp_give_pay.temp_sudang20, 0)) + sum(Isnull(temp_give_pay.temp_sudang30, 0)) + sum(Isnull(temp_give_pay.temp_sudang40, 0))+ sum(Isnull(temp_give_pay.temp_sudang60, 0))  total, " 		'Total  
	 sql = sql& " sum(Isnull(temp_give_pay.temp_give_pay, 0)) temp_give_pay, "	' E-wallet 
	 sql = sql& " sum(Isnull(temp_give_pay.temp_jukum, 0)) temp_jukum, "	' Saving
	 sql = sql& " sum(Isnull(temp_give_pay.temp_acoin, 0)) temp_acoin, "	' Vrt Coin
	 sql = sql& " sum(Isnull(temp_give_pay.temp_sudang60, 0)) temp_sudang60 " 'Team Rollup Bonus
	 sql = sql& "	FROM temp_give_pay, mmember  "
	 sql = sql& "	WHERE ( temp_give_pay.temp_mem_code = mmember.mem_code ) and  "
	 sql = sql& "         ( ( temp_give_pay.temp_date between '"&n_sdate&"' and '"&n_edate&"' ) and  "
	 sql = sql& "         ( mmember.mem_code = '"&Session("member")&"' ) ) and temp_give_pay.temp_date >= '20190800'  "
	 sql = sql& " GROUP BY temp_give_pay.temp_date "

   ' sql = "EXEC sp_수당조회_마이오피스 '" & n_sdate & "', '" & n_edate & "', '" & Session("member") & "', '" & n_type & "' "

	

	lngDataCnt = f_sql_select(db_conn, sql, arrData)

	If lngDataCnt > 0 Then 
		pageCnt = UBound(arrData, 2) + 1
	Else
		Response.write "<tr><td height='100' colspan='8'>"&language(lan,37)&"</td></tr>"
	End If 

	For i = 0 To lngDataCnt - 1
%>	
			  
            <tr>
              <td><%=lngDataCnt - i%></td>
              <td><%=arrData(0, i)%></td>
              <td><%=FormatNumber(arrData(1, i), 2)%></td>
              <td><%=FormatNumber(arrData(2, i), 2)%></td>
			  <td><%=FormatNumber(arrData(12, i), 2)%></td>
			  
              <td><%=FormatNumber(arrData(3, i), 2)%></td>
              <td><%=FormatNumber(arrData(4, i), 2)%></td>  
			  
<!--              <td><%=FormatNumber(arrData(5, i), 2)%></td>
              <td><%=FormatNumber(arrData(7, i), 2)%></td>   -->
              <td><%=FormatNumber(arrData(8, i), 2)%></td>
<!--              <td><%=FormatNumber(arrData(9, i), 2)%></td>  -->
              </tr>
<%	Next    %>
                  </tbody>
				  <tfoot>
                  	<%      If lngDataCnt > 0 Then     
			 sql1 =		"SELECT "
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_sudang10, 0)) temp_sudang10, " 'Referral   Bonus
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_sudang20, 0)) temp_sudang20, " 'Referral Rollup 
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_sudang30, 0)) temp_sudang30, " 'Binary  Bonus
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_sudang40, 0)) temp_sudang40, " 'Matching Bonus
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_sudang90, 0)) temp_sudang90, " '
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_sudang80, 0)) temp_sudang80, " '
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_dnpay, 0)) temp_dnpay, " 		'Deduct 
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_sudang10, 0)) + sum(Isnull(temp_give_pay.temp_sudang20, 0)) + sum(Isnull(temp_give_pay.temp_sudang30, 0)) + sum(Isnull(temp_give_pay.temp_sudang40, 0))+ sum(Isnull(temp_give_pay.temp_sudang60, 0)) total, " 		'Total  
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_give_pay, 0)) temp_give_pay, "	' E-wallet 
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_jukum, 0)) temp_jukum, "	' Saving
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_acoin, 0)) temp_acoin, "	' Vrt Coin
			 sql1 = sql1& " sum(Isnull(temp_give_pay.temp_sudang60, 0)) temp_sudang60 " 'Team Rollup
			 sql1 = sql1& "	FROM temp_give_pay, mmember  "
			 sql1 = sql1& "	WHERE ( temp_give_pay.temp_mem_code = mmember.mem_code ) and  "
			 sql1 = sql1& "         ( ( temp_give_pay.temp_date between '"&n_sdate&"' and '"&n_edate&"' ) and  "
			 sql1 = sql1& "         ( mmember.mem_code = '"&Session("member")&"' ) ) "
			 
'			 Response.write sql1
			 lngDataCnt1 = f_sql_select(db_conn, sql1, arrData1)
				If lngDataCnt1 > 0 Then 
%>
			<tr>
              <td colspan="2">Total Sum</td>
              <td><%=FormatNumber(arrData1(0, 0), 2)%></td>
              <td><%=FormatNumber(arrData1(1, 0), 2)%></td>
			  <td><%=FormatNumber(arrData1(11, 0), 2)%></td>
			  
              <td><%=FormatNumber(arrData1(2, 0), 2)%></td>
              <td><%=FormatNumber(arrData1(3, 0), 2)%></td>  
			  
<!--              <td><%=FormatNumber(arrData1(4, 0), 2)%></td>
              <td><%=FormatNumber(arrData1(6, 0), 2)%></td>   -->
              <td><%=FormatNumber(arrData1(7, 0), 2)%></td>
<!--              <td><%=FormatNumber(arrData1(8, 0), 2)%></td>   -->
              </tr>
<%      	End if    
		End if
 %>	
			  
<% End if%>
                  </tfoot>
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
  <script src="js/demo/datatables-demo.js"></script>

	  
<script type="text/javascript" src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript" src="/myoffice/lib/jquery.ui.datepicker-ko.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />	  
