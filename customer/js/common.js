//
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

//마우스오버 스크립트

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function setPng24(obj) { 
 obj.width=obj.height=1; 
 obj.className=obj.className.replace(/\bpng24\b/i,''); 
 obj.style.filter = 
 "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');" 
 obj.src='';  
 return ''; 
}
// 윈도를 띄운다
function OpenWindow(url,width,height,scroll)
{
	if(scroll == null) scroll = "no";
	winpos = "left=" + ((window.screen.width-width)/2) + ",top=" + ((window.screen.height-height-28)/2);
	winstyle="width=" + width + ",height=" + height + ",status=no,toolbar=no,menubar=no,location=no,resizable=no,copyhistory=no,scrollbars=" + scroll + "," + winpos;
	window.open(url,'_blank',winstyle);
}
// 레어아웃별 팝업 노스크롤
function pop1024_768()
{
	OpenWindow('[레이아웃_pop]1024_768.html','1012','700','0');
}
function pop1280_768()
{
	OpenWindow('[레이아웃_pop]1280_768.html','1268','700','0');
}
function pop1280_1024()
{
	OpenWindow('[레이아웃_pop]1280_1024.html','1268','955','0');
}
// 레어아웃별 팝업 스크롤

function pop1024_768_scroll()
{
	OpenWindow('[레이아웃_pop]1024_768.html','1030','700','1');
}
function pop1280_768_scroll()
{
	OpenWindow('[레이아웃_pop]1280_768.html','1286','700','1');
}
function pop1280_1024_scroll()
{
	OpenWindow('[레이아웃_pop]1280_1024.html','1286','955','1');
}
//Flash selMenu(개발함수 chgColumnList(1)~(5)
//Flash selMenu(외부링크시)								   
function flashAction(param)
{		
	switch(param)
	{
		case "selMenu1"	:location.href = "javascript:selMenu(1)";break;
		case "selMenu2"	:location.href = "javascript:selMenu(2)";break;
		case "selMenu3"	:location.href = "javascript:selMenu(3)";break;
		case "selMenu4"	:location.href = "javascript:selMenu(4)";break;
		case "selMenu5"	:location.href = "javascript:selMenu(5)";break;
		default : alert(noparam);
	}
}