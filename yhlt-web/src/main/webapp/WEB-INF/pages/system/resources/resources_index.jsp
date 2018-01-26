<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
<!--
/* .icons-combo{ */
/* 	background: #666666; */
/* } */
-->
</style>
<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
        <div region="north" border="false">
            <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
            	<form class="form-horizontal" for="companyDatagrid">
            		<table style="width: 600px; line-height: 40px;">
	                    <tr>
	                        <td>资源名称:</td>
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
             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="redo()" type="button" iconcls="icon-add" group="">展开</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="undo()" type="button" iconcls="icon-remove" group="">折叠</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="javascript:resourcesTreegrid.treegrid('reload');" type="button" iconcls="icon-reload" group="">刷新</button>
            </div>
        </div>
        <div region="center" border="false">
            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
                <table id="resourcesTreegrid"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog"  title="新增" style="width: 620px; height: 420px;" modal="true" closed="true" buttons="#new-buttons">
    <form class="addForm" action="${dynamicURL}/system/resources/save" method="post">
    	<input type="hidden" name="id" />
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">名称：</td>
	            <td>
	            	<input name="name"  type="text" class="easyui-textbox" style="width: 270px; height: 26px;" data-options="required:true"/>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr" style="width: 30%;">编码：</td>
	            <td>
	            	<input name="code" type="text" class="easyui-textbox" style="width: 270px; height: 26px;"/>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">类型：</td>
	            <td>
	            	<select name="type" id="typeFormId" style="width: 270px; height: 26px;">
                            <option value="0">菜单</option>
                            <option value="1">功能</option>
                    </select>
	            </td>
	        </tr>
	         <tr>
	            <td class="text_tr">父节点：</td>
	            <td>
	            	<input  class="easyui-textbox" type="text" id="resourceInfoFormId"  name="parentId" style="width: 270px; height: 26px;" data-options="required:true" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">顺序号：</td>
	            <td>
                     <input name="sortNumber"  type="text" style="width: 270px; height: 26px;"  class="easyui-textbox"  data-options="required:true,validType:'number'"/>
	            </td>
	        </tr>
	         <tr>
	            <td class="text_tr">URL：</td>
	            <td>
					<input name="url"  style="width: 270px; height: 26px;" type="text" 
                               data-options=""/>	            
                </td>
	        </tr>
	         <tr>
	            <td class="text_tr">图标：</td>
	            <td>
					<input name="icon" id="iconId" style="width: 270px; height: 26px;"/>	            
				</td>
	        </tr>
	         <tr>
	            <td class="text_tr">描述：</td>
	            <td>
					<textarea name="description" rows="5"  style="width: 270px; height: 26px;" cols="20"    >
	                     </textarea>	            
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
	var resourcesTreegrid,resourcesCombotree;
	$(function () {
	   	resourcesCombotree=$('#resourceInfoFormId').combotree({
	        panelWidth: 180,
	        panelHeight : 300,
	        valueField: 'id',
	        nameField: 'name',
	        url: '${dynamicURL}/system/resources/combotree?search_EQ_parentId=0&search_EQ_flag=0'
	     });
		resourcesTreegrid = $('#resourcesTreegrid').treegrid({
            url: '${dynamicURL}/system/resources/treegrid?search_EQ_parentId=0&search_EQ_flag=0',
            queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
            fit:true,
            pagination : true,
			rownumbers : true,
			singleSelect : true,
			lines:true,
			idField : 'id',
			treeField:"name",
            columns: [
                [
                    {field: 'id', checkbox: true},
                    {field: 'name', title: '名称',width:200, sortable: true,align:'left'},
                    {field: 'deleteFlag', title: '状态',width:100, sortable: true,
                        formatter: function (value, row, index) {
                            return row.deleteFlag == '0' ? '正常' : '禁用';
                        }
                    },
                    {field: 'type', title: '类型',width:100, sortable: true,
                        formatter: function (value, row, index) {
                            return row.type == '0' ? '菜单' : '功能';
                        },
                    	styler: function cellStyler(value,row,index){
                			if (value == 0){
                				return 'background-color:#178ba4;color:#FFF;';
                			}else {
                				return 'background-color:#b6edda;';
                			}
                		}
                    },
                    {field: 'icon', title: '图标',width:180, sortable: true,formatter: function (value, row, index) { return '<i class="'+row.icon+'"></i> '+row.icon;}},
                    {field: 'url', title: 'URL',width:180, sortable: true},
                    {field: 'sortNumber', title: '顺序号',width:60, sortable: true},
                    {field: 'code', title: '编码',width:200, sortable: true},
                    {field: 'description', width:500,title: '描述', sortable: true}
                ]
            ],
            onLoadSuccess: function(node, data){
//     			$(this).treegrid('collapseAll');
            },
            onDblClickRow: function(index){
				edit();
            },
            onExpand:function(node){
            	var id=node.id;
            	var tree = $('#resourceInfoFormId').combotree('tree');
            	var node = tree.tree("find",id);
            	tree.tree("expand",node.target);
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
		    textField:'name',
            url: '${dynamicURL}/system/company/combotree?search_EQ_parentId=0'
         });
		$('#iconId').combobox({
			data : (function() {
				var data = [];
				$.each(top.icons, function(i) {
					data.push({
						value : this,
						text : this
					})
				});
				return data;
			})(),
			editable:false,
			formatter : function(row) {
// 				return '<div class="resourceIcon"><ul><li><em class="'+row.value+'"></em></li></ul></div>';
				return '<i class="'+row.value+'"></i>'+row.value;
			}
		}).combo('panel').addClass("icons-combo");
	});
    function add() {
		$("#addWindow form.addForm").form("clear");
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
                resourcesTreegrid.treegrid('reload');
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
    	var row = resourcesTreegrid.treegrid("getSelected");
		if (row) {
			var form = $("#addWindow form.addForm");
			form.form("clear");
			$.ajax({
				url : "${dynamicURL}/system/resources/detail",
				data : {
					id : row.id
				},
				dataType : "json",
				success : function(response) {
					$("#resourceInfoFormId").combotree("setValue",response.obj.parentId||0);
					form.form("load", response.obj);
					$("#addWindow").dialog("open");
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'error');
		}
    }
    
    //删除
    function del(){
    	 top._del(resourcesTreegrid, {delUrl: "${dynamicURL}/system/resources/batchDelete"});
    }

    function redo() {
		var node = resourcesTreegrid.treegrid('getSelected');
		if (node) {
			resourcesTreegrid.treegrid('expandAll', node.id);
		} else {
			resourcesTreegrid.treegrid('expandAll');
		}
	}

	function undo() {
		var node = resourcesTreegrid.treegrid('getSelected');
		if (node) {
			resourcesTreegrid.treegrid('collapseAll', node.id);
		} else {
			resourcesTreegrid.treegrid('collapseAll');
		}
	}
</script>

