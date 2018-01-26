<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
        <div region="north" border="false">
            <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
            	<form class="form-horizontal" for="systemLogDatagrid">
            		<table style="width: 1000px; line-height: 40px;">
	                    <tr>
	                        <td>开始时间:</td>
	                        <td>
	                            <input class="easyui-datetimebox" type="text" name="gmtCreate_begin" style="width: 180px; height: 26px">
	                        </td>
	                        <td>结束时间:</td>
	                        <td>
	                            <input class="easyui-datetimebox" type="text" name="gmtCreate_end" style="width: 180px; height: 26px">
	                        </td>
	                        <td>操作人:</td>
	                        <td>
	                            <input class="easyui-textbox" type="text" name="search_LIKE_userInfo.name" style="width: 150px; height: 26px">
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
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="detail()" type="button" iconcls="icon-edit" group="">详情</button>
            </div>
        </div>
        <div region="center" border="false">
            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
                <table id="systemLogDatagrid"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="详情" style="width: 620px; height: 550px;overflow: auto;" modal="true" closed="true">
    <form class="addForm" action="#" method="post">
    	<input type="hidden" name="id" id="dictId"/>
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">操作人：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="userInfo" id="userNameFormId" style="width: 270px; height: 26px" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">操作内容：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="className" id="classNameFormId" style="width: 270px; height: 26px"/>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">业务主键：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="entityId" id="entityIdFormId" style="width: 270px; height: 26px" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">后台业务类：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="service" id="serviceFormId" style="width: 270px; height: 26px" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">后台业务方法：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="operation" id="operationFormId" style="width: 270px; height: 26px" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">操作时间：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="gmtCreate" id="gmtCreateFormId" style="width: 270px; height: 26px" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">操作前内容：</td>
	            <td>
	            	<textarea class=""  name="content" id="contentFormId" style="width: 270px;" rows="10"></textarea>
	            </td>
	        </tr> 
	        <tr>
	            <td class="text_tr">返回结果：</td>
	            <td>
	            	<textarea class="" name="result" id="resultFormId" style="width: 270px;" rows="10"></textarea>
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">关闭</button>
	    </div>
    </form>
</div>
<script type="text/javascript">
	//分页
	var systemLogDatagrid;
	$(function () {
		$("#addWindow input").attr("readonly","readonly");
		$("#addWindow textarea").attr("readonly","readonly");
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
        systemLogDatagrid = $('#systemLogDatagrid').datagrid({
			url: '${dynamicURL}/system/systemLog/list',
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			fitcolumns: true,
			pagination : true,
			rownumbers : true,
			singleSelect : true,
			lines:true,
			idField : 'id',
			columns: [ [
					{field: 'id', formatter:function Ra(val, row, index) {return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';}},
					{field: 'userInfo.name', title: '操作人', width: 200, align: 'left', sortable: true,formatter: function (value, rec) { return rec.userInfo['name'];}},
					{field: 'service', title: '后台业务类', width: 200, align: 'left', sortable: true},
					{field: 'operation', title: '后台业务方法', width: 200, align: 'left', sortable: true},
					{field: 'entityId', title: '业务主键', width: 200, align: 'left', sortable: true},
					{field: 'className', title: '操作内容', align: 'left', sortable: true},
					{field: 'gmtCreate', title: '操作时间', width: 200, align: 'center', sortable: true}
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
                    $("#dictDatagrid").datagrid("clearSelections");
                    $("input[type='radio']")[rowIndex].checked = false;
                    return false;
                }
            },
			onDblClickRow: function(index){
				detail();
			}
        });
		
		$("form[for] button.queryBtn").on("click.datagrid-query", function () {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function () {
			top._clearSearch($(this).parents("form"));
        });
	})
    
    //查看详情
    function detail() {
        var row = systemLogDatagrid.datagrid("getSelected");
		if (row) {
			var form = $("#addWindow form.addForm");
			form.form("clear");
			$.ajax({
				url : "${dynamicURL}/system/systemLog/detail",
				data : {'id' : row.id},
				dataType : "json",
				success : function(msg) {
					var obj=msg.obj;
					var userName=obj.userInfo.name;
					obj.userInfo=userName;
					form.form("load",msg.obj);
					$("#addWindow").dialog("open");
				}
			});
		} else {
			$.messager.alert('提示', '请选择要查看的记录！', 'error');
		}
    }
</script>

