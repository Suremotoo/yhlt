<%@ page contentType="text/html;charset=UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>æ æ é¢ææ¡£</title>
<style type="text/css">
</style>
</head>

<body>

<link rel="stylesheet" type="text/css" href="Huploadify.css"/>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="jquery.Huploadify.js"></script>
<script type="text/javascript">
$(function(){
	var up = $('#upload').Huploadify({
		auto:false,
		fileTypeExts:'*.jpg;*.png;*.exe;*.mp3;*.mp4;*.zip;*.doc;*.docx;*.ppt;*.pptx;*.xls;*.xlsx;*.pdf;*.txt',
		multi:true,
		fileSizeLimit:99999999,
		breakPoints:true,
		saveInfoLocal:true,
		showUploadedPercent:true,
		showUploadedSize:true,
		removeTimeout:9999999,
		uploader:'/ems2/system/resources/upload',
		onUploadSuccess:function(){
			//alert('success');
		},
		saveUploadedSize:function(file){
		},
		getUploadedSize:function(file){
			var data = {
				fileName : file.name,
				strLastModified : file.lastModifiedDate.getTime()
			};
		    var url = '/ems2/system/resources/uploadedSize';
		    var uploadedSize = 0;
			$.ajax({
				url : url,
				data : data,
				type : 'POST',
				async : false,
				success : function(msg){
					msg=JSON.parse(msg);
					uploadedSize = msg.uploadedSize;
				}
			}); 
			return uploadedSize;
		}	
	});

	$('#btn1').click(function(){
		up.stop();
	});
	$('#btn2').click(function(){
		up.upload('*');
	});
	$('#btn3').click(function(){
		up.cancel('*');
	});
	$('#btn4').click(function(){
		up.disable();
	});
	$('#btn5').click(function(){
		up.ennable();
	});


});
</script>
<div id="upload"></div>
<button id="btn1">stop</button>
<button id="btn2">upload</button>
<button id="btn3">cancel</button>
<button id="btn4">disable</button>
<button id="btn5">ennable</button>
</body>
</html>
