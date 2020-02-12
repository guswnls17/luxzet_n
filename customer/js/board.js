<!--
 var defCharset=document.charset;
 
 function form_chk(form){   

		//alert(navigator.userAgent);
	     if (/MSIE/.test(navigator.userAgent)) {
                       document.charset = 'euc-kr';
         }
		 
		 if (/Mozilla/.test(navigator.userAgent)) {
                       document.charset = 'euc-kr';
         }

		if(!form.subject.value){
			alert('Please enter a title.');
			form.subject.focus();
			return;
		}
		/*else if(!form.content.value){
			alert("내용을 입력하세요"); 
			//form.content.focus();
			return;
		}*/

 	 //var content = ed.getHtml(); //대체한 textarea에 작성한HTML값 전달 	 
	 var massage_st = (form.flag.value=="insert" || form.flag.value=="answer") ? "Registration" : "Modify";
	if(confirm("Do you want to "+massage_st+"?")) form.submit(); 

	 document.charset=defCharset;
 }  

//-->