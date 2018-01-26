/**
 * 识别js
*/
var address = "";
var asr_type = null;

//**********************************************
//初始页面显示内容函数定义
//**********************************************
//显示短信内容
var showSmsMsg = function()
{
};

//显示播放器
var showSingMsg = function()
{	var music_flash_str = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="400" height="95" id="bdmp3widget3295"><param name="movie" value="http://box.baidu.com/widget/flash/mbsong.swf?name=七里香&artist=周杰伦"></param><param name="wmode" value="opaque"></param><param name="allowscriptaccess" value="always"></param><embed src="http://box.baidu.com/widget/flash/mbsong.swf?name=七里香&artist=周杰伦" type="application/x-shockwave-flash" wmode="opaque" allowscriptaccess="always" width="400" height="95" name="bdmp3widget3295"></embed></object>';
	$('#local_flash').html(music_flash_str);
	// $('#local_flash').html('<embed  src="http://box.baidu.com/widget/flash/mbsong.swf?name=&artist=&autoPlay=auto" allowscriptaccess="never" allownetworking="internal" width="400" height="95" type="application/x-shockwave-flash" />');
};

//显示地图
var showPlaceMsg = function()
{
	var map = new BMap.Map('demo_text');            // 创建Map实例
	var point = new BMap.Point(116.404, 39.915);    // 创建点坐标
	map.centerAndZoom(point,10);                     // 初始化地图,设置中心点坐标和地图级别。
	map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
	map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
	setMapEvent(map);//设置地图事件
    addMapControl(map);//向地图添加控件
};

 //地图事件设置函数：
function setMapEvent(map){
    map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
    map.enableScrollWheelZoom();//启用地图滚轮放大缩小
    map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
    map.enableKeyboard();//启用键盘上下左右键移动地图
}
//创建地图函数：
function createMap(){
    var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
    var point = new BMap.Point(116.395106,39.929543);//定义一个中心点坐标
    map.centerAndZoom(point,12);//设定地图的中心点和坐标并将地图显示在地图容器中
    window.map = map;//将map变量存储在全局
}
//地图控件添加函数：
function addMapControl(map){
    //向地图中添加缩放控件
	var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
	map.addControl(ctrl_nav);
	    //向地图中添加缩略图控件
	var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
	map.addControl(ctrl_ove);
	    //向地图中添加比例尺控件
	var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
	map.addControl(ctrl_sca);
}


//显示视频
var showVideoMsg = function()
{
	var demo_text = document.getElementById('demo_text');
	demo_text.innerHTML = '<embed src="http://player.youku.com/player.php/sid/XMjI2NDk1Nzcy/v.swf"  width="1000px" height="493px" quality="left" align="middle" wmode="transparent" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"  ></embed>';
};
//取得地区
var getAreaName = function()
{
	var city_name = $('#city').val();
	var province_name = $('#province').val();
	return province_name + city_name;	
};

//**********************************************
//结果解析函数
//**********************************************
//显示短信
var flag=true;
var smsParseStr = function(result) 
{//alert(result)
	if (result.match(/\。$/))
	{
		result = result.replace(/(.*?)\。$/g,"$1");			
	}
	if(flag){
		//$('#demo_result').html(result);
		var index = $(".content .content_main .content_item").length,dateTime = new Date, hh=dateTime.getHours(),mm=dateTime.getMinutes(),
			timeStr = (hh>12)?("PM "+(hh-12)+":"+ mm):("AM "+hh+":"+ mm),
			textStr = "<div class='content_item content_item"+index%2+"'><div class='time'>"+timeStr+"</div><div class='text'><div class='scrollouter' onscroll='scrollOuter.call(this)'>"+
					"<div class='show_mes_textarea scrollinner'  name='demo_result'  >"+result+"</div></div>"+
					"<div class='scrollbar non'><div class='bar' id='barx' onmouseup='barMouseUp(event)' onmousemove='barMouseMove(event)' onmousedown='barMouseDown.call(this,event)'></div></div></div></div>";
		$(".message .content .content_main .content_inner").append(textStr);
		$(".message .content .content_main").scrollTop($(".message .content .content_main .content_item").height()*(index+1)); 
		flag=false;
		//滚动条
		setBar($(".text:last"));
	}else{
		/*if(!result||result==""){
			result="请说出你的文本内容..."
		}*/
		$("#txtContent").html(result);
		//$('#chatAudio')[0].play();
		$(".content_inner .show_mes_textarea:last ").text(result);
		setBar($(".text:last"));
		var barObj = $(".content_item:last .bar");
		$(".content_item:last .scrollouter").scrollTop(1000);
		
	}
	
};
if($(".content .content_main .content_item .time")){
	var dateTime = new Date, hh=dateTime.getHours(),mm=dateTime.getMinutes(),
			timeStr = (hh>12)?("PM "+(hh-12)+":"+ mm):("AM "+hh+":"+ mm);
	$(".content .content_main .content_item .time").html(timeStr);
	
}


