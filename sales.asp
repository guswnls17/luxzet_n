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
	menu1 = "산하매출"
	menu2 = "후원산하매출"

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
	
	page2 = request("page2")
	If page2 = "" Or page2 = "0" Then page2 = "1"

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
                            <input name="n_edate" id="i_edate" value="<%=n_edate%>"  readonly class="form-control col-md-4">
                            <button type="button" onclick="document.frmMain.submit();" class="btn btn-info ml-2"><%=language(lan,36)%></button>
                        </div>
                    </div>
                </form>
                <hr class="mt-4 mb-4">
                <p><strong class="text-danger">
<%
	n_sdate=Replace(n_sdate,"-","")
	n_edate=Replace(n_edate,"-","")
	
sql = "SELECT	"
sql = sql& "sum(sale_kum) "									
sql = sql& "FROM	mem_hdown,		"
sql = sql& "mmember,		"
sql = sql& "sale02		"
sql = sql& "WHERE	( mem_hdown.down_down = mmember.mem_code ) and	sale02.sale_date > '20190800' and	"
sql = sql& "( mmember.mem_code = sale02.sale_mem_code ) and		"
sql = sql& "( ( sale02.sale_date >= '"&n_sdate&"' and sale02.sale_date <= '"&n_edate&"' ) and		"
sql = sql& "( mem_hdown.down_member = '"&Session("member")&"') )	"
' response.write sql
Call f_sql_select(db_conn, sql, arrData)
If arrData(0,0) <> "" Then 
	response.write language(lan,85)&"</strong> : "& FormatNumber(arrData(0,0),0)
Else
	response.write language(lan,85)&"</strong> : 0"
End If
%>				
				</p>
            </div>
        </div>
      </div>
    </div>
        <div class="row mt-4 mb-5">
      <div class="col-lg-12">
        <div class="card">
<% 	

	If n_type = "0" Then 
		Dim hoo_code(10) '후원인 코드추출 후 A, B로 나눔
		sql = "select mem_code " _  
			& "from mmember " _
			& "where mem_hoo_code='"&Session("member")&"' and mem_code <> '0000000000' "

		lngDataCnt = f_sql_select(db_conn, sql, arrData)
		For i = 0 To lngDataCnt - 1 Step 1
			hoo_code(i)=arrData(0, i)
		Next
		
		If hoo_code(0) <> "" Then
		sql = "SELECT	sum(sale_kum), sum(sale_pvkum) as sale_pvkum "
		sql = sql& "FROM	mem_hdown,		"
		sql = sql& "mmember,		"
		sql = sql& "sale02		"
		sql = sql& "WHERE	( mem_hdown.down_down = mmember.mem_code ) and	sale02.sale_date > '20190800' and		"
		sql = sql& "( mmember.mem_code = sale02.sale_mem_code ) and		"
		sql = sql& "( ( sale02.sale_date >= '"&n_sdate&"' and sale02.sale_date <= '"&n_edate&"' ) and		"
		sql = sql& "( mem_hdown.down_member = '"&hoo_code(0)&"') )	"
		'sql = sql& "and mmember.mem_gubun='1'	"
		'sql = sql& "and sale02.sale_gubun='1'	"
		'Response.write sql
		lngDataCnt = f_sql_select(db_conn, sql, arrData)
		If arrData(0, 0) <> "" Then 
			Asum=FormatNumber(arrData(0, 0),0)
			Asum2=FormatNumber(arrData(1, 0),0)
		Else
			Asum=0
			Asum2=0
		End If
		
		sql = "SELECT	"
		sql = sql& " mem_nu_kum "									
		sql = sql& "FROM		"
		sql = sql& "mmember		"
		sql = sql& "WHERE	mem_code = '"&hoo_code(0)&"'	"
		' response.write sql
		Call f_sql_select(db_conn, sql, arrData)
		If arrData(0,0) <> "" Then 
			Asum3 =FormatNumber(arrData(0, 0),0)
		Else
			Asum3 =0
		End If
		
		sql = "SELECT	sale_date,	"
		sql = sql& "mem_code, "
		sql = sql& "mem_name,"      
		sql = sql& "sale_danga,"
		sql = sql& "sale_suryang, "
		sql = sql& "sale_kum,"
		sql = sql& "sale_pvkum,	"
		sql = sql& "sale_gubun,	"
		sql = sql& "sale_pankum	"
		sql = sql& "FROM	mem_hdown,		"
		sql = sql& "mmember,		"
		sql = sql& "sale02		"
		sql = sql& "WHERE	( mem_hdown.down_down = mmember.mem_code ) and	sale02.sale_date > '20190800' and		"
		sql = sql& "( mmember.mem_code = sale02.sale_mem_code ) and		"
		sql = sql& "( ( sale02.sale_date >= '"&n_sdate&"' and sale02.sale_date <= '"&n_edate&"' ) and		"
		sql = sql& "( mem_hdown.down_member = '"&hoo_code(0)&"') )	"
		sql = sql& " GROUP BY  mem_code, "           
		sql = sql& "	mem_name, "           
		sql = sql& "	sale_date, "            
		sql = sql& "	sale_danga, "           
		sql = sql& "	sale_suryang, "            
		sql = sql& "	sale_kum, "           
		sql = sql& "	sale_pvkum, "            
		sql = sql& "	sale_gubun,  "
		sql = sql& "	sale_pankum  "
		sql = sql& "	order by sale_date desc  "	
		'response.write sql
   
