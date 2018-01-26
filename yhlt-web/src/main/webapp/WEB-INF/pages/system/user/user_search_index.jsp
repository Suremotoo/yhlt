<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="easyui-layout layout-custom-resize" data-options="fit:true">
	<div data-options="region:'west',split:false,collapsible:false" style="width: 250px;overflow: scroll;">
		<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;line-height: 40px;">
			区域：<select id="companyComboTree" style="width: 180px; height: 26px;padding: 10px;" data-options="required:true" ></select>
        </div>
		<table id="departmentTreegrid"></table>
	</div>
	<div data-options="region:'center',split:false,collapsible:false" style="width: 400px;">
		<div class="easyui-layout layout" fit="true">
		    <div id="container" class="easyui-layout layout" fit="true">
		        <div region="north" border="false">
	            	<div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
			        	<form class="form-horizontal" for="userDatagrid">
			        		<table style="width: 800px; line-height: 40px;">
			                 <tr>
			                     <td>用户名:</td>
			                     <td>
			                         <input class="easyui-textbox" type="text" name="search_LIKE_name" style="width: 150px; height: 26px">
			                     </td>
			                     <td>联系电话:</td>
			                     <td>
			                         <input class="easyui-textbox" type="text" name="search_LIKE_mobile" style="width: 150px; height: 26px">
			                     </td>
			                     <td>
			                         <div class="BtnLine" style="border: 0px; margin: 0px; padding: 0px;text-align:left">
			                             <button type="button" class="easyui-linkbutton queryBtn" iconcls="icon-search" >搜索</button>
			                             <button type="button" class="easyui-linkbutton clearBtn" iconcls="icon-reload" >重置</button>
			                         </div>
			                     </td>
			                 </tr>
			             </table>
			        	</form>
			        </div>
		        </div>
		        <div region="center" border="false">
		            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
		               <table id="userDatagrid"></table>
		            </div>
		        </div>
		    </div>
		</div>	
	</div>
</div>

<script>
	var cardview = $.extend({}, $.fn.datagrid.defaults.view, {
        renderRow: function(target, fields, frozen, rowIndex, rowData){
            var cc = [];
            cc.push('<td colspan=' + fields.length + ' style="padding:10px 5px;border:1;">');
            if (!frozen && rowData.id){
				var img = rowData.headImgUrl;
				if(img != null && img != ""){
					img = "${dynamicURL}" + img.replaceAll(/\\/g,"/");
				}else{
					img = "${staticURL}/style/images/indPic03.png";
				}
                cc.push('<img src="'+img+'" style="width:120px;float:left">');
                cc.push('<div style="float:left;margin-left:20px;"><em class=\"elusive-user\" >');
                for(var i=0; i<fields.length; i++){
                    var copts = $(target).datagrid('getColumnOption', fields[i]);
                    var value = rowData[fields[i]];
                    if(fields[i]=="companyEntity.name"){
                    	value = rowData["companyEntity"]["name"];
                    }else if (fields[i]=="departmentEntity.name"){
                    	value = rowData["departmentEntity"]["name"];
                    }else if(fields[i]=="positionEntity.name"){
                    	value = rowData["positionEntity"]["name"];
                    }
                    value = (value==null?"未录入":value);
                    cc.push('<p><span class="c-label">' + copts.title + ':</span> ' + value + '</p>');
                }
                cc.push('</div>');
            }
            cc.push('</td>');
            return cc.join('');
        }
    });
