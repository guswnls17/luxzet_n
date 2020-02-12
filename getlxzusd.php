<?php
	
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
		
	} else {
	   // 파일 open시 에러 발생
	}
	
	if ($fp = fopen('https://v2data.coin2x.net/ticker_lxz', 'r')) {
	   $content = '';
	   // 전부 읽을때까지 계속 읽음
	   while ($line = fread($fp, 1024)) {
		  $content .= $line;
	   }
		
//		 echo "lxz price : ". $content;
		 $lxzprice = $content;
		
	} else {
	   // 파일 open시 에러 발생
	}
	
	echo $lxzprice."|".$usd;
	
?>