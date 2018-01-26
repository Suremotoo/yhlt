//滚屏
var scrollScreen = true;
var supplierId;

//提示用户是否离开此页面（关闭、刷新或者点击后退等）
try{
	window.addEventListener("beforeunload", function (e) {
		var xmlhttp;     
	    if (window.XMLHttpRequest) {  
	        xmlhttp = new XMLHttpRequest();                  
	    } else {  
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");//IE
	    }
	    xmlhttp.open("GET",dynamicURL+"/notice/bid/bidroom/exitChatRoom?uuid="+uuid,false);     
	    xmlhttp.send();     
	});
}catch(e){
	
}

/* 语音识别 */
$("#voices").click(function(){
	$('#voicesDialog').dialog({
	    title: '语音识别',    
	    openAnimation:'fade',
	    closeAnimation:'fade',
	    width: 280,    
	    height: 200,    
	    closed: false,    
	    cache: false,    
	    modal: false   
	});
});

$(function(){
    $('<audio id="chatAudio"><source src="'+staticURL+'/bidroom/ogg/notify.wav" type="audio/wav"><source src="'+staticURL+'/bidroom/ogg/notify.ogg" type="audio/ogg"><source src="'+staticURL+'/bidroom/ogg/notify.mp3" type="audio/mpeg"></audio>').appendTo('body');// 载入声音文件
    //语音云按钮
	/*$('#voices').voicewo({
		'width'			  : 92,
		'height'		  : 25,
		'buttonImage'	  : staticURL+'/voices/btn.png',
		'swf'			  : staticURL+'/voices/voicewo.swf',
		'overrideEvents'  : ['onOutput'],
		'preventCaching'  :false,
		'onOutput'		  : function(value){
			if(value==null||value==""){
				value="请将麦克风声音调大效果更好!";
			}
		    $("#txtContent").html(value);
		},
	   'onFallback'   : function(value){
			$.messager.alert('提示', '系统检测到您没有安装flash,若使用语音功能请先安装flash并本网站添加到flash信任站点中。', 'error');
	    },
	});*/

	RefreshUser(); 
	RefreshSupplier();

	//初始化私聊下拉框
	supplierId = $('#supplierId').combobox({
		valueField: 'userId',
		textField: 'userName',
	    url: dynamicURL+'/notice/bid/bidroom/supplierCombobox?uuid='+uuid
	});
	
	//键盘回车监听
	$(document).keypress(function(e){
		if(e.which==13){
			var $content=$("#txtContent");
			if($content.val()!=""){
				SendMessage($content.val());
    		}else{
    			$.messager.alert('提示消息','您发送的内容不能为空');
    			return false;
    		}
		}
	});
	//发送按钮事件响应
	$("#sendMsg").on("click", 
    	_.debounce(function() {
    		var $content=$("#txtContent");
    		if($content.val()!=""){
    			SendMessage($content.val());
    		}else{
    			$.messager.alert('提示消息','您发送的内容不能为空');
    			return false;
    		}
   		},waitTime,true)
    );

	//加载JSON
	InitJSON();
	//读取全部消息
	GetAllMessageList();
	//自动刷新
	AutoRefresh();

	$("#viewBidDocument").click(function(){
		$('#bidDocument').dialog({
		    title: '查看标书',    
		    width: 1000,    
		    height: 400,    
		    closed: false,    
		    cache: false,    
		    href:dynamicURL+"/notice/bid/bidroom/toViewBidDocument?uuid="+uuid,    
		    modal: true   
		}); 
	});

	$("#viewGrade").click(function(){
		$('#viewGradeDialog').dialog({
		    title: '查看评分', 
		    openAnimation:'fade',
		    closeAnimation:'fade',
		    width: 1000,    
		    height: 400,    
		    closed: false,    
		    cache: false,    
		    href:dynamicURL+"/notice/score/viewGrade?noticeUUID="+uuid,  
		   	border:false,
		    modal: true   
		}); 
	});

	/**查看发送评标纪律 */
	$("#bidDiscipline").click(function(){
		$('#bidDocument').dialog({
		    title: '大厅消息',    
		    width: 1000,    
		    height: 500,    
		    closed: false,    
		    cache: false,    
		    href:dynamicURL+"/notice/bid/bidroommessage/toBidDisciplinePage",    
		    modal: true   
		}); 
	});

	//确认报价
	$(".message-btn").click(function(){
		SendMessage($(this).attr("message-data"));
	});
	
	/**查看承诺书*/
	$("#checkPromise").click(function(){
		$('#promiseDiv').dialog({
		    title: '查看承诺书',    
		    width: 1000,    
		    height: 500,    
		    closed: false,    
		    cache: false,    
		    href:dynamicURL+'/notice/bid/bidroom/toPromisePage?uuid='+uuid,  
		    modal: true   
		}); 
	});
});

