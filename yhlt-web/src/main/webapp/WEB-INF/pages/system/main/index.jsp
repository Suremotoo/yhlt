<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
    <link type="text/css" rel="stylesheet" href="${staticURL }/style/css/themes/gray/accordion.css" />
    <link type="text/css" rel="stylesheet" href="${staticURL }/style/css/themes/icon.css" />
    <link type="text/css" rel="stylesheet" href="${staticURL }/style/css/style.css" />
    <link href="${staticURL }/content/css/style.css" rel="stylesheet" type="text/css">
    <link href="${staticURL }/content/css/indexPage.css" rel="stylesheet" />
    <style type="text/css">
        #mm1 {
            display:none;
            position: fixed;
            margin-top:5px;
            Z-index:9999;
            background-color:#2C6AA0;
        }
        #TopMore a:hover div#mm1  {
            display:block;
            position:fixed;
           	Z-index:9999;
        }
        a {
            /*background-color:#f00;*/
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        var menuList;
        $(function () {
            ///加载一级菜单
            $.ajax({
                type: "POST",
                url: "${dynamicURL}/main/menu/one",
                async: false,
                dataType:"json",
                success: function (data) {
                    var strHtml = "";
                    var str = "";//一级菜单div集合
                    var strmore = "";//更多部分集合
                    var totalWidth = GetWindowWidth();
                    totalWidth = totalWidth - 200 - 380;
                    var displayNum = parseInt(totalWidth / 90);
                    menuList = data;
                    $.each(data, function (i, item) {
                        i++;
                        if (i <= displayNum) {
                            str += "<li><a href=\"#\" id=\"hi_" + i + "\" class=\"mt\"  onclick=\"openT1(this,''," + item.id + ")\"><em class=\"" + item.icon + " icon-font-size\" ></em><br>" + item.name + "</a></li>";
                        }else { 
                        	strmore += "<li><a href=\"#\" id=\"hi_\"" + i + " onclick=\"openT1(this,''," + item.id + ")\"><em class=\"" + item.icon + "\"></em>" + item.name + "</a></li>" 
                        }
                    });
                    var strMoreBegin = "<li id='TopMore'><a href=\"#\" id=\"hi_9\" class=\"mt\" onclick=\"solid()\"><em class=\"more\">" +
                    "</em>更多<div id=\"mm1\"style=\"width: 90px;height:auto;Z-index:5000;\"><ul style=\"Z-index:5001\"></ul></div></a></li>";

                    if (data.length > displayNum) {
                        strHtml = str + strMoreBegin//全部一级菜单
                    }
                    else { strHtml = str }
                    $("#menu ul").html("");//一级菜单加载
                    $("#mm1 ul").html("");//一级菜单加载
                    $("#menu ul").append(strHtml);//一级菜单加载
                    $("#mm1 ul").append(strmore);//一级菜单加载
                    //加载第一个二级菜单
                    openT1(this,'',data[0].id);
                }
            });
            
            /*头部导航栏更多*/
            $('.last').hover(function () {
                $('.more-link').show().mousemove(function () {
                    $(this).show();
                }).mouseleave(function () {
                    $(this).hide();
                })
            }, function () {
            })
            
            //监听右键事件，创建右键菜单
            $('#tt').tabs({
                onContextMenu: function (e, title, index) {
                    e.preventDefault();
                    if (index > 0) {
                        $('#mm').menu('show', {
                            left: e.pageX,
                            top: 100//e.pageY
                        }).data("tabTitle", title);
                    }
                }
            });
            //右键菜单click
            $("#mm").menu({
                onClick: function (item) {
                	tabMenuOperation(this, item.name);
                }
            });
        });
        function leftMenuClick(){
            $('.box h3').click(function () {
                $('.box h3 b').removeClass("selected");
                $(this).find('b').addClass("selected");
                if ($(this).siblings('ul').is(':hidden')) {
                    $(this).siblings('ul').slideDown();
                }
                else {
                    $(this).siblings('ul').slideUp();
                }
            });
        	
            $(".box h3").siblings('ul').slideDown();
            $('.box a').click(function () {
                $(this).addClass('on').parent('li').siblings().find('a').removeClass('on');
                $(this).addClass('on').parents('.box').siblings().find('a').removeClass('on');
            })
        }
       
        function GetWindowWidth() {
            var winWidth;
            // 获取窗口宽度
            if (window.innerWidth)
                winWidth = window.innerWidth;
            else if ((document.body) && (document.body.clientWidth))
                winWidth = document.body.clientWidth;
            return winWidth;
        }
        window.onresize = function () {
            var strHtml = "";
            var str = "";//一级菜单div集合
            var strmore = "";//更多部分集合
            var totalWidth = GetWindowWidth();
            totalWidth = totalWidth - 200 - 380;
            var displayNum = parseInt(totalWidth / 90);
            $.each(menuList, function (i, item) {
                i++;
                if (i <= displayNum) {
                    str += "<li><a href=\"#\" id=\"hi_" + i + "\" class=\"mt\" onclick=\"openT1(this,''," + item.id + ")\"><em class=\"" + item.icon + " icon-font-size\"></em><br>" + item.name + "</a></li>";
                }
                else { strmore += "<li><a href=\"#\" id=\"hi_\"" + i + " onclick=\"openT1(this,''," + item.id + ")\"><em class=\"" + item.icon + "\"></em>" + item.name + "</a></li>" }
            })
            var strMoreBegin = "<li id='TopMore'><a href=\"#\" id=\"hi_9\" class=\"mt\" onclick=\"solid()\"><em class=\"more\">" +
            "</em>更多<div id=\"mm1\"style=\"width: 90px;height:auto;Z-index:5000;\"><ul style=\"Z-index:5001\"></ul></div></a></li>";
            if (menuList.length > displayNum) {
                strHtml = str + strMoreBegin//全部一级菜单
            }
            else { strHtml = str }
            $("#menu ul").html("");//一级菜单加载
            $("#mm1 ul").html("");//一级菜单加载
            $("#menu ul").append(strHtml);//一级菜单加载
            $("#mm1 ul").append(strmore);//一级菜单加载
        }
        function openT(title, path, openType, windowHeight, windowWidth) {
            if (typeof (openType) == "undefined") {
                openTab(title, path);
                return;
            }
            if (openType == "0") {
                openTab(title, path);
                return;
            }
            if (openType == "1") {
                if (typeof (windowHeight) == "undefined")
                    windowHeight = 800;
                if (typeof (windowWidth) == "undefined")
                    windowWidth = 500;
                openModelWindow(0, title, path, windowHeight, windowWidth);
            }
            if (openType == "2" || openType == "3" || openType == "4" || openType == "5") {
                var tempPath = "/Common/Report?";
                if (openType == "2") {
                    tempPath += "redir=" + path + "&title=" + title + "&type=0";
                    openModelWindow(1, title, tempPath, 450, 630);
                }
                if (openType == "3") {
                    tempPath += "redir=" + path + "&title=" + title + "&type=1";
                    openModelWindow(1, title, tempPath, 500, 630);
                }
                if (openType == "4") {
                    tempPath += "redir=" + path + "&title=" + title + "&type=2";
                    openModelWindow(1, title, tempPath, 500, 630);
                }
                if (openType == "5") {
                    tempPath += "redir=" + path + "&title=" + title + "&type=3";
                    openModelWindow(1, title, tempPath, 500, 630);
                }
            }
            if (openType == "10") {
                openEmptyTab(title, path);
                return;
            }
        }

        //打开模态窗口
        function openModelWindow(type, title, path, windwoHeight, windowWidth) {
            if (type == 0) {
                $('#modelWindow').window({
                    width: windowWidth,
                    height: windwoHeight,
                    modal: true,
                    content: createFrame(path),
                    minimizable: false,
                    maximizable: false,
                    title: title
                });
            }
            if (type == 1) {
                $('#modelWindow').window({
                    width: windowWidth,
                    height: windwoHeight,
                    modal: true,
                    content: createFrame(path),
                    minimizable: false,
                    maximizable: false,
                    title: title + " - 查询"
                });
            }
        }


        //关闭模态窗口
        function closeModelWindow() {
            $('#modelWindow').window('close');
        }

        //打开TAB
        function openTab(title, path) {
            if (path == "") {
                if ($('#tt').tabs('exists', title)) {
                    $('#tt').tabs('select', title); return false;
                }
            }
            if ($('#tt').tabs('exists', title)) {
                $('#tt').tabs('select', title);
                var tab = $('#tt').tabs('getSelected');
                $("#tt").tabs('update', {
                    tab: tab,
                    options: {
                        title: title,
                        content: createFrame(path),
                        closable: true
                    }
                });
            } else {
                $('#tt').tabs('add', {
                    title: title,
                    content: createFrame(path),
                    closable: true
                });
            }
        }

        //打开空TAB
        function openEmptyTab(title, target) {
            if (target == "") {
                if ($('#tt').tabs('exists', title)) {
                    $('#tt').tabs('select', title); return false;
                }
            }
            if ($('#tt').tabs('exists', title)) {
                $('#tt').tabs('select', title);
                var tab = $('#tt').tabs('getSelected');
                $("#tt").tabs('update', {
                        tab: tab,
                        options: {
                            title: title,
                            content: createEmptyFrame(target),
                            closable: true
                        }
                    });
            } else {
                $('#tt').tabs('add', {
                    title: title,
                    content: createEmptyFrame(target),
                    closable: true
                });
            }
        }

        function createEmptyFrame(target) {
            return '<iframe scrolling="auto" frameborder="0" class="fra" style="width:100%;height:100%;" name="' + target + '"></iframe>';
        }

        function createFrame(path) {
            var id = "tab_" + RoadUI.Core.newid(true);
            var idAndName = id + "_iframe";
            if (path.indexOf('?') >= 0)
                path += '&tabid=' + id;
            else
                path += '?tabid=' + id;
            return '<iframe scrolling="auto" frameborder="0" class="fra" src="' + path + '" style="width:100%;height:100%;" id="' + idAndName + '" name="' + idAndName + '" tabid="' + id + '"></iframe>';
        }

        function createFrame2(path) {
            return '<iframe scrolling="auto" frameborder="0" name="Score" class="fra" src="' + path + '" style="width:100%;height:100%;"></iframe>';
        }

        function closeSelectTab() {
            var currentTab = $('#tt').tabs('getSelected'),
            currentTabIndex = $('#tt').tabs('getTabIndex', currentTab);
            $('#tt').tabs('close', currentTabIndex);
        }
		
        function openT1(name, url, id) {
        	//ajax加载二级菜单
        	$.post('${dynamicURL}/main/menu/two',{parentId:id},function(data, status){
        		var second = "";
        		$.each(data, function (i, item) {
        			var third = "";
       				$.each(item.children, function (i, children) {
           				third += "<li><a onclick=\"openT('"+children.name+"', '"+children.url+"','0','300','300')\"><span>"+children.name+"</span></a></li>";
            		});
        			second +="<div class=\"box\"><h3 class=\"icon-t1\"><b class=\"lutub\"><em class=\""+item.icon+" second-icon-font-size\"></em>"+item.name+"</b></h3><ul class=\"boxNav\" style=\"display:block\">"+third+"</ul></div>";
                })
                $("#acc_menu").html("");//二三级菜单加载
	            $("#acc_menu").append(second);//二三级菜单加载
	        	leftMenuClick();
        	},'json');

            //调整样式
            $(".mt").click(function () {
                var id = $(this).attr("id");
                $(".mt").css({ "background-color": "#2C6AA0" });
                $("#" + id + "").css({ "background-color": "#0e3e68" });
            });
        }
        //Tabs操作
        function tabMenuOperation(menu, type) {
            var allTabs = $("#tt").tabs('tabs');
            var allTabtitle = [];
            $.each(allTabs, function (i, n) {
                var opt = $(n).panel('options');
                if (opt.closable)
                    allTabtitle.push(opt.title);
            });
            var curTabTitle = $(menu).data("tabTitle");
            var curTabIndex = $("#tt").tabs("getTabIndex", $("#tt").tabs("getTab", curTabTitle));
            switch (type) {
                case 1:
                    $("#tt").tabs("close", curTabIndex);
                    return false;
                    break;
                case 2:
                    for (var i = 0; i < allTabtitle.length; i++) {
                        $('#tt').tabs('close', allTabtitle[i]);
                    }
                    break;
                case 3:
                    for (var i = 0; i < allTabtitle.length; i++) {
                        if (curTabTitle != allTabtitle[i])
                            $('#tt').tabs('close', allTabtitle[i]);
                    }
                    $('#tt').tabs('select', curTabTitle);
                    break;
                case 4:
                    for (var i = curTabIndex; i < allTabtitle.length; i++) {
                        $('#tt').tabs('close', allTabtitle[i]);
                    }
                    $('#tt').tabs('select', curTabTitle);
                    break;
                case 5:
                    for (var i = 0; i < curTabIndex - 1; i++) {
                        $('#tt').tabs('close', allTabtitle[i]);
                    }
                    $('#tt').tabs('select', curTabTitle);
                    break;
                case 6:
                	var tab =  $("#tt").tabs('getSelected');
                	if(tab && tab.find("iframe").length > 0){
                		var url = tab.find('iframe')[0];
                		if(url && url.src){
                			$("#tt").tabs('update', {
                                tab: tab,
                                options: {
                                    title: curTabTitle,
                                    content: createFrame(url.src),
                                    closable: true
                                }
                            });
                		}
                	}
                    break;
            }
        }
        
        
        function LogOut() {
            $.messager.confirm(msgTitle, '确实退出登录吗?', function (r) {
                if (r) {
                    $.ajax({
                        type: "POST", //提交数据的类型 分为POST和GET
                        async: false,
                        url: "${dynamicURL}/login/logout",  //提交url 注意url必须小写
                        data: {},
                        success: function (data) {
                            window.location.href = '${dynamicURL}/login/userLogin';
                        }
                    });
                }
            });
        }
    </script>
</head>
<body class="easyui-layout">
    <div data-options="region:'north',border:false" class="top_head">
        <div class="top_inner">
            <div class="logo"></div>
            <div class="user_info15" style="float: right;">
                <dl style="overflow: hidden; width: 280px; margin-right: 10px;">
                    <dd style="float: left;">
                        <img id="imges" src="${staticURL }/style/images/headMask.png" width="56" height="56" style="background-size: cover;background-image: url('${staticURL }/style/images/indPic03.png'); background-size: cover; margin-top: 5px;" />
                    </dd>
                    <dt style="float: left; color: #ffffff; margin-left: 10px; margin-top: 5px;">
                        &nbsp;&nbsp;&nbsp;<span id="name"></span><span id="gh">${_login_name}</span>
                        <div style="width: 100%; height: 1px; background-color: #84b5df; margin: 5px 0;"></div>
                        <img src="${staticURL }/style/images/ico01.png" />
                        <a style="color: #84b5df" href="javascript: openT('修改密码', '${dynamicURL}/system/user/toEditPwd')">修改密码</a><span style="color: #84b5df;">&nbsp;|&nbsp;</span>
                        <img src="${staticURL }/style/images/ico02.png" />
                        <a style="color: #84b5df" onclick="LogOut();">退出登录</a>
                    </dt>
                </dl>
            </div>
<!-- 			顶部菜单 -->
             <div class="menu_list" id="menu">
                <ul>
                </ul>
            </div>
        </div>
    </div>
<!-- 	左侧菜单 -->
    <div data-options="region:'west',split:true,border:false" style="overflow-y: auto;" class="Idx_left">
        <div class="closed"></div>
        <div class="nav_head"><s></s>功能导航</div>
        <div class="acc_menu" id="acc_menu" style="display:block">
          
        </div>
    </div>
    <div data-options="region:'south',border:false" class="Idx-foot">
        <div style="float: left;margin-left: 10px" > 系统时间: <span id="time1"></span> </div>
        <div class="bfooter" style="width: 90%;">
        <span>Powered by <a href="${dynamicURL}/front">公司开发基本系统</a></span> &copy; 2015 - 2016, YHLT Inc.
        </div>
    </div>
    <div data-options="region:'center',border:false" id="MenuD" class="Idx_center">
        <div id="tt" class="easyui-tabs" fit="true" border="false" plain="true">
            <div title="首页" style="padding: 5px;">
                <div class="index_body">
                    <div class="indexMain">
                        
                        <div class="w265 fl pr5" id="indexLeft">
                             <div class="indSubM mt5" id="b39903ca-dff6-4973-9f92-09a6ccc1e65ba" sort="2" title="暂无内容" style="height: 285px;" flage="lefts"><div class="indTit"><span >暂无内容</span><a gid="b39903ca-dff6-4973-9f92-09a6ccc1e65ba" href="javascript:Morecompezdfuction()">MORE</a></div><div class="indMid03Wd" id="noticeInfoTask"></div></div>
                             <div class="indSubM mt5"sort="3" style="height: 280px;"><div class="indTit"><span>暂无内容</span><a href="javascript:Morecompexwfuction()">MORE</a></div><div class="ind03List" style="height: 235px;"><ul id="Compxw"></ul></div></div>
                        </div>
                        <div class="w265 fr pl5" id="indexLeft">
                            <div style="height: 588px;" class="indSubM mt5" id="caee8e54-43e0-481e-8697-474cba02633ca" sort="3" title="暂无内容" flage="rights"><div class="indTit"><span >暂无内容</span><a href="javascript:Morecomptzdfuction()">MORE</a></div><div class="ind03List" style="height: 550px;"><ul id="Comper"></ul></div></div>
                        </div>
                        <!--right End-->
                        
                        <div class="indexCenter">
<!--                             <div class="indTopM" id="banner"title="照片墙" sort="1"flage="model"><div class="indBanner"><ul></ul></div><div class="sBanBtn" id="sBanBtn"></div></div> -->
                            <div class="indSubM mt5" id="8fbb73f4-6430-4359-9df9-7c1fb278dc7ca"title="暂无内容" style="height: 285px;" sort="2" flage="model"><div class="indTit"><span >暂无内容</span><a gid="8fbb73f4-6430-4359-9df9-7c1fb278dc7ca" href="javascript:void(0)">MORE</a></div><div class="indMid03Wd" id="Mydb"></div></div>
                            <div class="indSubM mt5" id="8fbb73f4-6430-4359-9df9-7c1fb278dc7ca"title="暂无内容" style="height: 285px;" sort="2" flage="model"><div class="indTit"><span >暂无内容</span><a gid="8fbb73f4-6430-4359-9df9-7c1fb278dc7ca" href="javascript:void(0)">MORE</a></div><div class="indMid03Wd" id="Mydb"></div></div>
                        </div>

                        <div class="clr"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="mm" class="easyui-menu" style="width: 120px;">
    	<div id="mm-tabreload" data-options="name:6" iconcls="icon-reload">刷新</div>
        <div id="mm-tabclose" data-options="name:1" iconcls="icon-cancel">关闭</div>
        <div id="mm-tabcloseall" data-options="name:2">关闭全部</div>
        <div id="mm-tabcloseother" data-options="name:3">关闭其他</div>
        <div class="menu-sep"></div>
        <div id="mm-tabcloseright" data-options="name:4">关闭右侧标签页</div>
        <div id="mm-tabcloseleft" data-options="name:5">关闭左侧标签页</div>
    </div>
    <div id="modelWindow">
    </div>

<script type="text/javascript">

var ct="${_system_datetime}";
Date.prototype.format = function(format){
var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
}

if(/(y+)/.test(format)) { 
	format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
} 

for(var k in o) { 
	if(new RegExp("("+ k +")").test(format)) { 
		format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
	} 
} 
	return format; 
}

