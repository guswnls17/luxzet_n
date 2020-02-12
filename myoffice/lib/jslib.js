
function _onKeyPress(ev)
{
	var Key = null;

	if (ev)
		Key = ev;    
	else
		Key = window.event;

	return ("0".charCodeAt() > Key.keyCode || "9".charCodeAt() < Key.keyCode) ? false : true;
}

function _onKeyDown(ev)
{
	var Key = null;

	if (ev)
		Key = ev;    
	else
		Key = window.event;

	return (Key.keyCode == 229) ? false : true;
}

function view_img(image)
{
	window.open('/uploadimage/' + image, 'view', 'width=800,height=600,scrollbars=yes,resizable=yes,toolbar=no');	
}

function commaNum(num) {  
	var len, point, str;  

	num = num + "";  
	point = num.length % 3  
	len = num.length;  

	str = num.substring(0, point);  
	while (point < len) {  
		if (str != "") str += ",";  
		str += num.substring(point, point + 3);  
		point += 3;  
	}  
	return str;  
}  

