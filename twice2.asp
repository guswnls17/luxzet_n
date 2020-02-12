<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->

<!--#include file="header.asp" -->

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

	linkurl =  request.serverVariables("path_info")&"?n_sdate=" & n_sdate & "&n_edate=" & n_edate & "&n_type=" & n_type

	page = request("page")
	If page = "" Or page = "0" Then page = "1"
	
	 sql = "SELECT isNull(mem_rcoin,0) , isNull(mem_acoin,0)  "
    sql = sql & "FROM mmember  "
    sql = sql & "WHERE 1=1 "
	sql = sql & "AND mem_id = '" & session("userid") & "'"

	If f_sql_select(db_conn, sql, arrData) > 0 Then
		mem_rcoin = arrData(0, 0)								'베리티움 총 보유코인
		mem_acoin = arrData(1, 0)								'베리티움 총 지급코인
		
	End If
	
	
	
	
%>	  

 <!-- Begin Page Content -->
      <div class="container-fluid">
      	<div class="row">
      <div class="col-lg-12">
        <div class="card p-4">
        	<div class="card-search-header"> <strong class="text-md font-weight-bold"><%=language(lan,35)%></strong> </div>
            <div class="card-search-body">
            	<form name="frmMain" method="post" action="<%=request.serverVariables("path_info")%>">
                    <div class="form-group mt-4">
                        <div class="input-group">
                            <input name="n_sdate" id="i_sdate" value="<%=n_sdate%>" readonly class="form-control col-md-4">
                            <p class="m-2 ml-3 mr-3"> ~ </p>
                            <input name="n_edate" id="i_edate" value="<%=n_edate%>" readonly class="form-control col-md-4">
                            <button type="button" onclick="document.frmMain.submit();" class="btn btn-info ml-2"><%=language(lan,36)%></button>
                        </div>
                    </div>
                </form>
                <hr class="mt-4 mb-4">
                <p><%=language(lan,113)%> : <strong class="text-danger"><%=FormatNumber(mem_rcoin,4)%></strong></p>
                <p>
<%  
	sql1 = "SELECT  CASE GBN WHEN '0' THEN 'Sales Coin' WHEN '2' THEN 'Available conversions' WHEN '9' THEN 'Allowance coin' ELSE '' END , ISNULL(SUM(PAY),0) "
	sql1 = sql1 & " FROM coin_stock_his2 WHERE MEM_CODE = '"&Session("member")&"' GROUP BY GBN "
	lngDataCnt1 = f_sql_select(db_conn, sql1, arrData1)
	If lngDataCnt1 > 0 Then 
		Response.write "("
	END If 
	For i = 0 To lngDataCnt1 - 1
		If i > 0 Then 
			Response.write ","
		END If 
		Response.write arrData1(0, i) & " : " & arrData1(1, i) & " "
	Next
	If lngDataCnt1 > 0 Then 
		Response.write ")"
	END If 
%>				
				</p>
                <p><%=language(lan,114)%> : <strong class="text-danger"><%=FormatNumber(mem_acoin,4)%></strong></p>
            </div>
        </div>
      </div>
    </div>
        <div class="row mt-4 mb-5">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg text-uppercase"><%=language(lan,281)%></h6>
          </div>
          
          <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th><%=language(lan,73)%></th>
                      <th><%=language(lan,115)%></th>
                      <th><%=language(lan,116)%></th>
                      <th><%=language(lan,117)%></th>
                      <th><%=language(lan,118)%></th>
                      <th><%=language(lan,119)%></th>
                    </tr>
                  </thead>
                  <tbody>
<% 	
	n_sdate=Replace(n_sdate,"-","")
	n_edate=Replace(n_edate,"-","")

	If n_type = "0" Then 

	sql = "SELECT	seq,	"
	sql = sql& "date, "
	sql = sql& "pay,"      
	sql = sql& "gbn,"
	sql = sql& "day_cnt "
	sql = sql& "FROM	coin_stock_his2		"
	sql = sql& "WHERE	mem_code='"&Session("member")&"' "
	sql = sql& " and date >= '"&n_sdate&"' and  date <= '"&n_edate&"' 		"
	sql = sql& "	order by seq desc  "	
	'response.write sql
   
   ' sql = "EXEC sp_수당조회_마이오피스 '" & n_sdate & "', '" & n_edate & "', '" & Session("member") & "', '" & n_type & "' "

	'Response.write sql

	lngDataCnt = f_sql_select(db_conn, sql, arrData)

	If lngDataCnt > 0 Then 
		pageCnt = UBound(arrData, 2) + 1
	Else
		Response.write "<tr><td height='100' colspan='6'>"&language(lan,37)&"</td></tr>"
	End If 
	
	For i = 0 To lngDataCnt - 1
	
	'"0":매출코인,"9":수당코인,"2":사용가능전환
	Select Case arrData(3, i)
		Case "0"
			Temp = "Sales Coin"
		Case "9"
			Temp = "Allowance coin"
		Case "2"
			Temp = "Available conversions"
	End select

%>			  
              <tr>
                <td><%=lngDataCnt - i%></td>
                <td><%=arrData(0, i)%></td>
                <td><%=arrData(1, i)%></td>
                <td><%=FormatNumber(arrData(2, i), 0)%></td>
                <td><%=Temp%></td>
                <td><%=FormatNumber(arrData(4, i), 0)%></td>
              </tr>
<%	Next    %>		
<% End if%>	                   
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
