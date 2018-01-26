<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body>
	<div class="easyui-layout layout-custom-resize"
		data-options="custom_fit:true,fit:true">
		<div
			data-options="region:'west',split:false,collapsible:false"
			style="width: 300px;">
			<div id="container" class="easyui-layout layout" fit="true">
		        <div region="north" border="false">
					<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
		             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="addRole()" type="button" iconcls="icon-add" group="">新增</button>
		             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="editRole()" type="button" iconcls="icon-edit" group="">修改</button>
		             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="delRole()" type="button" iconcls="icon-delete" group="">删除</button>
		            </div>
	            </div>
	            <div region="center" border="false">
					<table id="roleTreegrid"></table>
				</div>
			</div>
		</div>
		<div
			data-options="region:'center',split:false,collapsible:false"
			style="width: 33%;">
			<div id="container" class="easyui-layout layout" fit="true">
		        <div region="north" border="false">
					<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
		             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="editUser()" type="button" iconcls="icon-add" group="">人员维护</button>
		             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="delUser()" type="button" iconcls="icon-delete" group="">删除</button>
		            </div>
		        </div>
		        <div region="center" border="false">
					<table id="userDatagrid"></table>
				</div>
			</div>
		</div>
		<div
			data-options="region:'east',split:false,collapsible:false"
			style="width: 33%;">
			<div id="container" class="easyui-layout layout" fit="true">
		        <div region="north" border="false">
					<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
		             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="editResources()" type="button" iconcls="icon-save" group="">保存</button>
		            </div>
		        </div>
		        <div region="center" border="false">
					<table id="resourceTreegrid"></table>
				</div>
			</div>
		</div>
	</div>
	<!-- -当前table列表右击菜单- -->
	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<div onclick="del();" iconCls="icon-remove">删除</div>
	</div>
<!-- 添加修改 -->
<div id="addRoleWin" class="easyui-dialog" title="新增" style="width: 620px; height: 260px;" modal="true" closed="true" buttons="#new-buttons">
    <form id="addForm" class="addForm" action="${dynamicURL}/system/role/save" method="post">
    	<input type="hidden" name="id" />
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">名称：</td>
	            <td>
	            	<input name="name" id="nameFormId" type="text" class="easyui-textbox" style="width: 270px; height: 26px;" data-options="required:true"/>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr" style="width: 30%;">所属机构：</td>
	            <td>
	            	<select name="companyId" id="companyFormId"  data-options="required:true" style="width: 270px; height: 26px;"></select>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">备注：</td>
	            <td>
	            	<input name="remark" id="remarkFormId" type="text" class="easyui-textbox" style="width: 270px; height: 26px;"/>
	            </td>
	        </tr>
	         <tr>
	            <td class="text_tr">排序：</td>
	            <td>
	            	<input name="sort_number" id="sort_numberFormId" type="text" class="easyui-textbox" style="width: 270px; height: 26px;" data-options="required:true,validType:'number'" />
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addRoleWin').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
	<!-- 添加修改 -->
