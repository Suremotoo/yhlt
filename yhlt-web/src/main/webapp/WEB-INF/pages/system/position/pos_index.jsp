<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>
<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
        <div region="north" border="false">
            <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
            	<form class="form-horizontal" for="posDatagrid">
            		<table style="width: 600px; line-height: 40px;">
	                    <tr>
	                        <td>名称:</td>
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
            	<security:ifAny authorization="职位管理_管理员">
	             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
             		<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
             	</security:ifAny>
             	<security:ifAny authorization="职位管理_管理员">
             		<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
             	</security:ifAny>
            </div>
        </div>
        <div region="center" border="false">
            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
                <table id="posDatagrid"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增" style="width: 620px; height: 220px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/system/position/save" method="post">
    	<input type="hidden" name="id" id="posId"/>
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">名称：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="name" id="nameFormId" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">备注：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="remark" id="remarkFormId" style="width: 270px; height: 26px"   />
	            </td>
	        </tr>
	         <tr>
	            <td class="text_tr">排序编码：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="sortNumber" style="width: 270px; height: 26px"   data-options="validType:['integer']"/>
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	    	<security:ifAny authorization="职位管理_管理员">
	    		<button type="button" class="easyui-linkbutton submit">保存</button>
           	</security:ifAny>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
<script type="text/javascript">
	//分页
	var posDatagrid;
	$(function () {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
        posDatagrid = $('#posDatagrid').datagrid({
			url: '${dynamicURL}/system/position/list?sort=sortNumber',
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
// 			fitcolumns: true,
			pagination : true,
			rownumbers : true,
			singleSelect : true,
			lines:true,
			idField : 'id',
			columns: [ [
					{field: 'id', formatter:function Ra(val, row, index) {return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';}},
					{field: 'name', title: '名称',width:200, sortable: true},
					{field: 'remark', title: '备注',width:200,sortable:true},
					{field: 'sortNumber',title:'排序编码',width:200,sortable:true}
				]
			],
			onClickRow: function (rowIndex, rowData) {
                //加载完毕后获取所有的checkbox遍历
                var radio1 = $("input[type='radio']")[rowIndex].disabled;
                //如果当前的单选框不可选，则不让其选中
                if (radio1 != true) {
                    //让点击的行单选按钮选中
                    $("input[type='radio']")[rowIndex].checked = true;
                    return false;
                }
                else {
                    $("#posDatagrid").datagrid("clearSelections");
                    $("input[type='radio']")[rowIndex].checked = false;
                    return false;
                }
            },
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
	})
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
            if (data.success) {
                $.messager.alert('提示', '保存成功！', "info");
                $('#addWindow').dialog('close');
                posDatagrid.datagrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
    /* $("#addWindow .BtnLine .submit").on("click", function () {
    	if($("#posId").val()==null||$("#posId").val()==""){
	    	$.post('${dynamicURL}/system/position/check',{'name':$('#nameFormId').val()},function(data){
				if(data.success){
					$("#addWindow form.addForm").submit();
				}else{
					$.messager.alert('提示', data.msg, 'error');
				}
			},'json');
		}else{
			$("#addWindow form.addForm").submit();
		}
    }); */
    
    $("#addWindow .BtnLine .submit").on("click", 
        	_.debounce(function() {
        		if($("#posId").val()==null||$("#posId").val()==""){
        	    	$.post('${dynamicURL}/system/position/check',{'name':$('#nameFormId').val()},function(data){
        				if(data.success){
        					$("#addWindow form.addForm").submit();
        				}else{
        					$.messager.alert('提示', data.msg, 'error');
        				}
        			},'json');
        		}else{
        			$("#addWindow form.addForm").submit();
        		}
       		},waitTime,true)
        );
    
    //修改
    function edit() {
        var row = posDatagrid.datagrid("getSelected");
        if (row) {
            var form = $("#addWindow form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/system/position/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
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
    	 top._del(posDatagrid, {delUrl: "${dynamicURL}/system/position/delete"});
    }
</script>

