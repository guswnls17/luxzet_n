<!-- #Include virtual = "/myoffice/lib/db.asp" -->
<!-- #Include virtual = "/myoffice/lib/function.asp" -->

<!--#include file="header.asp" -->

<%

	sy = Year(Date)
	sm = Month(Date)
	sd = Day(Date)

	 if(Len(sm) = 1 ) then sm = "0" & sm
	 if(Len(sd) = 1 ) then sd = "0" & sd
	 sale_date = sy & sm & sd 
	 

	myamount = 0 
	lim1 = 0 
	lim2 = 0 
	mylimit = 0
	uselimit = 0
	myewallet = 0 
	point = 0
	
	sql = "SELECT	"
sql = sql& "isnull(sum(sale_kum),0) "									
sql = sql& "FROM	sale02		"
sql = sql& "WHERE sale02.sale_mem_code	= '"&Session("member")&"' and isnull(sale_o_gubun,' ') <> '2' "

' response.write sql
Call f_sql_select(db_conn, sql, arrData)
If arrData(0,0) <> "" Then 
	myamount = FormatNumber(arrData(0,0),0)
End If 

    sql = " SELECT Isnull(sum(temp_su_orgkum), 0) FROM temp_pay WHERE temp_mem_code = '"&Session("member")&"' and (temp_su_date >= '20191126') and (temp_su_gubun <> '80')  "
	If f_sql_select(db_conn, sql, arrData) > 0 Then
		lim1  = arrData(0, 0)
	End If 

	sql = " SELECT Isnull(sum(sale_pvkum), 0) FROM sale02 WHERE sale_mem_code =  '"&Session("member")&"' and (sale_date between '20190801' and '"&sale_date&"') "
	If f_sql_select(db_conn, sql, arrData) > 0 Then
		lim2  = arrData(0, 0)
	End If 
	
	totallimit = (lim2 * 4)
	mylimit = totallimit - lim1
	uselimit = lim1 

	menu1 = "회원정보"
	menu2 = "내정보"
	
	sq1 = "select a.mem_code, (select mem_code from mmember where mem_code = a.mem_code) from mmember_temp a where a.mem_code = '" & Session("member") & "' "
		If f_sql_select(db_conn, sq1, arrData) > 0 Then
			n_memno = arrData(0, 0)
			s_memno = arrData(1, 0)
		End If
		If LEN(s_memno)  > 6 Then 
			n_table = "mmember"
		Else 
			n_table = "mmember_temp"
		End If 

    sql = "SELECT Isnull(mem_ye_kum,0) , Isnull(mem_rewards,0) "
    sql = sql & "FROM "&n_table&" A "
    sql = sql & "WHERE 1=1 "
	sql = sql & "AND a.mem_id = '" & session("userid") & "'"

	If f_sql_select(db_conn, sql, arrData) > 0 Then
		myewallet = round(arrData(0, 0),2)
		point = round(arrData(1, 0),2)
	End If
	
	Dim hoo_code(10) '후원인 코드추출 후 A, B로 나눔
		sql = "select mem_code " _  
			& "from mmember " _
			& "where mem_hoo_code='"&Session("member")&"' and mem_code <> '0000000000' "

		lngDataCnt = f_sql_select(db_conn, sql, arrData)
		For i = 0 To lngDataCnt - 1 Step 1
			hoo_code(i)=arrData(0, i)
		Next
	Dim chart11(10), chart12(10), chart21(10), chart22(10)
if hoo_code(0) <> "" Then 		
	sql = " SELECT TOP 10 sale_date, sum(sale_kum) FROM	mem_hdown, mmember, sale02 WHERE "
	sql = sql& " ( mem_hdown.down_down = mmember.mem_code ) and	sale02.sale_date > '20161113' and "									
	sql = sql& " ( mmember.mem_code = sale02.sale_mem_code ) and	( mem_hdown.down_member = '"&hoo_code(0)&"')  GROUP BY  sale_date order by sale_date desc	"
'	Response.write sql & "<br/>"
	lngDataCnt = f_sql_select(db_conn, sql, arrData)
	For i = 0 To lngDataCnt - 1