//全国地名搜索解析
var locationParseStr = function(result)
{
	var reg = /"(w)"\:\"(.+?)\"/g;
	var r_result = result.match(reg);
	var r_result_html = '';
	if (r_result == null)
	{
		location_html = '正在搜索……';
	}
	else
	{
		var location_html = '';
		var reg1 = /"(txt)"\:\"(.+?)\"/g;
		var json_content = result.match(reg1);
		if (json_content == null)
		{
			location_html = '无法找到该地址。';
		}
		else
		{
			var i = 0;
			for (i = 0;i < json_content.length;i++)
			{
				var place = json_content[i];
				place = place.replace(reg1,"$2");
				if (i == 0)
				{
					location_html = place;
					if (place != '') showAddress(place);
				}
			}
		}
	}	
	$('#demo_result').removeClass("non");
	$('#demo_result span').html("："+location_html);
};
// 显示地图位置
var showAddress = function(address)
{
	var city = $('#city').val();
	var province = $('#province').val();

	var city_name = new String();
	if (typeof(city) != 'undefined' && typeof(province) != 'undefined' )
		city_name = province + city;
	else
		city_name = '中国';
	var map = new BMap.Map('demo_text');
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);
	map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
	map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
	var local = new BMap.LocalSearch(city_name, {
	  renderOptions: {
	    map: map,
	    autoViewport: true,
	    selectFirstResult: true
	  }
	});
	local.search(address);
	$(".BMap_stdMpType0").css("top",70);
};

//视频搜索解析
var youkuParseStr = function(result)
{
	var field = ''; 
	result = result.replace(/(.*?)\。/g,"$1");
	var reg = /"(w)"\:\"(.+?)\",/g;
	result = result.match(reg);
	var r_result_html = '';
    for (i = 0;i < result.length;i++)
    {
            var place = result[i];
            place = place.replace(reg,"$2");
            r_result_html += place;
    }
	getYoukuHtml(r_result_html);
	field = r_result_html;
	$('#demo_result').removeClass("non");
	$('#demo_result span').html("："+field);
};

//写入优酷视频(优酷视频接口)
var getYoukuHtml = function(str)
{
	var video_id = '';
	if (!str) 
	{
		return;
	}
	else
	{
		//ajax获得视屏
		$.ajax({
			type: 'post',
			url:address+'index.php/default/ajax_getvideo',
			dataType:'text',
			data: 'search_str=' + encodeURIComponent(str) + '&num='+ Math.random(),
			success: function(text){
				video_id = text;
				var field = '<embed src="http://player.youku.com/player.php/sid/' + video_id + '/v.swf" quality="high"  width="1000px" height="493px" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" wmode="transparent"></embed>';
				$('#demo_text').html(field);
			},
			error:function(){
			}
		});
		
		
	}
};

//音乐检索解析
function singParseStr(result)
{
		var reg = /"(w)"\:\"(.+?)\"/g;
        var r_result = result.match(reg);
        var r_result_html = '';
        if (r_result == null)
        {
                location_html = '正在搜索……';
        }
        else
        {
//                r_result_html = '<br />';

                var sing_str = new String();
                var i = 0;
                for (i = 0;i < r_result.length;i++)
                {
                        var place = r_result[i];
                        place = place.replace(reg,"$2");
                        r_result_html += place;
                }
//                r_result_html += '<br /><br />';
                var location_html = '';
                var reg1 = /"(txt)"\:\"(.+?)\"/g;
                var json_content = result.match(reg1);
                if (json_content == null)
                {
                        location_html = '无法找到该节目。';
                }
                else
                {
                        var i = 0;
                        for (i = 0;i < json_content.length;i++)
                        {
                                var place = json_content[i],className="";
                                if(i==0){
                                	className="cur";
                                }
                                place = place.replace(reg1,"$2");
                                location_html += "<a class='ell "+className+"'  href=\"javascript:mspLocalListen('" + place + "')\" onclick='selectedMusic.call(this)' >" + place + "</a><br />";
                                if (i==0) sing_str = place;
                                if (i != json_content.length - 1) location_html += '<br />';
                        }
                }
                mspLocalListen(sing_str);
                location_html = location_html;
        }
        //document.getElementById('demo_result').innerHTML = location_html;
        //滚动条
		setBar($("#scrollbardiv1"));
        document.getElementById('iat_result').innerHTML = r_result_html;

}

