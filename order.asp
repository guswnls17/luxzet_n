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
        	<div class="pl-3 text-md font-weight-bold"><%=language(lan,35)%></div>
            <div class="card-search-body">
            	<form name="frmMain" method="post" action="<%=request.serverVariables("path_info")%>">
                    <div class="form-group mt-4 pl-3">
                        <div class="input-group">
                            <input class="form-control col-md-4" name="n_sdate" id="i_sdate" value="<%=n_sdate%>" readonly>
                            <p class="m-2 ml-3 mr-3"> ~ </p>
                            <input class="form-control col-md-4" id="i_edate" name="n_edate" value="<%=n_edate%>" readonly>
                            <button type="button" onclick="document.frmMain.submit();" class="btn btn-info ml-2"><%=language(lan,36)%></button>
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
              <h6 class="m-0 font-weight-bold text-lg"><%=language(lan,27)%></h6>
            </div>
          <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
<%
	
	n_sdate=Replace(n_sdate,"-","")
	n_edate=Replace(n_edate,"-","")

	page = request("page")
	If page = "" Or page = "0" Then page = "1"

    'sql    = "EXEC sp_회원_매출조회 '" & n_sdate & "', '" & n_edate & "', '" & Session("member") & "'"
	 sql   ="select	a.sale_date, a.sale_item, b.item_name, "
	 sql = sql& "a.sale_danga, a.sale_suryang, a.sale_kum, a.sale_pvkum, isnull(a.sale_cash, 0), isnull(a.sale_card, 0), isnull(a.sale_yekum, 0), isnull(a.sale_etc1, 0), "
	 sql = sql& "case a.sale_gubun	when '0' then 'Cancel' "
	 sql = sql& "			when '1' then 'Normalcy' "
	 sql = sql& "			when '2' then 'Return' "
     sql = sql& "			when '3' then 'Exchange' "
	 sql = sql& "			when '4' then 'Return Sales' "
	 sql = sql& "			when '5' then 'Exchange sales' "
	 sql = sql& "			when '6' then 'Waiting' else '' end,a.sale_sw , a.sale_pankum "
	 sql = sql& "from	sale02 a, citem b "
	 sql = sql& " where	a.sale_date between '" & n_sdate & "' and '" & n_edate & "'"
	 sql = sql& " and	a.sale_item = b.item_code and a.sale_date >= '20190800' "
	 sql = sql& " and	a.sale_mem_code = '" & session("member") & "' order by sale_number "
	 'sql = sql& " and	a.sale_gubun = '1' "
	'Response.write sql

	

%>					
                  <thead>
                    <tr>
                      <th><%=language(lan,73)%></th>
                      <th><%=language(lan,74)%></th>
                      <th><%=language(lan,75)%></th>
                      <th><%=language(lan,76)%></th>
                      <th><%=language(lan,77)%></th>
                      <th><%=language(lan,78)%></th>
                      <th><%=language(lan,79)%></th>
                      <th><%=language(lan,81)%></th>
                      <th><%=language(lan,82)%></th>
                      <th><%=language(lan,279)%></th>
                      <th><%=language(lan,280)%></th>
                    </tr>
                  </thead>
                  <tbody>
<%
		lngDataCnt = f_sql_select(db_conn, sql, arrData)

		If lngDataCnt > 0 Then 
			pageCnt = UBound(arrData, 2) + 1
		Else
			
			Response.write "<tr><td height='100' colspan='11'>"&language(lan,37)&"</td></tr>"
		End if
		
		For i = 0 To lngDataCnt - 1
		
		If arrData(12, i)= 1 Then
			repu = "Re-purchase"
		ElseIf arrData(12, i)= 2 Then
			repu = "Self Sale"
		Else
			repu = "New"
		End If
%>				  
                    <tr>
					  <td><%=lngDataCnt - i%></td>
					  <td><%=arrData(0, i)%></td>
					  <td><%=arrData(1, i)%></td>
					  <td><%=arrData(2, i)%></td>
					  <td><%=FormatNumber(arrData(3, i), 0)%></td>
					  <td><%=arrData(4, i)%></td>
					  <td><%=FormatNumber(arrData(5, i), 0)%></td>
		<!--              <td><%=FormatNumber(arrData(6, i), 0)%></td>   -->
					  <td><%=FormatNumber(arrData(7, i), 0)%></td>
					  <td><%=FormatNumber(arrData(9, i), 0)%></td>
					  <td><%=repu%></td>
					  <td><%=arrData(13, i)%></td>
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
  <script src="/js/demo/datatables-demo.js"></script>

	  
<script type="text/javascript" src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript" src="/myoffice/lib/jquery.ui.datepicker-ko.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />	  
