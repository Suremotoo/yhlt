<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <div class="easyui-layout layout-custom-resize" data-options="fit:true">
        <!-- 左侧 -->
        <div data-options="region:'west',split:false,collapsible:false" style="width: 330px;overflow: scroll;">
            <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
                类型：
                <select id="securityAssuranceComboTree" style="width: 260px; height: 26px"></select>
            </div>
            <table id="securityAssuranceCheckDatagrid"></table>
        </div>
        <!-- 中间 -->
        <div data-options="region:'center',split:false,collapsible:false" style="width: 400px;">
            <div class="easyui-layout layout" fit="true">
                <div class="easyui-layout layout-custom-resize" data-options="fit:true">
                    <div data-options="region:'north',collapsible:false" style="width: 400px; height:55%;">
                        <div class="easyui-layout layout-custom-resize" data-options="fit:true">
                            <div data-options="region:'north'">
                                <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
                                    <button class="easyui-linkbutton l-btn l-btn-small" id="addBasis" onclick="addBasis()" type="button" iconcls="icon-add">新增</button>
                                    <button class="easyui-linkbutton l-btn l-btn-small" id="editBasis" onclick="editBasis()" type="button" iconcls="icon-edit">修改</button>
                                    <button class="easyui-linkbutton l-btn l-btn-small" id="removeBasis" onclick="delBasis()" type="button" iconcls="icon-delete">删除</button>
                                </div>
                            </div>
                            <div data-options="region:'center'">
                                <table id="checkingBasisDatagrid"></table>
                            </div>
                        </div>
                    </div>
                    <div data-options="region:'center',collapsible:false" style="width: 400px;">
                        <div class="easyui-layout layout-custom-resize" data-options="fit:true">
                            <div data-options="region:'north'">
                                <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
                                    <button class="easyui-linkbutton l-btn l-btn-small" id="addStandard" onclick="addStandard()" type="button" iconcls="icon-add">新增</button>
                                    <button class="easyui-linkbutton l-btn l-btn-small" id="editStandard" onclick="editStandard()" type="button" iconcls="icon-edit">修改</button>
                                    <button class="easyui-linkbutton l-btn l-btn-small" id="removeStandard" onclick="delStandard()" type="button" iconcls="icon-delete">删除</button>
                                </div>
                            </div>
                            <div data-options="region:'center'">
                                <table id="checkingStandardDatagrid"></table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- 检查依据 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增"
	style="width: 620px; height: 220px;" modal="true" closed="true">
	<form class="addForm" action="${dynamicURL}/risk/securityAssurance/saveBasis"
		method="post">
		<input type="hidden" name="id" id="securityId" />
		<input type="hidden" name="parentId" id="parentId" />
		<table class="table_edit">
			<tr>
				<td class="text_tr" style="width: 30%;">添加依据：</td>
				<td><input class="easyui-textbox" type="text" name="name"
					id="nameFormId" style="width: 270px; height: 26px"
					data-options="required:true" /></td>
			</tr>
		</table>
		<div class="BtnLine">
			<button type="button" class="easyui-linkbutton submit">保存</button>
			<button type="button" class="easyui-linkbutton"
				onclick="$('#addWindow').dialog('close');return false;">取消</button>
		</div>
	</form>
</div>

<!-- 检查标准 添加修改-->
<div id="addWindowStandard" class="easyui-dialog" title="新增"
	style="width: 720px; height: 520px;" modal="true" closed="true">
	<form class="addForm" action="${dynamicURL}/risk/securityAssurance/saveStandard"
		method="post">
		<input type="hidden" name="id" id="securityId2" />
		<input type="hidden" name="parentId" id="parentId2" />
		<table class="table_edit">
		  <tr>
	        	<td  class="tr">检查标准：</td>
	        	<td>
	        		<textarea id="remarkFormId" name="remark" class="form-control" style="width: 1000px; height: 400px"></textarea>
	        	</td>
			</tr>
		</table>
		<div class="BtnLine">
			<button type="button" class="easyui-linkbutton submit">保存</button>
			<button type="button" class="easyui-linkbutton"
				onclick="$('#addWindowStandard').dialog('close');return false;">取消</button>
		</div>
	</form>
