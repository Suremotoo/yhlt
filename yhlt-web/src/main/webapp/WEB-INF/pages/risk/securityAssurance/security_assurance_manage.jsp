<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="easyui-layout layout" fit="true">
	<div id="container" class="easyui-layout layout" fit="true">
		<div region="north" border="false">
			<div id="queryHeader"
				style="padding: 10px; width: 100%; line-height: 40px;"
				class="easyui-panel">
				<form class="form-horizontal" for="securityAssuranceTypeTreegrid">
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
				<table id="securityAssuranceTypeTreegrid"></table>
			</div>
		</div>
	</div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增"
	style="width: 620px; height: 290px;" modal="true" closed="true">
	<form class="addForm" action="${dynamicURL}/risk/securityAssurance/saveType"
		method="post">
		<input type="hidden" name="id" id="securityId" />
		<table class="table_edit">
			<tr>
				<td class="text_tr" style="width: 30%;">名称：</td>
				<td><input class="easyui-textbox" type="text" name="name"
					id="nameFormId" style="width: 270px; height: 26px"
					data-options="required:true" /></td>
			</tr>
			<tr>
				<td class="text_tr">父节点：</td>
				<td><select class="easyui-textbox" name="parentId"
					id="typeFormId" style="width: 270px; height: 26px"
					data-options="required:true" >
					</select>
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
	//分页
	var securityAssuranceTypeTreegrid;
	$(function() {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		securityAssuranceTypeTreegrid = $('#securityAssuranceTypeTreegrid').treegrid({
			url : '${dynamicURL}/risk/securityAssurance/treegrid?search_EQ_parentId=0',
			pagination: false,
			rownumbers : true,
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			fitColumns:true,
			treeField: 'name',
			idField: 'id',
			columns : [ [
				{field: 'name',title: '名称',width: 200,sortable: true,align:'left'},
				{field: 'parentId',title: '父节点',width: 200,sortable: true},
				{field: 'type',title: '类型',width: 200,sortable: true},
				{field: 'opt', title: '操作', width: 100, align: 'center', sortable: true, 
				       formatter: function (value, rec) {
				              return '<button class="easyui-linkbutton l-btn l-btn-small" type="button" onclick="securityAssuranceSort(0,'+rec.id+')" >↑</button>&nbsp;&nbsp;'+
				              	 '<button class="easyui-linkbutton l-btn l-btn-small" type="button" onclick="securityAssuranceSort(1,'+rec.id+')">↓</button>';
				      }}
				] ],
				onDblClickRow : function(index) {
					edit();
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
				securityAssuranceTypeTreegrid.treegrid('reload');
			} else {
				$.messager.alert('提示', data.msg, 'error');
			}
		}
	});
	$("#addWindow .BtnLine .submit").on("click", _.debounce(function() {
		if ($("#securityId").val() == null || $("#securityId").val() == "") {
			$.post('${dynamicURL}/risk/securityAssurance/check', {
				'securityName' : $('#nameFormId').val()
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
		var row = securityAssuranceTypeTreegrid.treegrid("getSelected");
		if (row) {
			var form = $("#addWindow form.addForm");
			form.form("clear");
			$.ajax({
				url : "${dynamicURL}/risk/securityAssurance/detail",
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
		top._del(securityAssuranceTypeTreegrid, {
			delUrl : "${dynamicURL}/risk/securityAssurance/delete"
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
	function loadTypeCombotree(securityId){
			$.post('${dynamicURL}/risk/securityAssurance/combotree?search_EQ_parentId=0',function(data){
				$('#typeFormId').combotree("clear");
				$('#typeFormId').combotree('loadData',data);
				if(securityId){
					$("#typeFormId").combotree("setValue",securityId);
				}else{
					$("#typeFormId").combotree("setValue",0);
				}
			},'json');
	}
	
	// 上下排序移动
	function securityAssuranceSort(sortType,securityId){
        if (securityId) {
       	 	$.ajax({
                url: "${dynamicURL}/risk/securityAssurance/securityAssuranceSort",
                data: {sortType:sortType,securityAssuranceId: securityId},
                dataType: "json",
                success: function (data) {
                	if(data.success){
                		securityAssuranceTypeTreegrid.treegrid("reload");
                	}
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
	}

	// 展开
	 function redo() {
			var node = securityAssuranceTypeTreegrid.treegrid('getSelected');
			if (node) {
				securityAssuranceTypeTreegrid.treegrid('expandAll', node.id);
			} else {
				securityAssuranceTypeTreegrid.treegrid('expandAll');
			}
		}
 // 收缩
	function undo() {
			var node = securityAssuranceTypeTreegrid.treegrid('getSelected');
			if (node) {
				securityAssuranceTypeTreegrid.treegrid('collapseAll', node.id);
			} else {
				securityAssuranceTypeTreegrid.treegrid('collapseAll');
			}
		}
</script>

