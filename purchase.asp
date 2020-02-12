<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->

<!--#include file="header.asp" -->
<style>
@media (max-width: 780px) {
	.ps{width:100px !important; }
	.tdp{padding:0.1rem !important; }
	.mxp{margin-left:0.1rem !important; }
}
</style>
<script type="text/javascript" src="/myoffice/lib/httpRequest.js"></script>
<script type='text/javascript' src='/myoffice/lib/jslib.js'></script>
<script type='text/javascript'>

function input_check(){
    var frm = document.frmMain;
	//alert("프로그램 점검중입니다."); return;
    if (frm.PayAmt.value == 0 || frm.PayAmt.value == '') {
        alert(coin_lang[27]); //제품을 선택하여 주세요.
        return false;
    }
	


//	if((!frm.delivery[0].checked) && (!frm.delivery[1].checked)) //라디오박스 체크
//	{

//			alert('Please select a payment method.'); //결제방법을 선택해 주세요.
//			frm.delivery[0].focus();
//	        return false;
//	}
	
//	if(frm.delivery[1].checked) //라디오박스 체크
//	{

//		if (frm.in_name.value == '') {
//		    alert('Please enter the Depositor`s Name.'); //입금자명을 입력해 주세요.
//			frm.in_name.focus();
//	        return false;
//		}
//	}

	/*if(frm.delivery[0].checked) //라디오박스 체크
	{
		if (frm.n_addr1.value == '') {
			alert('Please enter your shipping address.'); //배송지를 입력해 주세요.
			frm.n_addr1.focus();
	        return false;
		}
		
		if (frm.d_tel.value == '') {
			alert('Please enter the contact.'); //연락처를 입력해 주세요.
			frm.d_tel.focus();
	        return false;
		}

		if (frm.d_name.value == '') {
			alert('Please enter the recipient.'); //수령자를 입력해 주세요.
			frm.d_name.focus();
	        return false;
		}
	}*/


	var payamt = parseInt(frm.PayAmt.value.replace(/,/gi, ''));
	
	var emoney = parseInt(frm.e_wallet.value.replace(/,/gi, ''));
	
	var iomoney = parseInt(frm.io_wallet.value.replace(/,/gi, ''));
	
	var ps_ewallet = parseInt(frm.ps_ewallet.value.replace(/,/gi, ''));
	var ps_iowallet = parseInt(frm.ps_iowallet.value.replace(/,/gi, ''));
	
	if(emoney > ps_ewallet){
		alert(coin_lang[28]);
		return false;
	}

	
	if(iomoney > ps_iowallet){
		alert(coin_lang[34]);
		return false;
	}

	var checker = document.getElementsByName('group1');
	var str = frm.io_wallet.value.replace(/,/gi, '');
	str = str.replace( /(\s*)/g, "");
	
		for(var i=0;i<checker.length;i++){
          if(checker[i].checked==true){
              if(checker[i].value == "ewallet"){
				if (payamt != (emoney)){
					alert(coin_lang[29]);
					return false;
					}
				if(document.getElementById('ecpAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}
				if(document.getElementById('lxzAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}
			  }else if(checker[i].value == "io_wallet"){
				if (payamt != (iomoney)){
					alert(coin_lang[29]);
					return false;
					}
				if(document.getElementById('ecpAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}
				if(document.getElementById('lxzAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}
			  }else if(checker[i].value == "ecpcoin"){
				var bcoin = frm.ecp_code.value
				if (bcoin == ""){
					alert("Please enter the sender ecp address.");
					return false;
				}
				
				if(document.getElementById('ecpAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}
				if(document.getElementById('lxzAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}

				// ecp
				$('#pop_ecp_amt').text(document.getElementById('ecpAmt').value);
				$('#pop_ecp_kum').text(document.getElementById('ecp_kum').value);
				$('#pop_ecpexdate').text(document.getElementById('exchange_time').value);
				$('#pop_ecp_addr').text(document.getElementById('ecp_code').value);
				
				
				
				$("#popmain").hide();
				$("#popecp").show();
				return ;
			  }else if(checker[i].value == "lxzcoin"){
				var bcoin = frm.lxz_code.value
				if (bcoin == ""){
					alert("Please enter the sender lxz address.");
					return false;
				}
				
				if(document.getElementById('ecpAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}
				if(document.getElementById('lxzAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}

				// ecp
				$('#pop_lxz_amt').text(document.getElementById('lxzAmt').value);
				$('#pop_lxz_kum').text(document.getElementById('lxz_kum').value);
				$('#pop_lxzexdate').text(document.getElementById('exchange_time').value);
				$('#pop_lxz_addr').text(document.getElementById('lxz_code').value);
				
				
				
				$("#popmain").hide();
				$("#poplxz").show();
				return ;
			  }else{
				var bcoin = frm.bit_code.value
				if (bcoin == ""){
					alert(coin_lang[30]);
					return false;
				}
				
				if(document.getElementById('ecpAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}
				if(document.getElementById('lxzAmt').value == "Infinity"){
					alert("Please select a product again.");
					return false;
				}
				

				$('#pop_bit_amt').text(document.getElementById('bitAmt').value);
				$('#pop_bit_kum').text(document.getElementById('bit_kum').value);
				$('#pop_exdate').text(document.getElementById('exchange_time').value);
				$('#pop_bit_addr').text(document.getElementById('bit_code').value);
				
				$("#popmain").hide();
				$("#popbtc").show();
				return ;
				
			  }
          }
      }
	return true;
}

function save()
{
	//if(document.frmMain.Verification.value == ""){
	//	alert("Verification Code check");
	//	document.frmMain.Verification.focus();
	//	return;
	//}
	if (input_check()) {
		if (confirm(coin_lang[8])) { //현재 내용을 저장하시겠습니까?
			document.frmMain.command.value = 'save';
			 document.frmMain.submit();
		}
	}
}


function prod_check(k)
{
	var _prod = document.getElementById('_prod' + k);
	var _qty = document.getElementById('i_qty' + k);
	var frm = document.frmMain;
	if (_prod.checked){
		_qty.style.display = '';
	} else {
		_qty.style.display = 'none';
	}

	var cnt = parseInt(document.getElementById('i_prodCnt').value);
	var total = 0;
	var point = 0;
	var dollar = 0;

	for (var i = 0; i < cnt; i++)
	{
		var _prods = document.getElementById('_prod' + i);
		var _qtys = parseInt(document.getElementById('i_qty' + i).value);
		if (_prods.checked) {
			var prods = _prods.value.split('|');
			dollar += _qtys * parseInt(prods[1]);
			total += _qtys * parseInt(prods[2]);
			point += _qtys * parseInt(prods[3]);
		}
	}

	document.getElementById('i_payDollar').value = commaNum(dollar);
	
	
	document.getElementById('i_payAmt').value = commaNum(total);


	document.getElementById('i_point').value = commaNum(point);
		
	var bip = document.getElementById('bit_kum').value;
	document.getElementById('bitAmt').value = (total/bip).toFixed(8);	
	
	var epp = document.getElementById('ecp_kum').value;
	document.getElementById('ecpAmt').value = (total/epp).toFixed(4);	

	var lpp = document.getElementById('lxz_kum').value;
	document.getElementById('lxzAmt').value = (total/lpp).toFixed(4);	

//		if(frm.delivery[0].checked) 
//		{
//			frm.in_name.disabled = true;
//			var paystr=document.getElementById('i_payAmt').value;
//			var payAmt=paystr.replace(/,/gi, ""); 
			//payAmt=(payAmt*1)+(payAmt*0.08);
			//persent.innerHTML="(Gcoin: "+commaNum(payAmt)+"G)";
//		}

}

function use_payment() {
	var frm = document.frmMain;
	if(frm.delivery[0].checked) 
	{
		frm.in_name.disabled = true;
		var paystr=document.getElementById('i_payAmt').value;
		var payAmt=paystr.replace(/,/gi, ""); 
		//payAmt=(payAmt*1)+(payAmt*0.08);
		//persent.innerHTML="(Gcoin: "+commaNum(payAmt)+"G)";

	} else {
		frm.in_name.disabled = false;
		persent.innerHTML="";
	}
}

/*function sammember(zip1,hp1,addr1,addr2,name1) {
	var f = document.frmMain;
	//카드 배송전화번호
	if(f.dchk.checked) { 
		f.d_tel.value=hp1;
		f.n_zipno.value=zip1;
		f.n_addr1.value=addr1;
		f.n_addr2.value=addr2;
		f.d_name.value=name1;

	} else {
		f.d_tel.value="";
		f.n_zipno.value="";
		f.n_addr1.value="";
		f.n_addr2.value="";
		f.d_name.value="";
	}

}*/
function showKeyCode(event) {
	if (event.keyCode >= 48 && event.keyCode <= 57) { //숫자키만 입력
        return true;
    } else {
        event.returnValue = false;
    }
}

function checkRadio(){
	var checker = document.getElementsByName('group1');
	
	for(var i=0;i<checker.length;i++){
          if(checker[i].checked==true){
console.log(document.getElementById('e_wallet').readOnly);		  
              if(checker[i].value == "ewallet"){
				document.getElementById('e_wallet').readOnly = false ;
				document.getElementById('e_wallet').value = 0;
				document.getElementById('io_wallet').readOnly = true ;
				document.getElementById('io_wallet').value = 0;
				$("#ecpdeaddr").hide();
				$("#ecpseaddr").hide();
				$("#lxzdeaddr").hide();
				$("#lxzseaddr").hide();
				$("#btcdeaddr").hide();
			  }else if(checker[i].value == "io_wallet"){
				document.getElementById('e_wallet').readOnly = true ;
				document.getElementById('e_wallet').value = 0;
				document.getElementById('io_wallet').readOnly = false ;
				document.getElementById('io_wallet').value = 0;
				$("#ecpdeaddr").hide();
				$("#ecpseaddr").hide();
				$("#lxzdeaddr").hide();
				$("#lxzseaddr").hide();
				$("#btcdeaddr").hide();
			  }else if(checker[i].value == "ecpcoin"){
				document.getElementById('e_wallet').readOnly = true ;
				document.getElementById('e_wallet').value = 0;
				document.getElementById('io_wallet').readOnly = true ;
				document.getElementById('io_wallet').value = 0;
				$("#btcdeaddr").hide();
				$("#lxzdeaddr").hide();
				$("#lxzseaddr").hide();
				$("#ecpdeaddr").show();
				$("#ecpseaddr").show();
			  }else if(checker[i].value == "lxzcoin"){
				document.getElementById('e_wallet').readOnly = true ;
				document.getElementById('e_wallet').value = 0;
				document.getElementById('io_wallet').readOnly = true ;
				document.getElementById('io_wallet').value = 0;
				$("#btcdeaddr").hide();
				$("#ecpdeaddr").hide();
				$("#ecpseaddr").hide();
				$("#lxzdeaddr").show();
				$("#lxzseaddr").show();
			  }else{
				$("#ecpdeaddr").hide();
				$("#ecpseaddr").hide();
				$("#lxzdeaddr").hide();
				$("#lxzseaddr").hide();
				$("#btcdeaddr").show();
				document.getElementById('e_wallet').readOnly = true ;
				document.getElementById('e_wallet').value = 0;
				document.getElementById('io_wallet').readOnly = true ;
				document.getElementById('io_wallet').value = 0;
				
			  }
          }
      }
}
function freset(){
	document.frmMain.reset();
	return false;
}
function ecp_check(){
	
	sendRequest('getecpusd.php', "", f_ecp_check_reply, 'POST');
}

function f_ecp_check_reply(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
//			alert(httpRequest.responseText);
			var ret = httpRequest.responseText.split('|');
//			document.frmMain.bit_kum.value = httpRequest.responseText;
			$("#btce").text(ret[0]);
			var ecpusd = parseFloat(ret[0]/ret[1]).toFixed(5);
			$("#btcd").text(ecpusd);
			document.frmMain.ecp_kum.value = (ecpusd);
//			alert(ret[1]);
			lxz_check();
		}
	}
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

function bit_check(){
	sendRequest('getbitusd.php', "", f_bit_check_reply, 'POST');
}

function f_bit_check_reply(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
//			alert(httpRequest.responseText);
//			var ret = httpRequest.responseText.split('|');
			document.frmMain.bit_kum.value = httpRequest.responseText;
			$("#btcs").text(httpRequest.responseText);
//			alert(httpRequest.responseText);
			ecp_check();
		}
	}
	
}
function get_bitcode()
{
	var mem_id = document.frmMain.n_id;

	var params = 'n_id=' + encodeURIComponent(mem_id.value);
	sendRequest('getBitCode_r.php', params, f_getbitcode_reply_id, 'POST');
	//location.href="id_check.php?"+params;
}
function f_getbitcode_reply_id(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			console.log("return : " + httpRequest.responseText);
			var ret = httpRequest.responseText.split('|');
			if(ret[1].charAt(0) == "3"){
				document.frmMain.bit_code.value = ret[1];
				//alert(ret[1]);
				set_bitcode();
			}
		}
	}
}
function set_bitcode()
{
	var mem_id = document.frmMain.n_id;
	var bitaddr = document.frmMain.bit_code.value;

	var params = 'n_id=' + encodeURIComponent(mem_id.value) + '&bitaddr='+bitaddr;
	sendRequest('set_bitcode.asp', params, f_setbitcode_reply_id, 'POST');
	//location.href="id_check.php?"+params;
}
function f_setbitcode_reply_id(){
	if (httpRequest.readyState == 4){
		if (httpRequest.status == 200){
			console.log("return : " + httpRequest.responseText);
			var ret = httpRequest.responseText.split('|');
			if(ret[0] == "N"){
				alert("fail set bitaddress");
			}
//			document.frmMain.bit_code.value = ret[1];
			//alert(ret[1]);
		}
	}
}
bit_check();

function popcan(){
	$("#popbtc").hide();
	$("#popmain").show();
}
function popcan1(){
	$("#popecp").hide();
	$("#popmain").show();
}
function popcan2(){
	$("#poplxz").hide();
	$("#popmain").show();
}
function popsave(){
	if (confirm(coin_lang[8])) { //현재 내용을 저장하시겠습니까?
		document.frmMain.command.value = 'save';
		 document.frmMain.submit();
	}
}

function commaNum(num) {  
	var len, point, str;  

	num = num + "";  
	point = num.length % 3  
	len = num.length;  

	str = num.substring(0, point);  
	while (point < len) {  
		if (str != "") str += ",";  
		str += num.substring(point, point + 3);  
		point += 3;  
	}  
	return str;  
}  
</script>

<%
	menu1 = "제품구매"
	menu2 = "제품주문"

    sql = "select isnull(mem_rewards, 0), isnull(mem_ye_kum, 0), mem_wbit_code, mem_id " _
		& "from mmember " _
		& "where mem_code = '" & session("member") & "' "
	
	io_wallet = 0
	emoney = 0
	n_wbit_code = ""
	n_mem_id = ""
	If f_sql_select(db_conn, sql, arrData) > 0 Then
		io_wallet = arrData(0, 0)
		emoney = arrData(1, 0)
		n_wbit_code = arrData(2, 0)
		n_mem_id = arrData(3, 0)
	End if
	
	sy = Year(Date)
	sm = Month(Date)
	sd = Day(Date)

	 if(Len(sm) = 1 ) then sm = "0" & sm
	 if(Len(sd) = 1 ) then sd = "0" & sd
	 
	  now_hour   = right("0" & hour(now), 2)
	now_minute = right("0" & minute(now), 2)
	now_second = right("0" & second(now), 2)
	
	nowtime = sy &""& sm &""& sd &""& now_hour &""& now_minute &""& now_second
	
	rcvaddr = ""
	lxzaddr = ""
	sql = "select comp_addr1, comp_addr2 from ccompany    " 
	If f_sql_select(db_conn, sql, arrData) > 0 Then
		rcvaddr = arrData(0, 0)
		lxzaddr = arrData(1, 0)
	End If 
%>

<!-- Begin Page Content -->
      <div class="container-fluid" id = "popmain">
        <div class="card">
    		<div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-lg"><%=language(lan,26)%></h6>
            </div>
          <div class="card-body">
            <div class="table">
              <table class="table" width="100%" cellspacing="0">
                <colgroup>
                <col width="20%">
                <col width="*">
                </colgroup>
                <form name='frmMain' method='post' action='./order/ordersignup_proc_te.asp' onsubmit='return input_check();' target='hiddenprocess'>
<input type='hidden' name='command'>	
                  <tbody>
                    <tr>
                      <th class="border-0 tdp"><%=language(lan,63)%></th>
                      <td class="border-0 tdp">
						<input type='hidden' name='ps_ewallet' id='ps_ewallet' value='<%=emoney%>' >
						<span class="d-block"><%=FormatNumber(emoney, 2)%>  <%=language(lan,52)%> </span> 
						<input type='hidden' name='ps_iowallet' id='ps_iowallet' value='<%=FormatNumber(io_wallet, 2)%>'>
						<span class="d-block"><%=FormatNumber(io_wallet, 2)%> <%=language(lan,264)%> </span> 
						<input type='hidden' name='bit_kum' id='bit_kum' value=''>
						<input type='hidden' name='ecp_kum' id='ecp_kum' value=''>
						<input type='hidden' name='lxz_kum' id='lxz_kum' value=''>
<input type='hidden' name='n_id' id='n_id' value='<%=n_mem_id%>'>
<input type='hidden' name='exchange_time' id='exchange_time' value='<%=nowtime%>'>
						<span class="d-block" style="display:none !important;" >1 ecp = <span id="btce"> </span> krw</span>
						<span class="d-block" style="display:none !important;" >1 ecp = <span id="btcd"> </span> usd</span>
						<span class="d-block" >1 lxz = <span id="btcl"> </span> krw</span>
						<span class="d-block" >1 lxz = <span id="btcx"> </span> usd</span>
						<span class="d-block" >1 btc = <span id="btcs"> </span></span>
					</td>
                    </tr>
                    <tr>
                      <th class="br-g bb-g tdp"><%=language(lan,64)%></th>
                      <td class="tdp"><div class="form-group mb-0 ml-4 mxp">
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

	For i = 0 To lngDataCnt - 1 Step 1
%>						  
                          <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" name='_product<%=i%>' id='_prod<%=i%>' value='<%=arrData(0, i) & "|" & arrData(2, i) & "|" & arrData(3, i) & "|" & arrData(4, i)%>' onclick='prod_check(<%=i%>);'>
                            <label class="custom-control-label" for='_prod<%=i%>'><%=arrData(1, i)%></label>
                            <span><%=arrData(5, i)%><%=FormatNumber(arrData(3, i), 0)%></span>
                            <select name='n_qyt<%=i%>' id='i_qty<%=i%>' class="p-0 ml-2" onchange='prod_check(<%=i%>);' style='display:none;' class="p-0 ml-2 d-none">
								<option value='1'>1</option>
								<option value='2'>2</option>
								<option value='3'>3</option>
								<option value='4'>4</option>
								<option value='5'>5</option>
								<option value='6'>6</option>
								<option value='7'>7</option>
								<option value='8'>8</option>
								<option value='9'>9</option>
								<option value='10'>10</option>
                            </select>
                          </div>
						  <%
	Next

	 sql = "select mem_code " _
		& "from mmember " _
		& "where (mem_hoo_code = '" & session("member") & "' or mem_choo_code= '" & session("member") & "')"
	
	lngDataCnt2 = f_sql_select(db_conn, sql, arrData)
	For i = 0 To lngDataCnt2 - 1 Step 1
			If i = 0 Then 'i=0 이면 콤마 없음
				addinqur="'"
			Else
				addinqur=",'"
			End If
			inqur=inqur&addinqur&arrData(0, i)&"'" '쿼리 in을 하기위해 붙임
	Next
			
	If inqur <> "" Then
		'후원인 매출이 한건이라도 있는지 채크
		sql = "select count(*) " _  
			& "from sale02 " _
			& "where sale_mem_code in ("&inqur&") "

		If f_sql_select(db_conn, sql, arrData) > 0 Then
			total_choo = arrData(0, 0)
		End If
	End If
	
%>
						<input type='hidden' name='prod_cnt' id='i_prodCnt' value='<%=lngDataCnt%>'>	
                        </div></td>
                    </tr>
                    <tr>
                      <th class="br-g bb-g tdp"><%=language(lan,65)%></th>
                      <td class="tdp">
                      	<div class="input-group">
							<input type='hidden' name='PayDollar' id='i_payDollar' value='0' size='12' style='text-align:right' readonly>
	                      <label for="" class="pt-2">$</label>                       
                          <input type="text" name='PayAmt' id='i_payAmt' value='0' readonly class="form-control col-md-2 ml-1">
						  <input type="hidden" name='Point' id='i_point' value='0' readonly />
                          <input type="text" name='ecpAmt'  style="display:none !important;" id='ecpAmt' value='0' readonly class="form-control col-md-2 ml-1">   
 	                      <label for=""  style="display:none !important;" class="ml-1 pt-2"> ecp</label>
						</div>
						<div class="input-group">
						  <input type="text" name='lxzAmt' id='lxzAmt' value='0' readonly class="form-control col-md-2 ml-1">   
 	                      <label for="" class="ml-1 pt-2"> lxz</label>
						  <input type="text" name='bitAmt' id='bitAmt' value='0' readonly class="form-control col-md-2 ml-1">   
 	                      <label for="" class="ml-1 pt-2"> btc</label>
                        </div>
                   </td>
                    </tr>
					<tr>
                      <th class="br-g bb-g tdp"><%=language(lan,66)%></th>
                      <td class="tdp"><select name='sale_sw' class="form-control">
                          <%If total_choo = 0 Then %><option value='0'><%=language(lan,154)%></option><%End If%>
						<option value='1'><%=language(lan,72)%></option>
						</select>
						<input type='hidden' name='delivery' value='1'>
						<input type="hidden" name='in_name' value=''/></td>
                    </tr>
                    <tr style="display:none;" id="ecpdeaddr">
                      <th class="br-g bb-g tdp">deposit ecp address</th>
                      <td class="tdp">
							<%=rcvaddr%>
					  </td>
                    </tr>  
					<tr style="display:none;" id="ecpseaddr">
                      <th class="br-g bb-g tdp">sender ecp address</th>
                      <td class="tdp">
						<input type="text" class="form-control" name='ecp_code' id='ecp_code' />
					  </td>
                    </tr>
					<tr style="display:none;" id="lxzdeaddr">
                      <th class="br-g bb-g tdp">deposit lxz address</th>
                      <td class="tdp">
							<%=lxzaddr%>
					  </td>
                    </tr>  
					<tr style="display:none;" id="lxzseaddr">
                      <th class="br-g bb-g tdp">sender lxz address</th>
                      <td class="tdp">
						<input type="text" class="form-control" name='lxz_code' id='lxz_code' />
					  </td>
                    </tr>					
					<tr style="display:none;" id="btcdeaddr">
                      <th class="br-g bb-g tdp">deposit bitcoin address</th>
                      <td class="tdp">
<% 
if LEN(n_wbit_code) < 30 or IsNull(n_wbit_code) then 
%>				  
					<input type="text" class="w-50 ps" name='bit_code' id='bit_code' readonly />
					<a href="javascript:get_bitcode();" class="btn btn-info ml-2">BITCOIN ADDR</a>
<% else %>
					<input type="text" class="form-control" name='bit_code' id='bit_code' value='<%=n_wbit_code%>' readonly />
<% end if %>					  
						
					  </td>
                    </tr>					
                    <tr>
                      <th class="br-g bb-g"><%=language(lan,69)%></th>
                      <td class="tdp"><div class="form-group mb-0 ml-4 mxp">
                        <div class="custom-control custom-radio">
                          <input type="radio" name='group1' class="custom-control-input" id="ewallet" value='ewallet' onchange="checkRadio();" >
                          <label class="custom-control-label" for="ewallet"></label>
                          <input type="text" name="e_wallet" id="e_wallet" value="0" readonly class="w-25 ps">
                          <label for=""><%=language(lan,52)%></label>
                        </div>
						<div class="custom-control custom-radio">
							  <input type="radio" name='group1' class="custom-control-input" id="bitcoin" value='bitcoin' onchange="checkRadio();" >
							  <label class="custom-control-label" for="bitcoin">bitCoin</label>
							</div>  
<!--						<div class="custom-control custom-radio">
							  <input type="radio" name='group1' class="custom-control-input" id="ecpcoin" value='ecpcoin' onchange="checkRadio();" >
							  <label class="custom-control-label" for="ecpcoin">ecpCoin</label>
							</div>   -->
						<div class="custom-control custom-radio">
							  <input type="radio" name='group1' class="custom-control-input" id="lxzcoin" value='lxzcoin' onchange="checkRadio();" >
							  <label class="custom-control-label" for="lxzcoin">lxzCoin</label>
							</div>
                        <div class="custom-control custom-radio">
                          <input type="radio" name='group1' class="custom-control-input" id="iowallet" value='io_wallet' onchange="checkRadio();" checked >
                          <label class="custom-control-label" for="iowallet"></label>
						  <input type="text" name="io_wallet" id="io_wallet" value="0"  class="w-25 ps">
                          <label for=""><%=language(lan,264)%></label>
                        </div>
						</div></td>
                    </tr>
                  </tbody>
                </form>
              </table>
            </div>
          </div>
		  <div class="text-center col-12">
                <div class="form-group">
                    <button type="button" onclick="save();" class="btn btn-warning btn-lg col-lg-3 mr-3"><i class="fa fa-check"></i><%=language(lan,144)%></button>
                    <button type="button" onclick="freset();" class="btn btn-primary btn-lg col-lg-3"><%=language(lan,71)%></button>
                </div>
             </div>
        </div>
      </div>
      <!-- /.container-fluid --> 
      <div id="popbtc" class="main-content" style="display:none;">		
		<div id="bonmun">	<center>
			<p style="background: rgba(255,255,255,.8);font-size: larger;">
				<%=language(lan,215)%>
			</p>
			<article class="article" style="text-align: center;padding: 10px 10px 10px 10px;">
        <table style="width: 97%;">
		    <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;"><%=language(lan,216)%></th>
			</tr>
			<tr>
			<td style="border:2px solid #bbb;" id="pop_bit_addr">
				<%=bit_addr%>
			</td>
		  </tr>
          <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;"><%=language(lan,217)%></th>
		    </tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_bit_amt">
					<%=bitAmt%>
				 </td>
          </tr>
		  <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;"><%=language(lan,218)%></th>
			</tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_bit_kum">
					<%=bit_kum%>
				 </td>
          </tr>
		  <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;"><%=language(lan,219)%></th>
			</tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_exdate">
					<%=exdate%>
				 </td>
          </tr>
        </table>
		<br/><br/>
		 <div class="row justify-content-center">
          <div class="col-xl-6 mb-4">
            <div class="row">
              <div class="col-xl-6 mb-1"> <a href="javascript:popsave();" class="btn btn-success btn-block btn-lg"> <%=language(lan,144)%> <i class="far fa-check-circle fs-lg"></i> </a> </div>
              <div class="col-xl-6"> <a href="javascript:popcan();" class="btn btn-primary btn-block btn-lg"> <%=language(lan,71)%> </a> </div>
            </div>
          </div>
        </div>
		</article>
		</center>
	  </div>
	</div>
	<div id="popecp" class="main-content" style="display:none;">		
		<div id="bonmun">	<center>
			<p style="background: rgba(255,255,255,.8);font-size: larger;">
				ECP coin deposit is valid for 6 hours from the submitted deposit request time. Otherwise, the request will be deleted and must submit again.
			</p>
			<article class="article" style="text-align: center;padding: 10px 10px 10px 10px;">
        <table style="width: 97%;">
		    <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">deposit ecpcoin address</th>
			</tr>
			<tr>
			<td style="border:2px solid #bbb;">
				<%=rcvaddr%> 
			</td>
		  </tr>
		  <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">sender ecpcoin address</th>
			</tr>
			<tr>
			<td style="border:2px solid #bbb;" id="pop_ecp_addr">
				<%=rcvaddr%>
			</td>
		  </tr>
          <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">ecp coin to pay</th>
		    </tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_ecp_amt">
					<%=bitAmt%>
				 </td>
          </tr>
		  <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">ECP coin exchange rate</th>
			</tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_ecp_kum">
					<%=bit_kum%>
				 </td>
          </tr>
		  <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">ECP coin exchange time</th>
			</tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_ecpexdate">
					<%=exdate%>
				 </td>
          </tr>
        </table>
		<br/><br/>
		 <div class="row justify-content-center">
          <div class="col-xl-6 mb-4">
            <div class="row">
              <div class="col-xl-6 mb-1"> <a href="javascript:popsave();" class="btn btn-success btn-block btn-lg"> <%=language(lan,144)%> <i class="far fa-check-circle fs-lg"></i> </a> </div>
              <div class="col-xl-6"> <a href="javascript:popcan1();" class="btn btn-primary btn-block btn-lg"> <%=language(lan,71)%> </a> </div>
            </div>
          </div>
        </div>
		</article>
		</center>
	  </div>
	</div>
	<div id="poplxz" class="main-content" style="display:none;">		
		<div id="bonmun">	<center>
			<p style="background: rgba(255,255,255,.8);font-size: larger;">
				LXZ coin deposit is valid for 6 hours from the submitted deposit request time. Otherwise, the request will be deleted and must submit again.
			</p>
			<article class="article" style="text-align: center;padding: 10px 10px 10px 10px;">
        <table style="width: 97%;">
		    <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">deposit LXZcoin address</th>
			</tr>
			<tr>
			<td style="border:2px solid #bbb;">
				<%=lxzaddr%> 
			</td>
		  </tr>
		  <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">sender LXZcoin address</th>
			</tr>
			<tr>
			<td style="border:2px solid #bbb;" id="pop_lxz_addr">
				<%=lxzaddr%>
			</td>
		  </tr>
          <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">LXZ coin to pay</th>
		    </tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_lxz_amt">
					<%=bitAmt%>
				 </td>
          </tr>
		  <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">LXZ coin exchange rate</th>
			</tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_lxz_kum">
					<%=bit_kum%>
				 </td>
          </tr>
		  <tr>
				<th style="border:2px solid #bbb;text-align: center;font-size: x-large;">LXZ coin exchange time</th>
			</tr>
			<tr>
				<td style="border:2px solid #bbb;" id="pop_lxzexdate">
					<%=exdate%>
				 </td>
          </tr>
        </table>
		<br/><br/>
		 <div class="row justify-content-center">
          <div class="col-xl-6 mb-4">
            <div class="row">
              <div class="col-xl-6 mb-1"> <a href="javascript:popsave();" class="btn btn-success btn-block btn-lg"> <%=language(lan,144)%> <i class="far fa-check-circle fs-lg"></i> </a> </div>
              <div class="col-xl-6"> <a href="javascript:popcan2();" class="btn btn-primary btn-block btn-lg"> <%=language(lan,71)%> </a> </div>
            </div>
          </div>
        </div>
		</article>
		</center>
	  </div>
	</div>
	 <!--  popup -->
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