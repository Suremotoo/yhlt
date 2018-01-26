<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>
<div id="container" class="easyui-layout layout" fit="true">
<div id="tabs" class="easyui-tabs psnAccoundTab" style="width: 100%;" fit="true">
        <div title="个人密码" style="padding: 20px;">
		    <div region="center" border="false">
		        <div class="changePSWD">
		            <table class="tableTdPb20">
		                <tr>
		                    <td class="w160 tr">旧密码：</td>
		                    <td>
		                        <input id="p5" type="password" value="" class="inputWd" /></td>
		                    <td class="w160" id="jmm">
		                        <span>请输入旧密码</span>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="w160 tr">新密码：</td>
		                    <td>
		                        <input id="p2" type="password" value="" class="inputWd" /></td>
		                    <td class="w160" id="xmm">
		                        <span>请输入新密码</span>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="w160 tr">确认密码：</td>
		                    <td>
		                        <input id="p3" type="password" value="" class="inputWd" /></td>
		                    <td class="w160" id="qrmm">
		                        <span>请再输入一次新密码</span>
		                    </td>
		                </tr>
		            </table>
		        </div>
		    </div>
		    <div region="south" border="false">
		        <div class="BtnLine">
		            <button type="submit" class="easyui-linkbutton" onclick="savepwd()">保  存</button>
		            <button type="submit" class="easyui-linkbutton" onclick="parent.window.reLoad('修改密码')">返  回</button>
		        </div>
		    </div>
    	</div>
    	<div title="电子签章密码" style="padding: 20px;">
		    <div region="center" border="false">
		        <div class="changePSWD">
		        
		        
			    	<table style="width:100%">
				        <tr>
				            <td style="text-align: center; height: 20px;">照片预览</td>
				        </tr>
				        <tr>
				            <td style="text-align: center; height: 180px;">
				                <div id="preview">
								    <img id="imghead" border=0 src="" width="240" height="180" />
								</div>
				            </td>
				        </tr>
			    	</table>
		        
		        
		        
		            <table class="tableTdPb20">
		                <tr>
		                    <td class="w160 tr">旧密码：</td>
		                    <td>
		                        <input id="dp1" type="password" value="" class="inputWd" /></td>
		                    <td class="w160" id="djmm">
		                        <span>请输入旧密码</span>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="w160 tr">新密码：</td>
		                    <td>
		                        <input id="dp2" type="password" value="" class="inputWd" /></td>
		                    <td class="w160" id="dxmm">
		                        <span>请输入新密码</span>
		                    </td>
		                </tr>
		                <tr>
		                    <td class="w160 tr">确认密码：</td>
		                    <td>
		                        <input id="dp3" type="password" value="" class="inputWd" /></td>
		                    <td class="w160" id="dqrmm">
		                        <span>请再输入一次新密码</span>
		                    </td>
		                </tr>
		            </table>
		        </div>
		    </div>
		    <div region="south" border="false">
		        <div class="BtnLine">
		            <button type="submit" class="easyui-linkbutton" onclick="dsavepwd()">保  存</button>
		            <button type="submit" class="easyui-linkbutton" onclick="parent.window.reLoad('修改密码')">返  回</button>
		        </div>
		    </div>
    	</div>
    </div>
</div>

<style type="text/css">
    #jmm {
        display: block;
    }
