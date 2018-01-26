<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
        <div region="north" border="false">
            <div id="queryHeader" style="padding: 10px; width: 800px; line-height: 40px;" class="easyui-panel">
            	<form class="form-horizontal" for="smsDatagrid">
            		<table style="width: 100%; line-height: 40px;">
	                    <tr>
	                        <td>目标号码:</td>
	                        <td>
	                            <input class="easyui-textbox" type="text" name="search_LIKE_tel" style="width: 150px; height: 26px">
	                        </td>
	                        <td>发送人:</td>
	                        <td>
	                            <input class="easyui-textbox" type="text" name="search_LIKE_sendName" style="width: 150px; height: 26px">
	                        </td>
	                        <td>
	                            <div class="BtnLine" style="border: 0px; margin: 0px; padding: 0px;text-align:left">
	                                <button type="button" class="easyui-linkbutton queryBtn" iconcls="icon-search" >搜索</button>
	                                <button type="button" class="easyui-linkbutton clearBtn" iconcls="icon-reload" >重置</button>
	                            </div>
	                        </td>
	                    </tr>
	                </table>
            	</form>
            </div>
            <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">发送</button>
            </div>
        </div>
        <div region="center" border="false">
            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
                <table id="smsDatagrid"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="发送" style="width: 620px; height: 315px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/sms/save" method="post">
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">电话号码：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="tel" id="nameFormId" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
	         <tr>
	            <td class="text_tr">短信内容：</td>
	            <td>
	            	<textarea class="easyui-textbox" name="content" style="width: 270px; height: 100px" data-options="required:true,multiline:true"></textarea>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr"></td>
	            <td><div style="width: 270px;color: green;">禁止发送赌博、黄色、诈骗等违法犯罪的信息，否则后果自负，谢谢配合！</div> </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">发送</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
<script type="text/javascript">
	//分页
	var smsDatagrid;
	$(function () {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
        smsDatagrid = $('#smsDatagrid').datagrid({
			url: '${dynamicURL}/sms/list?sort=gmtCreate&order=desc',
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			pagination : true,
			rownumbers : true,
			singleSelect : true,
			lines:true,
			idField : 'id',
			columns: [ [
					{field: 'id', formatter:function Ra(val, row, index) {return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';}},
					{field: 'sendName', title: '发送人',width:200},
					{field: 'tel',title:'目标号码',width:200},
					{field: 'content',title:'内容',width:200},
					{field: 'status',title:'状态',width:200,
						formatter:function(val, row, index) {
							 var color=val==0?"green":"red";
							 var html=val==0?"发送成功！":"发送失败！"
	                		 return $("<span>",{html:html,css:{"color": color}}).prop("outerHTML");
						}
					},
					{field: 'gmtCreate',title:'发送时间',width:200}
				]
			],
			onClickRow: function (rowIndex, rowData) {
                //加载完毕后获取所有的checkbox遍历
                var radio1 = $("input[type='radio']")[rowIndex].disabled;
                //如果当前的单选框不可选，则不让其选中
                if (radio1 != true) {
                    //让点击的行单选按钮选中
                    $("input[type='radio']")[rowIndex].checked = true;
                    return false;
                }
                else {
                    $("#posDatagrid").datagrid("clearSelections");
                    $("input[type='radio']")[rowIndex].checked = false;
                    return false;
                }
            },
			onDblClickRow: function(index){
				edit();
			}
        });
		
		$("form[for] button.queryBtn").on("click.datagrid-query", function () {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function () {
			top._clearSearch($(this).parents("form"));
        });
	})
    function add() {
		$("#addWindow form.addForm").form("clear");
		$("#addWindow").dialog("open");
    }
	 //初始化form表单
    $("#addWindow form.addForm").form({
        onSubmit: function () {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close');
            }
            return isValid;
        },
        success: function (data) {
            if (typeof data == "string") {
                data = JSON.parse(data);
            }
            if (data.success) {
                $.messager.alert('提示', '发送成功！', "info");
                $('#addWindow').dialog('close');
                smsDatagrid.datagrid('reload');
            } else {
                $.messager.alert('提示', "发送失败！", 'error');
            }
        }
    });
    $("#addWindow .BtnLine .submit").on("click", function () {
    	$("#addWindow form.addForm").submit();
    });
</script>