function selectedMusic(){
	$("#demo_result .cur").removeClass("cur");
	$(this).addClass("cur");
}

//本地试听处理
function mspLocalListen(str)
{
	var music_flash_str = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="400" height="95" id="bdmp3widget3295"><param name="movie" value="http://box.baidu.com/widget/flash/mbsong.swf?name='+str+'"></param><param name="wmode" value="opaque"></param><param name="allowscriptaccess" value="always"></param><embed src="http://box.baidu.com/widget/flash/mbsong.swf?name='+str+'" type="application/x-shockwave-flash" wmode="opaque" allowscriptaccess="always" width="400" height="95" name="bdmp3widget3295"></embed></object>';
	// var music_flash_str = '<embed   src="http://box.baidu.com/widget/flash/mbsong.swf?name='+str+'&artist=&autoPlay=auto" allowscriptaccess="never" allownetworking="internal" width="400" height="95" type="application/x-shockwave-flash" />';
	$('#local_flash').html(music_flash_str);
}

function childParseStr(result)
{
	var reg = /"(w)"\:\"(.+?)\"/g;
	var r_result = result.match(reg);
	if (r_result == null)
	{
		location_html = '正在搜索.....';
	}
	else
	{
		var location_html = '';
		var reg1 = /"(txt)"\:\"(.+?)\"/g;
		var json_content = result.match(reg1);
		if (json_content == null)
		{
			location_html = '无法找到该节目。';
		}
		else
		{
			var i = 0;
			for (i = 0;i < json_content.length;i++)
			{
				var place = json_content[i];
				place = place.replace(reg1,"$2");
				if (i == 0) 
				{
					location_html = place;
					getYoukuHtml(place);
				}
			}
		}
		location_html = location_html;
	}	
	$('#demo_result').removeClass("non");
	$('#demo_result span').html("："+location_html);
}

//**********************************************
//调用flash识别函数定义
//**********************************************
//初始化
function init(){
	thisMovie("iat").js_init();
}

//识别结果
function js_getResult(result){
//	alert(result);
	if (asr_type == null)
	{
		asr_type = $('#de_category').val();
	}
	parseReturnStr(result,asr_type);
	
}

//返回值解析
function parseReturnStr(result,type)
{
	all_asr_arr[type].access_func(result);
}

//搭建js与flash互通的环境
function thisMovie(movieName) {
	if (navigator.appName.indexOf("Microsoft") != -1) {
		return window[movieName];
	}else{
		return document[movieName];
	}
}



//****************************
//识别参数设置
//****************************
var all_asr_arr = new Array();
var sms_iat_arr = {
		id:'iat_sms',
		name:'短信转写',
		type:'UTF-8',
		param:'ssm=1,sub=iat,aue=raw,auf=audio/L16;rate=16000,ent=sms16k,rst=plain',
		serverurl:'60.166.12.146',
		config:'appid=4CEE121E,timeout=3000',
		lebel:'单击麦克风,说出想要说出的短信。（例：马上开会）',
		about:'此功能是在科大讯飞的语音云基础架构上运行的演示程序。',
		init_func:showSmsMsg,
		access_func:smsParseStr
	};
all_asr_arr['iat_sms'] = sms_iat_arr;

var position_iat_arr = {
		id:'iat_position',
		name:'地名搜索',
		type:'UTF-8',
		param:'ssm=1,aue=speex-wb,rst=plain,rse=utf8,auf=audio/L16;rate=16000,sub=iat,area=AREANAME,field=kailide,maxcnt=10,ent=poi16k,vad_speech_tail=600,vad_timeout=5000',
		serverurl:'116.213.69.195',
		config:'appid=4CEE121E,timeout=3000',
		lebel:'单击麦克风，说出想要查找的地名。',
		about:'此功能是在科大讯飞的语音云基础架构上运行的演示程序。',
		init_func:showPlaceMsg,
		access_func:locationParseStr
	};
