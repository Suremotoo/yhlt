<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>

<div class="easyui-layout layout-custom-resize" data-options="fit:true">
	<div data-options="region:'west',split:false,collapsible:false" style="width: 250px;overflow: scroll;">
		<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
         	<button class="easyui-linkbutton l-btn l-btn-small" id="refreshCompany" onclick="refreshCompany()" type="button" iconcls="icon-reload" >刷新</button>
        </div>
		<table id="companyTreegrid"></table>
	</div>
	<div data-options="region:'center',split:false,collapsible:false" style="width: 400px;">
        <div class="easyui-layout layout-custom-resize" data-options="fit:true">
			<div data-options="region:'north'">
				<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
				 <security:ifAny authorization="部门管理_管理员">
		         	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" >新增</button>
		         	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" >修改</button>
		         </security:ifAny>
		          <security:ifAny authorization="部门管理_管理员">
		         	<button class="easyui-linkbutton l-btn l-btn-small" id="remove" onclick="del()" type="button" iconcls="icon-delete" >删除</button>
		         </security:ifAny>
		        </div>
			</div>
			<div data-options="region:'center'">
				<table id="departmentTreegrid"></table>
			</div>
		</div>
	</div>
</div>
<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增" style="width: 620px; height: 350px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/system/department/save" method="post">
    	<input type="hidden" name="id" />
    	<input type="hidden" name="companyEntity.id" id="companyEntityId">
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">上级公司：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  id="companyEntityName"  style="width: 270px; height: 26px" disabled="disabled" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">上属部门：</td>
	            <td>
	            	<select class="easyui-textbox" name="parentId" id="departmentFormId" style="width: 270px; height: 26px" data-options="required:true" ></select>
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">部门名称：</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="name" id="nameFormId"  style="width: 270px; height: 26px" data-options="required:true" >
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">序号：</td>
	            <td>
	            	<input class="easyui-textbox" type="text" name="sortNumber" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">部门负责人：</td>
	            <td>
	            	<input class="text" type="text" readonly="readonly" onclick="editUser(1)" name="deptHeadName" style="width: 270px; height: 26px" placeholder="点击选择部门负责人"/>
	            	<input type="hidden" name="headId">
	            </td>
	        </tr>
	        <tr>
	            <td class="text_tr">部门领导：</td>
	            <td>
	            	<input class="text" type="text" readonly="readonly" onclick="editUser(0)" name="deptLeaderName" style="width: 270px; height: 26px" placeholder="点击选择部门领导"/>
	            	<input type="hidden" name="leaderId">
	            	<input type="hidden" name="editUserFlag">
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>

<!-- 	人员选择  dialog-->
	<div id="w" class="easyui-window" title="选择人员"
		data-options="closable:false,minimizable:false,maximizable:false,draggable:true,resizable:false,closed:true"
		style="width: 500px; height: 500px; padding: 10px; margin: auto;">
		<table width="100%" align="center" border="0" cellpadding="0"
			style="border-collapse: separate; border-spacing: 5px;"
			cellspacing="0">
			<tr>
				<td colspan="3">机构：<select 
					name="language" id="company" style="width: 136.3px; font-size: 14px;"
					contenteditable="false"></select> 部门：<select name="language" id="dept"
					style="width: 136.3px; font-size: 14px;" contenteditable="false"></select>
				</td>
			</tr>
			<tr>
				<td colspan="1">搜索：<input class="easyui-textbox"  id="searchBox"
					style="width: 136.3px"></input>
				</td>
				<td colspan="2"><button id="searchButton" class="easyui-linkbutton" plain="false">查询</button></td>
			</tr>
			<tr>
				<td style="width: 181.8px">待选人员：</td>
				<td style="width: 18px;"></td>
				<td style="width: 181.8px">已选人员：</td>
			</tr>
			<tr>
				<td style="width: 181.8px"><select multiple="multiple"
					id="select1"
					style="width: 181.8px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;">
				</select></td>
				<td style="width: 27px;">
				<button href="#" id="addUser" class="easyui-linkbutton">&gt;&nbsp;&nbsp;</button><br /> <br /> 
				<button href="#" id="removeUser" class="easyui-linkbutton">&lt;&nbsp;&nbsp;</button><br /> <br /> 
				<!-- <button href="#" id="add_all" class="easyui-linkbutton">&gt;&gt;</button><br /> <br />
				 <button href="#" id="remove_all" class="easyui-linkbutton">&lt;&lt;</button><br /> -->
				</td>
				<td style="width: 181.8px"><select multiple="multiple"
					id="select2"
					style="width: 181.8px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;">
				</select></td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: right;"><br/>
					<button id="rySubmit" class="easyui-linkbutton" plain="false">确定</button>&nbsp;&nbsp;<button id="cancel"
					class="easyui-linkbutton" plain="false" onclick="window.close();">取消</button></td>
			</tr>
		</table>
	</div>
