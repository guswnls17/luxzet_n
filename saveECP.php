<?php

	$price_usd =  $_REQUEST["price_usd"];		//(시세)
	$type = $_REQUEST["type"];		// ( ECP+)
	$from_address = $_REQUEST["from_address"];		//( 보낸 주소)
	$amunt = $_REQUEST["amunt"];		// ( 코인갯수 )
	if($amunt == ""){
		$amunt = $_REQUEST["amount"];		// ( 코인갯수 )
	}
	$hash = $_REQUEST["hash"];			// ( hash )

	
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
	

		
        $URL = 'http://www.chainvit.net/saveECP.asp';
        $ch = curl_init();
        curl_setopt ($ch, CURLOPT_URL, $URL);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 1);
        curl_setopt ($ch, CURLOPT_POST, 1);
        curl_setopt ($ch, CURLOPT_POSTFIELDS, 'price_usd='.$price_usd.'&type='.$type.'&from_address='.$from_address.'&amunt='.$amunt.'&hash='.$hash.'&ecpusd='.$usd.'&lxz='.$lxzprice);
        curl_setopt ($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
        $result = curl_exec ($ch);
        curl_close ($ch);

		echo $result;
		
	
?>
