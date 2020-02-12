<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->

<!--#include file="header.asp" -->
<script type="text/javascript" src="/myoffice/lib/httpRequest.js"></script>
<script type='text/javascript'>

function input_check(){
	var frm = document.frmMain;

    if (frm.n_pass.value == '') {
        alert(coin_lang[5]); //비밀번호를 입력해주세요.
        frm.n_pass.focus();
        return false;
    }
	
	if (frm.n_pass.value != frm.n_pass2.value) {
			alert(coin_lang[20]); //두개의 비밀번호가 일치하지 않습니다!
			frm.n_pass2.focus();
			return false;
		}
		
 /*	if (frm.n_ename.value == '') {
        alert("Please enter your Nickname."); //비밀번호를 입력해주세요.
        frm.n_ename.focus();
        return false;
    }

   if (frm.n_telnum.value == '') {
        alert("전화번호를 입력해주세요.");
        frm.n_telnum.focus();
        return false;
    }*/

    /*if (frm.n_name.value == '') {
        alert("이름을 입력해주세요.");
        frm.n_name.focus();
        return false;
    }

	if (frm.n_jumin1.value == '' ||frm.n_jumin2.value == '' ||frm.n_jumin3.value == '') {
        alert("Please enter your birthday."); //생일을 입력해 주세요.
        frm.n_jumin1.focus();
        return false;
    }else{
		
	}*/

	frm.n_jumin.value = frm.n_jumin2.value + frm.n_jumin3.value + frm.n_jumin1.value;
	
	if (frm.n_cellnum.value == '') {
        alert(coin_lang[21]); //휴대폰번호를 입력해주세요.
        frm.n_cellnum.focus();
        return false;
    }
	
/*	if (frm.n_mem_bcode.value == '') {
       alert("Please enter your outside Veriteum Coin address."); //outside Veriteum Coin address명.
        frm.n_mem_bcode.focus();
        return;
    }
	
	if (frm.bank_number.value == '') {
       alert("Please enter your Account number."); //계좌번호.
        frm.bank_number.focus();
        return;
    }
	
	if (frm.mem_yekumju.value == '') {
       alert("Please enter your Account Holder."); //예금주.
        frm.mem_yekumju.focus();
        return;
    }
*/
    if (frm.re_pass.value != frm.n_pass.value) {
        alert(coin_lang[22]);
    }


	
	
//	frm.n_masternum.value = frm.n_masternum1.value + frm.n_masternum2.value + frm.n_masternum3.value + frm.n_masternum4.value;

/*    if (frm.n_addr1.value == '') {
        alert("주소를 입력해주세요.");
        frm.n_addr1.focus();
        return false;
    }

    if (frm.n_addr2.value == '') {
        alert("상세주소를 입력해주세요.");
        frm.n_addr2.focus();
        return false;
    }
*/

   /* if (frm.n_account.value == '') {
        alert("Please enter your account number."); //계좌번호를 입력해주세요.
        frm.n_account.focus();
        return false;
    }*/

	return true;
}

function save()
{
/*	if (/MSIE/.test(navigator.userAgent)) {
          document.charset = 'euc-kr';
    }
	
	if (/Mozilla/.test(navigator.userAgent)) {
          document.charset = 'euc-kr';
    }
*/
	if (input_check()) {
		if (confirm(coin_lang[8])) { ////현재 내용을 저장하시겠습니까?
			document.frmMain.command.value = "info";
			document.frmMain.submit();
		}
	}
	
}

function saveId() {
	
	var mem_id = document.frmMain.n_id;

	if (document.frmMain.chk_div.value != 'Y')	{
		alert(coin_lang[3]);  //아이디 중복체크를 하여 주십시오!
		return;
	}

	if (mem_id.value == ''){
		mem_id.focus();
		alert(coin_lang[2]); //아이디를 입력하세요. (5~16자).
		return;
	}
	if (confirm(coin_lang[23])) { //ID를 변경하시겠습니까?
		var params = 'command=idch&mem_id=' + encodeURIComponent(mem_id.value);
		//location.href='member/memberproc.asp?'+params;
		sendRequest('member/memberproc.asp', params, f_savechk, 'get');
	}



}

function f_savechk(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			var ret = httpRequest.responseText.split('|');
			document.frmMain.chk_div.value = ret[0];
			alert(ret[1]);
			if(ret[0] == "Y"){
				location.href='./login.asp';
			}
		}
	}
}

function id_dubcheck()
{
	var mem_id = document.frmMain.n_id;

	if (mem_id.value == ''){
		mem_id.focus();
		alert(coin_lang[2]); //아이디를 입력하세요. (5~16자).
		return;
	}
	var params = 'mem_id=' + encodeURIComponent(mem_id.value);
	sendRequest('./id_check.asp', params, f_dupcheck_reply, 'POST');
}

