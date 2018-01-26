<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>

<div class="easyui-layout layout-custom-resize" data-options="fit:true">
	<div data-options="region:'west',split:false,collapsible:false" style="width: 300px;">
		<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
         	<button class="easyui-linkbutton l-btn l-btn-small" id="refreshCompany" onclick="ref()" type="button" iconcls="icon-reload" >刷新</button>
        </div>
		<table id="dictDatagrid"></table>
	</div>
	<div data-options="region:'center',split:false,collapsible:false" style="width: 70%;height:100%;">
		<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
		 <security:ifAny authorization="部门管理_管理员">
         	<button class="easyui-linkbutton l-btn l-btn-small" id="save" onclick="save()" type="button" iconcls="icon-save" >保存</button>
         </security:ifAny>
        </div>
        <div id="container" style="height:100%;">
    		<div id="tabs" class="" style="width: 100%;height:100%;background: #F1F1F1">
        		<textarea id="contents" style="width: 90%;height: 70%;margin: 2%;"></textarea>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var dictDatagrid;
	$(function () {
 	/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
        dictDatagrid = $('#dictDatagrid').datagrid({
			url: '${dynamicURL}/system/dict/list?search_EQ_type=NOTICE_TYPE',
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			rownumbers : true,
			singleSelect : true,
			lines:true,
			idField : 'id',
			columns: [ [
					{field: 'id', formatter:function Ra(val, row, index) {return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';}},
					{field: 'name', title: '名称',width:200}
				]
			],
			onClickRow: function (rowIndex, rowData) {
				var contents=$("#contents");
				contents.html("");
                $.ajax({
                	url:"${dynamicURL}/sms/template/search?typeId="+rowData.id,
                	type:"POST",
                	dataType:"JSON",
                	
                	success:function(msg){
                		contents.val(msg.contents);
                	}
                });
                //加载完毕后获取所有的checkbox遍历
                var radio1 = $("input[type='radio']")[rowIndex].disabled;
                //如果当前的单选框不可选，则不让其选中
                if (radio1 != true) {
                    //让点击的行单选按钮选中
                    $("input[type='radio']")[rowIndex].checked = true;
                    return false;
                }
                else {
                    $("#dictDatagrid").datagrid("clearSelections");
                    $("input[type='radio']")[rowIndex].checked = false;
                    return false;
                }
            }
        });
	});
	function save(){
		var row=dictDatagrid.datagrid("getSelected");
		if(row){
			 $.ajax({
	        	url:"${dynamicURL}/sms/template/save",
	        	type:"POST",
	        	data:{'typeId':row.id,'contents':$("#contents").val()},
	        	dataType:"JSON",
	        	success:function(msg){
	        		if(msg.success){
	        			$.messager.alert("提示","保存成功！","info");
	        		}else{
	        			$.messager.alert("提示","保存失败！","error");
	        		}
	        	}
	        });
		}
	}
	function ref(){
		dictDatagrid.datagrid("reload");
	}
</script>

