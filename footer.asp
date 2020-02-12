<!-- Bootstrap core JavaScript--> 
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script> 

<!-- Core plugin JavaScript--> 
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script> 

<!-- Custom scripts for all pages--> 
<script src="/js/sb-admin-2.min.js"></script>
<script type="text/javascript">
var filter = "win16|win32|win64|mac";
if(navigator.platform){
	if(0 > filter.indexOf(navigator.platform.toLowerCase())){   // mobile
		$('#accordionSidebar').addClass('toggled');
	}
}
</script>
</body>
</html>