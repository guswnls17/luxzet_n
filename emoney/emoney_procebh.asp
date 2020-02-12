<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<%

	memno = session("member")
	n_amount = CDbl(request("n_amount"))
	txid = request("txid")
	msg = request("msg")
	send_ebh_coin = request("send_ebh_coin")


	sql = "insert into ebhcoin (ebh_id, ebh_txid, ebh_sndaddr, ebh_bigo, ebh_coin, ebh_amount, ebh_senddate) values (" _
	    & "'" & session("userid") & "','" & txid & "','" & send_ebh_coin & "','" & msg & "'," & n_amount & "," & n_amount & ",convert(varchar(8), getdate(), 112) )" 
	
	If f_sql_modify(db_conn, sql) < 0 Then
		jsMessageBox "An error has occurred in the storage process. Contact your administrator."&sql, "", "document"
	End If
	

	
		jsMessageBox "The data has been saved.", "../ebhcoin.asp", "parent"
	



%>
