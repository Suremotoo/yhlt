<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <link href="${staticURL }/content/css/libs/WdatePicker.css" rel="stylesheet" type="text/css" />
    <link href="${staticURL }/content/css/style.css" rel="stylesheet" type="text/css">
    <link href="${staticURL }/content/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${staticURL }/content/css/create.css" rel="stylesheet" type="text/css"> 
    <link rel="stylesheet" type="text/css" href="${staticURL }/jquery-easyui-1.4.3/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="${staticURL }/jquery-easyui-1.4.3/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="${staticURL }/style/css/style.css" />
    <script type="text/javascript" src="${staticURL }/jquery-easyui-1.4.3/jquery.min.js"></script>
    <script type="text/javascript" src="${staticURL }/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
    <title>公司开发基本系统</title>
    

 <link type="text/css" rel="stylesheet" href="${staticURL }/content/css/newLogin.css" />

<style type="text/css">
body{
	background: #fff;
	font-family: "宋体", Helvetica, Arial, sans-serif;
}
#logo{
 	background-color: #fff;
 	position: relative;
 	margin-left:20%;	
}

#Login{
	position: absolute;
	left:60%;
	top:25%;
	background-image: url("${staticURL }/content/images/hello/login-box-single.png");
}
#container #background img{
	width:100%;
	height: 600px;
}
#container #background #background-opacity{
	margin:0 15%;
	width:70%;
	height: 600px;
	background: rgba(255,255,255,0.7);
	position: absolute;
	opacity:1;
}
#content-title{
	color:#145871;
	width:500px;
	height:360px;
	position:absolute;
	top:180px;
	left:330px;
}
#content-title #info1{
	font-size: 45px;
}
#content-title #info1 span{
	font-weight: 800;
}
#content-title #info2{
	font-size: 30px;
}
.ico-user {
    background-image: url("${staticURL }/content/images/hello/ico-user.png");
    background-position: 5px center;
    background-repeat: no-repeat;
}
.ico-pwd {
    background-image: url("${staticURL }/content/images/hello/ico-pwd.png");
    background-position: 5px center;
    background-repeat: no-repeat;
}

</style>
</head>
<body>
<div id="logo">
        <img src="${staticURL }/content/images/hello/logo.png" />
</div>
<div id="container">
	<div id="background">
	<div id="background-opacity"></div>
		<div id="content-title">
				<span id="info1"><span>SMS</span>安全信息管理系统</span>
				<br /><br />
				<span id="info2">打造无过滤的安全信息收集渠道 <br />严格保密报告个人信息</span>
		</div>
	<img src="${staticURL }/content/images/hello/background.jpg">
	</div>
	<div id="Login" class="helloR">
		<div class="login-box"
				style="background-image: url(${staticURL }/content/images/hello/login-box-single.png);">
				<div class="title">
					<span class="span-account active"
						style="width: 100%; cursor: default;">帐号登录</span>
						<font color="red">${errorMsg }</font>
				</div>
				<div class="login-account">
					<form action="${dynamicURL}/login/userLogin" method="post">   
						<div class="input-item">
							<input class="ico-user" id="username_in" type="text" name="username">
							<span id="user_palceholder" class="placeholder-user"
								style="display: block;">身份证号</span>
						</div>
						<div class="input-item">
							<input class="ico-pwd" id="password_in" type="password" name="password">
							<span id="pwd_palceholder" class="placeholder-pwd" style="">密码</span>
						</div>
						<input type="submit" class="login-btn" value="登录"  /> 
					</form>
				</div>
		</div>
	</div>       
</div>
<script type="text/javascript">
    $(function () {
        if (top.location == location) {
        }
        else {
            parent.location.href = "${dynamicURL}/login/userLogin";
        }
        

        var Wwidth = $(window).width();
        var Wheight = $(window).height();
        //alert(Wwidth + "x" + Wheight);

        var width = $("#container").width();
        var height = $("#container").height();
        //alert(width + "x" + height);
        $("#container").css("top", (Wheight / 2));
        refreshVerifyCode();
    });
    function refreshVerifyCode() {
        $("#verifiyCode").attr("src", "${dynamicURL}/login/code?time=" + (new Date()).getTime());
    }
    //cookie
	function addCookie(name)
	{
		var date  = new Date();
		date.setDate(date.getDate()+3600*24*30);
		var cookieString = "userTypeId="+escape(name)+";expires="+date.toGMTString();
		document.cookie=cookieString; 
	}
	function getCookie(name)
	{
		var strCookie=document.cookie; 
		var arrCookie=strCookie.split(";"); 
		for(var i=0;i<arrCookie.length;i++){ 
			var arr=arrCookie[i].split("="); 
			if(arr[0]==name)return arr[1]; 
		}
		return "";
	}
</script>
<script type="text/javascript">

	$(document).ready(function(){
		/***** placeholder效果   *****/
		$("#pwd_palceholder").show();
		$("#pwd_palceholder").click(function(){
		    $(this).hide();
		    $("#password_in").focus();
		});
		$("#password_in").focus(function(){
		    $("#pwd_palceholder").hide();
		}).blur(function(){
		    if($(this).val().length==0){
			    $("#pwd_palceholder").show();
		    }
		});
		
		$("#user_palceholder").show();
		$("#user_palceholder").click(function(){
		    $(this).hide();
		    $("#username_in").focus();
		});
		$("#username_in").focus(function(){
		    $("#user_palceholder").hide();
		}).blur(function(){
		    if($(this).val().length==0){
			    $("#user_palceholder").show();
		    }
		});
		
	});
</script>

</body>
</html>