<%-- 	<div id="addWindow" class="modal modal-700-175 "
		style="display: none;">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
			<h3>角色信息</h3>
		</div>
		<div class="modal-body">
			<form class="form-horizontal addForm"
				action="${dynamicURL}/system/role/save" method="post">
				<section class="corner-all">
					<legend>
						<span class="content-body-bg">基本信息</span>
					</legend>
					<input type="hidden" name='id' id="roleId">
					<div class="row-fluid">
						<div class="small-span6 span6">
							<label class="label-control" for="nameFormId" title="员工号">角色名</label>
							<input name="name" id="nameFormId" type="text"
								class="form-control easyui-validatebox"
								data-options="required:true" />
						</div>
						<div class="small-span6 span6">
							<label class="label-control">所属机构</label><!-- <select
								name="companyId" id="companyFormId" class="form-control"
								data-options="required:true"></select> -->
						</div>
					</div>
					<div class="row-fluid">
						<div class="small-span6 span6">
							<label class="label-control" for="remarkFormId" title="姓名">备注</label>
							<input name="remark" id="remarkFormId" type="text"
								class="form-control" />
						</div>
						<div class="small-span6 span6">
							<label class="label-control" for="sort_numberFormId" title="排序">排序</label>
							<input name="sort_number" id="sort_numberFormId" type="text"
								class="form-control easyui-validatebox"
								data-options="required:true,validType:'number'" />
						</div>
					</div>
				</section>
			</form>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn btn-success submit">保存</a> <a href="#"
				class="btn" data-dismiss="modal">关闭</a>
		</div>
	</div> --%>
	
	<!-- 	人员选择  dialog-->
	<div id="w" class="easyui-dialog" title="选择人员"  modal="true" closed="true" style="width: 500px; height: 470px; padding: 10px; margin: auto;">
		<table width="100%" align="center" border="0" cellpadding="0" style="border-collapse: separate; border-spacing: 5px;" cellspacing="0">
			<tr>
				<td colspan="3">机构：<select 
					name="language" id="company" style="width: 136.3px; font-size: 14px;"
					contenteditable="false"></select> 部门：<select name="language" id="dept"
					style="width: 136.3px; font-size: 14px;" contenteditable="false"></select>
				</td>
			</tr>
			<tr>
				<td colspan="1">搜索：<input class="easyui-textbox"  id="searchBox"
					style="width: 136.3px"></input>
				</td>
				<td colspan="2"><button id="searchButton" class="easyui-linkbutton" plain="false">查询</button></td>
			</tr>
			<tr>
				<td style="width: 181.8px">待选人员：</td>
				<td style="width: 18px;"></td>
				<td style="width: 181.8px">已选人员：</td>
			</tr>
			<tr>
				<td style="width: 181.8px"><select multiple="multiple"
					id="select1"
					style="width: 181.8px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;">
				</select></td>
				<td style="width: 27px;"><button href="#" id="add_right"
					class="easyui-linkbutton">&gt;&nbsp;&nbsp;</button><br /> <br /> <button
					href="#" id="remove_left" class="easyui-linkbutton">&lt;&nbsp;&nbsp;</button><br />
					<br /> <button href="#" id="add_all" class="easyui-linkbutton">&gt;&gt;</button><br />
					<br /> <button href="#" id="remove_all" class="easyui-linkbutton">&lt;&lt;</button><br />
				</td>
				<td style="width: 181.8px"><select multiple="multiple"
					id="select2"
					style="width: 181.8px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;">
				</select></td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: right;"><br/>
					<button id="rySubmit" class="easyui-linkbutton" plain="false">确定</button>&nbsp;&nbsp;<button id="cancel"
					class="easyui-linkbutton" plain="false" onclick="window.close();">取消</button></td>
			</tr>
		</table>
	</div>
	<script>