//刷新用户
function RefreshUser(){
	$('#userDatalist').datalist({
	    url: dynamicURL+'/notice/bid/bidroom/userList?uuid='+uuid, 
	    checkbox: true, 
	    lines: true,
	    groupField:'userTypeValue',
	    valueField:'userId',
	    textField:'userName',
	    groupFormatter:function(value,rows){
	    	return value;
	    },
	    textFormatter:function(value,row,index){
	    	if(row.userTypeValue == "专家"){
		    	return row.userName+row.isOnlineWrapper+row.scoreFinishWrapper;
	    	}
	    	return row.userName+row.isOnlineWrapper;
	    }
	});  
}
//刷新投标方
function RefreshSupplier(){
	$('#supplierDatalist').datalist({ 
	    url: dynamicURL+'/notice/bid/bidroom/supplierList?uuid='+uuid, 
	    checkbox: true, 
	    lines: true,
	    valueField:'userId',
	    textField:'userName',
	    textFormatter:function(value,row,index){
	    	return row.userName+row.isOnlineWrapper+row.unlockFinishWrapper;
	    },
	    onClickRow:function(index,row){
			$.messager.show({
				title:'提示',
				msg:'设置当前私聊对象为：'+row.userName+'！！！',
				showType:'show',
				timeout:5000,
				border:true,
				style:{
					color:'red',
					right:'',
					bottom:''
				}
			});

	    	supplierId.combobox("setValue",row.userId);
	    }
	}); 
}
//初始化json
function InitJSON(){
    if(typeof JSON == 'undefined'){
	   $("head").append($("<script type='text/javascript' src='"+staticURL+"/scripts/json.js'/>"));
	}
}
//自动更新页面信息
var interval_id = null;
function AutoRefresh(){
	interval_id = setInterval(GetMessageList,2000);
}
//发送消息
function SendMessage(content){
	$.ajax({
		type:"POST",
		url:dynamicURL+"/notice/bid/bidroom/sendMessage",
		data:"uuid="+uuid+"&content="+encodeURI(content)+"&receiverUserId="+$("#supplierId").combobox("getValue"),
		success:function(data){
			if(data){
				$("#txtContent").val('');
				goToBottom();
			}else{
				$("#txtContent").val('');
				$.messager.alert('提示消息','您发送的信息不能为空');
			}
		}
	});

}
//获取全部消息
function GetAllMessageList(){
	$.ajax({
		type:"POST",
		dataType: "json",
		url:dynamicURL+"/notice/bid/bidroom/getAllChatContent?t="+new Date().getTime(),
		data:"uuid="+uuid,
		success:function(data){
			if(data.SUCCESS){
				//最新消息
				if(data.ALL_MESSAGE){
					$("#divContent").html(data.ALL_MESSAGE);
					goToBottom();
				}
			}
		}
	});
};
//获取消息
function GetMessageList(){
	$.ajax({
		type:"POST",
		dataType: "json",
		url:dynamicURL+"/notice/bid/bidroom/getChatContent?t="+new Date().getTime(),
		data:"uuid="+uuid,
		success:function(data){
			if(data.SUCCESS){
				//最新消息
				if(data.MESSAGE){
					try {
						$("#divContent").append(data.MESSAGE);
						goToBottom();
						$('#chatAudio')[0].play(); // 播放声音
					} catch(e){
						
					}
				}
				//指令部分
				if(data.REFRESH_USER){
					RefreshUser();
				}
				if(data.REFRESH_SUPPLIER){
					RefreshSupplier();
				}
				if(data.CLOSE_CHATROOM){
					closeWindows();
				}
				if(data.START_GRADE){
					$('#container .easyui-accordion').accordion('select',"评分管理");
					if(!$('#expertMarking')!=undefined){
						$('#expertMarking').tooltip({
							position: 'right',    
							content: '<div style="padding:5px;color:#000"><font size="4" color="white">请点击专家评分！</font></div>',    
							onShow: function(){
								$(this).tooltip('tip').css({
									backgroundColor: '#258fec',
									borderColor: '#258fec',
									boxShadow: '1px 1px 3px #292929'
								});
							}
						});
						$('#expertMarking').tooltip("show");
					}
				}
				if(data.GRADE_APPROVAL1){
					$('#container .easyui-accordion').accordion('select',"大厅管理");
					if(!$('#gradeApproval1')!=undefined){
						$('#gradeApproval1').tooltip({
							position: 'right',    
							content: '<div style="padding:5px;color:#000"><font size="4" color="white">请点击报价审核！</font></div>',    
							onShow: function(){
								$(this).tooltip('tip').css({
									backgroundColor: '#258fec',
									borderColor: '#258fec',
									boxShadow: '1px 1px 3px #292929'
								});
							}
						});
						$('#gradeApproval1').tooltip("show");
					}
				}
				if(data.GRADE_APPROVAL2){
					$('#container .easyui-accordion').accordion('select',"大厅管理");
					if(!$('#gradeApproval2')!=undefined){
						$('#gradeApproval2').tooltip({
							position: 'right',    
							content: '<div style="padding:5px;color:#000"><font size="4" color="white">请点击评分审核！</font></div>',    
							onShow: function(){
								$(this).tooltip('tip').css({
									backgroundColor: '#258fec',
									borderColor: '#258fec',
									boxShadow: '1px 1px 3px #292929'
								});
							}
						});
						$('#gradeApproval2').tooltip("show");
					}
				}
			} else if(data.TIMEOUT){
				closeWindows();
			}
		},error:function(XMLHttpRequest, textStatus, errorThrown){
			closeWindows();
		}
	});
};

//关闭大厅
function closeChatRoom(){
	$.messager.confirm('确认','您确认想要关闭大厅吗？',function(r){    
	    if (r){    
	    	$.ajax({
	    		type:"POST",
	    		dataType: "json",
	    		url:dynamicURL+"/notice/bid/bidroom/closeChatRoom",
	    		data:"uuid="+uuid,
	    		success:function(data){
	    			if(data.success){
	    				closeWindows();
	    			}else{
	    				$.messager.alert('提示消息',data.msg,'error');
	    			}
	    		}
	    	});   
	    }    
	});  
}

//关闭窗口
function closeWindows(){
	clearInterval(interval_id);
	$.messager.alert('','招标大厅已关闭！','info',function(){
	    window.opener=null;  
	    window.open('','_self');  
	    window.close();  
	});
}

//到底部去
function goToBottom(){
	if(scrollScreen){
		var div=document.getElementById("divContent");
		div.scrollTop = div.scrollHeight;
	}
}