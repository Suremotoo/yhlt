<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="/tld/security.tld" %>
<html >
<head>
<title></title>
</head>
<body>
	<div class="easyui-layout layout-custom-resize"
		data-options="custom_fit:true,fit:true">
		<div
			data-options="region:'west',title:'资源列表',split:false,collapsible:false"
			style="width: 400px;">
			<table id="resourceTreegrid"></table>
		</div>
		<div
			data-options="region:'center',title:'属性列表',split:false,collapsible:false"
			style="width: 500px;">
			<table id="propertyDatagrid"></table>
		</div>
	</div>
	<!-- -当前table列表右击菜单- -->
	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="del();" iconCls="icon-remove">删除</div>
		<div onclick="edit();" iconCls="icon-edit">编辑</div>
	</div>
	<!-- combogrid toolbar 外键关联 查询条件中 对 combogrid 添加toolbar -->
	<!-- form start -->
	<!-- 添加修改 -->
	<div id="addWindow" class="modal modal800 "
		style="display: none;">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
			<h3>数据规则引擎-属性管理</h3>
		</div>
		<div class="modal-body">
			<form class="form-horizontal addForm" name="form"
				action="${dynamicURL}/datapermissionProperty/save" method="post">
				<section class="corner-all">
					<legend>
						<span class="content-body-bg">基本信息</span>
					</legend>
					<input type="hidden" name='id' id="id"/>
					<input type="hidden" name='resourcesEntity.id' id="resourceId"/>
					<div class="row-fluid">
						<div class="small-span6 span6 ">
							<label class="label-control" for="propertyCnnameFormId" title="中文属性名">中文属性名</label>
							<input name="propertyCnname" id="propertyCnnameFormId" type="text"
								class="form-control easyui-validatebox"
								data-options="required:true" />
						</div>
						<div class="small-span6 span6 ">
							<label class="label-control" for="propertyNameFormId" title="属性名称">属性名称</label>
							<input name="propertyName" id="propertyNameFormId" type="text"
								class="form-control easyui-validatebox" data-options="required:true"/>
						</div>
					</div>
					<div class="row-fluid">
						<div class="small-span6 span6 ">
							<label class="label-control" for="typeFormId" title="类型">类型</label>
							<input name="typeEntity.id" id="typeFormId" type="text"
								class="form-control" data-options="required:true"/>
						</div>
						<div class="small-span6 span6 ">
							<label class="label-control" for="sortNumberFormId" title="排序">排序</label>
							<input name="sortNumber" id="sortNumberFormId" type="text"
								class="form-control easyui-validatebox" data-options="required:true"/>
						</div>
					</div>
					<div class="row-fluid">
						<div class="small-span6 span6 ">
							<label class="label-control" for="urlFormId" title="URL">URL</label>
							<input name="url" id="urlFormId" type="text" class="form-control " />
						</div>
					</div>
					<div class="row-fluid">
						<div class="small-span6 span6 ">
							<label class="label-control" for="inputNameFormId" title="名称字段">名称字段</label>
							<input name="inputName" id="inputNameFormId" type="text"
								class="form-control " />
						</div>
						<div class="small-span6 span6 ">
							<label class="label-control" for="inputValueFormId" title="值字段">值字段</label>
							<input name="inputValue" id="inputValueFormId" type="text"
								class="form-control " />
						</div>
					</div>
				</section>
			</form>
		</div>
		<div class="modal-footer" style="text-align: center;">
			<a href="#" class="btn btn-success submit">保存</a> 
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
		</div>
	</div>
	<script>
		var resourceTreegrid;
		var propertyDatagrid,typeCombotree;
		var isLoad=false;//是否延迟加载
		$(function() {
			 resourceTreegrid = $('#resourceTreegrid').treegrid({
		            url: '${dynamicURL}/system/resources/treegrid?search_EQ_type=0',
		            pagination: false,
		            fit:true,
		            fitColumns:true,
		            custom_fit: true,//额外处理自适应性
		            treeField: 'name',
		            parentField: 'parentId',
		            idField: 'id',
		            singleSelect : true,
		            columns: [
		                [
		                    {field: 'id',checkbox : true},
		                    {field: 'name', title: '名称',width:500, sortable: true},
		                    {field: 'description', width:500,title: '描述', sortable: true}
		                ]
		            ],
		            toolbar: [{
		                text: '展开',
		                iconCls: 'elusive-plus',
		                handler: function () {
		                    redo();
		                }
	            	},'-',{
		                text: '折叠',
		                iconCls: 'elusive-minus-sign',
		                handler: function () {
		                    undo();
	                	}
		            }],
		            onCheck:function(row){
		            	var level=$(this).treegrid("getLevel",row.id);
		            	isLoad = false;
						if(level==3){
							isLoad = true;
							propertyDatagrid.datagrid("load", {'search_EQ_resourcesEntity.id' : row.id});
						}
		            },
		            onLoadSuccess: function(node, data){
		            }
		        });
			 propertyDatagrid =  $('#propertyDatagrid').datagrid({
				 	url: '${dynamicURL}/datapermissionProperty/list',
		            pagination: true,
		            fit:true,
		            fitColumns:true,
		            custom_fit: true,//额外处理自适应性
		            custom_height: 5,//额外处理自适应性（计算时留5px高度）
		            idField: 'id',
		            singleSelect : true,
		            columns: [
		                [
		                    {field: 'id',checkbox : true},
		                    {field: 'propertyCnname', title: '名称',width:200, sortable: true},
		                    {field: 'propertyName', title: '属性',width:200, sortable: true},
		                    {field: 'typeEntity.name', title: '类型',width:200, sortable: true,formatter: function (value, rec) { return rec.typeEntity['name'];}},
		                    {field: 'url', title: 'URL',width:200, sortable: true},
		                    {field: 'inputName', title: '名称字段',width:200, sortable: true},
		                    {field: 'inputValue', title: '值字段',width:200, sortable: true}
		                ]
		            ],
		            toolbar: [
					<security:ifAny authorization="数据规则引擎-属性管理_管理员">    
		            {
	            	 	text : '增加',
		                iconCls : 'elusive-plus',
		                handler: function () {
                	 		add();
		                }
	            	},'-', {
		                text : '修改',
		                iconCls : 'elusive-edit',
		                handler : function() {
		                	edit();
		                }
		            }, '-', {
		                text : '删除',
		                iconCls : 'elusive-remove',
		                handler : function() {
		                    major._del(propertyDatagrid,{delUrl:"${dynamicURL}/datapermissionProperty/delete"});
		                }
		            }, '-', 
	            	</security:ifAny>
	            	{
		                text: '取消选中',
		                iconCls: 'elusive-minus-sign',
		                handler: function () {
		                	
		                }
             		},'-',{
		                text: '刷新',
		                iconCls: 'elusive-refresh',
		                handler: function () {
		                	propertyDatagrid.datagrid('reload');
		                }
		            }],
		            onLoadSuccess: function(node, data){
		            	
		            },
		            onBeforeLoad:function(){
		            	return isLoad;
		            }
			 });
			 //初始化form表单
		        $("#addWindow form.addForm").form({
		            onSubmit: function(){
		                var isValid = $(this).form('validate');
		                if (!isValid){
		                    $.messager.progress('close');   
		                }
		                return isValid; 
		            },
		            success:function(data){
		                if(typeof data =="string"){
		                    data = JSON.parse(data);
		                }
		                $.messager.progress('close');
		                if(data.success){
		                    $(this).form("load",data.obj);
		                    $.messager.show({title : '提示',msg : '保存成功！'});
		                    propertyDatagrid.datagrid("reload");
		                    $("#addWindow").modal("hide");
		                }else{
		                    $.messager.alert('提示', data.msg, 'error');
		                }
		            }
		        });
		        $("#addWindow .modal-footer .submit").on("click",function(){
	        		$("#addWindow form.addForm").submit();
		        });
		        typeCombotree=$('#typeFormId').combotree({
		            panelWidth: 250,
		            lines : true,
		            panelHeight : 400,
		            //下面这两个字段需要视情况修改
		            idField: 'id',
		            textFiled: 'name',
		            parentField:'parentId',
		            url: '${dynamicURL}/system/dict/combobox?type=RULE_PROPERTY_INPUT'
		            //数据较多时打开下面两个属性分页 和 特殊属性prevQuery（不好描述）
		            //pagination : true,
		            //prevQuery:{},
		        });
		});
	    function redo() {
	        var node = resourceTreegrid.treegrid('getSelected');
	        if (node) {
	        	resourceTreegrid.treegrid('expandAll', node.id);
	        } else {
	        	resourceTreegrid.treegrid('expandAll');
	        }
	    }

	    function undo() {
	        var node = resourceTreegrid.treegrid('getSelected');
	        if (node) {
	        	resourceTreegrid.treegrid('collapseAll', node.id);
	        } else {
	        	resourceTreegrid.treegrid('collapseAll');
	        }
	    }
	    function edit(){
	        var  row = propertyDatagrid.datagrid("getSelected");
	        if(row){
	            var form = $("#addWindow form.addForm");
	            form.form("clear");
	            $.ajax({
	            	url: "${dynamicURL}/datapermissionProperty/detail",
	                data:{id:row.id},
	                dataType:"json",
	                success:function(response){
	                	form.form("load",response.obj);
	                	$("#resourceId").attr("value",response.obj.resourcesEntity['id']);
	                	typeCombotree.combotree("setValue",response.obj.typeEntity.id);
	                    $("#addWindow").modal("show");
	                }
	            });
	        }else{
	            $.messager.alert('提示', '请选择要删除的记录！', 'error');
	        }
	    }
		function add() {
		   	var row=resourceTreegrid.treegrid("getSelected");
		   	if(row){
		   		$("#addWindow form.addForm").form("clear");
				$("#addWindow").modal("show");
				$("#resourceId").attr("value",row.id);
		   	}else{
		   		$.messager.alert('提示', '请选择资源信息！', 'error');
		   	}
		}
		
	</script>
</body>
</html>