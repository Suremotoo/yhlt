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
			data-options="region:'center',title:'规则列表',split:false,collapsible:false"
			style="width: 300px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'center'">
					<table id="ruleDatagrid"></table>
				</div>
				<div data-options="region:'south',collapsed:false,title:'规则明细'" style="height: 300px">
					<table id="ruleDetailDatagrid"></table>
				</div>
			</div>
		</div>
		<div
			data-options="region:'east',title:'对象列表',split:false,collapsible:false"
			style="width: 500px;">
			<table id="userDatagrid"></table>
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
			<h3>数据规则引擎-规则管理</h3>
		</div>
		<div class="modal-body">
			<form class="form-horizontal addForm" name="form"
				action="${dynamicURL}/datapermissionRule/save" method="post">
				<section class="corner-all">
					<legend>
						<span class="content-body-bg">基本信息</span>
					</legend>
					<input type="hidden" name='id' id="id"/>
					<input type="hidden" name='resourcesEntity.id' id="resourceId"/>
					<div class="row-fluid">
						<div class="small-span4 span4 ">
							<label class="label-control" for="nameFormId" title="规则名称">规则名称</label>
							<input name="name" id="nameFormId" type="text" class="form-control" data-options="required:true" />
						</div>
						<div class="small-span4 span4 ">
							<label class="label-control" for="enableFormId" title="规则名称">状态</label>
							<select name="enable" id="enableFormId" class="form-control easyui-validatebox"  data-options="required:true" >
								<option value="0" selected="selected">启动</option>
								<option value="-1" >禁用</option>
							</select>
						</div>
						<div class="small-span4 span4 ">
							<label class="label-control" for="remarkFormId" title="备注">备注</label>
							<input name="remark" id="remarkFormId" type="text" class="form-control easyui-validatebox" />
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
	<!-- 添加明细修改 -->
	<div id="addWindowDetail" class="modal modal600 "
		style="display: none;">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
			<h3>数据规则引擎-规则明细管理</h3>
		</div>
		<div class="modal-body">
			<form class="form-horizontal addForm" name="form"
				action="${dynamicURL}/datapermissionRuleDetail/save" method="post">
				<section class="corner-all">
					<legend>
						<span class="content-body-bg">明细基本信息</span>
					</legend>
					<input type="hidden" name='id' id="id"/>
					<input type="hidden" name='ruleEntity.id' id="ruleId_detail"/>
					<input type="hidden" name='type' id="type_detail"/>
					<input type="hidden" name="propertyName" id="propertyName"/>
					<div class="row-fluid">
						<div class="small-span6 span6 ">
							<label class="label-control" for="propertyFormId" title="规则名称">规则名称</label>
							<input name="propertyEntity.id" id="propertyFormId" type="text" class="form-control" data-options="required:true" />
						</div>
					</div>
					<div class="row-fluid">
						<div class="small-span6 span6 ">
							<label class="label-control" for="conditionGroupFormId" title="规则名称">条件分组KEY</label>
							<input name="conditionGroup" id="conditionGroupFormId" type="text" class="form-control" data-options="required:true" />
						</div>
					</div>
					<div class="row-fluid">
						<div class="small-span6 span6 ">
							<label class="label-control" for="opeartorFormId" title="操作符">操作符</label>
							<select name="operator" id="opeartorFormId" class="form-control" >
								<option value="NONE" selected="selected">无</option>
								<option value="EQ" >等于</option>
								<option value="NEQ" >不等于</option>
								<option value="GT" >大于</option>
								<option value="GTE" >大于等于</option>
								<option value="LT" >小于</option>
								<option value="LTE" >小于等于</option>
								<option value="LIKE" >LIKE</option>
								<option value="IN" >IN</option>
							</select>
						</div>
					</div>
					<div class="row-fluid">
						<div class="small-span6 span6 ">
							<label class="label-control" for="valueFormId" title="值">值</label>
							<input name="value" id="valueFormId" type="text" class="form-control easyui-validatebox" data-options="required:true"/>
						</div>
					</div>
					<div class="row-fluid" id="dynForm">
					</div>
				</section>
			</form>
		</div>
		<div class="modal-footer" style="text-align: center;">
			<a href="#" class="btn btn-success submit">保存</a> 
			<a href="#" class="btn" data-dismiss="modal">关闭</a>
		</div>
	</div>
	<div id="windows" class="easyui-window" title="选取权限对象 "
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width: 560px; height: 520px; padding: 10px; margin: auto;">
		<div id="view"></div>
	</div>
