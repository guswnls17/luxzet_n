<!-- #Include virtual = "/myoffice/lib/db.asp" -->
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
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/css/sb-admin-6.css" rel="stylesheet">
  <script type="text/javascript" src="/myoffice/lib/langc<%=lan%>.js"></script>
<script language="JavaScript" type="text/JavaScript">

<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
<script type='text/javascript'>
var link = location.href;
var link2 = link.split(":");
if(typeof link2[0] != 'undefined'){
	if(link2[0] == "http"){
//		location.href="";
	}
}
function logincheck(){
    var frm = document.frmMain;
    var id = frm.n_id.value;
	var pw = frm.n_pw.value;

    if (id == '') {
        alert(coin_lang[0]);
        frm.n_id.focus();
        return false;
    }

    if (pw == '') {
        alert(coin_lang[1]);
        frm.n_pw.focus();
        return false;
    }
	return true;
}

function loginsubmit()
{
 var frm = document.frmMain;

        var id = frm.n_id.value;
        var pw = frm.n_pw.value;

        if (id == '') {
            alert(coin_lang[0]);
            frm.n_id.focus();
            return;
        }
    
        if (pw == '') {
            alert(coin_lang[1]);
            frm.n_pw.focus();
            return;
        }

		document.frmMain.submit();

}

function MoveEnter(vals) {	
	if(event.keyCode == 13){
	    if(vals=="login"){
			loginsubmit();
			return;
		}else{
		   document.getElementById(vals).focus();
		   return;
		}
	}
}
function notice_getCookie( name ){
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length )
    {
            var y = (x+nameOfCookie.length);
            if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                    if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                            endOfCookie = document.cookie.length;
                    return unescape( document.cookie.substring( y, endOfCookie ) );
            }
            x = document.cookie.indexOf( " ", x ) + 1;
            if ( x == 0 )
                    break;
    }
    return "";
}

function checkn(){
	if (document.frmMain.n_check.checked == true){
		document.frmMain.n_check.checked = false;
	}else{
		document.frmMain.n_check.checked = true;
	}
}

/*
if ( notice_getCookie( "Notice1" ) != "done" )
{
         window.open('./pop1.html','','left=0,top=200,width=620,height=650,scrollbars=yes'); // 팝업윈도우의 경로와 크기를 설정 하세요
}

if ( notice_getCookie( "Notice2" ) != "done" )
{
         window.open('./pop2.html','','left=300,top=200,width=620,height=650,scrollbars=yes'); // 팝업윈도우의 경로와 크기를 설정 하세요
}

if ( notice_getCookie( "Notice8" ) != "done" )
{
         window.open('./pop8.html','','left=600,top=200,width=750,height=790,scrollbars=yes'); // 팝업윈도우의 경로와 크기를 설정 하세요
}
*/
</script>
<%
session("username") = ""
session("userid") = ""
session("userauth") = ""
CompanyEName = "LUXZET"

strUser = Request.Cookies("memid") 
%>
</head>

<body class="bg-img-main">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card2 o-hidden border-0 shadow-lg my-8">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <!--div class="col-lg-6 d-none d-lg-block bg-login-image"></div-->
              <div class="col-lg-12">
                <div class="p-5 mt-5">
                  <div class="text-center">
                    <div class="logo"><img src="../img/logo.png"></div>
					<h1 class="h4 text-blue-900 mb-4 mt-4"><%=language(lan,271)%>!</h1>
                  </div>
				  <form name="frmMain" class="user" method="post" action="logincheck.asp">	
                    <div class="form-group">
                      <input type="email" class="form-control form-control-user" name="n_id" id="i_id" onKeyPress="MoveEnter('i_pw');" value="<%=strUser%>"  placeholder="<%=language(lan,10)%>">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" name="n_pw" id="i_pw" onKeyPress="MoveEnter('login');" placeholder="<%=language(lan,11)%>">
                    </div>
                    <div class="form-group mb-4 mt-4">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="n_check" checked>
                        <label class="custom-control-label" for="n_check"><%=language(lan,5)%></label>
                        <div class="float-right">
                        	<select name="select" id="select" onchange="LangChange(this)" class="form-control mt-n2">
                                <option value="USA"<%If la=0 Then Response.write " selected" End if%>>USA</option>
								<option value="CHN"<%If la=1 Then Response.write " selected" End if%>>CHN</option>
								<option value="JAP"<%If la=3 Then Response.write " selected" End if%>>JAP</option>   
                            </select>
                        </div>
                      </div>
                    </div>
                    <a href="javascript:loginsubmit();" class="btn btn-primary btn-user btn-block">
                      <%=language(lan,6)%>
                    </a>
                    <a href="join.asp" class="btn btn-success btn-user btn-block" ><%=language(lan,270)%>!</a>
                  </form>
                  <!--hr>
                  <div class="user">
                    <!--%=language(lan,269)%>? <br--><!--a href="join.asp" class="btn btn-success btn-user btn-block" ><%=language(lan,270)%>!</a>
                  </div-->
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="/vendor/jquery/jquery.min.js"></script>
  <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/js/sb-admin-2.min.js"></script>
<script>
function LangChange(e){
	location.href="login.asp?langu="+e.value;
}
</script>
</body>

</html>