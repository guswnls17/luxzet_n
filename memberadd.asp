<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->

<!--#include file="header.asp" -->
<script type="text/javascript" src="/myoffice/lib/httpRequest.js"></script>
<script type='text/javascript'>

function save()
{

 var frm = document.frmMain;

	if (frm.n_id.value == '') {
        alert(coin_lang[2]); //아이디를 입력하세요. (5~16자).
        frm.n_id.focus();
        return;
    }
	
	if((frm.n_id.value).indexOf(" ") > -1){
		alert('Please remove the space.'); //공백을 제거해 주세요.
        frm.n_id.focus();
        return;
	}

	if (frm.chk_div.value != 'Y')	{
		alert(coin_lang[3]);  //아이디 중복체크를 하여 주십시오!
		return;
	}

	if (frm.n_recom_no.value == '') {
        alert(coin_lang[4]); //추천인을 입력해주세요.
        frm.n_recom_no.focus();
        return;
    }

    if (frm.n_spon_no.value == '') {
        alert(coin_lang[24]); //후원인을 입력해주세요.
        frm.n_spon_no.focus();
        return;
    }

	if (frm.n_pass.value == '') {
       alert(coin_lang[5]); //비밀번호를 입력해주세요.
        frm.n_pass.focus();
        return;
    }


    if (frm.n_name.value == '') {
        alert(coin_lang[25]); //성명을 입력해주세요.
        frm.n_name.focus();
        return;
    }
	
/*	if (frm.birth1.value == '') {
        alert("Please enter your birth(Month)."); //Month 입력해주세요.
        frm.birth1.focus();
        return;
    }
	if (frm.birth2.value == '') {
        alert("Please enter your birth(Date)."); //Date 입력해주세요.
        frm.birth2.focus();
        return;
    }
	if (frm.birth3.value == '') {
        alert("Please enter your birth(Year)."); //Year 입력해주세요.
        frm.birth3.focus();
        return;
    }
	
	if (frm.bank_name.value == '') {
       alert("Please enter your bank name."); //은행명.
        frm.n_bank_name.focus();
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
    } */
	var psef = frm.n_point.value.replace(",","");
	var esef = frm.n_ewallet.value.replace(",","");
	var presu = frm.pResult.value.replace(",","");
	
	var checker = document.getElementsByName('group1');
	
	for(var i=0;i<checker.length;i++){
          if(checker[i].checked==true){
				if(checker[i].value == "ewallet"){
//					alert("check e-wallet");
					if(Number(esef) < Number(presu)){
						alert(coin_lang[28]); // Amount.
						frm.payment_amount.focus();
						return;
					}
				}else{
//					alert("check point");
					if(Number(psef) < Number(presu)){
						alert(coin_lang[34]); // Amount.
						frm.payment_amount.focus();
						return;
					}
				}
		  }
	}
	
	
//	frm.mastercard.value = frm.n_masternum1.value + frm.n_masternum2.value + frm.n_masternum3.value + frm.n_masternum4.value;
	//frm.mastercard.value = frm.mastercardt1.value + frm.mastercardt2.value + frm.mastercardt3.value + frm.mastercardt4.value;
	//frm.mastercard2.value = frm.mastercards1.value + frm.mastercards2.value + frm.mastercards3.value + frm.mastercards4.value;

	cmsg=coin_lang[8];
	if (confirm(cmsg)) { //현재 내용을 저장하시겠습니까?


		 document.frmMain.submit();
				
		

	}else{
		return;
	}

}