</style>
<script type="text/javascript">
    $(function () {
        $("#jmm").css("visibility", "hidden");
        $("#xmm").css("visibility", "hidden");
        $("#qrmm").css("visibility", "hidden");
        $("#sfxtmm").css("visibility", "hidden");
        
        

   	 	$.ajax({
            url: "${dynamicURL}/system/user/signature/ajax",
            data: {id: '${_user.id}'},
            dataType: "json",
            success: function (data) {
            	if(data.success){
            		$("#imghead").attr("src","${dynamicURL}"+data.path);
            	}
            }
        });
        
        
        
        
        
    $("#p5").blur(function () {
        var j = $("#p5").val();
        var jmm=$("#jmm");
        if (!j) {
        	jmm.find("span").html("请输入旧密码");
        	jmm.css("visibility", "visible");
        } else {
	   		 $.ajax({
	                type: "POST",   //提交数据的类型 分为POST和GET
	                url: "${dynamicURL}/system/user/checkOldPwd",  //提交url 注意url必须小写
	                data: {
	                    "oldPwd": j,
	                },
	                //执行成功的回调函数
	                success: function (data) {
	                    if(typeof data =='string'){
	                    	data=JSON.parse(data);
	                    }
	                    if(data.flag){
	                    	jmm.css("visibility", "hidden");
	                    }else{
	                    	jmm.find("span").html(data.msg);
	                    	jmm.css("visibility", "visible");
	                    }
	                },
	                //执行失败的回调函数
	                error: function () {
	
	                }
	          });
        }
    });
    $("#p2").blur(function () {
        var x = $("#p2").val();
        if (!x) {
            $("#xmm").css("visibility", "visible");
        } else {
            $("#xmm").css("visibility", "hidden");
        }
        $("#p3").trigger( "blur" );
    });
    $("#p3").blur(function () {
        var qr = $("#p3").val();
        var q1 = $("#p2").val();
        var qrmm=$("#qrmm");
        if (!qr) {
        	qrmm.val("<span>请再输入一次新密码</span>");
        	qrmm.css("visibility", "visible");
        } else {
            if (q1 != qr) {
            	qrmm.html("<span>两次输入密码不一样</span>");
            	qrmm.css("visibility", "visible");
            } else {
            	qrmm.css("visibility", "hidden");
            }
        }
    });
    $("#p5").focus(function () {
        $("#jmm").css("visibility", "hidden");
    });
    $("#p2").focus(function () {
        $("#xmm").css("visibility", "hidden");
    })
    $("#p3").focus(function () {
        $("#qrmm").css("visibility", "none");

    });
    });
    $(function () {
        $("#djmm").css("visibility", "hidden");
        $("#dxmm").css("visibility", "hidden");
        $("#dqrmm").css("visibility", "hidden");
        $("#dsfxtmm").css("visibility", "hidden");
    $("#dp1").blur(function () {
        var j = $("#dp1").val();
        var jmm=$("#djmm");
        if (!j) {
        	jmm.find("span").html("请输入旧密码");
        	jmm.css("visibility", "visible");
        } else {
	   		 $.ajax({
	                type: "POST",   //提交数据的类型 分为POST和GET
	                url: "${dynamicURL}/system/user/signature/checkOldPwd",  //提交url 注意url必须小写
	                data: {
	                    "oldPwd": j,
	                },
	                //执行成功的回调函数
	                success: function (data) {
	                    if(typeof data =='string'){
	                    	data=JSON.parse(data);
	                    }
	                    if(data.flag){
	                    	jmm.css("visibility", "hidden");
	                    }else{
	                    	jmm.find("span").html(data.msg);
	                    	jmm.css("visibility", "visible");
	                    }
	                },
	                //执行失败的回调函数
	                error: function () {
	
	                }
	          });
        }
    });
    $("#dp2").blur(function () {
        var x = $("#dp2").val();
        if (!x) {
            $("#dxmm").css("visibility", "visible");
        } else {
            $("#dxmm").css("visibility", "hidden");
        }
        $("#dp3").trigger( "blur" );
    });
    $("#dp3").blur(function () {
        var qr = $("#dp3").val();
        var q1 = $("#dp2").val();
        var qrmm=$("#dqrmm");
        if (!qr) {
        	qrmm.val("<span>请再输入一次新密码</span>");
        	qrmm.css("visibility", "visible");
        } else {
            if (q1 != qr) {
            	qrmm.html("<span>两次输入密码不一样</span>");
            	qrmm.css("visibility", "visible");
            } else {
            	qrmm.css("visibility", "hidden");
            }
        }
    });
    $("#dp5").focus(function () {
        $("#djmm").css("visibility", "hidden");
    });
    $("#dp2").focus(function () {
        $("#dxmm").css("visibility", "hidden");
    })
    $("#dp3").focus(function () {
        $("#dqrmm").css("visibility", "none");

    });
    });
    //保存密码
    function savepwd() {
        //验证
        var oldPwd = $("#p5").val();
        var Password = $("#p2").val();
        var NewPassword = $("#p3").val();
        if (!oldPwd) {
            $("#jmm").css("visibility", "block");
            //$.messager.alert("操作提示", "请输入旧密码!");
        }
        else if (!Password) {
            $("#xmm").css("visibility", "block");
            //$.messager.alert("操作提示", "请输入新密码!");
        }
        else if (!NewPassword) {
            $("#qrmm").css("display", "block");
            //$.messager.alert("操作提示", "请确认密码!");
        } else {
            $("#jmm").css("visibility", "none");
            $("#xmm").css("visibility", "none");
            $("#qrmm").css("visibility", "none");
            if (Password != NewPassword) {
                $.messager.alert("操作提示", "两次输入密码不一样!");
            } else {
                $.ajax({
                    type: "POST",   //提交数据的类型 分为POST和GET
                    async: false,   //同步 true 默认的,异步
                    url: "${dynamicURL}/system/user/savePwd",  //提交url 注意url必须小写
                    data: {
                        "oldPwd": oldPwd,
                        "password": Password,
                        "newPassword": NewPassword
                    },
                    //执行成功的回调函数
                    success: function (data) {
                    	data=JSON.parse(data);
                        if(data.success){
                        	$.messager.alert("提示",data.msg,"info",function(){
                        		LogOut();
                        	});
                        }else{
                        	$.messager.alert("提示",data.msg,"error");
                        }
                    },
                    //执行失败的回调函数
                    error: function () {

                    }
                });
            }
        }

    }
  //保存密码
    function dsavepwd() {
        //验证
        var oldPwd = $("#dp1").val();
        var Password = $("#dp2").val();
        var NewPassword = $("#dp3").val();
        if (!oldPwd) {
            $("#djmm").css("visibility", "block");
            //$.messager.alert("操作提示", "请输入旧密码!");
        }
        else if (!Password) {
            $("#dxmm").css("visibility", "block");
            //$.messager.alert("操作提示", "请输入新密码!");
        }
        else if (!NewPassword) {
            $("#dqrmm").css("display", "block");
            //$.messager.alert("操作提示", "请确认密码!");
        } else {
            $("#djmm").css("visibility", "none");
            $("#dxmm").css("visibility", "none");
            $("#dqrmm").css("visibility", "none");
            if (Password != NewPassword) {
                $.messager.alert("操作提示", "两次输入密码不一样!");
            } else {
                $.ajax({
                    type: "POST",   //提交数据的类型 分为POST和GET
                    async: false,   //同步 true 默认的,异步
                    url: "${dynamicURL}/system/user/signature/savePwd",  //提交url 注意url必须小写
                    data: {
                        "oldPwd": oldPwd,
                        "password": Password,
                        "newPassword": NewPassword
                    },
                    //执行成功的回调函数
                    success: function (data) {
                    	data=JSON.parse(data);
                        if(data.success){
                        	$.messager.alert("提示",data.msg,"info",function(){
                                window.parent.reLoad("修改密码");
                        	});
                        }else{
                        	$.messager.alert("提示",data.msg,"error");
                        }
                    },
                    //执行失败的回调函数
                    error: function () {

                    }
                });
            }
        }

    }
    function LogOut() {
         window.location.href = '${dynamicURL}/login/logout';
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
</script>
<script type="text/javascript">
    function closes() {
        $("#Loading").fadeOut("normal", function () {
            $(this).remove();
        });
    }
    var pc;
    $.parser.onComplete = function () {
        if (pc) clearTimeout(pc);
        pc = setTimeout(closes, 1000);
    }
</script>