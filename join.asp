<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>::<%=language(lan,0)%>::</title>

<!-- Custom fonts for this template-->
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/css/sb-admin-6.css" rel="stylesheet">
</head>

<script src="/vendor/jquery/jquery.min.js"></script> 
<script type="text/javascript" src="/myoffice/lib/httpRequest.js"></script>
<script type='text/javascript' src='/myoffice/lib/jslib.js'></script>
<script type="text/javascript" src="/myoffice/lib/langc<%=lan%>.js"></script>
<script type='text/javascript'>
function frmreset(){
	window.location.replace("join.asp");
}
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

//    if (frm.bit_code.value == '') {
//        alert("Please enter your BITCOIN ADDR."); //비트코인주소를 입력해주세요.
//        frm.bit_code.focus();
//        return;
//    }

	if (frm.n_pass.value == '') {
       alert(coin_lang[5]); //비밀번호를 입력해주세요.
        frm.n_pass.focus();
        return;
    }

	if (frm.n_pass.value != frm.n_pass2.value) {
		alert(coin_lang[6]); //두개의 비밀번호가 일치하지 않습니다!
		frm.n_pass2.focus();
		return;
	}

    if (frm.n_name.value == '') {
        alert(coin_lang[7]); //성명을 입력해주세요.
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
	
	if (frm.n_bank_name.value == '') {
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
    }
*/	
//	if (frm.verification.value == '') {
//       alert("Please enter your verification."); //verification.
//        frm.verification.focus();
//        return;
//    }else{
//		frm.pVerification.value = frm.verification.value
//	} 
	
	//frm.mastercard.value = frm.n_masternum1.value + frm.n_masternum2.value + frm.n_masternum3.value + frm.n_masternum4.value;
	//frm.mastercard.value = frm.mastercardt1.value + frm.mastercardt2.value + frm.mastercardt3.value + frm.mastercardt4.value;
	//frm.mastercard2.value = frm.mastercards1.value + frm.mastercards2.value + frm.mastercards3.value + frm.mastercards4.value;

	// verification_dubcheck();
	
	cmsg=coin_lang[8];
	if (confirm(cmsg)) { //현재 내용을 저장하시겠습니까?
		// get_bitcode();

		 document.frmMain.submit();
				
		

	}else{
		return;
	}

}

function mem_search(mem_no, mem_nm, gubun)
{
	eval(mem_no).value = '';
	eval(mem_nm).value = '';

	var url = 'recommender.asp?no=' + mem_no + '&nm=' + mem_nm;

	var popup = window.open('./recommender.asp?gubun='+gubun, '_blank', 'width=476,height=552,scrollbars=no,status=no,menubar=no');

	if (!popup)
		alert('Please allow a blocked pop-up window.');
	else
		popup.focus();
}

////////////////////////////////////////////         id_dubcheck

function id_dubcheck()
{
	var mem_id = document.frmMain.n_id;

	if (mem_id.value == ''){
		mem_id.focus();
		alert(coin_lang[2]); //아이디를 입력하세요. (5~16자).
		return;
	}
	var params = 'mem_id=' + encodeURIComponent(mem_id.value);
	sendRequest('id_check.asp', params, f_dupcheck_reply_id, 'POST');
	//location.href="id_check.php?"+params;
	
}
function f_dupcheck_reply_id(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			var ret = httpRequest.responseText.split('|');
			document.frmMain.chk_div.value = ret[0];
			alert(ret[1]);
		}
	}
	
}
////////////////////////////////////////////         id_dubcheck end



////////////////////////////////////////////         f_dupcheck_reply

function visa_dubcheck()
{	
	var frm = document.frmMain;
	// var mastercard = document.frmMain.mastercard;
	//frm.mastercard.value = frm.mastercardt1.value + frm.mastercardt2.value + frm.mastercardt3.value + frm.mastercardt4.value;
	if (frm.mastercard.value == ''){
		document.frmMain.cardcheck.value = "3"
		mastercard1.focus();
		return;
	}
	var params = 'visa_card_number=' + encodeURIComponent(frm.mastercard.value);
	sendRequest('visa_check.asp', params, f_dupcheck_reply, 'POST');
	//location.href="id_check.php?"+params;
}