function f_dupcheck_reply(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			var ret = httpRequest.responseText.split('|');
			document.frmMain.chk_div.value = ret[0];
			alert(ret[1]);
		}
	}
}

function fnvc(obj){
	vc = document.frmMain;

	hiddenprocess.location.href = "vc_create_proc.asp?verCoin="+obj;
}

function fnvc_save(Verification){
	level = document.frmMain.level.value;
	kum = document.frmMain.kum.value;
	hiddenprocess.location.href = "vc_create_save.asp?ver_code="+Verification+"&kum="+kum+"&level="+level;
}
function Fn_text(Result,level){
	document.frmMain.level.value = level;
	document.frmMain.kum.value = Result;
}
function setBankName(){	
	var strBankName = document.frmMain.n_bank_code.value;
	
	if(strBankName != ""){
		//alert(strBankName);
		var strPbank = strBankName.split('|');
		document.frmMain.bank_name.value = strPbank[1];
	}
}	

function get_bitcode()
{
	var mem_id = document.frmMain.n_id;

	if (mem_id.value == ''){
		mem_id.focus();
		alert(coin_lang[2]); //아이디를 입력하세요. (5~16자).
		return;
	}
	var params = 'n_id=' + encodeURIComponent(mem_id.value);
	sendRequest('getBitCode.php', params, f_getbitcode_reply_id, 'POST');
	//location.href="id_check.php?"+params;
}
function f_getbitcode_reply_id(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			var ret = httpRequest.responseText.split('|');
			document.frmMain.bit_code.value = ret[1];
			//alert(ret[1]);
		}
	}
}

function get_ebhcode()
{
	var mem_id = document.frmMain.n_id;

	if (mem_id.value == ''){
		mem_id.focus();
		alert(coin_lang[2]); //아이디를 입력하세요. (5~16자).
		return;
	}
	var params = 'n_id=' + encodeURIComponent(mem_id.value);
	sendRequest('getEbhCode.php', params, f_getebhcode_reply_id, 'POST');
	//location.href="id_check.php?"+params;
}
function f_getebhcode_reply_id(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			var ret = httpRequest.responseText.split('|');
			document.frmMain.ebh_code.value = ret[1];
			//alert(ret[1]);
		}
	}
}
</script>

<%
	menu1 = "회원정보"
	menu2 = "내정보"

    sql = "SELECT mem_agency_code, A.mem_level_count, A.mem_name, A.mem_jumin, A.mem_date, a.mem_id, "
    sql = sql & "a.mem_pw, a.mem_home_tel, a.mem_hp_tel, a.mem_post, a.mem_addr1, a.mem_addr2, a.mem_email, "
	sql = sql & "a.mem_bank_code, a.mem_bank_number, a.mem_yekumju, a.mem_pan_kum, a.mem_nu_kum,a.mem_choo_code,a.mem_nation,a.mem_ye_kum,a.mem_card_num,a.mem_hoo_code,a.mem_pic, "
	sql = sql & "(SELECT level_name FROM CLEVEL WHERE LEVEL_CODE = A.mem_level_code ) level_name, mem_avatar_pay , mem_avatar_kum,  "
	sql = sql & " (SELECT isnull(sum(pay_quantity),0)  FROM re_point_sales where mem_code = a.mem_code) , mem_bank_name, mem_scode, mem_rcode,  mem_bcode ,  "
	sql = sql & " (select agency_name FROM cagency where agency_code = A.mem_agency_code),mem_acode, mem_coin_sw, mem_bid, mem_bid_addr, mem_sid, mem_sid_addr, mem_ename, mem_bit_code, mem_wbit_code, mem_eid_addr  "
    sql = sql & "FROM mmember_temp A "
    sql = sql & "WHERE 1=1 "
	sql = sql & "AND a.mem_id = '" & session("userid") & "'"

	If f_sql_select(db_conn, sql, arrData) > 0 Then
		n_center = arrData(0, 0)
		n_number = arrData(1, 0)
		n_name = arrData(2, 0)
		n_jumin = arrData(3, 0)
		n_jumin1 = RIGHT(n_jumin, 4)
		n_jumin2 = LEFT(n_jumin, 2)
		n_jumin3 = MID(n_jumin, 3, 2)
		n_regdate = arrData(4, 0)
		to_n_regdate = MID(n_regdate, 5, 2) & "/" & RIGHT(n_regdate, 2) & "/" & LEFT(n_regdate, 4)
		n_id = arrData(5, 0)
		n_pass = arrData(6, 0)
		n_telnum = arrData(7, 0)
		n_cellnum = arrData(8, 0)
		n_zipno = arrData(9, 0)
		n_addr1 = arrData(10, 0)
		n_addr2 = arrData(11, 0) & ""
		n_email = arrData(12, 0)
		n_bank = arrData(13, 0)
		n_account = arrData(14, 0)
		n_owner = arrData(15, 0)
		n_mem_pan_kum = arrData(16, 0)
		n_mem_nu_kum = arrData(17, 0)
		mem_choo_code = arrData(18, 0)
		mem_hoo_code = arrData(22, 0)
		mem_nation = arrData(19, 0)	
		mem_ye_kum = arrData(20, 0)	
		mem_card_num = arrData(21, 0)
		mem_pic = arrData(23, 0)
		mem_level = arrData(24, 0)
		mem_avatar_pay = arrData(25, 0)
		mem_avatar_kum = arrData(26, 0)
		rewards_point = arrData(27, 0)
		n_bank_name = arrData(28, 0)
		n_mem_scode = arrData(29, 0)
		n_mem_rcode = arrData(30, 0)
		n_mem_bcode = arrData(31, 0)
		n_agency_name = arrData(32, 0)
		n_mem_acode = arrData(33, 0)
		n_mem_coinsw = arrData(34, 0)
		n_mem_bid = arrData(35, 0)
		n_mem_bid_addr = arrData(36, 0)
		n_mem_sid = arrData(37, 0)
		n_mem_sid_addr = arrData(38, 0)
		n_ename = arrData(39, 0)							'주민등록 번호로 사용
		n_bit_code = arrData(40, 0)
		n_wbit_code = arrData(41, 0)
		n_ebh_code = arrData(42, 0)
	End If
	
	n_masternum1=""
	n_masternum2=""
	n_masternum3=""
	n_masternum4=""
	if LEN(n_addr2) > 1 then 
		n_masternum1= Mid(n_addr2,1,4)
		n_masternum2= Mid(n_addr2,5,4)
		n_masternum3= Mid(n_addr2,9,4)
		n_masternum4= Mid(n_addr2,13,4)
	end if 
	