String.prototype.subName = function (length) {
	var name = this;
	if(name.length > length){
		name = name.substring(0,length) + "...";
	}
	return name;
}

	var str =ct;
	str = str.replace(/-/g,"/");
	var date = new Date(str );
	function setTime(){
		var c=date.getTime();
		c=c+1000;
		date=new Date(c);
		document.getElementById("time1").innerHTML=new Date(c).format("yyyy-MM-dd hh:mm:ss");;
		setTimeout("setTime()",1000);
	}
	setTime();
	/*  --------------显示时间end------------- */

	function reLoad(val) {
        if ($('#tt').tabs('exists', val)) {
            $('#tt').tabs('close', val);
        }
    }
    //普通的
    function show() {
        $.messager.show({
            title: '操作提示',
            msg: '您没有权限！',
            showType: 'show'
        });
    }
    //延迟消失
    function slide() {
        $.messager.show({
            title: '操作提示',
            msg: '您没有权限！',
            timeout: 3000,
            showType: 'slide'
        });
    }

    //延迟消失（有参数）
    function slide(ts) {
        $.messager.show({
            title: '操作提示',
            msg: ts,
            timeout: 5000,
            showType: 'slide'
        });
    }
    
    $(function(){
    	 $.ajax({
             type: "POST",   
             dataType: "json",     
             url: "${dynamicURL}/system/user/getCurrUser",     
             data:{},  
             success: function (data) { 
            	var img = data.user.headImgUrl ;
				if(img){
					img = img.replaceAll(/\\/g,"/");
	            	img = "${dynamicURL}" + img;
	            	$("#imges").attr("style","background-image: url('"+img+"'); background-size: cover; margin-top: 5px;");	
				}
             }
         });

         /* if ($("#Mydb").length == 0) {
             return false;
         }
         $("#Mydb").append('<div class="indM03List first"><div class="indTit02"><span>招标公告</span><a href="javascript:;"></a></div><div id="noticeInfoTask" class="indM03Li"></div></div>');
         $("#Mydb").append('<div class="indM03List"><div class="indTit02"><span>询价公告</span><a href="javascript:;"></a></div><div class="indM03Li"></div></div>');
         $("#Mydb").append('<div class="indM03List"><div class="indTit02"><span>竞价公告</span><a href="javascript:;"></a></div><div class="indM03Li"></div></div>'); */

    });
</script>

</body>
