<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>

<!-- meta -->
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>公司开发基本系统 - </title>
<meta name="viewport" content="width=device-width" />
<link rel="stylesheet" type="text/css" href="${staticURL }/jquery-easyui-1.4.3/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${staticURL }/jquery-easyui-1.4.3/themes/default/easyui_icons.css" />
<link rel="stylesheet" type="text/css" href="${staticURL }/jquery-easyui-1.4.3/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${staticURL }/style/css/style.css" />
<script type="text/javascript" src="${staticURL }/jquery-easyui-1.4.3/jquery.min.js"></script>
<script type="text/javascript" src="${staticURL }/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${staticURL }/jquery-easyui-1.4.3/jquery.earyui.merge.js"></script>
<script type="text/javascript" src="${staticURL}/jquery-easyui-1.4.3/easyui-extend/datagrid-detailview.js" ></script>
<script type="text/javascript" src="${staticURL}/jquery-easyui-1.4.3/easyui-extend/datagrid-groupview.js" ></script>
<script type="text/javascript" src="${staticURL}/jquery-easyui-1.4.3/easyui-extend/easyui-extend.js"></script>
<script src="${staticURL }/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
<script src="${staticURL }/scripts/common/Common.js"></script>
<script src="${staticURL }/plugins/plugins.js"></script>
<script src="${staticURL }/ckeditor/ckeditor.js"></script>
<style>
    a {
        cursor: pointer;
    }
    a:link,
    a:visited {
        color: #4169E1;
        text-decoration: none;
    }

    a:hover,
    a:active {
        color: #000000;
        text-decoration: none;
    }
    .btnz{
    	position: fixed;background: #F6F6F6;bottom: 0px;left: 0px;border: solid #C6C6C6 1px;z-index: 999;width: 99%;
    }
</style>

<link media="screen" type="text/css" rel="stylesheet" href="${staticURL }/content/theme/Common.css">
<link media="screen" type="text/css" rel="stylesheet" id="style_style" href="${staticURL }/content/theme/blue/style/style.css">
<link media="screen" type="text/css" rel="stylesheet" id="style_ui" href="${staticURL }/content/theme/blue/style/ui.css">

<!-- upload -->
<link href="${staticURL}/uploadify/uploadify.css" type="text/css" rel="stylesheet" />

<script src="${staticURL }/scripts/jquery.cookie.js"></script>
<script src="${staticURL }/scripts/json.js"></script>
<script src="${staticURL }/scripts/roadui.core.js"></script>
<%-- <script src="${staticURL }/scripts/roadui.button.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.calendar.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.file.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.member.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.dict.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.menu.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.select.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.combox.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.tab.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.text.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.textarea.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.editor.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.tree.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.validate.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.window.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.dragsort.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.selectico.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.accordion.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.grid.js"></script> --%>
<%-- <script src="${staticURL }/scripts/roadui.init.js"></script> --%>


<!-- 日程 -->
<link rel='stylesheet' href='${staticURL}/fullCalendar/lib/cupertino/jquery-ui.min.css' type="text/css"/>
<link href='${staticURL}/fullCalendar/fullcalendar.css' rel='stylesheet' type="text/css"/>
<link href='${staticURL}/fullCalendar/fullcalendar.print.css' rel='stylesheet' media='print' type="text/css"/>
<script src='${staticURL}/fullCalendar/lib/moment.min.js' type="text/javascript"></script>
<script src='${staticURL}/fullCalendar/fullcalendar.js' type="text/javascript"></script>
<script src='${staticURL}/fullCalendar/lang-all.js' type="text/javascript"></script>


<!-- 图形报表-->
<script src="${staticURL}/highcharts-4.0.3/highcharts.js" type="text/javascript"></script>
<script src="${staticURL}/highcharts-4.0.3/modules/exporting.js" type="text/javascript"></script>
<script src="${staticURL}/highcharts-4.0.3/highcharts-more.js" type="text/javascript"></script>
<script src="${staticURL}/highcharts-4.0.3/highcharts-3d.js" type="text/javascript"></script>



<!-- upload -->
<script src="${staticURL}/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
<!-- top-util -->
<script src="${staticURL}/scripts/top-util.js" type="text/javascript"></script>
<!-- icons -->
<script src="${staticURL}/scripts/top-icons.js" type="text/javascript"></script>

<!-- font -->
<link href="${staticURL}/style/css/elusive-webfont.css" type="text/css" rel="stylesheet" />

<!-- 重复提交 -->
<script src="${staticURL }/scripts/underscore-min.js"></script>

<!-- 图片上传 -->
<script type="text/javascript" src="${staticURL }/jquery-easyui-1.4.3/plugins/ajaxfileupload.js"></script>

<!-- js带回 -->
<script type="text/javascript" src="${staticURL }/scripts/top-dialog-parent.js"></script>

<script type="text/javascript">
	headerHost = "${header.Host }";
    dynamicURL = "${dynamicURL}/";
    staticURL = "${staticURL}/";
    waitTime = 200;
    $(document).ajaxError(function(event, jqXHR, options, errorMsg){
    	if(jqXHR.responseText=="{'statusCode':301}"){
    		$.messager.alert("提示","会话超时,请重新登录！","error",function(){
    			window.parent.location.href="${dynamicURL}/login/userLogin";
    		});
    	}
    });
</script>