%>

<!-- Begin Page Content -->
      <div class="container-fluid">
        <div class="card">
          <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg"><%=language(lan,275)%></h6>
            </div>
          <div class="row ml-4 mr-4">
            <div class="card-body col-lg-6 col-md-12">
              <form name="frmMain" method="post" action="./member/memberproc_re.asp" onsubmit="return input_check();" target='hiddenprocess'>
<input type='hidden' name='command'>
<input type='hidden' name='imgchk'>	
                <div class="form-group">
                  <label for="" class="control-label mb-1"><%=language(lan,38)%></label>
                  <div class="input-group">
                        <input name="n_id" id="n_id" value="<%=n_id%>" type="text" readonly class="form-control" aria-required="true" aria-invalid="false">
                  </div>
                  <p>※ <%=language(lan,58)%></p>
                </div>
                <div class="form-group">
                  <label for="i_pass" class="control-label mb-1"><%=language(lan,39)%></label>
                  <input name='n_pass' id='i_pass' value='<%=n_pass%>' type="password" class="form-control">
				  <input type="hidden" name='re_pass' id='re_pass' value='<%=n_pass%>' />
				  <input type="hidden" name='n_ename' id='i_ename' value='<%=n_ename%>' />
                </div>
                <div class="form-group">
                  <label for="i_pass2" class="control-label mb-1"><%=language(lan,40)%></label>
                  <input name='n_pass2' id='i_pass2' value='' type="password" class="form-control">
                </div>
                <div class="form-group">
                  <label for="select" class=" form-control-label"><%=language(lan,41)%></label>
                  <select name='n_nation' class="form-control">
                    <%
							sql = "select nation_code, nation_scode, nation_kname from cnation order by nation_code"

							lngDataCnt = f_sql_select(db_conn, sql, arrData)

							For i = 0 To lngDataCnt - 1
								'Response.write arrData(1, i)&"/"&mem_nation&"<br>"
								Response.write "<option value='" & Trim(arrData(0, i)) & "|" & Trim(arrData(1, i)) & "'"
								Response.write iif(Trim(arrData(0, i)) = Trim(mem_nation), " selected", "")
								Response.write ">" & Trim(arrData(2, i)) & "</option>"
							next
						%>
                  </select>
                </div>
                <div class="form-group">
                  <label for="belonging" class=" form-control-label"><%=language(lan,42)%></label>
                  <input type="text" readonly value="<%=n_agency_name%>" class="form-control">
                </div>
                <div class="form-group">
                  <label for="date" class=" form-control-label"><%=language(lan,43)%></label>
                  <input type="text" readonly value="<%=to_n_regdate%>" class="form-control">
                </div>
                <div class="form-group">
                  <label for="member-name" class=" form-control-label"><%=language(lan,44)%></label>
                  <input type="text" readonly value="<%=n_name%>" class="form-control">
                </div>
                <div class="form-group">
                  <label for="birth" class=" form-control-label"><%=language(lan,272)%></label>
                  <div class="row form-group">
                    <div class="col col-md-2">
					<input type="hidden" name='n_jumin' id='n_jumin' maxlength='8' value='<%=n_jumin%>' />
                      <input type="text" class="form-control" name='n_jumin2' id='n_jumin2' maxlength='2' value='<%=n_jumin2%>'>
                    </div>
                    <p class="pt-2">/</p>
                    <div class="col col-md-2">
                      <input type="text" class="form-control" name='n_jumin3' id='n_jumin3' maxlength='2' value='<%=n_jumin3%>'>
                    </div>
                    <p class="pt-2">/</p>
                    <div class="col col-md-2">
                      <input type="text" class="form-control" name='n_jumin1' id='n_jumin1' maxlength='4' value='<%=n_jumin1%>'>
                    </div>
                    <p class="pt-2"></p>
                    <div class="col col-md-5 pt-2">(August 16, 1985 -> 08/16/1985)</div>
                  </div>
                </div>
                <div class="form-group">
                <label for="birth" class=" form-control-label"><%=language(lan,45)%></label>
                <div class="row form-group">
                  <div class="col col-md-2">
                    <input type="text" class="form-control" name='n_telnum' id='n_telnum' value='<%=n_telnum%>'>
                  </div>
                  <p class="pt-2">/</p>
                  <div class="col col-md-7">
                    <input type="text" class="form-control" name='n_cellnum' id='i_cellnum' value='<%=n_cellnum%>'>
                  </div>
                  <p class="ml-3">(country code/Mobile Number -> 82/01012341234)</p>
                </div>
                <div class="form-group">
                  <label for="member-name" class=" form-control-label"><%=language(lan,46)%></label>
                  <input type="email" class="form-control" name='n_email' id='i_email' value='<%=n_email%>'>
                </div>
            </div>
          </div>
          <div class="card-body col-lg-6 col-md-12">
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,120)%></label>
                <input type="text" class="form-control" name='n_addr1' id='n_addr1' value='<%=n_addr1%>'>
				<input type="hidden" name='n_bank_code' id='n_bank_code' value="|"  style="width: 54.4%" />
				<input type="hidden" name='n_mem_sid' value='<%=n_mem_sid%>'  style="width: 54.4%" />
				<input type="hidden" name='n_mem_sid_addr' value='<%=n_mem_sid_addr%>' style="width: 100%" />
				<input type="hidden" name='n_mem_scode' value='<%=n_mem_scode%>'  style="width: 54.4%" />
              </div>
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,47)%></label>
                <input type="text" class="form-control" name='bank_name' value='<%=n_bank_name%>'>
              </div>
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,48)%></label>
                <input type="text" class="form-control" name='bank_number' value='<%=n_account%>'>
              </div>
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,49)%></label>
                <input type="text" class="form-control" name='mem_yekumju' value='<%=n_owner%>'>
              </div>