function f_dupcheck_reply(){
	var mastercard = document.frmMain.mastercard;
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			var ret = httpRequest.responseText.split('|');
	
				document.frmMain.cardcheck.value = ret[0];

		}
	}
}
////////////////////////////////////////////         f_dupcheck_reply end

///////////////////////////////////////////////// verification_dubcheck

function verification_dubcheck()
{
	var verification = document.frmMain.verification;

	if (verification.value == ''){
		document.frmMain.verificationcheck.value = "3";
		verification.focus();
		return;
	}
	var params = 'ver_code=' + encodeURIComponent(verification.value);
	sendRequest('verification_check.asp', params, f_dupcheck_reply_verification, 'POST');
	//location.href="id_check.php?"+params;
}


function f_dupcheck_reply_verification(){
	var verification = document.frmMain.verification;
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			var ret = httpRequest.responseText;
			if(parseInt(ret) > 0){
				document.frmMain.verificationcheck.value = "1";
			}else{
				document.frmMain.verificationcheck.value = "0";

				if(document.frmMain.verificationcheck.value == "0"){
					//alert("verification Code Not Match");	
					verification.value = "";

					verification.focus();
					return;
				}
				
			}
		}
	}
}
///////////////////////////////////////////////// verification_dubcheck end

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
function setid(){
	document.frmMain.chk_div.value = "N";
}
</script>
<body class="bg-img-main">
<a href="login.asp">
<header class="register-header">
	<%=language(lan,0)%>
</header>
</a>
<div class="container-fluid">
  <div class="card mt-3">
    <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-lg"><%=language(lan,17)%></h6>
    </div>
    <div class="row ml-4 mr-4">
      <div class="card-body col-lg-6 col-md-12">
		<form name="frmMain" method="post" action="joinproc.asp" novalidate>	
			<input type='hidden' name='verificationcheck' value=""> 
			<input type='hidden' name='cardcheck' value="">
			<input type='hidden' name='command' value="join">
			<input type='hidden' name='m_no' value="">
			<input type='hidden' name='mem_code' value="">
			<input type='hidden' name='mode' value="homereg">
              <div class="form-group">
                <label for="n_id" class="control-label mb-1"><%=language(lan,38)%></label>
                <div class="input-group">
                  <input name='n_id' id='i_id' onchange="setid();" type="text" class="form-control" aria-required="true" aria-invalid="false">
                  <button type="button" onclick="id_dubcheck();" class="btn btn-info ml-2"><%=language(lan,56)%></button>
				  <input type='hidden' name='chk_div' value='N'>
                </div>
              </div>
              <div class="form-group">
                <label for="n_pass" class="control-label mb-1"><%=language(lan,11)%></label>
                <input name='n_pass' id='n_pass' type="password" class="form-control">
              </div>
              <div class="form-group">
                <label for="n_pass2" class="control-label mb-1"><%=language(lan,40)%></label>
                <input name='n_pass2' id='n_pass2' type="password" class="form-control">
              </div>
              <div class="form-group">
                <label for="select" class=" form-control-label"><%=language(lan,41)%></label>
                <select name="n_nation" id="n_nation" onchange="putItem();" class="form-control">
 <%
						sql = "select nation_code, nation_scode, nation_kname from cnation where nation_ename = '1' order by nation_code"

						lngDataCnt = f_sql_select(db_conn, sql, arrData)

						For i = 0 To lngDataCnt - 1
							Response.write "<option value='" & Trim(arrData(0, i)) & "|" & Trim(arrData(1, i)) & "'"
							If Trim(arrData(2, i)) = "KOREA" Then
							Response.write " selected>" & Trim(arrData(2, i)) & "</option>"
							else
							Response.write ">" & Trim(arrData(2, i)) & "</option>"
							End if
						next
					%>
                </select>
              </div>
              <div class="form-group">
                <label for="n_name" class=" form-control-label"><%=language(lan,44)%></label>
                <input type="text" class="form-control" name='n_name' id='n_name'>
              </div>
              <div class="form-group">
                <label for="birth" class=" form-control-label"><%=language(lan,272)%></label>
                <div class="row form-group">
                  <div class="col col-md-2">
                    <input type="text" class="form-control" id="birth1" name="birth1" maxlength="2">
                  </div>
                  <p class="pt-2">/</p>
                  <div class="col col-md-2">
                    <input type="text" class="form-control" id="birth2" name="birth2" maxlength="2">
                  </div>
                  <p class="pt-2">/</p>
                  <div class="col col-md-2">
                    <input type="text" class="form-control" id="birth3" name="birth3" maxlength="4">
                  </div>
                  <p class="pt-2"></p>
                  <div class="col col-md-5 pt-2">(August 16, 1985 -> 08/16/1985)</div>
                </div>
              </div>
              <div class="form-group">
              <label for="birth" class=" form-control-label"><%=language(lan,45)%></label>
              <div class="row form-group">
                <div class="col col-md-2">
                  <input class="form-control" type="tel" name='n_telnum' id='n_telnum'>
                </div>
                <p class="pt-2">/</p>
                <div class="col col-md-7">
                  <input class="form-control" type="tel" name='n_cellnum' id='i_cellnum'>
                </div>
                <p class="ml-3">(country code/Mobile Number -> 82/01012341234)</p>
              </div>
      </div>
    </div>
    <div class="card-body col-lg-6 col-md-12">
			<div class="form-group">
                <label for="member-name" class=" form-control-label"><%=language(lan,46)%></label>
                <input type="email" class="form-control" name='n_email' id='n_email'>
              </div>
            <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,120)%></label>
                <input name='n_addr1' type="text" class="form-control">
				<input type="hidden" name='n_bank_code' id='n_bank_code' value="|"/>
            </div>
           <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,47)%></label>
                <input name='n_bank_name' id='n_bank_name' type="text" class="form-control">
            </div>
            <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,48)%></label>
                <input name='bank_number' id='bank_number' type="text" class="form-control">
            </div>
            <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,49)%></label>
                <input name='mem_yekumju' id='mem_yekumju' type="text" class="form-control">
				<input type="hidden" name='bit_code' readonly  /></td>
            </div>
            <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,42)%></label>
				<select name="n_agency" id="n_agency" class="form-control">
                        
                      </select>
            </div>
