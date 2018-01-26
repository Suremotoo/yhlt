<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="easyui-layout layout-custom-resize" data-options="fit:true">
	<div data-options="region:'north',split:false,collapsible:false" style="width: 100%;overflow: scroll;height: 250px">
		<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
        		<div data-options="region:'north'">
				<div class="BtnLine btnBox tl" style="border-top: solid 1px #ddd; width: 100%;">
					<button class="easyui-linkbutton l-btn l-btn-small" id="refreshQualification" onclick="refreshQualification()" type="button" iconcls="icon-reload">刷新</button>
					<button class="easyui-linkbutton l-btn l-btn-small" id="add"
						onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
					<button class="easyui-linkbutton l-btn l-btn-small" id="edit"
						onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
					<button class="easyui-linkbutton l-btn l-btn-small" id="edit"
						onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
				</div>
			</div>
        </div>
		<table id="qualificationDatagrid"></table>
	</div>
	<div data-options="region:'center',split:false,collapsible:false" style="width: 400px;">
        <div class="easyui-layout layout-custom-resize" data-options="fit:true">
			<div data-options="region:'north'">
				<div class="BtnLine btnBox tl" style="border-top: solid 1px #ddd; width: 100%;">
					<button class="easyui-linkbutton l-btn l-btn-small" id="add"
						onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
					<button class="easyui-linkbutton l-btn l-btn-small" id="edit"
						onclick="editChild()" type="button" iconcls="icon-edit" group="">修改</button>
					<button class="easyui-linkbutton l-btn l-btn-small" id="edit"
						onclick="delChild()" type="button" iconcls="icon-delete" group="">删除</button>
				</div>
			</div>
			<div data-options="region:'center'">
				<table id="qualificationChildrenDatagrid"></table>
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
	var qualificationDatagrid; // 上级证书数据
	var qualificationChildrenDatagrid; // 子级证书数据
	$(function() {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		// 上级证书
		qualificationDatagrid = $('#qualificationDatagrid').datagrid({
			url : '${dynamicURL}/system/qualification/treegrid?search_EQ_parentId=0',
			pagination: true,
			rownumbers : true,
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			fitColumns:true,
			singleSelect : true,
			treeField: 'name',
			idField: 'id',
			columns: [
						[
						{field: 'id', formatter: function Ra(val, row, index) {
							return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';
						}},
						{field: 'name', title: '证书名',width:130, sortable: true,align:'left'},
						{field: 'checkPeriod', title: '检查日期',width:100, sortable: true},
						{field: 'validDate', title: '有效期',width:40, sortable: true},
						{field: 'uuid', title: '证书编号',width:100, sortable: true },
						{field: 'remark', title: '备注',width:100, sortable: true }
						]
					],
			onBeforeLoad:function(){
						return isLoad;
					},
			onDblClickRow : function(index) {
				edit();
				},
			onClickRow:function(rowIndex, rowData){
				//加载完毕后获取所有的checkbox遍历
				var radio1 = $("input[type='radio']")[rowIndex].disabled;
				//如果当前的单选框不可选，则不让其选中
				if (radio1 != true) {
					//让点击的行单选按钮选中
					$("input[type='radio']")[rowIndex].checked = true;
					return false;
				} else {
					$("#qualificationDatagrid").datagrid("clearSelections");
					$("input[type='radio']")[rowIndex].checked = false;
					return false;
				}
	           },
	        onSelect:function(rowIndex,rowData){
	        	   childUrl = "${dynamicURL}/system/qualification/treegrid?search_EQ_parentId="+rowData.id;
				   qualificationChildrenDatagrid.datagrid("load", childUrl);
	           }
			
			});
		
		var childUrl; // 子级菜单地址
		//子级证书
		qualificationChildrenDatagrid = $('#qualificationChildrenDatagrid').datagrid({
			url : childUrl,
			//url : '${dynamicURL}/admin/system/qualification/list',
			pagination: true,
			rownumbers : true,
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			fitColumns:true,
			treeField: 'name',
			idField: 'id',
			columns: [
						[
						{field: 'id',formatter: function Ra(val, row, index) {
							return '<input type="radio" name="selectRadio" id="selectChildRadio"' + index + '/>';
						}},
						{field: 'name', title: '证书名',width:150, sortable: true,align:'left'},
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
				editChild();
				},
			onClickRow:function(rowIndex, rowData){
				//加载完毕后获取所有的checkbox遍历
				var radio1 = $('#selectChildRadio'+rowIndex).disabled;
				//如果当前的单选框不可选，则不让其选中
				if (radio1 != true) {
					//让点击的行单选按钮选中
					$('#selectChildRadio'+rowIndex).checked = true;
					return false;
				} else {
					$("#qualificationChildrenDatagrid").datagrid("clearSelections");
					$('#selectChildRadio'+rowIndex).checked = false;
					return false;
				}
		       }
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
				qualificationDatagrid.datagrid('reload');
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
	function edit(){
		var row = qualificationDatagrid.datagrid("getSelected");
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
					loadQualicationCombotree(response.obj.parentId);
					$("#addWindow").dialog("open");
				}
			});
		} else {
			$.messager.alert('提示', '请选择要修改的记录！', 'error');
		}
	}
	
	//修改子级证书
	function editChild(){
		var row = qualificationChildrenDatagrid.datagrid("getSelected");
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
		top._del(qualificationDatagrid, {
			delUrl : "${dynamicURL}/system/qualification/delete"
		});
	}
	
	//删除子级证书
	function delChild() {
		top._del(qualificationChildrenDatagrid, {
			delUrl : "${dynamicURL}/system/qualification/delete"
		});
	}
	
	// 上级资质证书选择框
  	$('#qualificationFormId').combotree({
        panelWidth: 250,
        lines : true,
        panelHeight : 400,
        //下面这两个字段需要视情况修改
        idField: 'id',
        nameField: 'name'
 	});
	
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
	
	//刷新qualifiction
    function refreshQualification(){
    	qualificationDatagrid.datagrid("reload");
    }

	
</script>

