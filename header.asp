<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>::<%=language(lan,0)%>::</title>

  <!-- Custom fonts for this template-->
  <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans|Noto+Serif:700&display=swap" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/css/sb-admin-6.css" rel="stylesheet">
  <link rel="stylesheet" href="/css/autron_style.css" />

		<script type="text/javascript" src="/js/lib/jquery/jquery.1.12.4.js"></script>
		<script type="text/javascript" src="/js/swiper.min.js"></script>
		<script type="text/javascript" src="/js/jquery.mCustomScrollbar.js"></script>
		<script type="text/javascript" src="/js/TweenMax.js"></script>
		<script type="text/javascript" src="/js/script.js"></script>
		<script type="text/javascript" src="/js/main.js"></script>

  <script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/myoffice/lib/langd<%=lan%>.js"></script> 
</head>
<script>
var link = location.href;
var link2 = link.split(":");
if(typeof link2[0] != 'undefined'){
	if(link2[0] == "http"){
//		location.href=""
	}
}
</script>
<body id="page-top">
<%
	If session("userid") = "" Then
		jsMessageBox "Please use after login.", "./login.asp", "document" '로그인 후 사용해 주세요
	End if
	
	urlstr = request.servervariables("HTTP_url")
	
%>	
<script type="text/javascript">
$(document).ready(function(){
	
	var wih = window.innerHeight;
			var obh = $("#hdwrap");
			if(obh.height() < wih){
				obh.height(wih);
			}
			
			$(window).resize(function() { 
				var wih = window.innerHeight;
				var obh = $("#hdwrap");
				if(obh.height() < wih){
					obh.height(wih);
				}
			}); 

});

function logout(){
    window.location.replace("login.asp");

}
</script>
<%
	sql = "select mem_id, mem_date from mmember a where a.mem_id = '" & session("userid") & "' " 

	setMtop = "0"
	memdate = ""
	If f_sql_select(db_conn, sql, arrData) > 0 Then
		setMtop = "1"
		memdate = arrData(1,0)
	Else 
		sql = "select mem_id, mem_date from mmember_temp a where a.mem_id = '" & session("userid") & "' " 
		If f_sql_select(db_conn, sql, arrData) > 0 Then
			setMtop = "0"
			memdate = arrData(1,0)
		End if 
	End if 
	
	
	sql = " SELECT comp_code , isnull(comp_bigo,0), comp_sanje_no, isnull(comp_upjong,0) FROM ccompany " 
	comp_bigo = 0
	comp_epay = 0
	comp_exdate = ""
	If f_sql_select(db_conn, sql, arrData) > 0 Then
			comp_bigo = arrData(1,0)
			comp_exdate = arrData(2,0)
			comp_epay = arrData(3,0)
	End If
	
%>	
  <!-- Page Wrapper -->
  <div id="wrapper">
        <div id="headerW"><!-- 상단 메뉴 시작 -->
		    <h1><a href="home.asp" class="logo"></a></h1>
				<div class="gnbDiv">
					<div class="inner">
						<ul>
						    <li><span class="bg-white user-id ml-3"><i class="fas fas fa-user"></i></span></li>
							<li class="text-white"><%=session("username")%></span></li>
                            <li class="nav-item" >
                                 <a href="javascript:logout();" class="logout-btn"><span><%=language(lan,12)%></span></a>
                             </li>
							<li>
									<%=language(lan,268)%> <span class="font-b">$<%=comp_epay%></span>
						    </li>
						</ul>
					</div>
					<a href="javascript:" class="fmSitBt"></a>
				</div><!-- 상단 메뉴 끝-->
	    </div><!-- // headerW -->
    	<div class="allMenu"><!-- Side 메뉴 시작-->
			    <a href="home.asp" class="logo"></a>
				<ul>
					<!--li>
						<a href="home.asp" class="oneD"><i class="fas fa-home"></i> <%=language(lan,211)%></a>
					</li-->
				    <li>
						<a href="javascript:" class="oneD"><i class="fas fa-flag"></i> <%=language(lan,212)%></a>
						<div class="twoD">
						    <a href="notice.asp" target="_self" class=""><%=language(lan,212)%></a>
						</div>
					</li>
<%
	If setMtop = "1" Then 