%>			
          <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg"><%=language(lan,29)%></h6>
          </div>
          <div class="table-title"><span><%=language(lan,86)%>: <%=FormatNumber(Asum,0)%></span><span> <%=language(lan,106)%>: <%=FormatNumber(Asum2,0)%></span> <span><%=language(lan,88)%> : <%=FormatNumber(Asum3,0)%></span></div>
          <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th><%=language(lan,73)%></th>
                      <th><%=language(lan,74)%></th>
                      <th><%=language(lan,90)%></th>
                      <th><%=language(lan,91)%></th>
                      <th><%=language(lan,92)%></th>
                      <th><%=language(lan,93)%></th>
                      <th><%=language(lan,94)%></th>
                      <th><%=language(lan,96)%></th>
                    </tr>
                  </thead>
                 <tbody>
<%
		lngDataCnt = f_sql_select(db_conn, sql, arrData)
		
		If lngDataCnt > 0 Then 
			pageCnt = UBound(arrData, 2) + 1
		Else
			Response.write "<tr><td height='100' colspan='8'>"&language(lan,37)&"</td></tr>"
		End If 

		For i = 0 To lngDataCnt - 1
		
		Select Case arrData(7, i)
			Case "0"
				Temp = "Cancel"
			Case "1"
				Temp = "Normalcy"
			Case "2"
				Temp = "Return"
			Case "3"
				Temp = "Exchange"
			Case "4"
				Temp = "Return Sales"
			Case "5"
				Temp = "Exchange sales"
		End select
%>				  
              <tr>
                <td><%=lngDataCnt - i%></td>
                <td><%=arrData(0, i)%></td>
                <td><%=arrData(1, i)%></td>
                <td><%=arrData(2, i)%></td>
                <td><%=FormatNumber(arrData(3, i), 0)%></td>
                <td><%=FormatNumber(arrData(4, i), 0)%></td>
                <td><%=FormatNumber(arrData(5, i), 0)%></td>
                <td><%=Temp%></td>
              </tr>
<%	Next    %>				  
                  </tbody>
                </table>
              </div>
            </div>
<% 		
		End If
		If hoo_code(1) <> "" Then
		
			sql = "SELECT	sum(sale_kum), sum(sale_pvkum) as sale_pvkum 	"
			sql = sql& "FROM	mem_hdown,		"
			sql = sql& "mmember,		"
			sql = sql& "sale02		"
			sql = sql& "WHERE	( mem_hdown.down_down = mmember.mem_code ) and	sale02.sale_date > '20190800' and		"
			sql = sql& "( mmember.mem_code = sale02.sale_mem_code ) and		"
			sql = sql& "( ( sale02.sale_date >= '"&n_sdate&"' and sale02.sale_date <= '"&n_edate&"' ) and		"
			sql = sql& "( mem_hdown.down_member = '"&hoo_code(1)&"') )	"
			'sql = sql& "and mmember.mem_gubun='1'	"
			'sql = sql& "and sale02.sale_gubun='1'	"
