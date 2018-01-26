<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="easyui-layout layout" fit="true">
	<div id="container" class="easyui-layout layout" fit="true">
		<div region="north" border="false">
			<div id="queryHeader"
				style="padding: 10px; width: 100%; line-height: 40px;"
				class="easyui-panel">
				<form class="form-horizontal" for="fileTypeTreegrid">
					<table style="width: 800px; line-height: 40px;">
						<tr>
							<td>名称:</td>
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
				<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="redo()" type="button" iconcls="icon-add" group="">展开</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="undo()" type="button" iconcls="icon-remove" group="">折叠</button>
			</div>
		</div>
		<div region="center" border="false">
			<div style="padding: 5px; width: 100%;" class="easyui-layout layout"
				fit="true">
				<table id="fileTypeTreegrid"></table>
			</div>
		</div>
	</div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增"
	style="width: 620px; height: 290px;" modal="true" closed="true">
	<form class="addForm" action="${dynamicURL}/file/fileType/save"
		method="post">
		<input type="hidden" name="id" id="fileTypeId" />
		<table class="table_edit">
		<tr>
				<td class="text_tr">上级节点：</td>
				<td><select class="easyui-textbox" name="parentId"
					id="typeFormId" style="width: 270px; height: 26px"
					data-options="required:true" >
					</select>
					</td>
			</tr>
			<tr>
				<td class="text_tr" style="width: 30%;">名称：</td>
				<td><input class="easyui-textbox" type="text" name="name"
					id="nameFormId" style="width: 270px; height: 26px"
					data-options="required:true" /></td>
			</tr>
			<tr>
				<td class="text_tr">类型：</td>
				<td><input class="easyui-textbox" type="text" name="type"
					style="width: 270px; height: 26px" data-options="required:true" />
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
	//分页
	var fileTypeTreegrid;
	$(function() {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		fileTypeTreegrid = $('#fileTypeTreegrid').treegrid({
			url : '${dynamicURL}/file/fileType/treegrid?search_EQ_parentId=0',
			pagination: false,
			rownumbers : true,
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			fitColumns:true,
			treeField: 'name',
			idField: 'id',
			columns : [ [
				{field: 'id', checkbox: true},
				{field: 'name',title: '名称',width: 200,sortable: true,align:'left'},
				{field: 'parentId',title: '父节点',width: 200,sortable: true},
				{field: 'type',title: '类型',width: 200,sortable: true},
				{field: 'gmtCreateUserName',title: '创建人',width: 200,sortable: true},
				{field: 'gmtCreate',title: '创建时间',width: 200,sortable: true},
				{field: 'opt', title: '操作', width: 100, align: 'center', sortable: true, 
				       formatter: function (value, rec) {
				              return '<button class="easyui-linkbutton l-btn l-btn-small" type="button" onclick="fileTypeSort(0,'+rec.id+')" >↑</button>&nbsp;&nbsp;'+
				              	 '<button class="easyui-linkbutton l-btn l-btn-small" type="button" onclick="fileTypeSort(1,'+rec.id+')">↓</button>';
				      }}
				] ],
			onDblClickRow : function(index) {
				edit();
			},
			onLoadSuccess: function () {
				fileTypeTreegrid.treegrid('collapseAll')
				}
		});

		$("form[for] button.queryBtn").on("click.datagrid-query", function() {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function() {
			top._clearSearch($(this).parents("form"));
		});
	})
	function add() {
		$("#addWindow form.addForm").form("clear");
		loadTypeCombotree(0);
		$("#addWindow").dialog("open");
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
				fileTypeTreegrid.treegrid('reload');
			} else {
				$.messager.alert('提示', data.msg, 'error');
			}
		}
	});
	$("#addWindow .BtnLine .submit").on("click", _.debounce(function() {
			$("#addWindow form.addForm").submit();
	}, waitTime, true));

	//修改
	function edit() {
		var row = fileTypeTreegrid.treegrid("getSelected");
		if (row) {
			var form = $("#addWindow form.addForm");
			form.form("clear");
			$.ajax({
				url : "${dynamicURL}/file/fileType/detail",
				data : {
					id : row.id
				},
				dataType : "json",
				success : function(response) {
					form.form("load", response.obj);
					loadTypeCombotree(response.obj.parentId);
					$("#addWindow").dialog("open");
				}
			});
		} else {
			$.messager.alert('提示', '请选择要修改的记录！', 'error');
		}
	}

	//删除
	function del() {
		top._del(fileTypeTreegrid, {
			delUrl : "${dynamicURL}/file/fileType/delete"
		});
	}
	
	// 类型选择框
  	$('#typeFormId').combotree({
        panelWidth: 250,
        lines : true,
        panelHeight : 400,
        //下面这两个字段需要视情况修改
        idField: 'id',
        nameField: 'name'
 	});
	
	// 加载类型
	function loadTypeCombotree(fileTypeId){
			$.post('${dynamicURL}/file/fileType/combotree?search_EQ_parentId=0',function(data){
				$('#typeFormId').combotree("clear");
				$('#typeFormId').combotree('loadData',data);
				if(fileTypeId){
					$("#typeFormId").combotree("setValue",fileTypeId);
				}else{
					$("#typeFormId").combotree("setValue",0);
				}
			},'json');
	}
	
	// 上下排序移动
	function fileTypeSort(sortType,fileTypeId){
        if (fileTypeId) {
       	 	$.ajax({
                url: "${dynamicURL}/file/fileType/fileTypeSort",
                data: {sortType:sortType,fileTypeId: fileTypeId},
                dataType: "json",
                success: function (data) {
                	if(data.success){
                		fileTypeTreegrid.treegrid("reload");
                	}
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
	}

	// 展开
	 function redo() {
			var node = fileTypeTreegrid.treegrid('getSelected');
			if (node) {
				fileTypeTreegrid.treegrid('expandAll', node.id);
			} else {
				fileTypeTreegrid.treegrid('expandAll');
			}
		}
 // 收缩
	function undo() {
			var node = fileTypeTreegrid.treegrid('getSelected');
			if (node) {
				fileTypeTreegrid.treegrid('collapseAll', node.id);
			} else {
				fileTypeTreegrid.treegrid('collapseAll');
			}
		}
</script>

