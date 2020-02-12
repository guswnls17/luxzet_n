<!--#include file ="../common/head.asp"-->
<style>
.community_bar_text {FONT-FAMILY:굴림; COLOR:5A5A5A;FONT-SIZE:9pt;}
.community_bar_unlink_text {FONT-FAMILY:굴림; COLOR:5A5A5A;FONT-SIZE:9pt;}

a:link, a:visited, a:active { color:#535353; TEXT-DECORATION:none;}
</style>
<%
'Response.write "점검중입니다"
'Response.end
%>
<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
    <TR> 
      <TD vAlign=top align=middle>　</TD>
      <TD height="10" colspan="3" align=middle vAlign=top> </TD>
    </TR>
    <TR> 
      <TD vAlign=top align=middle width=5>　</TD>
      <TD vAlign=top align=middle width=188><TABLE cellSpacing=0 cellPadding=0 width=150 border=0>
          <TBODY>
            <TR> 
              <TD vAlign=top bgColor=#ffffff> <TABLE width="100%" border=0 cellPadding=0 cellSpacing=0 background="../images/left_bg_bg.gif">
                  <TBODY>
                    <TR> 
                      <TD><img src="../images/left_bg_top.gif" width="188" height="11"></TD>
                    </TR>
                    <TR> 
                      <TD height="30" align="center" valign="bottom" background="../images/left_bg_bg.gif"><img src="../images/tit1.gif" width="142" height="23"></TD>
                    </TR>
                    <TR> 
                      <TD align="center"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="5" background="../images/dot.gif"> </td>
                          </tr>
                        </table></TD>
                    </TR>
                    <TR height=370> 
                      <TD 
                      style="PADDING-LEFT: 8px; LINE-HEIGHT: 25px; PADDING-TOP: 10px" 
                      vAlign=top 
                        background=../images/left_bg_bg.gif><p>
						· <a href="notice.asp"><font color="#333333">공지사항</font></A><br>
						· <a href="pds.asp"><font color="#333333">자료실</font></A><br>
						· <a href="board.asp"><font color="#333333">1:1 Q&A</font></A><br>
						<% If session("cenmaster") <> "" Then %>
						· <A 
                        style="FONT-WEIGHT: bold; COLOR: #003333;" 
                        href="cqna.asp">센터장 Q&A</A><br>
						<% End If%>
                        </p></TD>
                    </TR>
                    <TR> 
                      <TD 
                     
                      vAlign=bottom 
                        background=../images/left_bg_bg.gif><img src="../images/left_img.gif" width="188" height="230"></TD>
                    </TR>
                    <TR> 
                      <TD><IMG 
                    src="../images/left_bg_bot.gif" width="188" height="9"></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
      <TD width=15> 
        <!--공백-->
      </TD>
      <TD vAlign=top> <TABLE cellSpacing=0 cellPadding=0 width=807 border=0>
          <TBODY>
            <TR> 
              <TD style="PADDING-LEFT: 5px" width=200 height=40><IMG 
                  src="../images/tit_icon.gif" width="12" height="14" align="absmiddle"><SPAN style="FONT-SIZE: 11px"> 
                HOME &gt; <font color="1B660C">고객센터</font> &gt; <FONT color=1B660C><strong>센터장 Q&A</strong></FONT></SPAN> 
              </TD>
              <TD width=600 align=right valign="bottom"><SPAN style="FONT-SIZE: 11px"><%=session("Name")%> 
                님 접속하셨습니다.</SPAN></TD>
            </TR>
          </TBODY>
        </TABLE>
        <TABLE height=630 cellSpacing=0 cellPadding=0 width=807 border=0>
          <TBODY>
            <TR> 
              <TD height=8><img src="../images/center_top_bg.gif" width="807" height="8"></TD>
            </TR>
            <TR> 
              <TD align="center" vAlign=top background=../images/center_center_bg.gif 
                bgColor=#ffffff><TABLE cellSpacing=0 cellPadding=0 width=700 align=center 
                  border=0>
                  <TBODY>
                    <TR> 
                      <TD background="" height=1></TD>
                    </TR>
					<tr>
					<td><img src="/images/board/customer_tit06.jpg"></td>
					</tr>
                    <TR> 
                      <TD style="PADDING-TOP: 10px" align=left>
					<%	
					If request("mode") = "write" Then
						Server.Execute("./inc/cqna_write.asp")
					ElseIf request("mode") = "view" Then
						Server.Execute("./inc/cqna_view.asp")
					ElseIf request("mode") = "exec" Then
						
						Server.Execute("./inc/cqna_save.asp")
					Else
						Server.Execute("./inc/cqna_list.asp")
					End If
					%>
					  </TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
            <TR> 
              <TD height=8><img src="../images/center_bottom_bg.gif" width="807" height="8"></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
    </TR>
  </TBODY>
</TABLE>
<!--#include file ="../common/bottom.asp"-->