all_asr_arr['iat_position'] = position_iat_arr;
var video_iat_arr = {
		id:'iat_video',
		name:'视频搜索',
		type:'UTF-8',
		param:'ssm=1,aue=speex,auf=audio/L16;rate=16000,sub=iat,lang=video,acous=video,rate=16k',
		serverurl:'60.166.12.146',
		config:'appid=4CEE121E,timeout=3000',
		lebel:'单击麦克风,说出想要查询的视频。（例如：红楼梦）',
		about:'此功能是在科大讯飞的语音云基础架构上运行的演示程序。',
		init_func:showVideoMsg,
		access_func:youkuParseStr
	};
all_asr_arr['iat_video'] = video_iat_arr;
var music_iat_arr = {
		id:'iat_music',
		name:'音乐搜索',
		type:'UTF-8',
		param:'ssm=1,aue=speex-wb,rst=plain,auf=audio/L16;rate=16000,sub=iat,field=xianjinyuan,maxcnt=10,ent=video16k,vad_speech_tail=600,vad_timeout=5000',
		serverurl:'60.166.12.146',
		config:'appid=4d90398f,timeout=3000',
		lebel:'单击麦克风，说出想要查询的歌曲名。（例如：周杰伦）',
		about:'此功能是在科大讯飞的语音云基础架构上运行的演示程序。',
		init_func:showSingMsg,
		access_func:singParseStr
	};
all_asr_arr['iat_music'] = music_iat_arr;
var child_iat_arr = {
		id:'iat_child',
		name:'儿童频道',
		type:'UTF-8',
		param:'ssm=1,aue=speex-wb,rst=plain,auf=audio/L16;rate=16000,sub=iat,field=xianjinyuan,maxcnt=10,ent=video16k,vad_speech_tail=600,vad_timeout=5000',
		serverurl:'116.213.69.195',
		config:'appid=4d90398f,timeout=3000',
		lebel:'单击麦克风，说出想要搜索的儿童节目。',
		about:'此功能是在科大讯飞的语音云基础架构上运行的演示程序。',
		init_func:showVideoMsg,
		access_func:childParseStr
	};
all_asr_arr['iat_child'] = child_iat_arr;


//*****************************
//flash调用js函数  
//*****************************


function js_get_param() {
	flag=true;
	$(".tip").addClass("non");
	var asr_type = $('#de_category').val();
	var asr_obj = all_asr_arr[asr_type];
	var js_param = new String();
	var reg1 = /(.*)(AREANAME)(.*)/g;
	js_param = asr_obj.param;
	var match_content = js_param.match(reg1);
	if (match_content != null)
	{
		var area = getAreaName();
		js_param = js_param.replace(reg1,"$1"+ area +"$3");
	}
	
//	alert(js_param);
	return js_param;
}

function js_get_config()
{
	var asr_type = $('#de_category').val();
	var asr_obj = all_asr_arr[asr_type];
	return asr_obj.config;
}

function js_get_server_url()
{
	var asr_type = $('#de_category').val();
	var asr_obj = all_asr_arr[asr_type];
//	alert(asr_obj.serverurl);
	return asr_obj.serverurl;	
}

function js_get_encode()
{
	var asr_type = $('#de_category').val();
	var asr_obj = all_asr_arr[asr_type];	
	return asr_obj.type;	
}


//***************************************************************
//* 以下为实际处理部分
//**************************************************************
$(document).ready(function(){
	//window.parent.showIframe();
	
	address = $("#address").val();
	asr_type = $('#de_category').val();
	var asr_obj = all_asr_arr[asr_type];
	
	$(".item_back").click(function(){
		window.parent.non();
	});
	
	//关闭tip
	$(".tip .close").click(function(){
		$(".tip").addClass("non");
	});
	
	$(".BMap_stdMpZoomOut").click(function(){
		
	});
	$("body").mouseover(function(){
		$(".BMap_stdMpType0").css("top",70);
	})
	
	//asr_obj.init_func();
	
	// window.onunload = function(){
		// if ($.browser.mozilla) {
			// window.parent.non();
		// }
	// }

});