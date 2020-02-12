<!--#include virtual = "/myoffice/lib/db.asp"-->
<%
memno1 = request("memno1")
memberno = request("memno")
organ = request("organ")
down = request("down")
step = request("step")
flow = request("flow")
nopic = request("nopic")

if (memberno = "") then memberno = "1000000"
if (memno1 = "") then memno1 = memberno
if (organ = "") then organ = "recom"
if (down = "") then down = "yes"
if (step = "") then step = "5"
if (flow = "") then flow = "down"
if (nopic = "") then nopic = "N"
if (mem_name = "") then mem_name = "Y"
'Response.write memberno&"/"&memno1
%>
<!doctype html>
<html>
<head>
<title>Org Chart Static</title>
<script type="text/javascript" src="/myoffice/lib/httpRequest.js"></script>
<script type="text/javascript" src="go.js"></script>
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
		str += "\nU.N: " + info.grade;
		str += "\nAgency: " + info.agency;
		str += "\nPV: " + info.selfsales;
      return str;
    }

	function childcheck(info) {
		return (info.child > 0) ? true : false;
	}

    myDiagram.nodeTemplate =
      $(go.Node, go.Panel.Auto,
        { isShadowed: true },
        $(go.Shape,
          { figure: "BpmnTaskUser",
            fill: "azure" 
		  },
          new go.Binding("fill", "color")
		 ),
        $(go.Panel, go.Panel.Table,
          { margin: 3, maxSize: new go.Size(150, NaN), minSize: new go.Size(80, NaN) 
		  },
          $(go.RowColumnDefinition,
            { column: 0,
              stretch: go.GraphObject.Horizontal,
              alignment: go.Spot.Left 
			}
		   ),
          $(go.TextBlock,
            { row: 0, column: 0,
              margin: 15, maxSize: new go.Size(120, NaN),
              font: "bold 10pt sans-serif" , stroke: "black",
              alignment: go.Spot.Top
			},
            new go.Binding("text", "name")
		   ),
          $(go.TextBlock,
            { row: 1, column: 0,
              font: "9pt sans-serif"  , stroke: "black"
			},
            new go.Binding("text", "", theInfoTextConverter)
		   ),
		  $("Button",
          { alignment: go.Spot.TopLeft,
            alignmentFocus: go.Spot.Center,
            click: function (e, obj) {
              var node = obj.part;
              if (node === null) return;
              var data = node.data;
              info(data.key);
            }
		  }, $(go.TextBlock, "+"))
		 ,  { doubleClick: nodeDoubleClick }
		 )
		);

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
flow = request("flow")
nopic = request("nopic")

if (memberno = "") then memberno = "1000000"
if (memno1 = "") then memno1 = memberno
if (organ = "") then organ = "recom"
if (down = "") then down = "yes"
if (step = "") then step = "5"
if (flow = "") then flow = "down"
if (nopic = "") then nopic = "N"



sql = "SP_회원_조직조회_트리 '" & memberno & "', '" & organ & "', '" & down &"', '" & memno1 & "', '" & step & "' "

'response.write "//" & sql & chr(13) & chr(10)

lngDataCnt = f_sql_select(db_conn, sql, arrData)

for i = 0 to lngDataCnt - 1
	color0 = "#C3C3C3"
	grade = arrData(4, i)

	
	s_pv = arrData(12, i)
	
	  if CLng(s_pv) >= 9000 then 
		color0 = "#ff0000"	':빨
	  elseif CLng(s_pv) >= 4500 then 
		color0 = "#ff8200"  ':주
	  elseif CLng(s_pv) >= 2700 then 
		color0 = "#ffb500"  ':노
	  elseif CLng(s_pv) >= 1800 then 
		color0 = "#008000"  ':초
	  elseif CLng(s_pv) >= 900 then 
		color0 = "#0000ff"  ':파
	  elseif CLng(s_pv) >= 270 then 
		color0 = "#4b0082"   ':남
	  elseif CLng(s_pv) >= 90 then 
		color0 = "#800080"  ':보
	  end if 
	
	if arrData(3, i) = "0" then
		color0 = "#454545"
	end if
	color0 = "#E7E7E7"

	selfinfo = formatnumber(arrData(5, i), 0)

	if i = 0 then
		response.write "{ key: """ & arrData(0, i) & """, color: """ & color0 & """, boss:"""", name: """ & arrData(4, i) & """, grade: """ & grade & """, selfsales: """ & selfinfo & """, child: """ & arrData(6, i) &  """, agency: """ &arrData(9, i) & """ , pic: """ & arrData(10, i) & """ }"
	else
		response.write ", { key: """ & arrData(0, i) & """, color: """ & color0 & """, boss: """ & arrData(1, i) & """, name: """ & arrData(4, i) & """, grade: """ & grade & """, selfsales: """ & selfinfo & """, child: """ & arrData(6, i) &  """, agency: """ &arrData(9, i) & """, pic: """ & arrData(10, i) & """ }"
	end if
next
%>
	];

    var linkArray = [];
    for (var i = 0; i < nodeDataArray.length; i++) {
      var n = nodeDataArray[i];
      if (n.boss !== undefined) {
        linkArray.push({ from: n.boss, to: n.key });
      }
    }

    myDiagram.model = new go.GraphLinksModel(nodeDataArray, linkArray);

    myDiagram.layout =
      $(go.TreeLayout,
        { angle: 90,
          nodeSpacing: 5 });

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
	// alert("down : " + parentdata.boss);
	var memno = "";
	var memno1 = "";
	if (parentdata.boss == ''){
		memno = document.getElementById('usermember').value;
		memno1 = <%=memno1%>;
	}else{
		memno = parentdata.key;
		memno1 = <%=memno1%>;
	}
	// alert("treeview.asp?memno=" + memno + "&memno1="+memno1+"&organ=<%=organ%>&down=" + ((parentdata.boss == '') ? 'no' : 'yes') + "&step=<%=step%>");
	document.location = "treeview2.asp?memno=" + memno + "&memno1="+memno1+"&organ=<%=organ%>&down=" + ((parentdata.boss == '') ? 'no' : 'yes') + "&step=<%=step%>";
  }

function info(memno)
  {
	var params = 'memno=' + memno;
	sendRequest('member_info.asp', params, f_info_reply, 'POST');
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
		if (myDiagram.scale < 1) myDiagram.scale += 0.1;
  }

  function f_minus()
  {
		if (myDiagram.scale > 0.2) myDiagram.scale -= 0.1;
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
<input type="hidden" id="widthInput" value="842" />
<input type="hidden" id="heightInput" value="1191" />
<input type="hidden" id="usermember" value="<%=Session("member")%>" />
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
	
	document.getElementById('myDiagram').style.height = (myHeight - 10) + 'px';
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