function mem_search(mem_no, mem_nm, gubun)
{
	mem_no.value = '';
	mem_nm.value = '';

	var url = 'recommender.asp?no=' + mem_no + '&nm=' + mem_nm;

	var popup = window.open('./recommender.asp?gubun='+gubun, '_blank', 'width=520,height=455,scrollbars=no,status=no,menubar=no');

	if (!popup)
		alert('Please allow a blocked pop-up window.');
	else
		popup.focus();
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
	sendRequest('./member/id_check.asp', params, f_dupcheck_reply, 'POST');
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

function Fn_text(obj){
	var frm = document.frmMain;
	frm.pResult.value = obj;
}

function setBankName(){	
	var strBankName = document.frmMain.n_bank_code.value;
	
	if(strBankName != ""){
		//alert(strBankName);
		var strPbank = strBankName.split('|');
		document.frmMain.n_bank_name.value = strPbank[1];
	}
}

function setSelected(selectobj){
	var optcnt = document.frmMain.n_agency.options.length;
	
	for(var i =0 ; i < optcnt; i++){
	     if(document.frmMain.n_agency.options[i].value == selectobj) {
	          document.frmMain.n_agency.options[i].selected = true;
	          break;
	    }
	}
}
function freset(){
	document.frmMain.reset();
	return false;
}

function lxz_check(){
	
	sendRequest('getlxzusd.php', "", f_lxz_check_reply, 'POST');
}

function f_lxz_check_reply(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
//			alert(httpRequest.responseText);
			var ret = httpRequest.responseText.split('|');
//			document.frmMain.bit_kum.value = httpRequest.responseText;
			$("#btcl").text(ret[0]);
			var lxzusd = parseFloat(ret[0]/ret[1]).toFixed(5);
			$("#btcx").text(lxzusd);
			document.frmMain.lxz_kum.value = (lxzusd);
//			alert(ret[1]);
		}
	}
}
lxz_check();
// window.open('popup.html', 'Referral search', 'width=580px, height=460px')
</script>

<%
	menu1 = "회원정보"
	menu2 = "내정보"

    sql = "SELECT mem_agency_code, A.mem_level_count, A.mem_name, A.mem_jumin, A.mem_date, a.mem_id, "
    sql = sql & "a.mem_pw, a.mem_home_tel, a.mem_hp_tel, a.mem_post, a.mem_addr1, a.mem_addr2, a.mem_email, "
	sql = sql & "a.mem_bank_code, a.mem_bank_number, a.mem_yekumju, a.mem_pan_kum, a.mem_nu_kum,a.mem_choo_code,a.mem_nation,a.mem_ye_kum,a.mem_card_num,a.mem_hoo_code,a.mem_pic, "
	sql = sql & "(SELECT level_name FROM CLEVEL WHERE LEVEL_CODE = A.mem_level_code ) level_name, mem_avatar_pay , mem_avatar_kum,  "
	sql = sql & " (SELECT isnull(sum(pay_quantity),0)  FROM re_point_sales where mem_code = a.mem_code) , mem_bank_name, mem_scode, mem_rcode,  mem_bcode ,  "
	sql = sql & " (select agency_name FROM cagency where agency_code = A.mem_agency_code),mem_acode, mem_coin_sw, mem_bid, mem_bid_addr, mem_sid, mem_sid_addr, mem_ename, isnull(mem_rewards, 0)  "
    sql = sql & "FROM mmember A "
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
		n_point = arrData(40, 0)
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
        <div class="card mb-5">
        	<div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg"><%=language(lan,275)%></h6>
            </div>
          <div class="row pl-4 pr-4">
            <div class="card-body col-lg-6 col-md-12">
			<form name="frmMain" method="post" action="newmemproc_r.asp" onsubmit="return input_check();" target='hiddenprocess'>
