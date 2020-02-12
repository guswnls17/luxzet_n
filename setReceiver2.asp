<!-- #Include virtual = "/myoffice/lib/db.asp" -->

<%

Response.ContentType = "text/plain" 
Set uploadform = server.createobject("ABCUpload4.XForm")'XForm객체 생성

mem_id = uploadform("id")
mem_tdatei = uploadform("tdatei")
mem_sendaddr = uploadform("sendaddr")
mem_receaddr = uploadform("receaddr")
mem_amount = uploadform("amount")
mem_price = uploadform("price")
mem_type = uploadform("type")
mem_use = uploadform("use")
mem_krw_list = uploadform("krw_list")
mem_trades_list = uploadform("trades_list")
tpoint        = 0

If LEN(mem_amount) > 0 And LEN(mem_price) > 0 And LEN(mem_sendaddr) > 0 And LEN(mem_receaddr) > 0 Then
		tpoint = Cdbl(mem_amount) * (Cdbl(mem_price)/ 1300)
	End If 
	
	If LEN(mem_type) < 1 Then 
	  mem_type = "0"
	End If 
	
	If LEN(mem_use) < 1 Then 
	  mem_use = "0"
	End If 
	
	table = ""
	name = ""
	sqlst         = "select mem_id, mem_name  from mmember_temp where mem_id = '"&mem_id&"'" 
	If f_sql_select(db_conn, sqlst, arrData) > 0 Then
		table = "mmember_temp"
		name = arrData(1,0)
	End If 
	
	sqlst         = "select mem_id, mem_name  from mmember where mem_id = '"&mem_id&"'" 
	If f_sql_select(db_conn, sqlst, arrData) > 0 Then
		table = "mmember"
		name = arrData(1,0)
	End If 
	
	
	
	sy = Year(Date)
	sm = Month(Date)
	sd = Day(Date)

	 if(Len(sm) = 1 ) then sm = "0" & sm
	 if(Len(sd) = 1 ) then sd = "0" & sd
	 
	  now_hour   = right("0" & hour(now), 2)
	now_minute = right("0" & minute(now), 2)
	now_second = right("0" & second(now), 2)

	new_sy = Year(DateAdd("h",-6,now()))
	new_sm = Month(DateAdd("h",-6,now()))
	new_sd = Day(DateAdd("h",-6,now()))
	if(Len(new_sm) = 1 ) then new_sm = "0" & new_sm
	if(Len(new_sd) = 1 ) then new_sd = "0" & new_sd
	new_hour   = right("0" & hour(DateAdd("h",-6,now())), 2)
	new_minute = right("0" & minute(DateAdd("h",-6,now())), 2)
	new_second = right("0" & second(DateAdd("h",-6,now())), 2)
	
	idate = sy &""& sm &""& sd &""& now_hour &""& now_minute &""& now_second
	odate = new_sy &""& new_sm &""& new_sd &""& new_hour &""& new_minute &""& new_second
	
	If table = "" Then 
		mem_use = 0
	Else 
		mem_use = 1
	End If 
	
	sqlb = "select erc_seq, erc_amount, erc_hoocode, bit_sale_number, erc_memcode, erc_memid from purchase_erc2 where erc_iaddr = '"&mem_sendaddr&"' and erc_idate >= '" & odate & "' and erc_idate <= '" & idate & "' order by erc_seq "
	
	
	If f_sql_select(db_conn, sqlb, arrDatab) > 0 Then	
		mem_use = 0
	End If 
	
	sqlc = "select erc_seq, erc_amount, erc_hoocode, bit_sale_number, erc_memcode, erc_memid from purchase_erc where erc_iaddr = '"&mem_sendaddr&"' and erc_idate >= '" & odate & "' and erc_idate <= '" & idate & "' order by erc_seq "
	
	If f_sql_select(db_conn, sqlc, arrDatab) > 0 Then	
		mem_use = 0
	End If 
	
	
	Response.write mem_use
%>
