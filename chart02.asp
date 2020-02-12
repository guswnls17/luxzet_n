<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->
<!--#include file="header.asp" -->

<%
	
	menu1 = "조직현황"
	menu2 = "후원조직"

	Dim organ : organ = "recom"
	
%>		  
<script type="text/javascript" src="/myoffice/lib/httpRequest.js"></script>
<script type="text/JavaScript">
function reload() {
	var treeview = document.getElementById('treeview');
	var step = 3;		// document.getElementById('step').value;

	var member_no = document.frmMain.n_memno.value;


	member_no = (member_no == '') ? '<%=Session("member")%>' : member_no;

	treeview.src = './organize/treeview/treeview3.asp?memno1=<%=Session("member")%>&memno=' + member_no + '&organ=<%=organ%>&step=' + step;

	document.frmMain.n_memno.value = '';
	document.frmMain.n_memname.value = '';
}
function wideview(){
	var gn = document.getElementById('navi');
	var contw = document.getElementById('contw');
	var dis = document.getElementById('dis_article');
	if(gn.style.display=='none'){
		gn.style.display = 'block';
		contw.style.width = '1200px';
		dis.style.width = '860px';
	}else{
		gn.style.display = 'none';
		contw.style.width = '100%';
		dis.style.width = '100%';
	}

	
}
</script>	


<!-- Begin Page Content -->
      <div class="container-fluid">
      	<form name='frmMain'>
      <div class="card">
      	<div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg"><%=language(lan,33)%></h6>
            </div>
        <div class="m-2 pl-5 pb-2 pt-4">
            <div class="form-group">
              <div class="input-group">
                <a href="javascript:window.treeview.f_plus();" class="zoom-btn mr-2"><i class="far fa-plus-square"></i></a> 
                <a href="javascript:window.treeview.f_minus();" class="zoom-btn"><i class="far fa-minus-square"></i></a>
                <div class="input-group col-md-4 mt-2">
					<input type="hidden" name="n_memno" id="i_memno" readonly>
                    <input type="text" name="n_memname" id="i_memname" readonly class="form-control">
                    <div class="input-group-btn"><a onclick='window.open("./organize/membersearch.asp?no=frmMain.n_memno&nm=frmMain.n_memname&organ=<%=organ%>", "", "width=570,height=455,scrollbars=no,status=no,menubar=no");' class="btn btn-primary"><i class="fa fa-search"></i> <%=language(lan,112)%></a></div>
                </div>
<!--                <div class="input-group col-md-4 mt-2">
                	 <label for="" class="pt-2 mr-2"><%=language(lan,111)%></label>
                    <select id="step" class="form-control col-md-2">
                    <%
					For i = 2 To 50
						response.write "<option value=" & i
						If i = 4 Then response.write " selected"
						response.write ">" & i & "</option>"
					next
				%>
                </select>
                  <div class="input-group-btn"><button type="button" onclick="reload();" class="btn btn-info ml-2"><%=language(lan,36)%></button></div>
                </div>  -->
				<div style="width:100%;">
				  <table id="topc" style="float: right;margin-right: 2%;font-size: small;">
					<tr>
						<td><b style="color:#fe0000;">11000▲/</b></td>
						<td><b style="color:#ff8201;">10000▲/</b></td>
						<td><b style="color:#ffd701;">5000▲/</b></td>
						<td><b style="color:#006401;">3000▲/</b></td>
						<td><b style="color:#0000fe;">1000▲/</b></td>
						<td><b style="color:#17147f;">500▲/</b></td>
						<td><b style="color:#4b0081;">100▲</b></td>
					</tr>
				  </table>
				  <table id="tomobile" style="float: right;margin-right: 2%;font-size: small;">
					<tr>
						<td><b style="color:#fe0000;">11000▲/</b></td>
						<td><b style="color:#ff8201;">10000▲/</b></td>
						<td><b style="color:#ffd701;">5000▲/</b></td>
					</tr>
					<tr>
						<td><b style="color:#006401;">3000▲/</b></td>
						<td><b style="color:#0000fe;">1000▲/</b></td>
						<td><b style="color:#17147f;">500▲/</b></td>
						<td><b style="color:#4b0081;">100▲</b></td>
					</tr>
				  </table>
				</div>
              </div>
            </div>
        </div>
       </div>
      </form>
        <div class="chart-area" id="divtree">
              <!-- 이부분에 차트 삽입 -->
			  <iframe width="99%" height="100%" id='treeview' name='treeview' scrolling='no' frameborder='0'></iframe>
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

<script language="javascript">
var filter = "win16|win32|win64|mac";
var mp = 0;
if(navigator.platform){
	if(0 > filter.indexOf(navigator.platform.toLowerCase())){   // mobile
		$("#topc").hide();
		$("#tomobile").show();
		mp = 200;
	}else{
		$("#topc").show();
		$("#tomobile").hide();
	}
}
	var myWidth = 0, myHeight = 0;
    if (typeof (window.innerWidth) == 'number') { //Chrome
         myWidth = window.innerWidth;
         myHeight = window.innerHeight;
    } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
         myWidth = document.documentElement.clientWidth;
         myHeight = document.documentElement.clientHeight;
    } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) { //IE9
         myWidth = document.body.clientWidth;
         myHeight = document.body.clientHeight;
    }
	
	document.getElementById('treeview').style.height = (myHeight-300+ mp) + 'px';

	reload();
	
	if(myWidth > 1000){
	 $("#divtree").css("height","600px");
	}
</script>  
  <!--#inc   
  <!--#include file="footer.asp"-->