</div>
<script type="text/javascript">
//添加标准文本输入框
	CKEDITOR.replace('remarkFormId', {
		height : 200,
		width : '80%',
		toolbar :
			[
		 		{ name: 'document',    items : [ '-','DocProps','-','Templates' ] },
		 		{ name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
				{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
		   		'/',
		    	{ name: 'styles',      items : [ 'Styles','Format','Font','FontSize' ] },
		    	{ name: 'colors',      items : [ 'TextColor','BGColor' ] },
		    	{ name: 'tools',       items : [ 'Maximize', 'ShowBlocks','-','About' ] }
			]
	});

var securityAssuranceComboTree; //类型选择下拉框
var securityAssuranceCheckDatagrid; // 检查项目数据
var checkingBasisDatagrid; // 检查依据数据
var checkingStandardDatagrid; // 检查标准数据
var isLoad = false;
$(function(){
	// 安保类型
	securityAssuranceComboTree = $('#securityAssuranceComboTree').combotree({
		 panelWidth: 260,
         lines : true,
         panelHeight : 300,
         //下面这两个字段需要视情况修改
         idField: 'id',
         nameField: 'name',
        url: '${dynamicURL}/risk/securityAssurance/combotree?search_EQ_parentId=0',
        onChange:function(newId,oldId) {
        	if(newId!=0){
        		securityAssuranceCheckDatagrid.datagrid("load", {'search_EQ_parentId' : newId});
        	}else{
        		securityAssuranceCheckDatagrid.datagrid("load",{"url":'${dynamicURL}/risk/securityAssurance/list?search_EQ_type=1'});
        	} 
        	securityAssuranceCheckDatagrid.datagrid('clearSelections');
        	checkingBasisDatagrid.datagrid('clearSelections');
        	checkingStandardDatagrid.datagrid('clearSelections');
        },
        onLoadSuccess: function (node, data) {
        	var data=$("#securityAssuranceComboTree").combotree('tree').tree("getRoot");
        	$("#securityAssuranceComboTree").combotree('setValue',data.id);
        }
    });
	
	/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
	
	// 检查项目
	securityAssuranceCheckDatagrid = $('#securityAssuranceCheckDatagrid').datagrid({
   		url: '${dynamicURL}/risk/securityAssurance/list?search_EQ_type=1',
   		queryForm : "#queryHeader form",//列筛选时附带加上搜索表单的条件
		fit : true,
		//fitcolumns: true,
		//pagination : true,
		rownumbers : true,
		singleSelect : true,
		lines : true,
		idField : 'id',
		columns : [ [
			{field: 'id',formatter: function Ra(val, row, index) {
				return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';
			}},
			{field: 'name',title: '检查项目',width: 200,sortable: true}
		] ],
		onSelect:function(rowIndex, rowData){
			isLoad = true;
			checkingBasisDatagrid.datagrid("load", {'search_EQ_parentId' : rowData.id});
	        }, 
		onClickRow : function(rowIndex, rowData) {
			//加载完毕后获取所有的checkbox遍历
			var radio1 = $("input[type='radio']")[rowIndex].disabled;
			//如果当前的单选框不可选，则不让其选中
			if (radio1 != true) {
				//让点击的行单选按钮选中
				$("input[type='radio']")[rowIndex].checked = true;
				return false;
			} else {
				$("#securityAssuranceCheckDatagrid").datagrid("clearSelections");
				$("input[type='radio']")[rowIndex].checked = false;
				return false;
			}
		 }
		});
	
	// 检查依据
	checkingBasisDatagrid = $('#checkingBasisDatagrid').datagrid({
   		url: '${dynamicURL}/risk/securityAssurance/list?search_EQ_type=2',
   		queryForm : "#queryHeader form",//列筛选时附带加上搜索表单的条件
		fit : true,
		fitcolumns: true,
		pagination : true,
		rownumbers : true,
		singleSelect : true,
		lines : true,
		idField : 'id',
		columns : [ [
			{field: 'id',formatter: function Ra(val, row, index) {
				return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';
			}},
			{field: 'name',title: '检查依据',sortable: true}
		] ],
		onBeforeLoad:function(){
	        	return isLoad;//isLoad;
	      },
		onSelect : function(rowIndex, rowData) {
			checkingStandardDatagrid.datagrid("load", {'search_EQ_parentId' : rowData.id});
		 },
		onDblClickRow : function(index) {
			editBasis();
		 }
	});
	
	// 检查标准
	checkingStandardDatagrid = $('#checkingStandardDatagrid').datagrid({
   		url: '${dynamicURL}/risk/securityAssurance/list?search_EQ_type=3',
   		queryForm : "#queryHeader form",//列筛选时附带加上搜索表单的条件
		fit : true,
		//fitcolumns: true,
		pagination : true,
		rownumbers : true,
		singleSelect : true,
		custom_fit : true,//额外处理自适应性
		custom_heighter : "#queryHeader",//额外处理自适应性（计算时留出元素#queryHeader高度）
		custom_height : 5,//额外处理自适应性（计算时留5px高度）
		lines : true,
		idField : 'id',
		columns : [ [
			{field: 'id',formatter: function Ra(val, row, index) {
				return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';
			}},
			{field: 'remark',title: '检查标准',sortable: true}
		] ],
		onBeforeLoad:function(){
	        	return isLoad;//isLoad;
	        },
		onDblClickRow : function(index) {
			editStandard();
		}
	});
	
	$("form[for] button.queryBtn").on("click.datagrid-query", function() {
		top._search($(this).parents("form[for]"));
	});
	$("form[for] button.clearBtn").on("click.datagrid-query", function() {
		top._clearSearch($(this).parents("form"));
	});
});

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
			checkingBasisDatagrid.datagrid('reload');
		} else {
			$.messager.alert('提示', data.msg, 'error');
		}
	}
});

