<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--------------------------------------------头部开始-------------------------------------------->
<div class="head block">
	<div class="top">
    <span class="fl">欢迎访问本站!!</span>
    <span class="fl ml10"><font class="fl">今天是：</font><div id="time" class="fl ml5"></div></span>
    <span class="fr pr20"><a onclick="SetHome(window.location)" href="javascript:void(0)">设为首页</a> | <a onclick="AddFavorite(window.location,document.title)" href="javascript:void(0)">加入收藏</a></span></div>
<%--     <div class="logo"><a href="#"><img src="${staticURL }/front/images/logo.jpg" width="1000" height="163"></a></div> --%>

	<DIV style="HEIGHT: 226px" id=flash>
		<OBJECT id=FlashID2 classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000
			width=1000 height=226>
			<PARAM NAME="_cx" VALUE="26564">
			<PARAM NAME="_cy" VALUE="5979">
			<PARAM NAME="FlashVars" VALUE="">
			<PARAM NAME="Movie" VALUE="${staticURL }/front/images/s.swf">
			<PARAM NAME="Src" VALUE="${staticURL }/front/images/s.swf">
			<PARAM NAME="WMode" VALUE="Opaque">
			<PARAM NAME="Play" VALUE="-1">
			<PARAM NAME="Loop" VALUE="-1">
			<PARAM NAME="Quality" VALUE="High">
			<PARAM NAME="SAlign" VALUE="">
			<PARAM NAME="Menu" VALUE="-1">
			<PARAM NAME="Base" VALUE="">
			<PARAM NAME="AllowScriptAccess" VALUE="">
			<PARAM NAME="Scale" VALUE="ShowAll">
			<PARAM NAME="DeviceFont" VALUE="0">
			<PARAM NAME="EmbedMovie" VALUE="0">
			<PARAM NAME="BGColor" VALUE="">
			<PARAM NAME="SWRemote" VALUE="">
			<PARAM NAME="MovieData" VALUE="">
			<PARAM NAME="SeamlessTabbing" VALUE="1">
			<PARAM NAME="Profile" VALUE="0">
			<PARAM NAME="ProfileAddress" VALUE="">
			<PARAM NAME="ProfilePort" VALUE="0">
			<PARAM NAME="AllowNetworking" VALUE="all">
			<PARAM NAME="AllowFullScreen" VALUE="false">
			<PARAM NAME="AllowFullScreenInteractive" VALUE="false">
			<PARAM NAME="IsDependent" VALUE="0">

			<!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->
			<!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->
			<!--[if !IE]>-->
			<object type="application/x-shockwave-flash"
				data="${staticURL }/front/images/s.swf" width="1004" height="226">
				<!--<![endif]-->
				<!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->
				<!--
				<div>	  <h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
				  <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="获取 Adobe Flash Player" /></a></p>
				</div>	-->
				<!--[if !IE]>-->
			</object>
			<!--<![endif]-->
		</OBJECT>
	</DIV>
	<div class="navBar">
			<ul class="nav clearfix">
<!-- 				<li class="m" id="top">m on  -->
<%-- 					<h3><a  href="${dynamicURL}/front">网站首页</a></h3> --%>
<!-- 				</li> -->
<!--                 <li class="s">|</li> -->
<!-- 				<li class="m"> -->
<!-- 					<h3></h3> -->
<!-- 				</li> -->
			</ul>

			<ul class="subNav border radius4">
				<li>
<!-- 				<iframe width="300" scrolling="no" height="25" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=10&icon=1"></iframe> -->
				你好！
				</li>
			</ul>
            <div class="iframe" style="margin-top: -38px;">
            	<form name="searchform" method="post" action="${dynamicURL}/front/searchUserInfo">
    				<input name='ecmsfrom' type='hidden' value='9'>
    				<input type="hidden" name="show" value="title,newstext">
    				<input class="index_srh" name="name" value='${name}'>
    				<input class="search" type="submit" name="submit" value="搜索">
    			</form>
            </div>
	</div>
    
</div>
<!--------------------------------------------头部结束-------------------------------------------->