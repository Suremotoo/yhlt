<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>

<div class="easyui-layout layout-custom-resize" data-options="fit:true">
	<div data-options="region:'north',split:true,collapsible:false" style="width: 400px; height:60%;">
        <div class="easyui-layout layout-custom-resize" data-options="fit:true">
			<div data-options="region:'north'">
				<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
		         	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" >新增</button>
		         	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" >修改</button>
		         	<button class="easyui-linkbutton l-btn l-btn-small" id="remove" onclick="del()" type="button" iconcls="icon-delete" >删除</button>
		        </div>
			</div>
			<div data-options="region:'center'">
				<table id="qualificationDatagrid"></table>
			</div>
		</div>
	</div>
	
	<div data-options="region:'center',split:true,collapsible:false" style="width: 400px;">
		<div class="easyui-layout layout-custom-resize" data-options="fit:true">
		<div data-options="region:'north'">
					<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
			      		<button class="easyui-linkbutton l-btn l-btn-small" id="addDetail" onclick="addchild()" type="button" iconcls="icon-add" >新增</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="editDetail" onclick="editchild()" type="button" iconcls="icon-edit" >修改</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="removeDetail" onclick="delchild()" type="button" iconcls="icon-delete" >删除</button> 
			        </div>
		        </div>
			<div data-options="region:'center'">
				<table id="qualificationChildrenDatagrid"></table>
			</div>
		</div>
	</div>
</div>
<!-- 添加 -->
<div id="addWindow" class="easyui-dialog" title="新增" style="width: 620px; height: 350px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/system/qualification/save" method="post" >
    	<input type="hidden" name="id" id="idFormId"/>
    	<table class="table_edit">
	       <tr>
	            <td class="text_tr" style="width: 30%;">名称：</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="name" id="nameFormId"  style="width: 350px; height: 26px" data-options="required:true" >
	            </td>
	         </tr>
	         <tr>
	            <td class="text_tr">审查日期：</td>
	            <td>
	            	<input name="checkPeriod" type="text" class="form-control easyui-datebox" style="width: 270px; height: 26px" />
	            </td>
	        </tr>
	     <!--     <tr>
	            <td class="text_tr"></td>
	            <td>
	            	<span style="color: red;">审查日期说明，填写0则此资质属于不需定期审查</span>
	            </td>
	        </tr> -->
	         <tr>
	            <td class="text_tr">有效期(月份)：</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="validDate" id="validDateFormId"  style="width: 350px; height: 26px" data-options="required:true" >
	            </td>
	        </tr>
	        <!-- <tr>
	            <td class="text_tr"></td>
	            <td>
	            	<span style="color: red;">有效期说明，填写0则此资质有效期为无限</span>
	            </td>
	        </tr> -->
	        <tr>
	            <td class="text_tr">备注：</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="remark" id="remarkFormId"  style="width: 350px; height: 26px" >
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
<!-- 添加 -->
<div id="addWindowChild" class="easyui-dialog" title="新增" style="width: 620px; height: 220px;" modal="true" closed="true">
    <form class="addFormChild" action="${dynamicURL}/system/qualification/save" method="post" >
    	<input type="hidden" name="id" id="idChildFormId"/>
    	<input type="hidden" name="parentId" id="parentId"/>
    	<table class="table_edit">
	       <tr>
	            <td class="text_tr" style="width: 30%;">名称：</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="name" id="namechildFormId"  style="width: 350px; height: 26px" data-options="required:true" >
	            </td>
	         </tr>
	            <tr>
	            <td class="text_tr">有效期(月份)：</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="validDate" id="validDateFormId"  style="width: 350px; height: 26px" data-options="required:true" >
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">备注：</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="remark" id="remarkchildFormId"  style="width: 350px; height: 26px"  >
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindowChild').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
<script type="text/javascript">
var qualificationDatagrid;
var qualificationChildrenDatagrid;
var isLoad=false;//是否延迟加载
$(function () {

	qualificationDatagrid = $('#qualificationDatagrid').datagrid({
        url: '${dynamicURL}/system/qualification/list?search_EQ_parentId=0',
        queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
        fit:true,
        pagination : true,
		rownumbers : true,
		singleSelect : true,
		lines:true,
		idField : 'id',
		treeField: 'name',
        columns: [ [
                {field: 'id',formatter: function Ra(val, row, index) {
					return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';
				}},
                {field: 'name', title: '名称',width:300, sortable: true},
                {field: 'checkPeriod', title: '审查日期', width: 200, sortable: true},
                {field: 'validDate', title: '有效期(月份)', width: 200, sortable: true},
                {field: 'remark', title: '备注', width: 200, sortable: true},
            	{field: 'gmtCreate', title: '创建时间', width: 200, sortable: true}
            ]
        ],
        onSelect:function(rowIndex, rowData){
			isLoad=true;
			qualificationChildrenDatagrid.datagrid("load", {'search_EQ_parentId' : rowData.id});
        }, 
        onClickRow : function(rowIndex, rowData) {
        	//加载完毕后获取所有的checkbox遍历
			var radio1 = $("input[name='selectRadio']")[rowIndex].disabled;
			//如果当前的单选框不可选，则不让其选中
			if (radio1 != true) {
				//让点击的行单选按钮选中
				$("input[name='selectRadio']")[rowIndex].checked = true;
				return false;
			} else {
				$("#qualificationDatagrid").datagrid("clearSelections");
				$("input[name='selectRadio']")[rowIndex].checked = false;
				return false;
			}
		},
		onDblClickRow: function(index){
        	edit();
        }});
		
		qualificationChildrenDatagrid = $('#qualificationChildrenDatagrid').datagrid({
			url : '${dynamicURL}/system/qualification/list',
			pagination : true,
			rownumbers : true,//行数  
//			queryForm : "#queryHeader form",//列筛选时附带加上搜索表单的条件
			custom_fit : true,//额外处理自适应性
			custom_heighter : "#queryHeader",//额外处理自适应性（计算时留出元素#queryHeader高度）
			custom_height : 5,//额外处理自适应性（计算时留5px高度）
			singleSelect : true,
			idField : 'id',
			fit:true,
			columns : [ [ 
			    {field: 'id',formatter: function Ra(val, row, index) {
					return '<input type="radio" name="selectRadioDetail" id="selectRadioDetail"' + index + '/>';
				}},
				{field: 'name', title: '名称',width:300, sortable: true},
                {field: 'remark', title: '备注', width: 200, sortable: true},
            	{field: 'gmtCreate', title: '创建时间', width: 200, sortable: true}
			] ],
            onBeforeLoad:function(){
            	return isLoad;//isLoad;
            },
            onClickRow : function(rowIndex, rowData) {
				//加载完毕后获取所有的checkbox遍历
				var radio1 = $("input[name='selectRadioDetail']")[rowIndex].disabled;
				//如果当前的单选框不可选，则不让其选中
				if (radio1 != true) {
					//让点击的行单选按钮选中
					$("input[name='selectRadioDetail']")[rowIndex].checked = true;
					return false;
				} else {
					$("#qualificationChildrenDatagrid").datagrid("clearSelections");
					$("input[name='selectRadioDetail']")[rowIndex].checked = false;
					return false;
				}
			}, onDblClickRow: function(index){
	        	editchild();
	        }});
})

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

