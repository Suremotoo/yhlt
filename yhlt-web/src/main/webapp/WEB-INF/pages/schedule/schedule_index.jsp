<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.color {
	padding: .5em;
	margin-right: .4em;
	border: 1px solid #aaa;
	border-radius: 3px;
	width: 140px;
}
.cp-color-picker {
	position: absolute;
	padding: 6px 6px 0;
	background-color: #444;
	color: #bbb;
	z-index:130;
	font: 600 12px Arial,Helvetica,sans-serif;
	cursor: default;
	border-radius: 5px;
}
</style>
<link rel="stylesheet" type="text/css" href="${staticURL}/colorPicker/compatibility.css">
<script type="text/javascript" src="${staticURL}/colorPicker/jqColorPicker.min.js"></script>

<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
        <div region="north" border="false">
            <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
            	<form class="form-horizontal" for="scheduleDataGrid">
            		<table style="width: 600px; line-height: 40px;">
	                    <tr>
	                        <td>标题:</td>
	                        <td>
	                            <input class="easyui-textbox" type="text" name="search_LIKE_title" style="width: 150px; height: 26px">
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
             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
            </div>
        </div>
        <div region="center" border="false">
            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
                <table id="scheduleDataGrid"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="详情" style="width: 620px; height: 600px;overflow: auto;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/schedule/save" method="post">
    	<input type="hidden" name="id" id="dictId"/>
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">标题：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="title" id="titleFormId" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">全天：</td>
	            <td>
	            	<select name="allDay" id="allDayFormId" class="easyui-validatebox" style="width: 270px; height: 26px" data-options="required:true" >
						<option value="1" selected="selected">是</option>
						<option value="0" >否</option>
					</select>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">背景颜色：</td>
	            <td>
	            	<input name="color" id="colorFormId" type="text" class="easyui-validatebox color no-alpha" style="width: 270px; height: 26px" data-options="required:true"  value="#FFFFFF"/>
	            </td>
	        </tr>
	         <tr>
	            <td class="text_tr">文本颜色：</td>
	            <td>
	            	<input name="textColor" id="textColorFormId" type="text" class="easyui-validatebox color no-alpha" style="width: 270px; height: 26px" data-options="required:true"  value="#FFFFFF"/>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">开始时间：</td>
	            <td>
	            	<input name="start" id="startFormId"  type="text" class="form-control easyui-datetimebox" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">结束时间：</td>
	            <td>
	            	<input name="end" id="endFormId" type="text" class="form-control easyui-datetimebox" style="width: 270px; height: 26px" data-options="required:true"  />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">URL：</td>
	            <td>
	            	<input id="urlFormId" type="text" class="form-control easyui-validatebox" style="width: 270px; height: 26px"  name="url" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">日程描述：</td>
	            <td>
					<textarea id="contentFormId" class="form-control easyui-validatebox" style="width: 270px;" rows="10" name="content"></textarea>
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
<script type="text/javascript">
	//分页
	$('.color').colorPicker();
	var scheduleDataGrid;
	$(function () {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
        scheduleDataGrid = $('#scheduleDataGrid').datagrid({
			url: '${dynamicURL}/schedule/list',
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
					{field: 'title', title: '日程标题', width: 200, sortable: true},
					{field: 'content', title: '日程描述', width: 300, sortable: true},
					{field: 'allDay', title: '全天', width: 100,  sortable: true,
					 formatter:function(value,row,index){if(value==1){return '是';}else{return '否';}}},
					{field: 'start', title: '开始时间', width: 100,  sortable: true},
					{field: 'end', title: '结束时间', width: 100,  sortable: true},
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
		$("#allDayFormId")[0].selectedIndex=0;
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
                $.messager.alert('提示', '保存成功！', "info");
                $('#addWindow').dialog('close');
                scheduleDataGrid.datagrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
    $("#addWindow .BtnLine .submit").on("click", function () {
		$("#addWindow form.addForm").submit();
    });
    
    
    //修改
    function edit() {
        var row = scheduleDataGrid.datagrid("getSelected");
        if (row) {
            var form = $("#addWindow form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/schedule/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
                    form.form("load", response.obj);
                    $("#addWindow").dialog("open");
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function del(){
    	 top._del(scheduleDataGrid, {delUrl: "${dynamicURL}/schedule/delete"});
    }
	
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

