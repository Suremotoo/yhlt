<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="${staticURL}/codemirror/lib/codemirror.js"></script>
<link rel="stylesheet" href="${staticURL}/codemirror/lib/codemirror.css">
<script src="${staticURL}/codemirror/mode/javascript/javascript.js"></script>
<script src="${staticURL}/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${staticURL}/codemirror/addon/selection/active-line.js"></script>

<style type="text/css">
.CodeMirror {
  border: 2px solid #eee;
  height: 500px;
}
</style>
<title></title>
</head>
<body>
	<div class="easyui-layout layout-custom-resize"
		data-options="custom_fit:true,fit:true">
		<div
			data-options="region:'west',title:'Portal组件',split:false,collapsible:false"
			style="width: 350px;">
			<table id="protalModuleDatagrid"></table>
		</div>
		<div
			data-options="region:'center',title:'效果展示',split:false,collapsible:false"
			style="width: 500px;">
			<div id="view"></div>
		</div>
	</div>
		<!-- form start -->
	<!-- 添加修改 -->
	<div id="addWindow" class="modal modal-700-175 "
		style="display: none;">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
			<h3>Portal组件</h3>
		</div>
		<div class="modal-body">
			<form class="form-horizontal addForm"
				action="${dynamicURL}/portalModule/save" method="post">
				<section class="corner-all">
					<legend>
						<span class="content-body-bg">Portal组件信息</span>
					</legend>
					<input type="hidden" name='id' id="portalModuleId">
					<div class="row-fluid">
						<div class="small-span4 span4">
							<label class="label-control" for="nameFormId">组件名称</label>
							<input name="name" id="nameFormId" type="text"
								class="form-control easyui-validatebox" data-options="required:true" />
						</div>
						<div class="small-span4 span4">
							<label class="label-control" for="containerFormId">容器ID</label>
							<input name="container" id="containerFormId" type="text"
								class="form-control easyui-validatebox" data-options="required:true" />
						</div>
						<div class="small-span4 span4">
	                        <label class="label-control" for="iconId" title="图标">图标</label>
	                        <input name="icon" id="iconId" class="form-control" data-options="required:true" />
	                    </div>
					</div>
					<div class="row-fluid">
						<div class="small-span12 span12">
							<label class="label-control" for="contentFormId">组件代码</label>
							<textarea name="content" id="contentFormId"></textarea> 
						</div>
					</div>
				</section>
			</form>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn btn-success submit">保存</a> 
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
		</div>
	</div>
	<script>
		var protalModuleDatagrid;
		var editor;
		$(function() {
			protalModuleDatagrid = $('#protalModuleDatagrid').datagrid({
				url : '${dynamicURL}/portalModule/list',
	           	pagination: true,
	            rownumbers : true,//行数  
	            custom_height: 5,//额外处理自适应性（计算时留5px高度）
	            singleSelect:true, 
	            idField: 'id',
				columns : [ [ {
					field : 'id',
					hidden:true,
				}, {
					field : 'name',
					title : '组件名称',
					align : 'center',
					width:160,
					sortable : true
				}, {
					field : 'container',
					title : '容器ID',
					align : 'center',
					width:150,
					sortable : true
				}
				] ],
			 	toolbar: [{
	                text: '新增',
	                iconCls: 'elusive-edit',
	                handler: function () {
	                	$("#addWindow form.addForm").form("clear");
	                	editor.getDoc().setValue('');
	                	editor.refresh();
	                	$("#addWindow").modal("show");
	                	
	                }
	            },'-',{
					text : '修改',
					iconCls : 'elusive-edit',
					handler : function() {
						var row = protalModuleDatagrid.datagrid("getSelected");
				        if (row) {
				            var form = $("#addWindow form.addForm");
				            form.form("clear");
				            $.ajax({
				                url: "${dynamicURL}/portalModule/detail",
				                data: {id: row.id},
				                dataType: "json",
				                success: function (response) {
				                    form.form("load", response.obj);
				            		editor.getDoc().setValue(response.obj.content);
				                    editor.refresh();
				                    $("#addWindow").modal("show");
				                }
				            });
				        } else {
				            $.messager.alert('提示', '请选择要修改的记录！', 'error');
				        }
					}
				},'-',{
					text : '删除',
					iconCls : 'elusive-remove',
					handler : function() {
						major._del(protalModuleDatagrid, {
							delUrl : "${dynamicURL}/portalModule/delete"
						});
					}
				}, '-',{
	                text: '取消选中',
	                iconCls: 'elusive-minus-sign',
	                handler: function () {
	                	protalModuleDatagrid.datagrid('unselectAll');
	                }
	            },'-', {
					text : '刷新',
					iconCls : 'elusive-refresh',
					handler : function() {
						protalModuleDatagrid.datagrid('reload');
					}
				}],
				onDblClickRow : function(index,row) {
					$('#view').panel({ 
						fit:true,
						href:"${dynamicURL}/portalModule/module?id="+row.id
					});
				}
			});
			$('#iconId').combobox({
				data : (function() {
					var data = [];
					$.each(major.icons, function(i) {
						data.push({
							value : this,
							text : this
						})
					});
					return data;
				})(),
				panelWidth : 500,
				formatter : function(row) {
					return '<i class="'+row.value+'"></i> ' + row.value;
				}
			}).combo('panel').addClass("icons-combo");
			//初始化form表单
			$("#addWindow form.addForm").form({
				onSubmit : function() {
					var isValid = $(this).form('validate');
					if (!isValid) {
						$.messager.progress('close');
					}
					return isValid;
				},
				success : function(data) {
					if (typeof data == "string") {
						data = JSON.parse(data);
					}
					$.messager.progress('close');
					if (data.success) {
						$(this).form("load", data.obj);
						$("#addWindow").modal("hide");
						$.messager.alert('提示', '保存成功！', 'success');
						protalModuleDatagrid.datagrid('reload');
						clearList();
					} else {
						$.messager.alert('提示', data.msg, 'error');
					}
				}
			});
			$("#addWindow .modal-footer .submit").on("click", function() {
				var res = $("#addWindow form.addForm").submit();
			});
		});
		editor = CodeMirror.fromTextArea($("#contentFormId")[0], {
		    lineNumbers: true,
		    mode:  "javascript",
		    styleActiveLine: true,
		    matchBrackets: true
		 });

	</script>
</body>
</html>