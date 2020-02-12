<?php

	$userid =  $_REQUEST["userid"];
	$txid = $_REQUEST["txid"];
	$amount = $_REQUEST["amount"];

	
	$btcwon = 0;
		

	if ($fp = fopen('https://blockchain.info/ticker', 'r')) {
	   $content = '';
	   // 전부 읽을때까지 계속 읽음
	   while ($line = fread($fp, 1024)) {
		  $content .= $line;
	   }
	   $json_o = json_decode($content, true);

		
		$usdcoin = $json_o['USD'];
		
		// echo "usdcoin : ". $usdcoin[0];
		unset( $usdcoin[0] );
		$btcwon = current($usdcoin);
//		echo "btcwon : ".$btcwon."<br/>";
		
	} else {
	   // 파일 open시 에러 발생
	}
	
	$usd = 0;
	$lxzprice = 0;

	if ($fp = fopen('https://quotation-api-cdn.dunamu.com/v1/forex/recent?codes=FRX.KRWUSD', 'r')) {
	   $content = '';
	   // 전부 읽을때까지 계속 읽음
	   while ($line = fread($fp, 1024)) {
		  $content .= $line;
	   }
	   $json_o = json_decode($content, true);
		
		$usdcoin1 = $json_o[0]['basePrice'];

		 $usd = $usdcoin1;
		unset( $usdcoin1[0] );
		
	} else {
	   // 파일 open시 에러 발생
	}
	
	if ($fp = fopen('https://v2data.coin2x.net/ticker_lxz', 'r')) {
	   $content = '';
	   // 전부 읽을때까지 계속 읽음
	   while ($line = fread($fp, 1024)) {
		  $content .= $line;
	   }
		
		 $lxzprice = $content;
		
	} else {
	   // 파일 open시 에러 발생
	}

		
		
//		echo " 요청 시작 !!<br/>";
		
        $URL = 'http://www.chainvit.net/saveBitcoin.asp';
        $ch = curl_init();
        curl_setopt ($ch, CURLOPT_URL, $URL);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 1);
        curl_setopt ($ch, CURLOPT_POST, 1);
        curl_setopt ($ch, CURLOPT_POSTFIELDS, 'userid='.$userid.'&txid='.$txid.'&amount='.$amount.'&btcwon='.$btcwon.'&ecpusd='.$usd.'&lxz='.$lxzprice);
        curl_setopt ($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
        $result = curl_exec ($ch);
        curl_close ($ch);

		echo $result;
		
	
?>