<input type='hidden' name='verificationcheck' value=""> 
<input type='hidden' name='cardcheck' value="">
<input type='hidden' name='command' value="join">
<input type='hidden' name='m_no' value="">
<input type='hidden' name='mem_code' value="">
<input type='hidden' name='mode' value="homereg">
              <div class="form-group">
                <label for="cc-payment" class="control-label mb-1"><%=language(lan,63)%></label>
				<input type="hidden" name="n_ewallet" id="n_ewallet" readonly value="<%=mem_ye_kum%>">
				<input type="hidden" name="n_point" id="n_point" readonly value="<%=n_point%>">
                <input type="text" name="x1"  readonly value="<%=mem_ye_kum%> E-wallet" class="form-control">
                <input type="text" name="x2"  readonly value="<%=n_point%> Point" class="form-control mt-1"> 
				<input type="hidden" name="btcl" id="btcl" readonly value="">
				<input type="hidden" name="btcx" id="btcx" readonly value="">
				<input type="hidden" name="lxz_kum" id="lxz_kum" readonly value="">
              </div>
              <div class="form-group">
                <label for="n_id" class="control-label mb-1"><%=language(lan,38)%></label>
                <div class="input-group">
                  <input name="n_id" id="n_id"  type="text" class="form-control" aria-required="true" aria-invalid="false" value="">
				  <input type='hidden' name='chk_div' value='N'>
                  <button type="button" onclick="id_dubcheck();" class="btn btn-info ml-2"><%=language(lan,56)%></button>
                </div>
                <p>※ <%=language(lan,58)%>.</p>
              </div>
              <div class="form-group">
                <label for="i_pass" class="control-label mb-1"><%=language(lan,39)%></label>
                <input name='n_pass' id='i_pass' value='' type="password" class="form-control">
              </div>
              <div class="form-group">
                <label for="n_nation" class=" form-control-label"><%=language(lan,41)%></label>
                <select name='n_nation' id="n_nation" onchange="putItem();" class="form-control">
                 <%
						sql = "select nation_code, nation_scode, nation_kname from cnation where nation_ename = '1' order by nation_code"

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
                <label for="n_agency" class=" form-control-label"><%=language(lan,42)%></label>
                <select name="n_agency" id="n_agency" class="form-control">
                  
                </select>
              </div>
              <div class="form-group">
                <label for="member-name" class=" form-control-label"><%=language(lan,44)%></label>
                <input type="text" name="n_name" id="n_name" value="" class="form-control">
              </div>
              <div class="form-group">
                <label for="birth" class=" form-control-label"><%=language(lan,272)%></label>
                <div class="row form-group">
                  <div class="col col-md-2">
                    <input type="text" class="form-control" name='birth1' id='birth1' maxlength='2' value=''>
                  </div>
                  <p class="pt-2">/</p>
                  <div class="col col-md-2">
                    <input type="text" class="form-control" name='birth2' id='birth2' maxlength='2' value=''>
                  </div>
                  <p class="pt-2">/</p>
                  <div class="col col-md-2">
                    <input type="text" class="form-control" name='birth3' id='birth3' maxlength='4' value=''>
                  </div>
                  <p class="pt-2"></p>
                  <div class="col col-md-5 pt-2">(August 16, 1985 -> 08/16/1985)</div>
                </div>
              </div>
              <div class="form-group">
              <label for="birth" class=" form-control-label"><%=language(lan,45)%></label>
              <div class="row form-group">
                <div class="col col-md-2">
                  <input type="text" class="form-control" name='n_telnum' id='n_telnum' value=''>
                </div>
                <p class="pt-2">/</p>
                <div class="col col-md-7">
                  <input type="text" class="form-control" name='n_cellnum' id='i_cellnum' value=''>
                </div>
                <p class="ml-3">(country code/Mobile Number -> 82/01012341234)</p>
              </div>
          </div>
          </div>
          <div class="card-body col-lg-6 col-md-12">
			<div class="form-group">
                <label for="member-name" class=" form-control-label"><%=language(lan,46)%></label>
                <input type="email" class="form-control" name='n_email' id='i_email' value=''>
              </div>
            <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,120)%></label>
                <input name='n_addr1' id='n_addr1' value='' type="text" class="form-control" >
				<input type="hidden" name='n_bank_code' id='n_bank_code' value="|"/>
            </div>
           <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,47)%></label>
                <input name='bank_name' id='bank_name' type="text" class="form-control" value="">
            </div>
            <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,48)%></label>
                <input name='bank_number' id='bank_number' type="text" class="form-control" value="">
            </div>
            <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,49)%></label>
                <input name='mem_yekumju' id='mem_yekumju' type="text" class="form-control" value="">
            </div>
            <div class="form-group">
               <label for="n_recom_nm" class="control-label mb-1"><%=language(lan,53)%></label>
               <div class="input-group">
                 <input name='n_recom_nm' id='n_recom_nm' readonly type="text" class="form-control" aria-required="true" aria-invalid="false" >
				 <input type="hidden" name='n_recom_no' id='n_recom_no' readonly />
                 <button type="button" onclick='mem_search("frmMain.n_recom_no", "frmMain.n_recom_nm","a");' class="btn btn-info ml-2"><%=language(lan,60)%></button>
               </div>
            </div>
            <div class="form-group">
               <label for="n_spon_nm" class="control-label mb-1"><%=language(lan,54)%></label>
               <div class="input-group">
                 <input name='n_spon_nm' id='n_spon_nm' readonly type="text" class="form-control" aria-required="true" aria-invalid="false" >
				 <input type="hidden" name='n_spon_no' id='n_spon_no' />
                 <button type="button" onclick='mem_search("frmMain.n_spon_no", "frmMain.n_spon_nm","b");' class="btn btn-info ml-2"><%=language(lan,61)%></button>
               </div>
            </div>
            <div class="form-group">
               <label for="cc-payment" class="control-label mb-1"><%=language(lan,62)%></label>
               <div class="input-group">
                 <select name="payment_amount" onchange="Fn_text(this.value);" class="form-control col-md-3">