'		Response.write lngDataCnt -1 -i & " : " &arrData(0,i) & " : " & arrData(1,i) & "<br/>"
		chart11(lngDataCnt -1 -i) = arrData(0,i)
		chart12(lngDataCnt -1 -i) = arrData(1,i)
	Next 
End If 
if hoo_code(1) <> "" Then 		
	sql = " SELECT TOP 10 sale_date, sum(sale_kum) FROM	mem_hdown, mmember, sale02 WHERE "
	sql = sql& " ( mem_hdown.down_down = mmember.mem_code ) and	sale02.sale_date > '20161113' and "									
	sql = sql& " ( mmember.mem_code = sale02.sale_mem_code ) and	( mem_hdown.down_member = '"&hoo_code(1)&"')  GROUP BY  sale_date order by sale_date desc	"

	lngDataCnt = f_sql_select(db_conn, sql, arrData)
	For i = 0 To lngDataCnt - 1
'		Response.write arrData(0,i) * " : " & arrData(1,i)
		chart21(lngDataCnt -1 -i) = arrData(0,i)
		chart22(lngDataCnt -1 -i) = arrData(1,i)
	Next 
End If 
'Response.write 13 & chart11(0)
'Response.write chart21(0)

 sql = "SELECT isNull(mem_rcoin,0) , isNull(mem_acoin,0)  "
    sql = sql & "FROM mmember  "
    sql = sql & "WHERE 1=1 "
	sql = sql & "AND mem_id = '" & session("userid") & "'"

	If f_sql_select(db_conn, sql, arrData) > 0 Then
		mem_rcoin = arrData(0, 0)								'베리티움 총 보유코인
		mem_acoin = arrData(1, 0)								'베리티움 총 지급코인
		
	End If

  
