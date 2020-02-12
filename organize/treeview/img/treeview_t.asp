<!--#include virtual = "/myoffice/lib/db.asp"-->
<%
memno1 = request("memno1")
memberno = request("memno")
organ = request("organ")
down = request("down")
step = request("step")
flow = request("flow")
nopic = request("nopic")
n_sdate = request("n_sdate")
n_edate = request("n_edate")
mem_code = request("mem_code")
mem_name = request("mem_name")
mem_date = request("mem_date")
mem_center = request("mem_center")
mem_choo = request("mem_choo")
mem_hoo = request("mem_hoo")
mem_level = request("mem_level")
low_pvkum = request("low_pvkum")
mem_pvkum = request("mem_pvkum")


if (memberno = "") then memberno = "1000000"
if (memno1 = "") then memno1 = memberno
if (organ = "") then organ = "recom"
if (down = "") then down = "yes"
if (step = "") then step = "5"
if (flow = "") then flow = "down"
if (nopic = "") then nopic = "Y"
If (n_sdate = "") Then n_sdate = Date - 365
If (n_edate = "") Then n_edate = Date 
if (mem_name = "") then mem_name = "Y"
'Response.write memberno&"/"&memno1
%>
<!doctype html>
<html>
<head>
<title>Org Chart Static</title>
<script type="text/javascript" src="/myoffice/lib/httpRequest.js"></script>
<script type="text/javascript" src="go.js"></script>
<style type="text/css">
  #myOverviewDiv {
    position: absolute;
    width:200px;
    height:100px;
    top: 10px;
    left: 10px;
    background-color: white;
    z-index: 300; /* make sure its in front */
    border: solid 0px ;
  }