<%
		sql = "select item_code, item_name, item_mem_kum, item_sale_kum, item_pv_kum, item_danwe " _
			& " from citem " _
			& " where item_bigo='1' " 
		
		if session("userid") = "MONEYKING" then 
			sql = sql & " and item_web_state in ('1','2') "
		else
			sql = sql & " and item_web_state = '1' "
		end if
		lngDataCnt = f_sql_select(db_conn, sql, arrData)

		firstval = FormatNumber(arrData(3, 0), 0)
		For i = 0 To lngDataCnt - 1 Step 1
	%>	
						<option value="<%=FormatNumber(arrData(3, i), 0)%>"><%=arrData(1, i)%></option>
	<% 
		Next
	%>
                </select>
                <p class="pt-2 ml-2 mr-1">$</p> <input type="text" name="pResult" value="<%=FormatNumber(firstval, 0)%>" readonly class="form-control">
               </div>
            </div>
            <div class="form-group mb-0 ml-4">
                <div class="custom-control custom-radio">
                  <input type="radio" name='group1' class="custom-control-input" id="ewallet" value='ewallet'>
                  <label class="custom-control-label" for="ewallet"></label>
                  <label for=""><%=language(lan,107)%></label>
                </div>
                <div class="custom-control custom-radio">
                  <input type="radio" name='group1' class="custom-control-input" id="iowallet" value='io_wallet' checked>
                  <label class="custom-control-label" for="iowallet"><%=language(lan,264)%></label>
                </div>
             </div>
             
          
          </div>
          <div class="text-center col-12">
                <div class="form-group">
                    <button type="button" onclick="save();" class="btn btn-warning btn-lg col-lg-3 mr-3"><i class="fa fa-check"></i><%=language(lan,70)%></button>
                    <button type="button" onclick="freset();" class="btn btn-primary btn-lg col-lg-3"><%=language(lan,71)%></button>
                </div>
             </div>
             </form>
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

<script>
  var arrset = [
<%
						sql = "select agency_nation, agency_code, agency_name from cagency order by agency_code"

						lngDataCnt = f_sql_select(db_conn, sql, arrData)

						For i = 0 To lngDataCnt - 1
							Response.write "'" & Trim(arrData(0, i)) & "|" & "" & Trim(arrData(1, i)) & "|" & "" & Trim(arrData(2, i)) & "'," 
						next
					%>  
  ];
  
//  alert(arrset.length);
  
	function putItem(){
		//target 셀렉트박스의 아이템을 초기화(삭제)하는것은 생략한다.
		var nation = document.getElementById("n_nation");
		
		var setcode = nation.options[nation.selectedIndex].value;
		
		 var target = document.getElementById("n_agency");
		 
		 target.options.length = 0;
 
		  for (x in arrset) {
			if(setcode.split("|")[0] == arrset[x].split("|")[0]){
				var opt = document.createElement("option");
				opt.value = arrset[x].split("|")[1];
				opt.innerHTML = arrset[x].split("|")[2];
				target.appendChild(opt);
			}
		  } 

	}
	

	
	putItem();
  </script>  
<iframe name='hiddenprocess' style='display:none'></iframe>	  
  <!--#include file="footer.asp"-->