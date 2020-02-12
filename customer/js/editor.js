	 
//**	에디터 파일이 있는 경로 맨 뒤에 / 포함
	var Editor_Root_Dir	=	"/customer/editor/";
	var appName		= navigator.appName;											//**	브라우저명
	var appVersion	= parseFloat(navigator.appVersion.split("MSIE")[1]);			//**	브라우저 버전
	var bitUseEditor																//**	에디터 사용 유무

		if(appName != "Microsoft Internet Explorer" || appVersion < 5.5){
			bitUseEditor	= false;												//**	익스플로어가 아니고 버전이 5.5보다 작을때는 "사용 안함"
		}else{
			bitUseEditor	= true;													//**	에디터 사용함
		}
		
	if(bitUseEditor){
		document.write('<scrip'+'t language="JScript" src="'+Editor_Root_Dir+'editor_image/KNEditor.js"></scrip'+'t>');
	}