%>					
                	<li>
						<a href="javascript:" class="oneD"><i class="fas fa-info-circle"></i> <%=language(lan,17)%></a>
						<div class="twoD">
							<a href="myaccount.asp" target="_self"  class=""><%=language(lan,275)%></a>
						    <a href="memberadd.asp" target="_self"  class=""><%=language(lan,25)%></a>
						</div>
					</li>
				    <li>
					    <a href="javascript:" class="oneD"><i class="fas fa-dolly-flatbed"></i> <%=language(lan,18)%></a>
						<div class="twoD">
						    <a href="purchase.asp" target="_self" class=""><%=language(lan,18)%></a>
						</div>
					</li>
					<li>
					    <a href="javascript:" class="oneD"> <i class="fas fa-box-open"></i> <%=language(lan,19)%></a>
						<div class="twoD">
									<a href="order.asp" target="_self" class=""><%=language(lan,27)%></a>
								    <a href="order_ecp.asp" target="_self" class=""><%=language(lan,28)%></a>
								    <a href="order_lxz.asp" target="_self"  class=""><%=language(lan,283)%></a>
									<a href="order_bit.asp" target="_self" class=""><%=language(lan,284)%></a>
						</div>
						</li>
					<li>
							<a href="javascript:" class="oneD"><i class="fas fa-cart-arrow-down"></i> <%=language(lan,20)%></a>
						<div class="twoD">
									<a href="sales.asp" target="_self" class=""><%=language(lan,29)%></a>
								    <a href="sales02.asp" target="_self" class=""><%=language(lan,30)%></a>
						</div>
						</li>
					    <li>
							<a href="javascript:" class="oneD"><i class="fab fa-rebel"></i> <%=language(lan,21)%></a>
						<div class="twoD">
									<a href="allowance.asp" target="_self" class=""><%=language(lan,31)%></a>
						</div>
						</li>
					    <li>
							<a href="javascript:" class="oneD"><i class="fas fa-chart-bar"></i> <%=language(lan,22)%></a>
						<div class="twoD">
									<a href="chart.asp" target="_self" class=""><%=language(lan,32)%></a>
									<a href="chart02.asp" target="_self" class=""><%=language(lan,33)%></a>
						</div>
						</li>
					    <li>
							<a href="javascript:" class="oneD"><i class="fas fa-coins"></i> <%=language(lan,109)%></a>
						<div class="twoD">
									<a href="twice2.asp" target="_self" class=""><%=language(lan,23)%></a>
									<a href="twicecoin2.asp" target="_self" class=""><%=language(lan,55)%></a>
						</div>
						</li>
					    <li>
							<a href="javascript:" class="oneD"><i class="fas fa-wallet"></i> <%=language(lan,24)%></a>
						<div class="twoD">
									<a href="coin.asp" target="_self" class=""><%=language(lan,24)%></a>
								    <a href="coinp.asp" target="_self" class=""><%=language(lan,264)%></a>
						</div>
						</li>
<% 
	Else 
%>
					<li>
						<a href="javascript:" class="oneD"><i class="fas fa-info-circle"></i> <%=language(lan,17)%></a>
						<div class="twoD">
							<a href="myaccount_re.asp" target="_self"  class=""><%=language(lan,275)%></a>
						</div>
					</li>
				    <li>
					    <a href="javascript:" class="oneD"><i class="fas fa-dolly-flatbed"></i> <%=language(lan,18)%></a>
						<div class="twoD">
						    <a href="purchase_re.asp" target="_self" class=""><%=language(lan,18)%></a>
						</div>
					</li>
					<li>
					    <a href="javascript:" class="oneD"> <i class="fas fa-box-open"></i> <%=language(lan,19)%></a>
						<div class="twoD">
								    <a href="order_lxz.asp" target="_self"  class=""><%=language(lan,283)%></a>
									<a href="order_bit.asp" target="_self" class=""><%=language(lan,284)%></a>
						</div>
					</li>
<%	
	End If
%>							
					</ul>
				<a href="javascript:" class="closeBtn"></a>
			</div><!-- S	ide 메뉴 끝-->

     <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="home.asp">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3"><%=language(lan,0)%></div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider mb-4">
	  <li class="nav-item user-info">
      	<span class="bg-white user-id"><i class="fas fas fa-user"></i></span>
        <span style="overflow:auto;"><%=session("username")%></span>
      </li>
      <li class="nav-item logout-btn">
        <a class="nav-link" href="javascript:logout();">
          <i class="fas fa-sign-out-alt"></i>
          <span><%=language(lan,12)%></span></a>
      </li>
	  <hr class="sidebar-divider my-4">
      <!-- Nav Item -->
      <li class="nav-item">
        <a class="nav-link" href="home.asp">
          <i class="fas fa-home"></i>
          <span><%=language(lan,211)%></span></a>
      </li>
      <!-- Nav Item -->
      <li class="nav-item">
        <a class="nav-link" href="notice.asp">
          <i class="fas fa-flag"></i>
          <span><%=language(lan,212)%></span></a>
      </li>
<%
	If setMtop = "1" Then 
