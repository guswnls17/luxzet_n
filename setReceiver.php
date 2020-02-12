<?php
/*
	echo $_REQUEST["id"];
	echo " | ".$_REQUEST["tdatei"];
	echo " | ".$_REQUEST["sendaddr"];
	echo " | ".$_REQUEST["receaddr"];
	echo " | ".$_REQUEST["amount"];
	echo " | ".$_REQUEST["price"];
	echo " | ".$_REQUEST["type"];
	echo " | ".$_REQUEST["use"];

echo "<br/> array1 : ";


$temp2 =unserialize(urldecode($_REQUEST["krw_list"]));

 $cnt = 0;
 $krwliststr = "";
foreach($temp2 as $value){

	if($cnt == 0){
		$krwliststr = $value['name'].",".$value['userid'].",".$value['in_price'].",".$value['in_time'];
	}else{
		$krwliststr = $krwliststr."|".$value['name'].",".$value['userid'].",".$value['in_price'].",".$value['in_time'];
	}
	$cnt++;
}
// echo $krwliststr;


// echo "<br/> array2 : ";
$temp3 =unserialize(urldecode($_REQUEST["trades_list"]));



 $cnt = 0;
 $tradesliststr = "";
foreach($temp3 as $value){
	if($cnt == 0){
		$tradesliststr = $value['type'].",".$value['krw_amt'].",".$value['coin_toal'].",".$value['coin_price'].",".$value['updated_dt'];
	}else{
		$tradesliststr = $tradesliststr."|".$value['type'].",".$value['krw_amt'].",".$value['coin_toal'].",".$value['coin_price'].",".$value['updated_dt'];
	}
	$cnt++;


}
*/
//echo $tradesliststr;
//echo "<br/>";
//echo "<br/>";
//echo "<br/>";
$krwliststr = "";
$tradesliststr = "";
// 전송 확인

	$usd = 0;
	$lxzprice = 0;

	if ($fp = fopen('https://quotation-api-cdn.dunamu.com/v1/forex/recent?codes=FRX.KRWUSD', 'r')) {
	   $content = '';
	   // 전부 읽을때까지 계속 읽음
	   while ($line = fread($fp, 1024)) {
		  $content .= $line;
	   }
	   $json_o = json_decode($content, true);

//		var_dump( $json_o[0]);
		
		$usdcoin = $json_o[0]['basePrice'];
		
//		 echo "basePrice : ". $usdcoin;
		 $usd = $usdcoin;
		unset( $usdcoin[0] );
//		$btcwon = current($usdcoin);
//		echo "btcwon : ".$btcwon."<br/>";
		
	} else {
	   // 파일 open시 에러 발생
	}
	
	if ($fp = fopen('https://v2data.coin2x.net/ticker_lxz', 'r')) {
	   $content = '';
	   // 전부 읽을때까지 계속 읽음
	   while ($line = fread($fp, 1024)) {
		  $content .= $line;
	   }
		
//		 echo "ecp price : ". $content;
		 $lxzprice = $content;
		
	} else {
	   // 파일 open시 에러 발생
	}



$URL = 'http://www.chainvit.net/setReceiver_r.asp';

$param ["id"] = $_REQUEST["id"];
$param ["tdatei"] = $_REQUEST["tdatei"];
$param ["sendaddr"] = $_REQUEST["sendaddr"];
$param ["receaddr"] = $_REQUEST["receaddr"];
$param ["amount"] = $_REQUEST["amount"];
$param ["price"] = $_REQUEST["price"];
$param ["type"] = $_REQUEST["type"];
$param ["use"] = $_REQUEST["use"];
$param ["krw_list"] = $krwliststr;
$param ["trades_list"] = $tradesliststr;
$param ["usd"] = $usd;
$param ["lxzprice"] = $lxzprice;



$ch = curl_init();                                 //curl 초기화
curl_setopt($ch, CURLOPT_URL, $URL);               //URL 지정하기
curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-type: multipart/form-data"));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);    //요청 결과를 문자열로 반환 
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);      //connection timeout 10초 
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);   //원격 서버의 인증서가 유효한지 검사 안함
curl_setopt ($ch, CURLOPT_POST, 1);
curl_setopt ($ch, CURLOPT_POSTFIELDS, $param);
 
$response = curl_exec($ch);
curl_close($ch);
 
 
var_dump($response);
?>