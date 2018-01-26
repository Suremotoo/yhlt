<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="easyui-layout layout" fit="true">
	<div id="container" class="easyui-layout layout" fit="true">
		<div region="north" border="false">
			<div id="queryHeader"
				style="padding: 10px; width: 100%; line-height: 40px;"
				class="easyui-panel">
				<form class="form-horizontal" for="qualificationTreegrid">
					<table style="width: 800px; line-height: 40px;">
						<tr>
							<td>证书名称:</td>
							<td><input class="easyui-textbox" type="text"
								name="search_LIKE_name" style="width: 150px; height: 26px">
							</td>
							<td>
								<div class="BtnLine"
									style="border: 0px; margin: 0px; padding: 0px; text-align: left">
									<button type="button" class="easyui-linkbutton queryBtn"
										iconcls="icon-search">搜索</button>
									<button type="button" class="easyui-linkbutton clearBtn"
										iconcls="icon-reload">重置</button>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="BtnLine btnBox tl"
				style="border-top: solid 1px #ddd; width: 100%;">
				<button class="easyui-linkbutton l-btn l-btn-small" id="add"
					onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
				<button class="easyui-linkbutton l-btn l-btn-small" id="edit"
					onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
				<button class="easyui-linkbutton l-btn l-btn-small" id="edit"
					onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
			</div>
		</div>
		<div region="center" border="false">
			<div style="padding: 5px; width: 100%;" class="easyui-layout layout"
				fit="true">
				<table id="qualificationTreegrid"></table>
			</div>
		</div>
	</div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增"
	style="width: 620px; height: 350px;" modal="true" closed="true">
	<form class="addForm" action="${dynamicURL}/system/qualification/save"
		method="post">
		<input type="hidden" name="id" />
		<table class="table_edit">
			<tr>
				<td class="text_tr" style="width: 30%;">证书名：</td>
				<td><input class="easyui-textbox" type="text" name="name"
					id="qualificationName" style="width: 270px; height: 26px"
					data-options="required:true" /></td>
			</tr>
			  <tr>
	            <td class="text_tr">上属证书：</td>
	            <td>
	            	<select class="easyui-textbox" name="parentId" id="qualificationFormId" style="width: 270px; height: 26px"></select>
	            </td>
	        </tr>
			<tr>
				<td class="text_tr">检查日期：</td>
				 <td>
	            	<input name="checkPeriod" type="text" class="form-control easyui-datebox" style="width: 270px; height: 26px" />
	            </td>
			</tr>
			<tr>
				<td class="text_tr">有效期：</td>
				<td><input class="easyui-textbox" type="text" name="validDate"
					style="width: 270px; height: 26px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<td class="text_tr">证书编号：</td>
				<td><input class="easyui-textbox" type="text" name="uuid"
					id="qualificationUuid" style="width: 270px; height: 26px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<td class="text_tr">备注：</td>
				<td><input class="easyui-textbox" type="text" name="remark"
					 style="width: 270px; height: 26px" />
				</td>
			</tr>
		</table>
		<div class="BtnLine">
			<button type="button" class="easyui-linkbutton submit">保存</button>
			<button type="button" class="easyui-linkbutton"
				onclick="$('#addWindow').dialog('close');return false;">取消</button>
		</div>
	</form>
</div>
<script type="text/javascript">
	var isLoad=true;//是否延迟加载
	//分页
	var qualificationTreegrid; // 证书数据Tree
	$(function() {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		qualificationTreegrid = $('#qualificationTreegrid').treegrid({
			url : '${dynamicURL}/system/qualification/treegrid?search_EQ_parentId=0',
			pagination: false,
			rownumbers : true,
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			fitColumns:true,
			treeField: 'name',
			idField: 'id',
			columns: [
						[
						{field: 'id', checkbox: true},
						{field: 'name', title: '证书名',width:180, sortable: true,align:'left'},
						{field: 'checkPeriod', title: '检查日期',width:100, sortable: true},
						{field: 'validDate', title: '有效期',width:60, sortable: true},
						{field: 'uuid', title: '证书编号',width:100, sortable: true },
						{field: 'remark', title: '备注',width:100, sortable: true }
						]
					],
			onBeforeLoad:function(){
						return isLoad;
					},
			onDblClickRow : function(index) {
				edit();
				}
			});
		
		// 上级资质证书选择框
	  	$('#qualificationFormId').combotree({
            panelWidth: 250,
            lines : true,
            panelHeight : 400,
            //下面这两个字段需要视情况修改
            idField: 'id',
            nameField: 'name'
     	});

		$("form[for] button.queryBtn").on("click.datagrid-query", function() {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function() {
			top._clearSearch($(this).parents("form"));
		});
	})
	
	// 添加
	function add() {
		$("#addWindow form.addForm").form("clear");
		loadQualicationCombotree(0); // 点击添加按钮加载上级证书列表框
		$("#addWindow").dialog("open");
	}
	
	// 加载上级证书
	function loadQualicationCombotree(qualificationId){
			$.post('${dynamicURL}/system/qualification/combotree?search_EQ_parentId=0',function(data){
				$('#qualificationFormId').combotree("clear");
				$('#qualificationFormId').combotree('loadData',data);
				if(qualificationId){
					$("#qualificationFormId").combotree("setValue",qualificationId);
				}else{
					$("#qualificationFormId").combotree("setValue",0);
				}
			},'json');
	}
	
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
			if (data.success) {
				$.messager.alert('提示', '保存成功！', "info");
				$('#addWindow').dialog('close');
				qualificationTreegrid.treegrid('reload');
			} else {
				$.messager.alert('提示', data.msg, 'error');
			}
		}
	});
	
	// 提交前验证uuid和name是否重复
	$("#addWindow .BtnLine .submit").on("click", _.debounce(function() {
		 if ($("#qualificationUuid").val() == null || $("#qualificationUuid").val() == "") {
			$.post('${dynamicURL}/system/qualification/check', {
				'qualificationUuid' : $('#qualificationUuid').val(),
				'qualificationName' : $('#qualificationName').val()
			}, function(data) {
				if (data.success) {
					$("#addWindow form.addForm").submit();
				} else {
					$.messager.alert('提示', data.msg, 'error');
				}
			}, 'json');
		} else {
			$("#addWindow form.addForm").submit();
		} 
	}, waitTime, true));

	//修改
	function edit() {
		var row = qualificationTreegrid.datagrid("getSelected");
		if (row) {
			var form = $("#addWindow form.addForm");
			form.form("clear");
			$.ajax({
				url : "${dynamicURL}/system/qualification/detail",
				data : {
					id : row.id
				},
				dataType : "json",
				success : function(response) {
					form.form("load", response.obj);
					var companyRow = qualificationTreegrid.treegrid("getSelected");
					loadQualicationCombotree(response.obj.parentId);
					$("#addWindow").dialog("open");
				}
			});
		} else {
			$.messager.alert('提示', '请选择要修改的记录！', 'error');
		}
	}

	//删除
	function del() {
		top._del(qualificationTreegrid, {
			delUrl : "${dynamicURL}/system/qualification/delete"
		});
	}
</script>

