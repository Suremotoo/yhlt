<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>

<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
        <div region="north" border="false">
            <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
            	<form class="form-horizontal" for="companyDatagrid">
            		<table style="width: 600px; line-height: 40px;">
	                    <tr>
	                        <td>公司名称:</td>
	                        <td>
	                            <input class="easyui-textbox" type="text" name="search_LIKE_name" style="width: 150px; height: 26px">
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
            <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
             <security:ifAny authorization="公司管理_管理员">
             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
             </security:ifAny>
             <security:ifAny authorization="公司管理_管理员">
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
             </security:ifAny>
            </div>
        </div>
        <div region="center" border="false">
            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
                <table id="companyDatagrid"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增" style="width: 620px; height: 220px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/system/company/save" method="post">
    	<input type="hidden" name="id" />
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">上级公司：</td>
	            <td>
	            	<select name="parentId" id="companyFormId" style="width: 270px; height: 26px;" data-options="required:true"></select>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">公司名称：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="name" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
	         <tr>
	            <td class="text_tr">序号：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="sortNumber" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
<script type="text/javascript">
	//分页
	var companyDatagrid;
	$(function () {
 /*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
        companyDatagrid = $('#companyDatagrid').treegrid({
            url: '${dynamicURL}/system/company/list?search_EQ_parentId=0',
            queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
            fit:true,
            pagination : false,
			rownumbers : true,
			singleSelect : true,
			lines:true,
			idField : 'id',
			treeField: 'name',
            columns: [ [
                    {field: 'id', checkbox: true},
                    {field: 'name', title: '名称',width:200, sortable: true,align:'left'},
                    {field: 'deleteFlag', title: '状态',width:100, sortable: true,
                        formatter: function (value, row, index) {
                            return row.deleteFlag == '0' ? '正常' : '禁用';
                        }
                    },
                    {field: 'icon', title: '图标',width:180, sortable: true}
                ]
            ],
	        onDblClickRow: function(index){
	        	edit();
	        }

        });
		$("form[for] button.queryBtn").on("click.datagrid-query", function () {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function () {
			top._clearSearch($(this).parents("form"));
        });
		 $('#companyFormId').combotree({
		 	valueField:'id',
		    nameField:'name',
            url: '${dynamicURL}/system/company/combotree?search_EQ_parentId=0'
         });
	})
    function add() {
		$("#addWindow form.addForm").form("clear");
		var data=$("#companyFormId").combotree('tree').tree("getRoot");
    	$("#companyFormId").combotree('setValue',data.id);
		$("#addWindow").dialog("open");
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
//             $.messager.progress('close');
            if (data.success) {
//                 $(this).form("load", data.obj);
//                 $.messager.show({title: '提示', msg: '保存成功！'});
                $.messager.alert('提示', '保存成功！', "info");
                $('#addWindow').dialog('close');
                companyDatagrid.treegrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
    $("#addWindow .BtnLine .submit").on("click", 
    	_.debounce(function() {
    		$("#addWindow form.addForm").submit();
   		},waitTime,true)
    );
    
    
    //修改
    function edit() {
        var row = companyDatagrid.treegrid("getSelected");
        if (row) {
            var form = $("#addWindow form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/system/company/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
        			$('#companyFormId').combotree("reload");
        			if(response.obj.parent!=null){
        				$("#companyFormId").combotree("setValue",response.obj.parentId);
        			}
                    form.form("load", response.obj);
                    $("#addWindow").dialog("open");
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function del(){
    	 top._del(companyDatagrid, {delUrl: "${dynamicURL}/system/company/delete"});
    }
	
</script>

