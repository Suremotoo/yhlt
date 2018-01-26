<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="${staticURL}/codemirror/lib/codemirror.js"></script>
<link rel="stylesheet" href="${staticURL}/codemirror/lib/codemirror.css">
<script src="${staticURL}/codemirror/mode/javascript/javascript.js"></script>
<script src="${staticURL}/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${staticURL}/codemirror/addon/selection/active-line.js"></script>

<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
    	<div region="north" border="false">
            <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
            </div>
        </div>
        <div region="center" border="false">
			<div class="easyui-layout layout-custom-resize"
		data-options="custom_fit:true,fit:true">
		<div
			data-options="region:'west',title:'报表列表',split:false,collapsible:false"
			style="width: 350px;">
			<table id="reportDatagrid"></table>
		</div>
		<div
			data-options="region:'center',title:'效果展示',split:false,collapsible:false"
			style="width: 75%;">
			<div id="view"></div>
		</div>
	</div>
	
        </div>
    </div>
</div>


<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增" style="width: 1000px; height: 800px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/system/report/save" method="post">
    	<input type="hidden" name="id" id="reportId"/>
    	<table class="table_edit" >
	        <tr>
	            <td class="text_tr" style="width: 20%;">名称：</td>
	            <td>
                    <input name="name" id="nameFormId" type="text" class="easyui-validatebox" data-options="required:true"/>
	            </td>
	            <td class="text_tr">所属模块：</td>
	            <td>
	            	 <input name="module" id="moduleFormId" type="text" class="form-control" data-options="required:true" style="width: 180px;"/>
	            </td>
	             <td class="text_tr">顺序号：</td>
	            <td>
	            	 <input name="sortNumber" id="sortNumberFormId" type="text"  class="form-control easyui-validatebox" data-options="required:true"/>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">报表显示代码：</td>
	            <td colspan="5">
	            	<textarea name="content" id="contentFormId" class="form-control"  data-options="required:true"></textarea> 
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">报表JS代码：</td>
	            <td colspan="5">
	            	 <textarea name="jsContent" id="jsContentFormId"></textarea> 
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>

<script>
	var reportDatagrid;
	var editor;
	var jsEditor;
	$(function() {
		reportDatagrid = $('#reportDatagrid').datagrid({
			url : '${dynamicURL}/system/report/list',
           	pagination: true,
            rownumbers : true,//行数  
            fit:true,
            singleSelect:true, 
            idField: 'id',
			columns : [ [ {
				field : 'id',
				hidden:true,
			}, {
				field : 'name',
				title : '报表名称',
				width:150
			}, {
				field : 'moduleName',
				title : '所属模块',
				width:150
			}
			] ],
			onDblClickRow : function(index,row) {
				showView(row.id);
			}
		});
		
		editor = CodeMirror.fromTextArea($("#contentFormId")[0], {
		    lineNumbers: true,
		    mode:  "javascript"
		 });
		
		jsEditor = CodeMirror.fromTextArea($("#jsContentFormId")[0], {
		    lineNumbers: true,
		    mode:  "javascript"
		 });
		$("#moduleFormId").combobox({
			url:"${dynamicURL}/system/dict/combobox?type=REPORT_MODULE",
			valueField:'value',   
			textField:'name',
			panelWidth: 180,
	        panelHeight : 300,
			editable:false 
		});
	});
	
	function showView(id){
		$('#view').panel({ 
			fit:true,
			href:'${dynamicURL}/system/report/view?id='+id  
		});
	}
	
	function add() {
		$("#addWindow form.addForm").form("clear");
		$("#addWindow").dialog("open");
		editor.refresh();
    	editor.getDoc().setValue('');
    	jsEditor.refresh();
    	jsEditor.getDoc().setValue('');
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
                reportDatagrid.datagrid('reload');
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
        var row = reportDatagrid.datagrid("getSelected");
        if (row) {
            var form = $("#addWindow form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/system/report/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
                    form.form("load", response.obj);
                    $("#addWindow").dialog("open");
                    editor.refresh();
            		editor.getDoc().setValue(response.obj.content);
            		jsEditor.refresh();
                    jsEditor.getDoc().setValue(response.obj.jsContent);
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function del(){
    	 top._del(reportDatagrid, {delUrl: "${dynamicURL}/system/report/delete"});
    }
</script>