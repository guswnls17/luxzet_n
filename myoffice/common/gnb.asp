<%
	If session("userid") = "" Then
		jsMessageBox "로그인 후 사용해 주세요", "/myoffice/login.asp", "document"
	End if
%>
		<div id="header">
			<h1></h1>
			<div id="gnb">
				<ul>
					<!--<li><a href="/myoffice/main.asp"><%'=CompanyName%></a></li>-->
					<li><a href="/myoffice/member/memberinfo.asp">회원정보</a></li>
					<li><a href="/myoffice/order/ordersignup.asp">제품구매</a></li>
					<li><a href="/myoffice/order/orderlist.asp">주문현황</a></li>
					<!--<li><a href="/myoffice/organize/rcom_member.asp">추천현황</a></li>-->
					<li><a href="/myoffice/pay/hAcount.asp">산하매출</a></li>
					<li><a href="/myoffice/pay/paylist.asp">수당현황</a></li>
	
<%
	'If Session("member") = "0000000000" Then
%>
<!--<li><a href="/myoffice/etc_manage/notice_list.asp">홈페이지관리</a></li>-->
<%
	'End If
%>

<li><a href="/myoffice/organize/tree_spon.asp">조직도</a></li>
<li><a href="/myoffice/emoney/emoney.asp">전자머니</a></li>
				</ul>
			</div>
			<div class="user_info">
				<div>
					<p><strong><%=session("username")%></strong>님 안녕하세요.</p>
					<dl>
						<dt>[<strong>접속일</strong></dt>
						<dd>&nbsp;: <%=session("lastlogin")%>]</dd>
					</dl>
					<input type="image" src="/myoffice/images/btn_logout.png" title="로그아웃" style="cursor:hand" onclick="location.href='/myoffice/login.asp';" />
				</div>
			</div>
		</div>