<!--              <div class="form-group">
                <label for="" class="control-label mb-1">Twice coin address</label>
                
              </div>  -->
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,276)%></label>
                <input type="text" class="form-control" name='n_mem_rcode' id="n_mem_rcode" value='<%=n_mem_rcode%>'>
              </div>
<!--			  <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,277)%></label>
                <input type="text" class="form-control" name='n_wbit_code' id="n_wbit_code" value='<%=n_wbit_code%>'>
              </div>  -->
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,210)%></label>
                <input type="text" class="form-control" name='bit_code' id="bit_code" value='<%=n_bit_code%>'>
              </div>
			  <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,278)%></label>
				<input type="text" class="form-control" name='n_mem_bcode' id="n_mem_bcode" value='<%=n_mem_bcode%>'>
              </div>
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,52)%></label>
                <input name="user-name" type="text" class="form-control" value='<% If mem_ye_kum <>"" Then Response.write FormatNumber(mem_ye_kum,2) Else Response.write "0" End If %>' readonly>
              </div>
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,53)%></label>
                <input name="user-name" type="text" class="form-control" value="<%=mem_choo_code%> (<%=get_membername(conn,mem_choo_code)%>)" readonly>
              </div>
              <div class="form-group">
                <label for="" class="control-label mb-1"><%=language(lan,54)%></label>
                <input name="user-name" type="text" class="form-control" value="<%=mem_hoo_code%> (<%=get_membername(conn,mem_hoo_code)%>)" readonly>
              </div>
            </form>
          </div>
          <div class="text-center col-12">
                <div class="form-group">
                    <button type="button" onclick="save();" class="btn btn-warning btn-lg col-lg-3 mr-3"><i class="fa fa-check"></i><%=language(lan,144)%></button>
                    <button type="button" onclick="freset();" class="btn btn-primary btn-lg col-lg-3"><%=language(lan,71)%></button>
                </div>
             </div>
          <!-- .card --> 
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