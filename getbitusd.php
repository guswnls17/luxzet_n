<?php

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
		echo "".$btcwon."";
		
	} else {
	   // 파일 open시 에러 발생
	}
	
?>