%>

    <div class="container-fluid"><!-- Begin Page Content -->
       
		<div class="row"><!-- Content Row -->
            <div class="col-xl-12 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    
					<div class="col border-bottom"><!-- Point -->
					    <ul class="list-inline-item2">
                            <li class="font-weight-bold text-white btn-title text-uppercase pt-3"><%=language(lan,264)%></li>
					        <li class="h5 ml-2 font-weight-bold text-black-700 text-ld"><%=formatnumber(point,2)%></li>
					  </ul>
                    </div>
                    <div class="col border-bottom mt-2"><!-- E-Wallet -->
					    <ul class="list-inline-item2">
                            <li class="font-weight-bold text-white btn-title text-uppercase pt-3"><%=language(lan,52)%></li>
					        <li class="h5 ml-2 font-weight-bold text-black-700 text-ld"><%=formatnumber(myewallet,2)%></li>
					  </ul>
                    </div>
                    <div class="col border-bottom mt-2"><!-- Total Holding LXZ -->
					    <ul class="list-inline-item2">
                            <li class="font-weight-bold text-white btn-title text-uppercase"><%=language(lan,113)%></li>
					        <li class="h5 ml-2 font-weight-bold text-black-700 text-ld"><%=FormatNumber(mem_rcoin,4)%></li>
					  </ul>
                    </div>
					<div class="col mt-2"><!-- Total Payment LXZ -->
					    <ul class="list-inline-item2">
                            <li class="font-weight-bold text-white btn-title text-uppercase"><%=language(lan,114)%></li>
					        <li class="h5 ml-2 font-weight-bold text-black-700 text-ld"><%=FormatNumber(mem_acoin,4)%></li>
					  </ul>
                    </div>

                  </div>
                </div>
              </div>
            </div>
        </div><!-- Content Row -->
  
 		<div class="row"><!-- Content Row -->
            <div class="col-xl-12 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    
					<div class="col border-bottom"><!-- Point -->
					    <ul class="list-inline-item2">
                            <li class="font-weight-bold text-white btn-title2 text-uppercase pt-3"><%=language(lan,225)%></li>
					        <li class="h5 ml-2 font-weight-bold text-black-700 text-ld"><%=formatnumber(myamount,0)%></li>
					  </ul>
                    </div>
                    <div class="col border-bottom mt-2"><!-- E-Wallet -->
					    <ul class="list-inline-item2">
                            <li class="font-weight-bold text-white btn-title2 text-uppercase pt-3"><%=language(lan,226)%></li>
					        <li class="h5 ml-2 font-weight-bold text-black-700 text-ld"><%=formatnumber(totallimit,2)%></li>
					  </ul>
                    </div>
                    <div class="col border-bottom mt-2"><!-- Total Holding LXZ -->
					    <ul class="list-inline-item2">
                            <li class="font-weight-bold text-white btn-title2 text-uppercase pt-3"><%=language(lan,227)%></li>
					        <li class="h5 ml-2 font-weight-bold text-black-700 text-ld"><%=formatnumber(mylimit,2)%></li>
					  </ul>
                    </div>
					<div class="col mt-2"><!-- Total Payment LXZ -->
					    <ul class="list-inline-item2">
                            <li class="font-weight-bold text-white btn-title2 text-uppercase pt-3"><%=language(lan,228)%></li>
					        <li class="h5 ml-2 font-weight-bold text-black-700 text-ld"><%=formatnumber(uselimit,2)%></li>
					  </ul>
                    </div>

                  </div>
                </div>
              </div>
            </div>
        </div><!-- Content Row -->

          <!-- Content Row -->          
          <div class="row">
            <!-- Area Chart -->
            <div class="col-xl-4 col-md-6 mb-4">
              <div class="card3 shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card3-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="font-weight-bold m-0 text-uppercase text-md2 text-white"><%=language(lan,229)%></h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">Dropdown Header:</div>
                      <a class="dropdown-item" href="#">Action</a>
                      <a class="dropdown-item" href="#">Another action</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
                <div class="card3-body">
                  <div class="chart-area">
                    <canvas id="myAreaChart"></canvas>
                  </div>
                </div>
              </div>
            </div>
            
			<!-- Area Chart -->
            <div class="col-xl-4 col-md-6 mb-4">
              <div class="card3 shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card4-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="font-weight-bold m-0 text-uppercase text-md2 text-white"><%=language(lan,230)%></h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">Dropdown Header:</div>
                      <a class="dropdown-item" href="#">Action</a>
                      <a class="dropdown-item" href="#">Another action</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
                <div class="card3-body">
                  <div class="chart-area">
                    <canvas id="myAreaChart02"></canvas>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- Area Chart -->
            <div class="col-xl-4 col-md-6 mb-4">
              <div class="card3 shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card5-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="font-weight-bold m-0 text-uppercase text-md2 text-white"><%=language(lan,231)%></h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">Dropdown Header:</div>
                      <a class="dropdown-item" href="#">Action</a>
                      <a class="dropdown-item" href="#">Another action</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
                <div class="card3-body">
                  <div class="chart-area">
                    <canvas id="myAreaChart03"></canvas>
                  </div>
                </div>
              </div>
            </div>            
          </div>
          
          <!-- content row 
          <div class="row">     -->          
            <!-- Area Chart
            <div class="col-xl-12 col-lg-12">
              <div class="card shadow mb-4">  -->
                <!-- Card Header - Dropdown
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 text-primary text-uppercase text-md">D-team sales by period</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">Dropdown Header:</div>
                      <a class="dropdown-item" href="#">Action</a>
                      <a class="dropdown-item" href="#">Another action</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                  </div>
                </div> -->
                <!-- Card Body 
                <div class="card-body">
                  <div class="chart-area">
                    <canvas id="myAreaChart04"></canvas>
                  </div>
                </div>
              </div>
            </div>            
          </div>-->

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="javascript:logout();">Logout</a>
        </div>
      </div>
    </div>
  </div>
    <script src="/vendor/chart.js/Chart.min.js"></script>
 <script>
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}

