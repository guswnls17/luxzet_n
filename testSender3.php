<?php

	$param ["id"] = "test1008";
	$param ["tdatei"] = "20191008";
	$param ["sendaddr"] = "0x9014C876Cc5C48D47bC9dA7Ee8Fe979D41A81Abb";
	$param ["receaddr"] = "0x4Cead48cEf0d1B136e9937DC2Ed969318Dd2Ce31";
	$param ["amount"] = "4786.9794";
	$param ["price"] = "25.00000000";
	$param ["type"] = "3";
	$param ["use"] = 0;

	
//var_dump($param);
//echo "<br/>";

        $URL = 'http://www.chainvit.net/setReceiver.php';


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