$("#addWindow .BtnLine .submit").on("click", _.debounce(function() {
	if ($("#idFormId").val() == null || $("#idFormId").val() == "") {
		$.post('${dynamicURL}/system/qualification/check', {
			'qualificationName' : $('#nameFormId').val()
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

function add() {
	$("#addWindow form.addForm").form("clear");
	$("#addWindow").dialog("open");
}
function edit() {
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
				$("#addWindow").dialog("open");
			}
		});
	} else {
		$.messager.alert('提示', '请选择要修改的记录！', 'error');
	}
}
//删除
function del() {
	var row = qualificationDatagrid.datagrid("getSelected");
	$.ajax({
		url : "${dynamicURL}/system/qualification/checkNext",
		data : {
			id : row.id
		},
		dataType : "json",
		success : function(response) {
			if(response.success){
				top._del(qualificationDatagrid, {
					delUrl : "${dynamicURL}/system/qualification/delete"
				});
				}
			else{
				$.messager.alert('提示', '有下级数据，无法删除', 'error');
			}
		}
	});
}
//初始化form表单
$("#addWindowChild form.addFormChild").form({
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
			$('#addWindowChild').dialog('close');
			qualificationChildrenDatagrid.datagrid('reload');
		} else {
			$.messager.alert('提示', data.msg, 'error');
		}
	}
});
//提交前验证证书是否重复
$("#addWindowChild .BtnLine .submit").on("click", _.debounce(function() {
	if ($("#idChildFormId").val() == null || $("#idChildFormId").val() == "") {
		$.post('${dynamicURL}/system/qualification/check', {
			'qualificationName' : $('#namechildFormId').val()
		}, function(data) {
			if (data.success) {
				$("#addWindowChild form.addFormChild").submit();
			} else {
				$.messager.alert('提示', data.msg, 'error');
			}
		}, 'json');
	} else {
		$("#addWindowChild form.addFormChild").submit();
	}
}, waitTime, true));

function addchild() {
	
		var row = qualificationDatagrid.datagrid("getSelected");
		if(row){
			$("#addWindowChild form.addFormChild").form("clear");
			$("#parentId").val(row.id)
			$("#addWindowChild").dialog("open");}
		else{
			$.messager.alert('提示', '请选择要添加的上级资质', 'error');
		}
}
function editchild() {
    var row = qualificationChildrenDatagrid.datagrid("getSelected");
    if (row) {
        var form = $("#addWindowChild form.addFormChild");
        form.form("clear");
        $.ajax({
            url: "${dynamicURL}/system/qualification/detail",
            data: {id: row.id},
            dataType: "json",
            success: function (response) {
                form.form("load", response.obj);
                $("#addWindowChild").dialog("open");
            }
        });
    } else {
        $.messager.alert('提示', '请选择要修改的记录！', 'error');
    }
}
function delchild() {
	top._del(qualificationChildrenDatagrid, {
		delUrl : "${dynamicURL}/system/qualification/delete"
	});
}
</script>