// Area Chart Example
var ctx = document.getElementById("myAreaChart");
var myLineChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: [
<% for i=0 to UBound(chart11)-1 
	If i <> 0 Then 
	   Response.write ","
	End If
	Response.write	chr(34)&chart11(i)&chr(34)
  Next 	 %>
	],
    datasets: [{
      label: "Earnings",
      lineTension: 0.3,
      backgroundColor: "rgba(78, 115, 223, 0.05)",
      borderColor: "rgba(78, 115, 223, 1)",
      pointRadius: 3,
      pointBackgroundColor: "rgba(78, 115, 223, 1)",
      pointBorderColor: "rgba(78, 115, 223, 1)",
      pointHoverRadius: 3,
      pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
      pointHoverBorderColor: "rgba(78, 115, 223, 1)",
      pointHitRadius: 10,
      pointBorderWidth: 2,
      data: [
<% for i=0 to UBound(chart12)-1 
	If i <> 0 Then 
	   Response.write ","
	End If
	Response.write	chart12(i)
  Next 	 %>	  
	  ],
    }],
  },
  options: {
    maintainAspectRatio: false,
    layout: {
      padding: {
        left: 10,
        right: 25,
        top: 25,
        bottom: 0
      }
    },
    scales: {
      xAxes: [{
        time: {
          unit: 'date'
        },
        gridLines: {
          display: false,
          drawBorder: false
        },
        ticks: {
          maxTicksLimit: 7
        }
      }],
      yAxes: [{
        ticks: {
          maxTicksLimit: 5,
          padding: 10,
          // Include a dollar sign in the ticks
          callback: function(value, index, values) {
            return '$' + number_format(value);
          }
        },
        gridLines: {
          color: "rgb(234, 236, 244)",
          zeroLineColor: "rgb(234, 236, 244)",
          drawBorder: false,
          borderDash: [2],
          zeroLineBorderDash: [2]
        }
      }],
    },
    legend: {
      display: false
    },
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      titleMarginBottom: 10,
      titleFontColor: '#6e707e',
      titleFontSize: 14,
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      intersect: false,
      mode: 'index',
      caretPadding: 10,
      callbacks: {
        label: function(tooltipItem, chart) {
          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
          return datasetLabel + ': $' + number_format(tooltipItem.yLabel);
        }
      }
    }
  }
});
// Area Chart Example
var ctx = document.getElementById("myAreaChart02");
var myLineChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: [
<% for i=0 to UBound(chart21)-1 
	If i <> 0 Then 
	   Response.write ","
	End If
	Response.write	chr(34)&chart21(i)&chr(34)
  Next 	 %>	
	],
    datasets: [{
      label: "Earnings",
      lineTension: 0.3,
      backgroundColor: "rgba(78, 115, 223, 0.05)",
      borderColor: "rgba(78, 115, 223, 1)",
      pointRadius: 3,
      pointBackgroundColor: "rgba(78, 115, 223, 1)",
      pointBorderColor: "rgba(78, 115, 223, 1)",
      pointHoverRadius: 3,
      pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
      pointHoverBorderColor: "rgba(78, 115, 223, 1)",
      pointHitRadius: 10,
      pointBorderWidth: 2,
      data: [
<% for i=0 to UBound(chart22)-1 
	If i <> 0 Then 
	   Response.write ","
	End If
	Response.write	chart22(i)
  Next 	 %>		  
	  ],
    }],
  },
  options: {
    maintainAspectRatio: false,
    layout: {
      padding: {
        left: 10,
        right: 25,
        top: 25,
        bottom: 0
      }
    },
    scales: {
      xAxes: [{
        time: {
          unit: 'date'
        },
        gridLines: {
          display: false,
          drawBorder: false
        },
        ticks: {
          maxTicksLimit: 7
        }
      }],
      yAxes: [{
        ticks: {
          maxTicksLimit: 5,
          padding: 10,
          // Include a dollar sign in the ticks
          callback: function(value, index, values) {
            return '$' + number_format(value);
          }
        },
        gridLines: {
          color: "rgb(234, 236, 244)",
          zeroLineColor: "rgb(234, 236, 244)",
          drawBorder: false,
          borderDash: [2],
          zeroLineBorderDash: [2]
        }
      }],
    },
    legend: {
      display: false
    },
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      titleMarginBottom: 10,
      titleFontColor: '#6e707e',
      titleFontSize: 14,
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      intersect: false,
      mode: 'index',
      caretPadding: 10,
      callbacks: {
        label: function(tooltipItem, chart) {
          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
          return datasetLabel + ': $' + number_format(tooltipItem.yLabel);
        }
      }
    }
  }
});
// Pie Chart Example
var ctx = document.getElementById("myAreaChart03");
var myPieChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: ["Use", "Limit"],
    datasets: [{
      data: [<%=uselimit%>,<%=mylimit%>],
      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
      hoverBorderColor: "rgba(234, 236, 244, 1)",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: false
    },
    cutoutPercentage: 80,
  },
});
</script> 

	  <!-- Page level plugins -->

  <!--#include file="footer.asp"-->