</style>
<script type="text/javascript">
  function init() {

	var $ = go.GraphObject.make;

    myDiagram =
      $(go.Diagram, "myDiagram",
        { initialDocumentSpot: go.Spot.TopCenter,
          initialViewportSpot: go.Spot.TopCenter,
		  isReadOnly: true});

    myDiagram.toolManager.draggingTool.dragsTree = false;
	myDiagram.allowZoom = true;

    function theInfoTextConverter(info) {
      var str = "";
	   <% If mem_code = "Y" Then 'NO표시여부채크 %>
	  if (info.grade) str += "\nNo: " + info.key;
	   <% End If %>
	   <% If mem_center = "Y" Then '센터표시여부채크 %>
			str += "\n센터: " + info.agency;
	   <% End If %>
	   <% If mem_pvkum = "Y" Then 'PV표시여부채크 %>
			str += "\nPV: " + info.selfsales;
	   <% End If %>
   	   <% If low_pvkum = "Y" Then '하선PV표시여부채크 %>
			str += "\n하선PV: " + info.hoo_sale_pvkum;
	   <% End If %>
	   <% If mem_date = "Y" Then '등록일표시여부채크 %>
			str += "\n등록일: " + info.date;
	   <% End If %>
	   <% If mem_choo = "Y" Then '추천인표시여부채크 %>
			str += "\n추천인: " + info.choo_name;
	   <% End If %>
	   <% If mem_hoo = "Y" Then '후원인표시여부채크 %>
			str += "\n후원인: " + info.hoo_name;
	   <% End If %>
	   <% If mem_level = "Y" Then '직급표시여부채크 %>
			str += "\n직급: " + info.level_name;
	   <% End If %>

      // if (info.grade) str += "\n센터: " + info.agency;
      // if (info.selfsales) str += "\nPV: " + info.selfsales;
      return str;
    }
	
	function convertKeyImage(key) {
		if (!key) key = "001";
		if(key < "008") key = "001";
		return "http://cs.daonstory.com/myoffice/kr/organize/treeview/test/"+key+".jpg";
	  }

	function childcheck(info) {
		return (info.child > 0) ? true : false;
	}

    myDiagram.nodeTemplate =
	  $(go.Node, "Vertical",  // the whole node panel
        $(go.TextBlock,  // the text label
          new go.Binding("text", "key")),
        $(go.Picture,  // the icon showing the logo
          // You should set the desiredSize (or width and height)
          // whenever you know what size the Picture should be.
          { desiredSize: new go.Size(74, 80) },
          new go.Binding("source", "key", convertKeyImage))
      );

/*	  
      $(go.Node, go.Panel.Auto,
        { isShadowed: true },
        $(go.Shape,
          { figure: "Rectangle",
            fill: "azure" 
		  },
          new go.Binding("fill", "color")
		 ),
        $(go.Panel, go.Panel.Table,
          { margin: 15, maxSize: new go.Size(140, NaN), minSize: new go.Size(80, NaN) 
		  },
          $(go.RowColumnDefinition,
            { column: 0,
              stretch: go.GraphObject.Horizontal,
              alignment: go.Spot.Left 
			}
		   ),
          $(go.TextBlock,
            { row: 0, column: 0,
              maxSize: new go.Size(110, NaN),
              font: "bold 10pt sans-serif",
              alignment: go.Spot.Top
			},
            new go.Binding("text", "name")
		   ),
          $(go.TextBlock,
            { row: 1, column: 0,
              font: "9pt sans-serif" 
			},
            new go.Binding("text", "", theInfoTextConverter)
		   ),
//		  $("Button",
//          { alignment: go.Spot.TopLeft,
//          alignmentFocus: go.Spot.Center,
//           click: function (e, obj) {
//              var node = obj.part;
//              if (node === null) return;
//              var data = node.data;
//              info(data.key);
//            }
//		  }, $(go.TextBlock, "+")),
		  { doubleClick: nodeDoubleClick }
		 )
		);
		*/

    myDiagram.linkTemplate =
      $(go.Link, go.Link.Orthogonal,
        { selectable: false },
        $(go.Shape));

    var nodeDataArray = [
<%

memno1 = request("memno1")
memberno = request("memno")
organ = request("organ")
down = request("down")
step = request("step")
level = request("level")
flow = request("flow")
nopic = request("nopic")
n_sdate = request("n_sdate")
n_edate = request("n_edate")

if (memberno = "") then memberno = "1000000"
if (memno1 = "") then memno1 = memberno
if (organ = "") then organ = "recom"
if (down = "") then down = "no"
if (step = "") then step = "5"
if (level = "") then level = "001"
if (flow = "") then flow = "down"
if (nopic = "") then nopic = "Y"
If (n_sdate = "") Then n_sdate = Date - 365
If (n_edate = "") Then n_edate = Date 

n_sdate = REPLACE (n_sdate, "-", "")
n_edate = REPLACE (n_edate, "-", "")

sql = "SP_회원_조직조회_트리3 '" & memberno & "', '" & organ & "', '" & down &"', '" & memno1 & "', '" & step & "', '" & n_sdate & "', '" & n_edate & "','"& level & "'"


response.write "//" & sql & chr(13) & chr(10)

lngDataCnt = f_sql_select(db_conn, sql, arrData)

for i = 0 to lngDataCnt - 1
	color0 = "#FFFFFF"
	grade = arrData(4, i)
'	if arrData(3, i) = "0" then
'		color0 = "#BFBFBF"
'	end if

'	sql2 = "SELECT	ISNULL(sum(sale_pvkum),0)"
'	sql2 = sql2& "FROM	mem_hdown,		"
'	sql2 = sql2& "mmember,		"
'	sql2 = sql2& "sale02		"
'	sql2 = sql2& "WHERE	( mem_hdown.down_down = mmember.mem_code ) and		"
'	sql2 = sql2& "( mmember.mem_code = sale02.sale_mem_code ) and		"
'	sql2 = sql2& "( ( sale02.sale_date >= '"&n_sdate&"' and sale02.sale_date <= '"&n_edate&"' ) and		"
'	sql2 = sql2& "( mem_hdown.down_member = '"&arrData(0, i)&"') )	"
'	sql2 = sql2& "and sale02.sale_gubun <> '0'	"
	
'	response.write "//" & sql2 & chr(13) & chr(10)
	
'	lngDataCnt2 = f_sql_select(db_conn, sql2, arrData2)

'	selfinfo = formatnumber((Clng(arrData(5, i)) + CLng(arrData(15, i))),0)
	'(Clng(formatnumber(arrData(5, i), 0)) + CLng(formatnumber(arrData(15, i), 0)))
'	hoo_info = formatnumber(arrData(15, i), 0)
	
'	selfinfo = hoo_info
	
	hoo_info = formatnumber(arrData(15, i),0)
	
	selfinfo = formatnumber(arrData(5, i),0) 'hoo_info

	if i = 0 then
		response.write "{ key: """ & arrData(0, i) & """, color: """ & color0 & """, boss:"""", name: """ & arrData(2, i) & """, grade: """ & grade & """, selfsales: """ & selfinfo & """, child: """ & arrData(6, i) &  """, agency: """ &arrData(9, i) & """ , pic: """ & arrData(10, i) & """ , date: """ & arrData(11, i) & """ , choo_name: """ & arrData(12, i) & """ , hoo_name: """ & arrData(13, i) & """ , level_name: """ & arrData(7, i) & """ , hoo_sale_pvkum: """ & hoo_info & """ }"
		'response.write "{ ""key"": """ & arrData(0, i) & """, ""name"": """ & arrData(2, i) & """, ""title"": """ & grade & """, ""selfsales"": """ & selfinfo & """, ""child"": """ & arrData(6, i) & """, ""agency"": """ & arrData(9, i) & """ , ""pic"": """ & arrData(10, i) & """ , ""date"": """ & arrData(11, i) & """ , ""choo_name"": """ & arrData(12, i) & """ , ""hoo_name"": """ & arrData(13, i) & """ , ""level_name"": """ & arrData(14, i) & """ , ""hoo_sale_pvkum"": """ & hoo_info & """ }"
	else
		response.write ", { key: """ & arrData(0, i) & """, color: """ & color0 & """, boss: """ & arrData(1, i) & """, name: """ & arrData(2, i) & """, grade: """ & grade & """, selfsales: """ & selfinfo & """, child: """ & arrData(6, i) &  """, agency: """ &arrData(9, i) & """, pic: """ & arrData(10, i) & """ , date: """ & arrData(11, i) & """ , choo_name: """ & arrData(12, i) & """ , hoo_name: """ & arrData(13, i) & """ , level_name: """ & arrData(7, i) & """ , hoo_sale_pvkum: """ & hoo_info & """  }"
		'response.write ", { ""key"": """ & arrData(0, i) & """,  ""name"": """ & arrData(2, i) & """, ""title"": """ & grade & """,""parent"": """ & arrData(1, i) & """, ""selfsales"": """ & selfinfo & """, ""child"": """ & arrData(6, i) & """, ""agency"": """ & arrData(9, i) & """, ""pic"": """ & arrData(10, i) & """ , ""date"": """ & arrData(11, i) & """ , ""choo_name"": """ & arrData(12, i) & """ , ""hoo_name"": """ & arrData(13, i) & """ , ""level_name"": """ & arrData(14, i) & """ , ""hoo_sale_pvkum"": """ & hoo_info & """  }"
	end if
next
%>
	];

    var linkArray = [];
	
    for (var i = 0; i < nodeDataArray.length; i++) {
      var n = nodeDataArray[i];
      if (n.boss !== undefined) {
        linkArray.push({ from: n.boss, to: n.level_name });
      }
    }  

    myDiagram.model = new go.GraphLinksModel(nodeDataArray, linkArray);
	

    myDiagram.layout =
	 $(go.LayeredDigraphLayout,
		  { direction: 90,
			layerSpacing: 10,
			columnSpacing: 15,
			setsPortSpots: false });
  
//  $(go.TreeLayout,
//        { angle: 90,
//          nodeSpacing: 5 });

	var ck_scale = getCookie("daonstory_scale");
	if(ck_scale == null || ck_scale == "" || ck_scale == 0) ck_scale = 1.4;
	myDiagram.scale = (Math.floor(ck_scale*10))/10;
	
    new go.Overview("myOverview").observed = myDiagram;

	
  }
  
  // when a node is double-clicked, add a child to it
    function nodeDoubleClick(e, obj) {
	  var clicked = obj.part;
      if (clicked !== null) {
			var thisemp = clicked.data;
		 
		  nextStep(thisemp);
		  //info(thisemp.key);
       
		/*var thisemp = clicked.data;
        myDiagram.startTransaction("add employee");
        var nextkey = (myDiagram.model.nodeDataArray.length + 1).toString();
        var newemp = { key: nextkey, name: "(new person)", title: "", parent: thisemp.key };
        myDiagram.model.addNodeData(newemp);
        myDiagram.commitTransaction("add employee");*/

      }
    }

  function nextStep(parentdata) {
	// alert("treeview.asp?memno=" + parentdata.key + "&memno1=<%=memno1%>&organ=<%=organ%>&down=" + ((parentdata.boss == '') ? 'no' : 'yes') + "&step=<%=step%>");
	document.location = "treeview.asp?memno=" + parentdata.key + "&memno1=<%=memno1%>&organ=<%=organ%>&down=" + ((parentdata.boss == '') ? 'no' : 'yes') + "&step=<%=step%>" + "&nopic=<%=nopic%>&n_sdate=<%=n_sdate%>&n_edate=<%=n_edate%>&mem_code=<%=mem_code%>&mem_date=<%=mem_date%>&mem_center=<%=mem_center%>&mem_choo=<%=mem_choo%>&mem_hoo=<%=mem_hoo%>&mem_level=<%=mem_level%>&mem_pvkum=<%=mem_pvkum%>&low_pvkum=<%=low_pvkum%>";
  }

 function info(memno)
  {
	var params = 'memno=' + memno +'&n_sdate=<%=n_sdate%>&n_edate=<%=n_edate%>';
	//alert(params);
	<% If organ = "recom" Then %>
		sendRequest('member_info_choo.asp', params, f_info_reply, 'POST');
	<% Else %>
		sendRequest('member_info_hoo.asp', params, f_info_reply, 'POST');
	<% End If%>
  }

  function f_info_reply(){
	if(httpRequest.readyState==4){
		if(httpRequest.status == 200){
			alert(httpRequest.responseText);
		}
	}
  }

  function f_plus()
  {
		if (myDiagram.scale < 2) myDiagram.scale += 0.2;
		setCookie("daonstory_scale",myDiagram.scale,365);
  }

  function f_minus()
  {
		if (myDiagram.scale > 0.2) myDiagram.scale -= 0.2;
		setCookie("daonstory_scale",myDiagram.scale,365);
  }
  
  
  // 쿠키 생성
     function setCookie(cName, cValue, cDay){
          var expire = new Date();
          expire.setDate(expire.getDate() + cDay);
          cookies = cName + '=' + escape(cValue) + '; path=/ '; 
          if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
          document.cookie = cookies;
     }

     // 쿠키 가져오기
     function getCookie(cName) {
          cName = cName + '=';
          var cookieData = document.cookie;
          var start = cookieData.indexOf(cName);
          var cValue = '';
          if(start != -1){
               start += cName.length;
               var end = cookieData.indexOf(';', start);
               if(end == -1)end = cookieData.length;
               cValue = cookieData.substring(start, end);
          }
          return unescape(cValue);
     }
	
</script>
<style type="text/css">
/*@media print {
  html, body, div {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
  }

   Hide everything on the page 
  body * {
    display: none;
  }

  #content, #myImages, #myImages * {
    display: block;
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
  }

  #myImages br {
    display: none;
  }

  img {
    page-break-inside: avoid;
    page-break-after:always;
  }
}
@page {
  margin: 1cm;
}*/
</style>
</head>
<body onload="init()">
<div>
  <div id="myDiagram" style="background-color: #FFFFFF; border: solid 1px black; width:100%;"></div>
  <div id="myOverviewDiv"></div>
<input type="hidden" id="widthInput" value="842" />
<input type="hidden" id="heightInput" value="1191" />
<center><button id="makeImages">조직도 프린트</button></center>
<p><br><br><br><br></p>
<div id="myImages" ></div>

</body>
</html>
<script type='text/javascript'>
//	var height = parent.document.getElementById('treeview').scrollHeight - 120;
	var myWidth = 0, myHeight = 0;
    if (typeof (window.innerWidth) == 'number') { //Chrome
         myWidth = window.innerWidth;
         myHeight = window.innerHeight;
    } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
         myWidth = document.documentElement.clientWidth;
         myHeight = document.documentElement.clientHeight;
    } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) { //IE9
         myWidth = document.body.clientWidth;
         myHeight = document.body.clientHeight;
    }
	
	document.getElementById('myDiagram').style.height = (myHeight - 130) + 'px';
</script>

<script language="javascript">
<!--

      function prePrint(){
          var head = document.getElementsByTagName("head")[0];
        
          var style = document.createElement("style");
          style.setAttribute("type","text/css");
          var css_code = "html,body {overflow:hidden;width:100%;height:100%;}" +
                "@media print {" +
             "html, body {height:auto !important;}" +
             "div#myImages {position:static !important; margin:0 auto; width:auto; height:auto !important; overflow:visible !important; zoom:normal !important;}" +
             "div#myImages .pwth {width:auto !important;}" +
             "div#myImages div.btn-area, div#p-close {display:none;}" +
            "}";
            
      
        if (style.styleSheet) {
         style.styleSheet.cssText = css_code;
        } else {
         css_code = document.createTextNode(css_code);
         style.appendChild(css_code);
         
        }
        
        head.appendChild(style);
        style = null;
      
        window.print();
      }

//-->
</script>

<script type='text/javascript'>
// if width or height are below 50, they are set to 50
    function generateImages(width, height) {
      // sanitize input
      width = parseInt(width);
      height = parseInt(height);
      if (isNaN(width)) width = 100;
      if (isNaN(height)) height = 100;
      // Give a minimum size of 50x50
      width = Math.max(width, 50);
      height = Math.max(height, 50);



      var imgDiv = document.getElementById('myImages');
      imgDiv.innerHTML = ''; // clear out the old images, if any
      var db = myDiagram.documentBounds.copy();
      var boundswidth = db.width;
      var boundsheight = db.height;
      var imgWidth = width;
      var imgHeight = height;
      var p = db.position.copy();
      for (var i = 0; i < boundsheight; i += imgHeight) {
        for (var j = 0; j < boundswidth; j += imgWidth) {
          img = myDiagram.makeImage({
            scale: 1,
            position: new go.Point(p.x + j, p.y + i),
            size: new go.Size(imgWidth, imgHeight)
          });
          // Append the new HTMLImageElement to the #myImages div
          img.className = 'images';
          imgDiv.appendChild(img);
          imgDiv.appendChild(document.createElement('br'));
        }
      }
	  prePrint();
    }

	
    var button = document.getElementById('makeImages');
    button.addEventListener('click', function() {
      var width = parseInt(document.getElementById('widthInput').value);
      var height = parseInt(document.getElementById('heightInput').value);
      generateImages(width, height);
    }, false);

    // Call it with some default values
    generateImages(842, 1191);
	
</script>