var userDatagrid;
var roleTreegrid;
var resourceTreegrid;
var isLoad=false;//是否延迟加载
var depCom;
var comanyCombo;
var company;
$(function() {
	company=$('#company').combotree({
		   panelWidth: 250,
		   panelHeight : 400,
		   idField: 'id',
		   nameField: 'name',
		   url: '${dynamicURL}/system/company/combotree?search_EQ_parentId=0',
		   onChange:function(newValue, oldValue){
		   		//级联加载
				$.get('${dynamicURL}/system/department/combotree',{'search_EQ_companyEntity.id':newValue},function(data){
					depCom.combotree("clear").combotree('loadData',data);
				},'json');
		   		//人员加载
				$.get('${dynamicURL}/system/user/search',{'search_EQ_companyEntity.id':newValue},function(data){
					$("#select1").empty();
					$.each(eval(data),function(i,d){
							$("#select1").append("<option value='"+d.id+"'>"+d.name+"</option>");
					});
				},'json');
			}
		});
		comanyCombo = $('#companyFormId').combotree({
			panelWidth : 250,
			lines : true,
			panelHeight : 400,
			//下面这两个字段需要视情况修改
			idField : 'id',
			nameField : 'name',
			url : '${dynamicURL}/system/company/combotree?search_EQ_parentId=0'
		}); 
		depCom = $('#dept').combotree({
		   panelWidth: 250,
		   lines : true,
		   panelHeight : 400,
		   idField: 'id',
		   nameField: 'name',
		  	onChange:function(newValue, oldValue){
		  		//人员加载
					$.get('${dynamicURL}/system/user/search',{'search_EQ_departmentEntity.id':newValue},function(data){
						$("#select1").empty();
						$.each(eval(data),function(i,d){
							$("#select1").append("<option value='"+d.id+"'>"+d.name+"</option>");
						});
					},'json');
		  	}
		});
		 resourceTreegrid = $('#resourceTreegrid').treegrid({
	            url: '${dynamicURL}/system/resources/ntreegrid?search_EQ_parentId=0&search_EQ_flag=0',
	            pagination: false,
	            queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
	            fit:true,
	            fitColumns:true,
	            treeField: 'name',
	            idField: 'id',
	            singleSelect : false,
	            lines:true,
	            columns: [
	                [
	                    {field: 'id',checkbox : true},
	                    {field: 'name', title: '名称',width:500, sortable: true,align:'left'},
	                    {field: 'description', width:500,title: '描述', sortable: true}
	                ]
	            ],
	            onCheck:function(node){
	            	cascadeCheck(node);
	            	//cascadeUnCheck(node);
	            },
	            onLoadSuccess: function(node, data){
     				//$(this).treegrid('collapseAll');
					checkResourceTree();
	            },
	            onBeforeCollapse:function(){
	            	//return false;
	            },
	            onBeforeLoad:function(){
	            	return isLoad;
	            }
	        });
		userDatagrid = $('#userDatagrid').datagrid({
			url : '${dynamicURL}/system/role/selectedUser',
			pagination : true,
			rownumbers : true,//行数  
			queryForm : "#queryHeader form",//列筛选时附带加上搜索表单的条件
			custom_fit : true,//额外处理自适应性
			custom_heighter : "#queryHeader",//额外处理自适应性（计算时留出元素#queryHeader高度）
			custom_height : 5,//额外处理自适应性（计算时留5px高度）
			singleSelect : false,
			idField : 'id',
			fit:true,
			columns : [ [ {
				field : 'id',
				checkbox : true
			}, {
				field : 'user.loginName',
				title : '登录名',
				width : 60,
				align : 'left',
				sortable : true,
				formatter: function (value, rec) { return rec.user['loginName'];}
			}, {
				field : 'user.name',
				title : '中文用户名',
				width : 100,
				align : 'left',
				sortable : true,
				formatter: function (value, rec) { return rec.user['name'];}
			} , {
				field : 'user.companyEntity.name',
				title : '公司名称',
				width : 100,
				align : 'left',
				sortable : true,
				formatter: function (value, rec) { return rec.user.companyEntity["name"];}
			} , {
				field : 'user.departmentEntity.name',
				title : '部门名称',
				width : 100,
				align : 'left',
				sortable : true,
				formatter: function (value, rec) { return rec.user.departmentEntity["name"];}
			} ] ],
			//行右击菜单
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
            onBeforeLoad:function(){
            	return isLoad;
            }
		});
		roleTreegrid = $('#roleTreegrid').treegrid({
			url : '${dynamicURL}/system/role/roleTreegrid?search_EQ_parentId=0',
			pagination : false,
			singleSelect : true,
			custom_height : 5,//额外处理自适应性（计算时留5px高度）
			treeField : 'name',
			lines:true,
			fit:true,
			idField : 'id',
			columns : [ [ 
			              {field : 'id',checkbox : true}, 
			              {field : 'name',title : '名称',width : 150,align:'left'}, 
			              {field : 'flag',hidden : true} 
			           ] ],
			onLoadSuccess : function(node, data) {
			},
            onBeforeCollapse:function(){
            	return true;
            },
            onSelect:function(row, checked){
            	if (row.flag == 1) {//角色节点
					isLoad=true;
					userDatagrid.datagrid("clearSelections");
					userDatagrid.datagrid("load", {'id' : row.id});
					resourceTreegrid.treegrid('reload');//重载  勾选
				} else {//公司节点
					clearList();
				}
            }
		}); 
		/*---------------------Form 外键为combogrid----------------*/
		//初始化form表单
		$("#addForm").form({
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
					//$(this).form("load", data.obj);
					$("#addRoleWin").dialog("close");
					$.messager.alert('提示', '保存成功！', 'success');
					roleTreegrid.treegrid("reload");
					clearList();
				} else {
					$.messager.alert('提示', data.msg, 'error');
				}
			}
		});

		//注册主筛选条件表单的 查询和清空事件
		$("form[for] button.queryBtn").on("click.datagrid-query",
				function() {
					major._search($(this).parents("form[for]"));
				});
		$("form[for] button.clearBtn").on("click.datagrid-query",
				function() {
					major._clearSearch($(this).parents("form"));
				});
		//注册combogrid筛选条件表单的 查询和清空事件
		$("form.gridTb .easyui-linkbutton[iconcls='elusive-search']").on(
				"click.datagrid-query",
				function() {
					major._search($(this).parents("form.gridTb"), $(this)
							.parents(".datagrid-toolbar").next(
									".datagrid-view").find("> table"));
				})
		$("form.gridTb .easyui-linkbutton[iconcls='elusive-repeat']").on(
				"click.datagrid-query", function() {
					major._clearSearch($(this).parents("form.gridTb"));
				})

		$("#addRoleWin  .submit").on("click", function() {
			//查询角色注册
			/* $.post('${dynamicURL}/system/role/check', {
				'roleName' : $("#nameFormId").val(),
				'roleId' : $("#roleId").val()
			}, function(data) {
				if (data.success) {
					var res = $("#addRoleWin form.addForm").submit();
				} else {
					$.messager.alert('提示', data.msg, 'error');
				}
			}, 'json'); */
			var res = $("#addRoleWin form.addForm").submit();
		});
		/*-------------- 当前table右击菜单操作  --------------------*/
		
		
		//勾选资源树
		function checkResourceTree(){
			var row=roleTreegrid.treegrid("getSelected");
			if(row && row.flag == 1){
				resourceTreegrid.treegrid("unselectAll");
				$.ajax({
					url:"${dynamicURL}/system/role/resourceTreegrid",
					type:"POST",
					dataType:"json",
					data:{"roleId":row.id},
					success:function(msg){
						$.each(msg,function(i,d){
							resourceTreegrid.treegrid('select',d);
						});
					}
				});
			}
		}
		//选择子节点级联父节点
		function cascadeCheck(node){
			var parentNode=resourceTreegrid.treegrid("getParent",node.id);
			if(parentNode){
				resourceTreegrid.treegrid('select',parentNode.id);
				cascadeCheck(parentNode);
			}
		}
		//取消选中父节点级联所有子节点
		function cascadeUnCheck(node){
			var childNodes=resourceTreegrid.treegrid("getChildren",node.id);
			$.each(childNodes,function(i,d){
				resourceTreegrid.treegrid("unselect",d.id);
			});
		}
		//人员选择
		//确定按钮
		$("#rySubmit").click(function() {
			var row = roleTreegrid.treegrid("getSelected");
			var arr = [];
				$("#select2 option").each(function(i, d) {
					arr.push(d.value);
				});
			window.returnValue = arr;
			var params = {};
			params["ids"]=arr;
			params["roleId"]=row.id;
			if(row.id && arr.length){
				$.ajax({
					type : 'POST',
					url : "${dynamicURL}/system/role/editUser",
					data : $.param(params,true),
					dataType:"json",
					beforeSend : function(XMLHttpRequest){
						progress();
					},
					success : function(msg) {
						$.messager.progress('close');
						if(msg.success){
							$.messager.alert('提示', '保存成功！', 'success');
							userDatagrid.datagrid('load', {
								'id' : row.id
							});
						}else{
							$.messager.alert('提示', '保存失败！', 'error');
						}
					},
					error : function(msg) {
						$.messager.progress('close');
						$.messager.alert('提示', '保存失败！', 'error');
					}
				});
			}
			$("#w").window("close");
		});
		//取消
		$("#cancel").click(function(){
			$("#w").window("close");
		});
		//移到右边
		$('#add_right').click(function() {
			//获取选中的选项，删除并追加给对方
			$('#select1 option:selected').appendTo('#select2');
		});
		//移到左边
		$('#remove_left').click(function() {
			$('#select2 option:selected').appendTo('#select1');
		});
		//全部移到右边
		$('#add_all').click(function() {
			//获取全部的选项,删除并追加给对方
			$('#select1 option').appendTo('#select2');
		});
		//全部移到左边
		$('#remove_all').click(function() {
			$('#select2 option').appendTo('#select1');
		});
		//双击选项
		$('#select1').dblclick(function() { //绑定双击事件
			//获取全部的选项,删除并追加给对方
			$("option:selected", this).appendTo('#select2'); //追加给对方
		});
		//双击选项
		$('#select2').dblclick(function() {
			$("option:selected", this).appendTo('#select1');
		});
	      //查询按钮
	       $("#searchButton").click(function() {
				var searchText = $('#searchBox').val();
				if(searchText==""){
					$.messager.alert('消息', '请填写查询人信息！', 'info');
				}else{
					var companyId=company.combotree("getValue");
					var deptId=depCom.combotree("getValue");
					$.get('${dynamicURL}/system/user/search',{"search_EQ_companyEntity.id":companyId,"search_EQ_departmentEntity.id":deptId,"search_LIKE_name":searchText},function(data){
						$("#select1").empty();
						$.each(data,function(index,content){
								$("#select1").append("<option value='"+content.id+"'>"+content.name+"</option>");
					 	});
					},'json');
				}
			});
	});
	function delRole() {
		var prompt = "您要删除当前所选项目以及当前项目包含的子项（人员关系，资源关系）吗？";
		var row = roleTreegrid.treegrid("getSelected");
		if (row) {
			if(row.flag==1){
				$.messager.confirm('确认对话框', prompt, function(r){
					if (r){
						$.ajax({
							url:"${dynamicURL}/system/role/delete",
							type:"POST",
							dataType:"JSON",
							data:{"ids":row.id},
							success:function(msg){
								if(msg.success){
									$.messager.alert('提示', '删除成功！', 'success');
									roleTreegrid.treegrid("reload");
								}else{
									$.messager.alert('提示', '删除失败！', 'error');
								}
								clearList();
							}
						});
					}
				});
			}else{
				$.messager.alert('提示', '公司节点不可删除！', 'error');
			}
		} else {
			$.messager.alert('提示', '请选择要删除的角色！', 'error');
		}
	}
	function editRole() {
		var row = roleTreegrid.treegrid("getSelected");
		if (row) {
			if (row.flag == 1) {
				var form = $("#addRoleWin form.addForm");
				form.form("clear");
				$.ajax({
					url : "${dynamicURL}/system/role/detail",
					data : {
						id : row.id
					},
					dataType : "json",
					success : function(response) {
						var obj = response.obj
						form.form("load", response.obj);
						$("#addRoleWin").dialog("open");
					}
				});
			} else {
				$.messager.alert('提示', '公司信息不可编辑！', 'error');
			}
		} else {
			$.messager.alert('提示', '请选择要编辑的记录！', 'error');
		}
	}
	function addRole() {
		$("#addRoleWin form.addForm").form("clear");
		$("#addRoleWin").dialog("open");
	}
	
	//人员维护
	function editUser() {
		var row = roleTreegrid.treegrid("getSelected");
		if (row) {
			if (row.flag == 1) {
				//清空
				$('#select2').empty();
				$('#select1').empty();
				depCom.combotree("clear");
				company.combotree("clear");
				$("#w").window("open");
			} else {
				$.messager.alert('提示', '你不能在公司节点维护人员！', 'error');
			}
		} else {
			$.messager.alert('提示', '请选择要维护的角色！', 'error');
		}
	}
	function delUser(){
		var rows = userDatagrid.datagrid("getSelections");
		if (rows) {
			$.messager.confirm('确认对话框', '您确定要将选中人员从当前角色中删除吗？', function(r){
				if (r){
					var p={};
					var idsz=[];
					$.each(rows,function(i,d){
						idsz.push(d.id);
					});
					p["ids"]=idsz;
					$.ajax({
						url : "${dynamicURL}/system/role/deleteUser",
						data :$.param(p,true),
						dataType : "json",
						type:"POST",
						success : function(res) {
							if(res.success){
								userDatagrid.datagrid("reload");
								$.messager.alert('提示', '删除成功！', 'success');
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的人员！', 'info');
		}
	}
	//保存资源
	function editResources(){
		var rows=resourceTreegrid.treegrid("getSelections");
		var params={};
		var resourceIds;
		if(rows.length){
			resourceIds=[];
			$.each(rows,function(i,d){
				resourceIds.push(d.id);
			});
		}
		params["resourceIds"]=resourceIds;
		var selRow=roleTreegrid.treegrid("getSelected");
		params["roleId"]=selRow && selRow.flag == 1 ? selRow.id : "";
		$.ajax({
			url:"${dynamicURL}/system/role/editResources",
			type:"POST",
			dataType:"JSON",
			data:$.param(params,true),
		 	beforeSend : function(XMLHttpRequest){
				progress();
			},
			success:function(msg){
				$.messager.progress('close');
				if(msg.success){
					$.messager.alert('提示', '保存成功！', 'info');
					resourceTreegrid.treegrid("reload");
				}else{
					$.messager.alert('提示', '保存失败！', 'error');
				}
			},
			error:function(){
				$.messager.progress('close');
			}
		});
	}
	
	function progress(){
	    var win = $.messager.progress({
	        title:'保存',
	        msg:'处理中...'
	    });
	}
	
	//清空右侧列表
	function clearList(){
		userDatagrid.datagrid('loadData',{total:0,rows:[]});//清空人员列表
		resourceTreegrid.treegrid('loadData',{total:0,rows:[]});//清空资源列表
	}

	</script>
