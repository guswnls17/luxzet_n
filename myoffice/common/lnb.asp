<%
Select Case menu1
Case "회원정보"
%>
			<div id="lnb">
				<h2>회원정보</h2>
				<ul>
					<li><a href="memberinfo.asp" <%If menu2 = "내정보" Then Response.write " class='on'" End if%>>내정보</a></li>
					<li><a href="memberjoin.asp" <%If menu2 = "회원등록" Then Response.write " class='on'" End if%>>회원등록</a></li>
				</ul>
			</div>
<%
Case "제품구매"
%>
			<div id="lnb">
				<h2>제품주문</h2>
				<ul>
					<li><a href="ordersignup.asp" <%If menu2 = "제품주문" Then Response.write " class='on'" End if%>>제품주문</a></li>
				</ul>
			</div>
<%
Case "산하매출"
%>
			<div id="lnb">
				<h2>산하매출</h2>
				<ul>
					<li><a href="hAcount.asp" <%If menu2 = "후원산하매출" Then Response.write " class='on'" End if%>>후원 산하매출 현황</a></li>
				</ul>
				<ul>
					<li><a href="cAcount.asp" <%If menu2 = "추천산하매출" Then Response.write " class='on'" End if%>>추천 산하매출 현황</a></li>
				</ul>
			</div>
<%
Case "주문현황"
%>
			<div id="lnb">
				<h2>주문현황</h2>
				<ul>
					<li><a href="orderlist.asp" <%If menu2 = "주문조회" Then Response.write " class='on'" End if%>>주문조회</a></li>
					<!--<li><a href="ordersignup.asp" <%'If menu2 = "주문등록" Then Response.write " class='on'" End if%>>주문등록</a></li>-->
				</ul>
			</div>
<%
Case "수당팀현황"
%>
			<div id="lnb">
				<h2>수당팀현황</h2>
			</div>
<%
Case "수당현황"
%>
			<div id="lnb">
				<h2>수당현황</h2>
				<!--
				<ul style='display:none'>
					<li><a href="paylist.asp" <%'If menu2 = "수당조회" Then Response.write " class='on'" End if%>>수당조회</a></li>
					<li><a href="payweekly.asp" <%'If menu2 = "주간수당조회" Then Response.write " class='on'" End if%>>주간수당조회</a></li>
					<li><a href="downresult.asp" <%'If menu2 = "하부실적조회" Then Response.write " class='on'" End if%>>하부실적조회</a></li>
					<li><a href="takeback.asp" <%'If menu2 = "하부반품내역" Then Response.write " class='on'" End if%>>하부반품내역</a></li>
				</ul>
				-->
			</div>
<%
Case "전자머니"
%>
			<div id="lnb">
				<h2>전자머니</h2>
			</div>
<%
Case "홈페이지관리"
%>
			<div id="lnb">
				<h2>홈페이지관리</h2>
				<ul>
					<li><a href="notice_list.asp" <%If menu2 = "공지사항" Then Response.write " class='on'" End if%>>공지사항</a></li>
					<li><a href="/home/customer/notice.asp" target="_blink" <%If menu2 = "공지사항(홈페이지)" Then Response.write " class='on'" End if%>>공지사항(홈페이지)</a></li>
					<li><a href="/home/customer/board.asp" target="_blink" <%If menu2 = "게시판(홈페이지)" Then Response.write " class='on'" End if%>>게시판(홈페이지)</a></li>
					<li><a href="/home/customer/data.asp"  target="_blink" <%If menu2 = "자료실(홈페이지)" Then Response.write " class='on'" End if%>>자료실(홈페이지)</a></li>
				</ul>
			</div>
<%
Case "조직현황"
%>
			<div id="lnb">
				<h2>조직현황</h2>
				<ul>
					<li><a href="tree_spon.asp" <%If menu2 = "후원조직" Then Response.write " class='on'" End if%>>후원조직</a></li>
					<li><a href="tree_recom.asp" <%If menu2 = "추천조직" Then Response.write " class='on'" End if%>>추천조직</a></li>
				</ul>
			</div>
		
<%
Case Else
%>
			<div id="lnb">
				<h2>HOME</h2>
			</div>
<%
End Select
%>