<!--            <div class="form-group">
              <label for="" class="control-label mb-1">LXZ coin address</label>
                <input name="user-name" type="text" class="form-control" >
            </div>
            <div class="form-group">
              <label for="" class="control-label mb-1">Withdrawal bitcoin address</label>
                <input name="user-name" type="text" class="form-control" >
            </div>
            <div class="form-group">
              <label for="" class="control-label mb-1">E-Wallet</label>
               <input name="user-name" type="text" class="form-control" readonly>
            </div>  
			<div class="form-group">
              <label for="" class="control-label mb-1">Placement Code</label>
              <input name="user-name" type="text" class="form-control">
			</div>
			-->
            <div class="form-group">
              <label for="" class="control-label mb-1"><%=language(lan,53)%></label>
			  <div class="input-group">
				<input type="hidden" name='n_recom_no' id='n_recom_no' readonly />
				<input name='n_recom_nm' id='n_recom_nm' readonly type="text" class="form-control">
                 <button type="button" onclick='mem_search("frmMain.n_recom_no", "frmMain.n_recom_nm","a");' class="btn btn-info ml-2"><%=language(lan,168)%></button>
               </div>
            </div>
            
      
    </div>
    <div class="text-center col-12">
      <div class="form-group">
        <button type="button" onclick="save();" class="btn btn-danger btn-lg col-lg-3 mr-3"><i class="fa fa-check"></i><%=language(lan,7)%></button>
        <button type="button" onclick="frmreset();" class="btn btn-dark btn-lg col-lg-3"><%=language(lan,71)%></button>
      </div>
      </form>
    </div>
    <!-- .card --> 
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

    <!--#include file="footer.asp"-->