<!-- 	<!-- 添加规则用户 -->
<!-- 	<div id="addWindowUser" class="modal modal800 " -->
<!-- 		style="display: none;"> -->
<!-- 		<div class="modal-header"> -->
<!-- 			<a class="close" data-dismiss="modal">×</a> -->
<!-- 			<h3>数据规则引擎-规则用户管理</h3> -->
<!-- 		</div> -->
<!-- 		<div class="modal-body"> -->
<!-- 			<form class="form-horizontal addForm" name="form" -->
<%-- 				action="${dynamicURL}/datapermissionRuleUser/save" method="post"> --%>
<!-- 				<input type="hidden" name='id' id="id"/> -->
<!-- 				<input type="hidden" name='ruleEntity.id' id="ruleId_user"/> -->
<!-- 				<input type="hidden" name='resourcesEntity.id' id="resourceId_user"/> -->
<!-- 				 <div class="easyui-tabs" data-options="tabWidth:112" style="width:750px;height:350px"> -->
<!-- 			        <div title="公司" style="padding:10px"> -->
<!-- 			            <section class="corner-all"> -->
<!-- 							<legend> -->
<!-- 								<span class="content-body-bg">规则用户信息</span> -->
<!-- 							</legend> -->
<!-- 							<div class="row-fluid"> -->
<!-- 								<div class="small-span6 span6 "> -->
<!-- 									<label class="label-control" for="companyFormId" title="公司">公司</label> -->
<!-- 									<input name="companyEntity.id" id="companyFormId" type="text" class="form-control" data-options="required:true" /> -->
<!-- 								</div> -->
<!-- 								<div class="small-span6 span6 "> -->
<!-- 									<label class="label-control" for="sortNumberFormId" title="排序">排序</label> -->
<!-- 									<input name="sortNumber" id="sortNumberFormId" type="text" class="form-control easyui-validatebox" data-options="required:true" /> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</section> -->
<!-- 			        </div> -->
<!-- 			        <div title="部门" style="padding:10px"> -->
<!-- 			            <p>Maps Content.</p> -->
<!-- 			        </div> -->
<!-- 			        <div title="角色" style="padding:10px"> -->
<!-- 			            <p>Journal Content.</p> -->
<!-- 			        </div> -->
<!-- 			        <div title="岗位" style="padding:10px"> -->
<!-- 			            <p>History Content.</p> -->
<!-- 			        </div> -->
<!-- 			        <div title="人员" style="padding:10px"> -->
<!-- 			            <p>References Content.</p> -->
<!-- 			        </div> -->
<!-- 			    </div> -->
<!-- 			</form> -->
<!-- 		</div> -->
<!-- 		<div class="modal-footer" style="text-align: center;"> -->
<!-- 			<a href="#" class="btn btn-success submit">保存</a>  -->
<!-- 			<a href="#" class="btn" data-dismiss="modal">关闭</a> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<script>
		var resourceTreegrid;
		var ruleDatagrid;
		var ruleDetailDatagrid;
		var userDatagrid;
		var isLoad=false;//是否延迟加载
		var isLoadDetail=false;//规则 明细表、用户表加载
        var dynDatagrid;//动态表格内容
        var propertyCombotree;
		$(function() {
			//资源
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
	                	ruleDatagrid.datagrid('unselectAll');
		            	var level=$(this).treegrid("getLevel",row.id);
		            	isLoad = false;
						if(level==3){
							//刷新规则表格
							isLoad = true;
							isLoadDetail = false;
				        	ruleDatagrid.datagrid("load", {'search_EQ_resourcesEntity.id' : row.id});
							clearDataGrid();
						}
		            },
		            onLoadSuccess: function(node, data){
		            }
		        });
			 //规则
			 ruleDatagrid =  $('#ruleDatagrid').datagrid({
				 	url: '${dynamicURL}/datapermissionRule/list',
		            pagination: false,
		            fit:true,
		            fitColumns:true,
		            custom_fit: true,//额外处理自适应性
		            custom_height: 5,//额外处理自适应性（计算时留5px高度）
		            idField: 'id',
		            singleSelect : true,
		            selectOnCheck : true,
		            checkOnSelect : true,
		            columns: [
		                [
		                    {field: 'id',checkbox : true},
		                    {field: 'name', title: '名称',width:200, sortable: true},
		                    {field: 'enable', title: '状态',width:200, sortable: true,formatter: function (value, rec) { return value==0?"启用":"禁用"}},
		                    {field: 'remark', title: '备注',width:200, sortable: true},
		                    {field: 'createUser', title: '创建人',width:200, sortable: true}
		                ]
		            ],
		            toolbar: [ 
					<security:ifAny authorization="数据规则引擎-规则管理_管理员">    
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
		                    major._del(ruleDatagrid,{delUrl:"${dynamicURL}/datapermissionRule/delete"},function(){clearDataGrid();});
		                }
		            }, '-', 
	            	</security:ifAny>
	            	{
		                text: '取消选中',
		                iconCls: 'elusive-minus-sign',
		                handler: function () {
		                	ruleDatagrid.datagrid('unselectAll');
		                }
             		},'-',{
		                text: '刷新',
		                iconCls: 'elusive-refresh',
		                handler: function () {
		                	ruleDatagrid.datagrid('reload');
		                }
		            }],
		            onLoadSuccess: function(node, data){
		            	
		            },
		            onClickRow:function(index){
		            	isLoadDetail = true;
		            	//刷新规则明细表格
		            	ruleDatagrid.datagrid('selectRow',index);
		    		    var row = ruleDatagrid.datagrid('getSelected');  
		            	ruleDetailDatagrid.datagrid("load", {'search_EQ_ruleEntity.id' : row.id});
		            	userDatagrid.datagrid("load", {'search_EQ_ruleEntity.id' : row.id});
		            },
		            onBeforeLoad:function(){
		            	return isLoad;
		            }
			 });
			 //明细
			 ruleDetailDatagrid = $('#ruleDetailDatagrid').datagrid({
				 	url:'${dynamicURL}/datapermissionRuleDetail/list',
		            pagination: false,
		            fit:true,
		            fitColumns:true,
		            custom_fit: true,//额外处理自适应性
		            custom_height: 5,//额外处理自适应性（计算时留5px高度）
		            idField: 'id',
		            singleSelect : true,
		            columns: [
		                [
		                    {field: 'id',checkbox : true},
		                    {field: 'propertyEntity.name', title: '名称',width:150, sortable: true,formatter: function (value, rec) { return rec.propertyEntity['propertyCnname'];}},
		                    {field: 'name', title: '名称',width:350, sortable: true},
		                    {field: 'conditionGroup', title: '条件分组KEY',width:350, sortable: true},
		                    {field: 'operator', title: '操作符',width:100, sortable: true},
		                    {field: 'value', title: '值',width:200, sortable: true},
		                    {field: 'sortNumber', title: '排序',width:100, sortable: true},
		                ]
		            ],
		            toolbar: [
					<security:ifAny authorization="数据规则引擎-规则管理_管理员">    
		            {
	            	 	text : '增加',
		                iconCls : 'elusive-plus',
		                handler: function () {
		                	addDetail();
		                }
	            	},'-', {
		                text : '修改',
		                iconCls : 'elusive-edit',
		                handler : function() {
		                	editDetail();
		                }
		            }, '-', {
		                text : '删除',
		                iconCls : 'elusive-remove',
		                handler : function() {
		                    major._del(ruleDetailDatagrid,{delUrl:"${dynamicURL}/datapermissionRuleDetail/delete"});
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
		                	ruleDetailDatagrid.datagrid('reload');
		                }
		            }],
		            onLoadSuccess: function(node, data){
		            	
		            },
		            onBeforeLoad:function(){
		            	return isLoadDetail;
		            },
		            view: detailview,
		            detailFormatter: function(rowIndex, rowData){
	                    return '<div style="word-break:break-all;font-size:12px;">' + rowData.name + '</div>';
	                }
			 });
			 //用户表
			 userDatagrid= $('#userDatagrid').datagrid({
				 	url:'${dynamicURL}/datapermissionRuleUser/list',
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
		                    {field: 'type',title: '类型',formatter: 
		                    	function (value, rec) {
		                    		var result="加载异常";
		                    		if(rec.companyEntity){
		                    			result="公司";
		                    		}else if(rec.departmentEntity){
		                    			result="部门";
		                    		}else if(rec.roleEntity){
		                    			result="角色";
		                    		}else if(rec.userEntity){
		                    			result="人员";
		                    		}
		                    		return result;
		                    	}
		                    },
		                    {field: 'name', title: '名称',width:200, sortable: true,formatter: 
		                    	function (value, rec) {
		                    		var result="加载异常";
		                    		if(rec.companyEntity){
		                    			result=rec.companyEntity['name'];
		                    		}else if(rec.departmentEntity){
		                    			result=rec.departmentEntity['name'];
		                    		}else if(rec.roleEntity){
		                    			result=rec.roleEntity["name"];
		                    		}else if(rec.userEntity){
		                    			result=rec.userEntity["name"];
		                    		}
		                    		return result;
		                    	}},
		                    {field: 'sortNumber', title: '排序',width:200, sortable: true},
		                    {field: 'createUser', title: '创建人',width:200, sortable: true}
		                ]
		            ],
		            toolbar: [
					<security:ifAny authorization="数据规则引擎-规则管理_管理员">    
		            {
	            	 	text : '增加',
		                iconCls : 'elusive-plus',
		                handler: function () {
		                	addUser();
		                }
	            	}, '-', {
		                text : '删除',
		                iconCls : 'elusive-remove',
		                handler : function() {
		                    major._del(userDatagrid,{delUrl:"${dynamicURL}/datapermissionRuleUser/delete"});
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
		                	userDatagrid.datagrid('reload');
		                }
		            }],
		            onLoadSuccess: function(node, data){
		            	
		            },
		            onBeforeLoad:function(){
		            	return isLoadDetail;
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
	                    ruleDatagrid.datagrid("reload");
	                    $("#addWindow").modal("hide");
	                }else{
	                    $.messager.alert('提示', data.msg, 'error');
	                }
	            }
	        });
	        $("#addWindow .modal-footer .submit").on("click",function(){
        		$("#addWindow form.addForm").submit();
	        });
	        //规则明细form表单
	        $("#addWindowDetail form.addForm").form({
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
	                    var row=ruleDatagrid.datagrid("getSelected");
	                    if(row){
	                    	ruleDetailDatagrid.datagrid("load", {'search_EQ_ruleEntity.id' : row.id});
	                    }
	                    $("#addWindowDetail").modal("hide");
	                }else{
	                    $.messager.alert('提示', data.msg, 'error');
	                }
	            }
	        });
	        $("#addWindowDetail .modal-footer .submit").on("click",function(){
	        	//TODO:
	        	if(dynDatagrid){
	        		var data = dynDatagrid.treegrid('getSelections');
	        		var tempData = [];
	        		$.each(data,function(i,row){
	        			tempData.push({
	        		        "id":row.id,
	        		        "name":row.name
	        		    })
	        		});
	        		$("#valueFormId").attr("value",JSON.stringify(tempData));
	        	}
        		$("#addWindowDetail form.addForm").submit();
	        });
	      	//规则用户form表单
	        $("#addWindowUser form.addForm").form({
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
	                    var row=ruleDatagrid.datagrid("getSelected");
	                    if(row){
	                    	userDatagrid.datagrid("load", {'search_EQ_ruleEntity.id' : row.id});
	                    }
	                    $("#addWindowUser").modal("hide");
	                }else{
	                    $.messager.alert('提示', data.msg, 'error');
	                }
	            }
	        });
	        $("#addWindowUser .modal-footer .submit").on("click",function(){
        		$("#addWindowUser form.addForm").submit();
	        });
	        $('#companyFormId').combotree({
	            panelWidth: 250,
	            lines : true,
	            panelHeight : 400,
	            //下面这两个字段需要视情况修改
	            idField: 'id',
	            textFiled: 'name',
	            parentField:'parentId',
	            url: '${dynamicURL}/system/company/combotree'
	            //数据较多时打开下面两个属性分页 和 特殊属性prevQuery（不好描述）
	            //pagination : true,
	            //prevQuery:{},
             });
	         propertyCombotree=$('#propertyFormId').combotree({
	            panelWidth: 250,
	            lines : true,
	            panelHeight : 400,
	            //下面这两个字段需要视情况修改
	            idFiled: 'id',
	            textFiled: 'propertyCnname',
	            //数据较多时打开下面两个属性分页 和 特殊属性prevQuery（不好描述）
	            //pagination : true,
	            //prevQuery:{},
            	onSelect:function(record){
            		//TODO:
            		$("#type_detail").attr("value",record.typeEntity.value);
            		$("#propertyName").attr("value",record.propertyName);
            		var attrDiv = "";
            		 $("#opeartorFormId").val("NONE");
            		if(record.typeEntity.value=='checkbox'){
            			$("#opeartorFormId").val("IN");
            			attrDiv = '<table id="dynDatagrid"></table>';
            			$("#dynForm").html(attrDiv);
            			dynDatagrid = $('#dynDatagrid').treegrid({
            	            url: '${dynamicURL}/'+record.url,
            	            title: '列表',
            	            pagination: false,
            	            custom_fit: true,//额外处理自适应性
            	            custom_height: 5,//额外处理自适应性（计算时留5px高度）
            	            treeField: record.inputName,
            	            parentField: 'parentId',
            	            idField: record.inputValue,
            	            singleSelect:false,
            	            selectOnCheck:true,
            	            checkOnSelect:true,
            	            columns: [
            	                [
            	                    {field: record.inputValue, checkbox: true},
            	                    {field: record.inputName, title: '名称',width:200, sortable: true}
            	       			]
            	       		]}
            	        );
            			
            		}else if(record.typeEntity.value=='input'){
//             			attrDiv = '<div class="small-span6 span6 ">'+
// 								'<label class="label-control" for="valueFormId" title="值">值</label>'+
// 								'<input name="value" id="valueFormId" type="text" class="form-control easyui-validatebox" data-options="required:true"/>'+
// 								'</div>';
            			$("#dynForm").html(attrDiv);
            		}
            		$.parser.parse($("#dynForm").get(0));//重新渲染：否则数字验证不好使
	            }
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
	    //添加规则
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
	    function edit(){
	        var  row = ruleDatagrid.datagrid("getSelected");
	        if(row){
	            var form = $("#addWindow form.addForm");
	            form.form("clear");
	            $.ajax({
	            	url: "${dynamicURL}/datapermissionRule/detail",
	                data:{id:row.id},
	                dataType:"json",
	                success:function(response){
	                	form.form("load",response.obj);
	                	$("#resourceId").attr("value",response.obj.resourcesEntity['id']);
	                    $("#addWindow").modal("show");
	                }
	            });
	        }else{
	            $.messager.alert('提示', '请选择要删除的记录！', 'error');
	        }
	    }
		//添加明细
		function addDetail() {
		   	var row=ruleDatagrid.datagrid("getSelected");
		   	var resourceRow=resourceTreegrid.treegrid("getSelected");
		   	if(row && resourceRow){
		   		$("#propertyFormId").combotree('reload','${dynamicURL}/datapermissionProperty/combotree?search_EQ_resourcesEntity.id='+resourceRow.id);
		   		$("#addWindowDetail form.addForm").form("clear");
    			$("#addWindowDetail").modal("show");
        		$("#ruleId_detail").attr("value",row.id);
        		//$("#dynDatagrid").empty();
        		$("#dynForm").html("");
		   	}else{
		   		$.messager.alert('提示', '请选择规则信息！', 'error');
		   	}
		}
	    function editDetail(){
	        var row = ruleDetailDatagrid.datagrid("getSelected");
	        if(row){
	            var form = $("#addWindowDetail form.addForm");
	            form.form("clear");
	            $.ajax({
	            	url: "${dynamicURL}/datapermissionRuleDetail/detail",
	                data:{id:row.id},
	                dataType:"json",
	                success:function(response){
	                	form.form("load",response.obj);
	                	propertyCombotree.combotree("setValue",response.obj.propertyEntity.id);
	                	$("#ruleId_detail").attr("value",response.obj.ruleEntity['id']);
	                    $("#addWindowDetail").modal("show");
	                }
	            });
	        }else{
	            $.messager.alert('提示', '请选择要删除的记录！', 'error');
	        }
	    }
	  	//添加规则用户
		function addUser() {
			var resourceRow=resourceTreegrid.treegrid("getSelected");
		   	var row=ruleDatagrid.datagrid("getSelected");
		   	if(resourceRow && row){
		   		var param={};
		   		param["resourceId"]=resourceRow.id;
		   		param["ruleId"]=row.id;
		   		param["win"]="view";
		   	 	$('#windows').window('open');
		   		 $('#view').panel({ 
					href:'${dynamicURL}/datapermissionRule/selection',
					queryParams:{'data':JSON.stringify(param)},
					method:'POST'
				});
// 		   		$("#addWindowUser form.addForm").form("clear");
//     			$("#addWindowUser").modal("show");
//         		$("#ruleId_user").attr("value",row.id);
//         		//设置用户资源id
// 				$("#resourceId_user").attr("value",resourceRow.id);
		   	}else{
		   		$.messager.alert('提示', '请选择规则信息！', 'error');
		   	}
		}
		function clearDataGrid(){
        	//清空明细表
        	ruleDetailDatagrid.datagrid('loadData',{total:0,rows:[]});
        	userDatagrid.datagrid('loadData',{total:0,rows:[]});
		}
	</script>
</body>
</html>