//初始化form表单
$("#addWindowStandard form.addForm").form({
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
			$('#addWindowStandard').dialog('close');
			checkingStandardDatagrid.datagrid('reload');
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

$("#addWindowStandard .BtnLine .submit").on("click", _.debounce(function() {
	var maxlength = CKEDITOR.instances.remarkFormId.getData().length; //取得纯文本
		if(maxlength > 20000){
	  		$.messager.alert('提示', '内容超出最大长度！', 'error');
	  		return false;
	 	 }
	$("#addWindowStandard form.addForm").submit();
}, waitTime, true));

//添加依据
function addBasis() {
	var row = securityAssuranceCheckDatagrid.datagrid("getSelected");
	if(row){
			$("#addWindow form.addForm").form("clear");
			$("#parentId").val(row.id);
			$("#addWindow").dialog("open");
		}
	else{
		$.messager.alert('提示', '请选择要添加的检查项目', 'error');
	}
}

//修改依据
function editBasis() {
	var row = checkingBasisDatagrid.datagrid("getSelected");
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
				$("#addWindow").dialog("open");
			}
		});
	} else {
		$.messager.alert('提示', '请选择要修改的记录！', 'error');
	}
}

//删除依据
function delBasis() {
	var row = checkingBasisDatagrid.datagrid("getSelected");
	$.ajax({
		url : "${dynamicURL}/risk/securityAssurance/checkNext",
		data : {
			id : row.id
		},
		dataType : "json",
		success : function(response) {
			if(response.success){
				top._del(checkingBasisDatagrid, {
					delUrl : "${dynamicURL}/risk/securityAssurance/delete"
				});
			}
			else{
				$.messager.alert('提示', '有下级数据，无法删除', 'error');
			}
		}
	});
}


//添加标准
function addStandard() {
	var row = checkingBasisDatagrid.datagrid("getSelected");
	if(row){
			$("#addWindowStandard form.addForm").form("clear");
			$("#parentId2").val(row.id);
			$("#addWindowStandard").dialog("open");
		}
	else{
		$.messager.alert('提示', '请选择要添加的检查依据', 'error');
	}
}

//修改标准
function editStandard() {
	var row = checkingStandardDatagrid.datagrid("getSelected");
	if (row) {
		var form = $("#addWindowStandard form.addForm");
		form.form("clear");
		$.ajax({
			url : "${dynamicURL}/risk/securityAssurance/detail",
			data : {
				id : row.id
			},
			dataType : "json",
			success : function(response) {
				form.form("load", response.obj);
				CKEDITOR.instances.remarkFormId.setData(response.obj.remark);
				$("#addWindowStandard").dialog("open");
			}
		});
	} else {
		$.messager.alert('提示', '请选择要修改的记录！', 'error');
	}
}

//删除标准
function delStandard() {
	top._del(checkingStandardDatagrid, {
		delUrl : "${dynamicURL}/risk/securityAssurance/delete"
	});

}
</script>