%>	  
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-info-circle"></i>
          <span><%=language(lan,17)%></span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,17)%>:</h6>
            <a class="collapse-item" href="myaccount.asp"><%=language(lan,275)%></a>
            <a class="collapse-item" href="memberadd.asp"><%=language(lan,25)%></a>
          </div>
        </div>
      </li>
      <!-- Nav Item -->
      <li class="nav-item">
        <a class="nav-link" href="purchase.asp">
          <i class="fas fa-dolly-flatbed"></i>
          <span><%=language(lan,18)%> </span></a>
      </li>
      <!-- Nav Item - Utilities Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
          <i class="fas fa-box-open"></i>
          <span><%=language(lan,19)%></span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,19)%>:</h6>
            <a class="collapse-item" href="order.asp"><%=language(lan,27)%></a>
            <a class="collapse-item" href="order_ecp.asp"><%=language(lan,28)%></a>  
			<a class="collapse-item" href="order_lxz.asp"><%=language(lan,283)%></a>  
			<a class="collapse-item" href="order_bit.asp"><%=language(lan,284)%></a>  			
          </div>
        </div>
      </li>
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSales" aria-expanded="true" aria-controls="collapseSales">
          <i class="fas fa-cart-arrow-down"></i>
          <span><%=language(lan,20)%></span>
        </a>
        <div id="collapseSales" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,20)%>:</h6>
            <a class="collapse-item" href="sales.asp"><%=language(lan,29)%></a>
            <a class="collapse-item" href="sales02.asp"><%=language(lan,30)%></a>
          </div>
        </div>
      </li>
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseAllow" aria-expanded="true" aria-controls="collapseAllow">
          <i class="fab fa-rebel"></i>
          <span><%=language(lan,21)%></span>
        </a>
        <div id="collapseAllow" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,21)%>:</h6>
            <a class="collapse-item" href="allowance.asp"><%=language(lan,31)%></a>
          </div>
        </div>
      </li>
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseChart" aria-expanded="true" aria-controls="collapseChart">
          <i class="fas fa-chart-bar"></i>
          <span><%=language(lan,22)%></span>
        </a>
        <div id="collapseChart" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,22)%>:</h6>
            <a class="collapse-item" href="chart.asp"><%=language(lan,32)%></a>
            <a class="collapse-item" href="chart02.asp"><%=language(lan,33)%></a>
          </div>
        </div>
      </li>
      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseCoin" aria-expanded="true" aria-controls="collapseCoin">
          <i class="fas fa-coins"></i>
          <span><%=language(lan,109)%></span>
        </a>
        <div id="collapseCoin" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,109)%>:</h6>
<!--            <a class="collapse-item" href="twicecoin.asp">LC+ coin</a>  -->
            <a class="collapse-item" href="twice2.asp"><%=language(lan,23)%></a>
            <a class="collapse-item" href="twicecoin2.asp"><%=language(lan,55)%></a>
          </div>
        </div>
      </li>
      <!-- Nav Item -->
	  <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEwallet" aria-expanded="true" aria-controls="collapseEwallet">
          <i class="fas fa-wallet"></i>
          <span><%=language(lan,24)%></span>
        </a>
        <div id="collapseEwallet" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,24)%>:</h6>
            <a class="collapse-item" href="coin.asp"><%=language(lan,24)%></a>
            <a class="collapse-item" href="coinp.asp"><%=language(lan,264)%></a>
          </div>
        </div>
      </li>
<% 
	Else 
%>		
		<!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-info-circle"></i>
          <span><%=language(lan,17)%></span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,17)%>:</h6>
            <a class="collapse-item" href="myaccount_re.asp"><%=language(lan,275)%></a>
          </div>
        </div>
      </li>
      <!-- Nav Item -->
      <li class="nav-item">
        <a class="nav-link" href="purchase_re.asp">
          <i class="fas fa-dolly-flatbed"></i>
          <span><%=language(lan,18)%> </span></a>
      </li>
	  <!-- Nav Item - Utilities Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
          <i class="fas fa-box-open"></i>
          <span><%=language(lan,19)%></span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header"><%=language(lan,19)%>:</h6>
            <a class="collapse-item" href="order_ecp.asp"><%=language(lan,28)%></a> 
			<a class="collapse-item" href="order_lxz.asp"><%=language(lan,283)%></a>  			
			<a class="collapse-item" href="order_bit.asp"><%=language(lan,284)%></a>  			
          </div>
        </div>
      </li>
<%	
	End If
%>		  
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block mt-4">
	<div class="language " style="display:none;">
	  <select class="form-control" onchange="LangChange(this)">
		<option value="USA"<%If la=0 Then Response.write " selected" End if%>>USA</option>
		<option value="CHN"<%If la=1 Then Response.write " selected" End if%>>CHN</option>
		<option value="JAP"<%If la=3 Then Response.write " selected" End if%>>JAP</option>    
	  </select>
	</div>
      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
		<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
			 <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>				<a href="/index_e.php" class="lang"><i class="fas fa-info-circle"></i> <%=language(lan,12)%></a>
          </button>
          <!-- inb content -->
 <!--  
		  <div class="w-100">
   		    <p class="mt-2 font-s pl-5 float-left icon-bg02 mr-5">
            	<%=language(lan,268)%> <span class="font-b">$<%=comp_epay%></span>
            </p>
     	<p class="mt-2 font-s pl-5 float-left icon-bg01 mr-5 ml-5">
            	Twice coin <span class="font-b">$<%=comp_bigo%></span>
            </p>
           <p class="mt-2 font-s pl-5 float-left icon-bg02">
            	1 GOLD BIT COIN <span class="font-b">$0.12</span>
            </p> 
          </div>  -->

        </nav>
        <!-- End of Topbar -->
<script>
function LangChange(e){
	var link = '<%=request.servervariables("HTTP_url") %>';
	if(link.indexOf("?") < 0 ){
		location.href = link + "?langu="+e.value
	}else{
		var ll = link.split("?");
		location.href = ll[0] + "?langu="+e.value;
	}

}
</script>