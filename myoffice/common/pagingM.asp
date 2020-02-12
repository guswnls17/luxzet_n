<%
If lngDataCnt > 0 then
	group = fix((page - 1) / 3)
'	Response.write "group(" & Group & ")"
'	Response.write "lngDataCnt(" & lngDataCnt & ")"
	pagecount = Fix(lngDataCnt / pagesize)
'	Response.write "pagecount(" & pagecount & ")"
	If lngDataCnt Mod pagesize > 0 Then pagecount = pagecount + 1
'	Response.write "pagecount(" & pagecount & ")"
	startpage = group * 3 + 1
'	Response.write "startpage(" & startpage & ")"
	If pagecount >= startpage + 3 Then endpage = startpage + 3 Else endpage = pagecount + 1
'	Response.write "endpage(" & endpage & ")"
%>
				<div class="paging">
<% If group > 0 then%>
					<a href="<%=linkurl%>&page=1"><img src="/myoffice/images/board_paging_start.gif" alt="마지막페이지" /></a>
					<a href="<%=linkurl%>&page=<%=(group - 1) * 3 + 1%>"><img src="/myoffice/images/board_paging_prev.gif" alt="다음페이지" /></a>
<% Else %>
					<img src="/myoffice/images/board_paging_start.gif" alt="마지막페이지" />
					<img src="/myoffice/images/board_paging_prev.gif" alt="다음페이지" />
<% End If %>
						<p class="num">
<%
	i = startpage
	While i < endpage
		If CInt(page) = CInt(i) Then 
				response.write "<b>" & i & "</b>"
		else
%>
				<a href="<%=linkurl%>&page=<%=i%>"><%=i%></a>
<%
		End If
		i = i + 1
	Wend
%>

						</p>
<% If pagecount > 3 And (Group + 1) * 3 < pagecount Then%>
					<a href="<%=linkurl%>&page=<%=(Group + 1) * 3 + 1%>"><img src="/myoffice/images/board_paging_next.gif" alt="이전페이지" /></a>
					<a href="<%=linkurl%>&page=<%=pagecount%>"><img src="/myoffice/images/board_paging_end.gif" alt="처음페이지" /></a>
<% Else %>
					<img src="/myoffice/images/board_paging_next.gif" alt="이전페이지" />
					<img src="/myoffice/images/board_paging_end.gif" alt="처음페이지" />
<% End If %>
				</div>
<%
End If
%>