'			Response.write sql
			lngDataCnt = f_sql_select(db_conn, sql, arrData)
			If arrData(0, 0) <> "" Then 
				Bsum=FormatNumber(arrData(0, 0),0)
				Bsum2=FormatNumber(arrData(1, 0),0)
			Else
				Bsum=0
				Bsum2=0
			End If
		
			sql = "SELECT	"
			sql = sql& " mem_nu_kum "									
			sql = sql& "FROM		"
			sql = sql& "mmember		"
			sql = sql& "WHERE	mem_code = '"&hoo_code(1)&"'	"
			' response.write sql
			Call f_sql_select(db_conn, sql, arrData)
			If arrData(0,0) <> "" Then 
				Bsum3 =FormatNumber(arrData(0, 0),0)
			Else
				Bsum3 =0
			End If

			sql2 = "SELECT	sale_date,	"
			sql2 = sql2& "mem_code, "
			sql2 = sql2& "mem_name,"      
			sql2 = sql2& "sale_danga,"
			sql2 = sql2& "sale_suryang, "
			sql2 = sql2& "sale_kum,"
			sql2 = sql2& "sale_pvkum,	"
			sql2 = sql2& "sale_gubun,	"
			sql2 = sql2& "sale_pankum	"
			sql2 = sql2& "FROM	mem_hdown,		"
			sql2 = sql2& "mmember,		"
			sql2 = sql2& "sale02		"
			sql2 = sql2& "WHERE	( mem_hdown.down_down = mmember.mem_code ) and	sale02.sale_date > '20190800' and		"
			sql2 = sql2& "( mmember.mem_code = sale02.sale_mem_code ) and		"
			sql2 = sql2& "( ( sale02.sale_date >= '"&n_sdate&"' and sale02.sale_date <= '"&n_edate&"' ) and		"
			sql2 = sql2& "( mem_hdown.down_member = '"&hoo_code(1)&"') )	"
			sql2 = sql2& " GROUP BY  mem_code, "           
			sql2 = sql2& "	mem_name, "           
			sql2 = sql2& "	sale_date, "            
			sql2 = sql2& "	sale_danga, "           
			sql2 = sql2& "	sale_suryang, "            
			sql2 = sql2& "	sale_kum, "           
			sql2 = sql2& "	sale_pvkum, "            
			sql2 = sql2& "	sale_gubun,  "
			sql2 = sql2& "	sale_pankum  "
			sql2 = sql2& "	order by sale_date desc  "	
'			response.write sql
		   
		   ' sql = "EXEC sp_수당조회_마이오피스 '" & n_sdate & "', '" & n_edate & "', '" & Session("member") & "', '" & n_type & "' "

'			Response.write sql

			
			
			
'			Response.write Session("member") & ":" & hoo_code(1)
		
%>			
			<br/>
			<div class="table-title"><span><%=language(lan,89)%>: <%=FormatNumber(Bsum,0)%></span><span> <%=language(lan,106)%>: <%=FormatNumber(Bsum2,0)%></span> <span><%=language(lan,88)%> : <%=FormatNumber(Bsum3,0)%></span></div>
          <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable1" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th><%=language(lan,73)%></th>
                      <th><%=language(lan,74)%></th>
                      <th><%=language(lan,90)%></th>
                      <th><%=language(lan,91)%></th>
                      <th><%=language(lan,92)%></th>
                      <th><%=language(lan,93)%></th>
                      <th><%=language(lan,94)%></th>
                      <th><%=language(lan,96)%></th>
                    </tr>
                  </thead>
                 <tbody>
<%
	lngDataCnt2 = f_sql_select(db_conn, sql2, arrData2)


		If lngDataCnt2 > 0 Then 
			pageCnt2 = UBound(arrData2, 2) + 1
		Else
			Response.write "<tr><td height='100' colspan='8'>"&language(lan,37)&"</td></tr>"
		End If 
	
	For i = 0 To lngDataCnt2 - 1
	
	Select Case arrData2(7, i)
		Case "0"
			Temp = "Cancel"
		Case "1"
			Temp = "Normalcy"
		Case "2"
			Temp = "Return"
		Case "3"
			Temp = "Exchange"
		Case "4"
			Temp = "Return Sales"
		Case "5"
			Temp = "Exchange sales"
	End select
%>				  
              <tr>
                <td><%=lngDataCnt2 - i%></td>
                <td><%=arrData2(0, i)%></td>
                <td><%=arrData2(1, i)%></td>
                <td><%=arrData2(2, i)%></td>
                <td><%=FormatNumber(arrData2(3, i), 0)%></td>
                <td><%=FormatNumber(arrData2(4, i), 0)%></td>
                <td><%=FormatNumber(arrData2(5, i), 0)%></td>
                <td><%=Temp%></td>
              </tr>
<%	Next    %>				  
                  </tbody>
                </table>
              </div>
            </div>
<% 		End If
	End if  
%>	
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
  <script src="/js/demo/datatables-demo1.js"></script>

	  
<script type="text/javascript" src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript" src="/myoffice/lib/jquery.ui.datepicker-ko.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />	    