</script>
<script type="text/javascript">
	var companyComboTree;
	var departmentTreegrid;
	var userDataGrid;
	var isLoad=false;//是否延迟加载
	$(function () {
		companyComboTree = $('#companyComboTree').combotree({
		 	valueField:'id',
		    nameField:'name',
            url: '${dynamicURL}/system/company/combotree?search_EQ_parentId=0',
            onChange:function(newId,oldId) {
            	isLoad = true;
            	departmentTreegrid.treegrid("load", {'companyId' : newId});
            },
            onLoadSuccess: function (node, data) {
            	var data=$("#companyComboTree").combotree('tree').tree("getRoot");
            	$("#companyComboTree").combotree('setValue',data.id);
            }
        });
 		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		departmentTreegrid = $('#departmentTreegrid').treegrid({
	   		url: '${dynamicURL}/system/department/treegrid?search_EQ_parentId=0',
			pagination: false,
// 			rownumbers : true,
			fit:false,
			fitColumns:true,
			treeField: 'name',
			idField: 'id',
			columns: [
			    [
// 			        {field: 'id', checkbox: true},
			        {field: 'name', title: '科室名称',width:200, sortable: true,align:'left'},
			    ]
			],
			onBeforeLoad:function(){
				return isLoad;
			},
            onSelect:function(rowIndex, rowData){
				userDataGrid.datagrid("load", {'search_EQ_departmentEntity.id' : rowIndex.id});
            }
		});
		userDataGrid = $('#userDatagrid').datagrid({
            url: '${dynamicURL}/system/user/list',
            queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
            pagination: true,
            rownumbers : true,//行数  
            singleSelect:true, 
            fit:true,
            custom_heighter: "#queryHeader",//额外处理自适应性（计算时留出元素#queryHeader高度）
            custom_height: 5,//额外处理自适应性（计算时留5px高度）
            idField: 'id',
            columns: [[
//                  {field: 'id', checkbox: true},
//                  {field: 'loginName', title: '登录名', width: 200, align: 'center', sortable: true},
                 {field: 'name', title: '用户名', width: 200, align: 'center', sortable: true},
//                  {field: 'companyEntity.name', title: '区域', width: 200, align: 'center', sortable: true, formatter: function (value, rec) { return rec.companyEntity['name'];}},
                 {field: 'departmentEntity.name', title: '科室', width: 200, align: 'center', sortable: true, formatter: function (value, rec) { return rec.departmentEntity['name'];}},
                 {field: 'positionEntity.name', title: '职务', width: 200, align: 'center', sortable: true, formatter: function (value, rec) { return rec.positionEntity['name'];}},
                 {field: 'telephone', title: '办公电话', width: 200, align: 'center', sortable: true},
                 {field: 'mobile', title: '手机', width: 200, align: 'center', sortable: true}
            ]],
            view: cardview
        });
		$("form[for] button.queryBtn").on("click.datagrid-query", function () {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function () {
			top._clearSearch($(this).parents("form"));
        });
	})
	 function add() {
		var companyId = companyComboTree.combotree("getValue");
		var companyName = companyComboTree.combotree("getText");
		var department = departmentTreegrid.treegrid("getSelected");
		if(companyId && companyName && department){
			$("#addWindow form.addForm").form("clear");
			//公司
			$("#companyEntityId").val(companyId);
			$("#companyEntityName").textbox('setValue',companyName);
			//部门
			$("#departmentEntityId").val(department.id);
			$("#departmentEntityName").textbox('setValue',department.name);
			
			$("#addWindow").dialog("open");
		}else{
			$.messager.alert('提示', '请选择公司及部门信息！', 'error');
		}
    }
	 //初始化form表单
    $("#addWindow form.addForm").form({
        onSubmit: function () {
            var isValid = $(this).form('validate');
            if (!isValid) {
                $.messager.progress('close');
            }
            return isValid;
        },
        success: function (data) {
            if (typeof data == "string") {
                data = JSON.parse(data);
            }
            if (data.success) {
                $.messager.alert('提示', '保存成功！', "info");
                $('#addWindow').dialog('close');
                userDataGrid.datagrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
    $("#addWindow .BtnLine .submit").on("click", function () {
		$("#addWindow form.addForm").submit();
    });
    
    //修改
    function edit() {
        var row = userDataGrid.treegrid("getSelected");
        if (row) {
            var form = $("#addWindow form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/system/user/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
                    form.form("load", response.obj);
                  	//加载公司信息
        			$("#companyEntityId").val(response.obj.companyEntity['id']);
        			$("#companyEntityName").textbox('setValue',response.obj.companyEntity['name']);
        			//加载部门信息
        			$("#departmentEntityId").val(response.obj.departmentEntity['id']);
        			$("#departmentEntityName").textbox('setValue',response.obj.departmentEntity['name']);
        			
                    $("#addWindow").dialog("open");
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function del(){
    	 top._del(userDataGrid, {delUrl: "${dynamicURL}/system/user/delete"});
    }
    
    
    
    
</script>
<style type="text/css">
    .c-label{
        display:inline-block;
        width:100px;
        font-weight:bold;
    }
</style>
