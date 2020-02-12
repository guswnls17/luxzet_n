<%
If lngDataCnt2 > 0 then
	group = fix((page2 - 1) / 10)
'	Response.write "group(" & Group & ")"
'	Response.write "lngDataCnt(" & lngDataCnt & ")"
	pagecount2 = Fix(lngDataCnt2 / pagesize)
'	Response.write "pagecount(" & pagecount & ")"
	If lngDataCnt2 Mod pagesize > 0 Then pagecount2 = pagecount2 + 1
'	Response.write "pagecount(" & pagecount & ")"
	startpage = group * 10 + 1
'	Response.write "startpage(" & startpage & ")"
	If pagecount2 >= startpage + 10 Then endpage = startpage + 10 Else endpage = pagecount2 + 1
'	Response.write "endpage(" & endpage & ")"
%>
				<div class="paging">
<% If group > 0 then%>
					<a href="<%=linkurl%>&page2=1"><img src="/images/board_paging_start.gif" alt="마지막페이지" /></a>
					<a href="<%=linkurl%>&page2=<%=(group - 1) * 10 + 1%>"><img src="/images/board_paging_prev.gif" alt="다음페이지" /></a>
<% Else %>
					<img src="/images/board_paging_start.gif" alt="마지막페이지" />
					<img src="/images/board_paging_prev.gif" alt="다음페이지" />
<% End If %>
						<p class="num">
<%
	i = startpage
	While i < endpage
		If CInt(page2) = CInt(i) Then 
				response.write "<b>" & i & "</b>"
		else
%>
				<a href="<%=linkurl%>&page2=<%=i%>"><%=i%></a>
<%
		End If
		i = i + 1
	Wend
%>

						</p>
<% If pagecount2 > 10 And (Group + 1) * 10 < pagecount2 Then%>
					<a href="<%=linkurl%>&page2=<%=(Group + 1) * 10 + 1%>"><img src="/images/board_paging_next.gif" alt="이전페이지" /></a>
					<a href="<%=linkurl%>&page2=<%=pagecount2%>"><img src="/images/board_paging_end.gif" alt="처음페이지" /></a>
<% Else %>
					<img src="/images/board_paging_next.gif" alt="이전페이지" />
					<img src="/images/board_paging_end.gif" alt="처음페이지" />
<% End If %>
				</div>
<%
End If
%>