<script type="text/javascript">
	var companyTreegrid;
	var departmentTreegrid;
	var isLoad=false;//是否延迟加载
	var depCom;
	var company;
	$(function () {
 	/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
        companyTreegrid = $('#companyTreegrid').treegrid({
            url: '${dynamicURL}/system/company/list?search_EQ_parentId=0',
            queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
            fit:false,
            pagination : false,
// 			rownumbers : true,
			singleSelect : true,
			lines:true,
			idField : 'id',
			treeField: 'name',
            columns: [ [
// 					{field : 'id',checkbox:true}, 
                    {field: 'name', title: '名称',width:200, sortable: true,align:'left'},
                ]
            ],
            onSelect:function(rowIndex, rowData){
				isLoad=true;
				departmentTreegrid.treegrid("load", {'companyId' : rowIndex.id});
            }
        });
        /*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		departmentTreegrid = $('#departmentTreegrid').treegrid({
		   		url: '${dynamicURL}/system/department/treegrid?search_EQ_parentId=0',
				pagination: false,
				rownumbers : true,
				queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
				fit:true,
				fitColumns:true,
				treeField: 'name',
				idField: 'id',
				iconCls: "icon2 r22_c5",
				columns: [
				    [
				        {field: 'id', checkbox: true},
				        {field: 'name', title: '部门名称',width:200, sortable: true,align:'left'},
				        {field: 'companyEntity.name', title: '公司名称',width:180, sortable: true, formatter: function (value, rec) { return rec.companyEntity['name'];}},
				        {field: 'userCount', title: '员工数',width:60, sortable: true},
				        {field: 'sortNumber', title: '顺序号',width:60, sortable: true},
				        {field: 'deleteFlag', title: '状态',width:100, sortable: true,
				            formatter: function (value, row, index) {
				                return row.deleteFlag == '0' ? '正常' : '禁用';
				            }
				        }
				    ]
				],
				onBeforeLoad:function(){
					return isLoad;
				},
				onDblClickRow : function(index) {
					edit();
				}
		});
	   	$('#departmentFormId').combotree({
            panelWidth: 250,
            lines : true,
            panelHeight : 400,
            //下面这两个字段需要视情况修改
            idField: 'id',
            nameField: 'name'
     	});
	   	
	   	company=$('#company').combotree({
			   panelWidth: 250,
			   panelHeight : 400,
			   idField: 'id',
			   nameField: 'name',
			   url: '${dynamicURL}/system/company/combotree?search_EQ_parentId=0',
			   onChange:function(newValue, oldValue){
			   		//级联加载
					$.get('${dynamicURL}/system/department/combotree',{'search_EQ_companyEntity.id':newValue},function(data){
						depCom.combotree("clear").combotree('loadData',data);
					},'json');
			   		//人员加载
					$.get('${dynamicURL}/system/user/search',{'search_EQ_companyEntity.id':newValue},function(data){
						$("#select1").empty();
						$.each(eval(data),function(i,d){
								$("#select1").append("<option value='"+d.id+"'>"+d.name+"</option>");
						});
					},'json');
				}
			});
	    
	    depCom = $('#dept').combotree({
			   panelWidth: 250,
			   lines : true,
			   panelHeight : 400,
			   idField: 'id',
			   nameField: 'name',
			  	onChange:function(newValue, oldValue){
			  		//人员加载
						$.get('${dynamicURL}/system/user/search',{'search_EQ_departmentEntity.id':newValue},function(data){
							$("#select1").empty();
							$.each(eval(data),function(i,d){
								$("#select1").append("<option value='"+d.id+"'>"+d.name+"</option>");
							});
						},'json');
			  	}
			});
	    
	  //人员选择
		//确定按钮
		$("#rySubmit").click(function() {
			var flag = $("input[name='editUserFlag']").val();
			$("#select2 option").each(function(i, d) {
				if(flag == "0"){
					$("input[name='deptLeaderName']").val($(d).text());
					$("input[name='leaderId']").val($(d).val());
				}else if(flag == "1"){
					$("input[name='deptHeadName']").val($(d).text());
					$("input[name='headId']").val($(d).val());
				}
			});
			$("#w").window("close");
		});
		//取消
		$("#cancel").click(function(){
			$("#w").window("close");
		});
		//移到右边
		$('#addUser').click(function() {
			//获取选中的选项，删除并追加给对方
			var size = $("#select2 option").size()
			if(size > 0){
				$.messager.alert('提示', '只能选择一个用户！', 'info');
			}else{
				$('#select1 option:selected').appendTo('#select2');
			}
			
		});
		//移到左边
		$('#removeUser').click(function() {
			$('#select2 option:selected').appendTo('#select1');
		});
		//双击选项
		$('#select1').dblclick(function() { //绑定双击事件
			//获取全部的选项,删除并追加给对方
			var size = $("#select2 option").size()
			if(size > 0){
				$.messager.alert('提示', '只能选择一个用户！', 'info');
			}else{
				$("option:selected", this).appendTo('#select2'); //追加给对方
			}
			
		});
		//双击选项
		$('#select2').dblclick(function() {
			$("option:selected", this).appendTo('#select1');
		});
	      //查询按钮
	       $("#searchButton").click(function() {
				var searchText = $('#searchBox').val();
				if(searchText==""){
					$.messager.alert('消息', '请填写查询人信息！', 'info');
				}else{
					var companyId=company.combotree("getValue");
					var deptId=depCom.combotree("getValue");
					$.get('${dynamicURL}/system/user/search',{"search_EQ_companyEntity.id":companyId,"search_EQ_departmentEntity.id":deptId,"search_LIKE_name":searchText},function(data){
						$("#select1").empty();
						$.each(data,function(index,content){
								$("#select1").append("<option value='"+content.id+"'>"+content.name+"</option>");
					 	});
					},'json');
				}
			});
	})
	 function add() {
		var row = companyTreegrid.treegrid("getSelected");
		if(row){
			$("#addWindow form.addForm").form("clear");
			$("#companyEntityId").val(row.id);
			$("#companyEntityName").textbox('setValue',row.name);
			loadDepartmentCombotree(row.id);
			$("#addWindow").dialog("open");
		}else{
			$.messager.alert('提示', '请选择公司！', 'error');
		}
    }
	function loadDepartmentCombotree(companyId,departmentId){
		if(companyId){
			$.post('${dynamicURL}/system/department/combotree?search_EQ_parentId=0',{'search_EQ_companyEntity.id':companyId},function(data){
				$('#departmentFormId').combotree("clear");
				$('#departmentFormId').combotree('loadData',data);
				if(departmentId){
					$("#departmentFormId").combotree("setValue",departmentId);
				}else{
					$("#departmentFormId").combotree("setValue",0);
				}
			},'json');
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
                departmentTreegrid.treegrid('reload');
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
        var row = departmentTreegrid.treegrid("getSelected");
        if (row) {
            var form = $("#addWindow form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/system/department/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
                    form.form("load", response.obj);
        			$("#companyEntityId").val(response.obj.companyEntity['id']);
        			$("#companyEntityName").textbox('setValue',response.obj.companyEntity['name']);
        			//加载部门信息
        			var companyRow = companyTreegrid.treegrid("getSelected");
        			loadDepartmentCombotree(companyRow.id,response.obj.parentId);
                    $("#addWindow").dialog("open");
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function del(){
    	 top._del(departmentTreegrid, {delUrl: "${dynamicURL}/system/department/delete"});
    }
    
    //刷新公司
    function refreshCompany(){
    	companyTreegrid.treegrid("reload");
    }
    
    //人员维护
	function editUser(flag) {
		$("input[name='editUserFlag']").val(flag);
		//清空
		$('#select2').empty();
		$('#select1').empty();
		depCom.combotree("clear");
		company.combotree("clear");
		$("#w").window("open");
	}
</script>

