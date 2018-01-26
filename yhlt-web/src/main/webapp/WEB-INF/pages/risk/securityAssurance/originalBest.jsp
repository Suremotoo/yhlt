<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>


<div class="easyui-layout layout-custom-resize" data-options="fit:true">
	<!-- 西边的 -->
	<div data-options="region:'west',split:false,collapsible:false" style="width:500px;overflow:scroll;overflow-x:hidden"><!-- 禁止横向滚动 -->
		<div class="easyui-layout layout-custom-resize" data-options="fit:true">
			<div data-options="region:'north'">
		        <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
					  类型：<select id="securityBillComboTree" style="width: 350px; height: 26px"></select>
		        </div>
		        <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
		      		<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="addType()" type="button" iconcls="icon-add" >新增</button>
		         	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="editType()" type="button" iconcls="icon-edit" >修改</button>
		         	<button class="easyui-linkbutton l-btn l-btn-small" id="remove" onclick="delType()" type="button" iconcls="icon-delete" >删除</button> 
		        </div>
	        </div>
	        <div data-options="region:'center'">
	        	<table id="securityBillTypeDatagrid"></table>
	        </div>
		</div>
	</div>
	
	<!-- 中心部分 -->
	<div data-options="region:'center',split:false,collapsible:false" style=" ">
		<!-- 里面北边的 -->
		<div data-options="region:'north',split:true,collapsible:false" style="height: 50%;">
			<div class="easyui-layout layout-custom-resize" data-options="fit:true">
				<div data-options="region:'north'">
<!-- 			        <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel"> -->
<!-- 						<form class="form-horizontal" for="securityBillTypeDatagrid"> -->
<!-- 							<table style="width: 800px; line-height: 40px;"> -->
<!-- 								<tr> -->
<!-- 									<td>名称:</td> -->
<!-- 									<td><input class="easyui-textbox" type="text" name="search_LIKE_name" style="width: 150px; height: 26px"> -->
<!-- 									</td> -->
<!-- 									<td> -->
<!-- 										<div class="BtnLine" style="border: 0px; margin: 0px; padding: 0px; text-align: left"> -->
<!-- 											<button type="button" class="easyui-linkbutton queryBtn" iconcls="icon-search">搜索</button> -->
<!-- 											<button type="button" class="easyui-linkbutton clearBtn" iconcls="icon-reload">重置</button> -->
<!-- 										</div> -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 							</table> -->
<!-- 						</form> -->
<!-- 					</div> -->
					<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
			      		<button class="easyui-linkbutton l-btn l-btn-small" id="addCheckItem" onclick="addCheckItem()" type="button" iconcls="icon-add" >新增</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="editCheckItem" onclick="editCheckItem()" type="button" iconcls="icon-edit" >修改</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="removeCheckItem" onclick="delCheckItem()" type="button" iconcls="icon-delete" >删除</button> 
			        </div>
		        </div>
		        <div data-options="region:'center'">
		        	<table id="securityBillDatagrid"></table>
		        </div>
			</div>
		</div>
		
		<!-- 里面中心部分 -->
		<div data-options="region:'center',split:true,collapsible:false" style="height:50%; overflow: auto;">
			<div class="easyui-layout layout-custom-resize" data-options="fit:true">
				<div data-options="region:'north'">
					<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
			      		<button class="easyui-linkbutton l-btn l-btn-small" id="addDetail" onclick="addDetail()" type="button" iconcls="icon-add" >新增</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="editDetail" onclick="editDetail()" type="button" iconcls="icon-edit" >修改</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="removeDetail" onclick="delDetail()" type="button" iconcls="icon-delete" >删除</button> 
			        </div>
		        </div>
		        <div data-options="region:'center'">
		        	<table id="securityBillDetailDatagrid"></table>
		        </div>
			</div>
		</div>
	</div>
	
</div>

<!-- 添加类型 -->
<div id="addWindowType" class="easyui-dialog" title="新增" style="width: 620px; height: 220px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/risk/securityAssurance/save" method="post">
    	<input type="hidden" name="id" />
    	<input type="hidden" name="securityAssuranceEntity.id" id="securityAssuranceEntityId">
    	<table class="table_edit">
    		<tr>
    			<td class="text_tr" style="width: 30%;">类型：</td>
    			<td>
    				<select class="easyui-combotree" name="parentId" id="securityAssuranceFormId" style="width: 270px; height: 26px;" data-options="required:true"></select>
    			</td>
    		</tr>
	        <tr>
	            <td class="text_tr" style="width: 30%;">名称：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="name" id="nameFormId" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindowType').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>


<!-- 添加-检查依据-->
<div id="addWindowItem" class="easyui-dialog" title="新增" style="width: 620px; height: 150px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/risk/securityAssurance/saveDetail?type=2" method="post">
    	<input type="hidden" name="id" id="id"/>
    	<input type="hidden" name="parentId" id="parentIdItem"/>
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width:30%;">检查依据：</td>
	            <td>
	            	<input class="easyui-textbox" type="text"  name="name" id="nameFormId" style="width: 270px; height: 26px" data-options="required:true" />
	            </td>
	        </tr>
<!-- 	        <tr> -->
<!-- 	        	<td  class="tr">检查标准：</td> -->
<!-- 	        	<td> -->
<!-- 	        		<textarea id="remarkFormId" name="remark" class="form-control" style="width: 1000px; height: 400px"></textarea> -->
<!-- 	        	</td> -->
<!-- 			</tr> -->
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindowItem').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>

<!-- 添加 检查项 明细详情 -->
<div id="addWindowDetail" class="easyui-dialog" title="新增" style="width: 1200px; height: 600px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/risk/securityAssurance/saveDetail?type=3" method="post">
    	<input type="hidden" name="id" id="id"/>
    	<input type="hidden" name="parentId" id="parentIdDetail"/>
    	<table class="table_edit">
<!-- 	        <tr> -->
<!-- 	            <td class="text_tr" style="width:150px">检查依据：</td> -->
<!-- 	            <td> -->
<!-- 	            	<input class="easyui-textbox" type="text"  name="name" id="nameFormId" style="width: 820px; height: 26px" data-options="required:true" /> -->
<!-- 	            </td> -->
<!-- 	        </tr> -->
	        <tr>
	        	<td  class="tr">检查标准：</td>
	        	<td>
	        		<textarea id="remarkFormId" name="remark" class="form-control" style="width: 1000px; height: 400px"></textarea>
	        	</td>
			</tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindowDetail').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>

<script type="text/javascript">
	CKEDITOR.replace('remarkFormId', {
		height : 250,
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
	var isLoad=false;//是否延迟加载
	
	var securityBillComboTree;// 西侧 - 北部  0分类树
	var securityBillTypeDatagrid;// 西侧 - 南部 - 1检查项
	var securityBillDatagrid;// 中部 - 北侧 - 2检查依据
	var securityBillDetailDatagrid;// 中部 - 北侧 - 3检查依据明细
	
	$(function () {
		// 西侧 - 北部  0分类树
		securityBillComboTree = $('#securityBillComboTree').combotree({
		 	valueField:'id',
		    nameField:'name',
            url: '${dynamicURL}/admin/risk/securityAssurance/securityAssurance/tree?search_EQ_parentId=0&sort=sortNumber',
            onSelect:function(record) {
            	if(record.id==0){
            		securityBillTypeDatagrid.datagrid("load", {'url':'${dynamicURL}/admin/risk/securityAssurance/securityAssurance/tree?search_EQ_parentId=0&sort=sortNumber'});
            	}else{
            		securityBillTypeDatagrid.datagrid("load", {'search_EQ_parentId' : record.id});
            	}
            	
            	securityBillTypeDatagrid.datagrid("clearSelections");
            	securityBillDatagrid.datagrid("clearSelections");
            	securityBillDetailDatagrid.datagrid("clearSelections");
            },
            onLoadSuccess: function (node, data) {
            	var data=$("#securityBillComboTree").combotree('tree').tree("getRoot");
            	$("#securityBillComboTree").combotree('setValue',data.id);
            }
        });
		
		// 西侧 - 南部 - 1检查项
		securityBillTypeDatagrid = $('#securityBillTypeDatagrid').datagrid({
		     url: '${dynamicURL}/risk/securityAssurance/list?search_EQ_type=1&sort=sortNumber',
		     queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
		     fit:true,
		     pagination : true,
			 rownumbers : true,
			 singleSelect : true,
			 lines:true,
			 idField : 'id',
		     columns: [ [
		             {field: 'id',formatter: function Ra(val, row, index) {
							return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';
						}},
		             {field: 'name', title: '名称',width:300, sortable: false},
		             {field: 'sortNumber', title: '排序', width: 40, sortable: false},
		         	 {field: 'opt', title: '操作', width: 100, sortable: false, 
		             	formatter: function (value, rec) {
		             		return '<button class="easyui-linkbutton l-btn l-btn-small" type="button" onclick="securityAssuranceSort(0,'+rec.id+')" >↑</button>&nbsp;&nbsp;'+
		             		'<button class="easyui-linkbutton l-btn l-btn-small" type="button" onclick="securityAssuranceSort(1,'+rec.id+')">↓</button>';
		             }}
		         ]
		     ],
		     onSelect:function(rowIndex, rowData){
		    	 isLoad = true;
				 securityBillDatagrid.datagrid("load", {'search_EQ_parentId' : rowData.id});
				 securityBillDatagrid.datagrid("clearSelections");
	             securityBillDetailDatagrid.datagrid("clearSelections");
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
					$("#securityBillTypeDatagrid").datagrid("clearSelections");
					$("input[name='selectRadio']")[rowIndex].checked = false;
					return false;
				}
			 },
		     onDblClickRow: function(index){
		     	editType();
		     }
		 });
		
		// 中部 - 北侧 - 2检查依据
		securityBillDatagrid = $('#securityBillDatagrid').datagrid({
			url : '${dynamicURL}/risk/securityAssurance/list?search_EQ_type=2',
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
					return '<input type="radio" name="selectRadioItem" id="selectRadioItem"' + index + '/>';
				}},
				{field: 'name', title: '检查依据',width:'100%', sortable: true}/* ,
				{field: 'remark', title: '检查标准',width:700, sortable: true} */
			] ],
	        onBeforeLoad:function(){
	        	return isLoad;//isLoad;
	        },
	        onSelect:function(rowIndex, rowData){
				 isLoad=true;
				 securityBillDetailDatagrid.datagrid("load", {'search_EQ_parentId' : rowData.id});
	             securityBillDetailDatagrid.datagrid("clearSelections");
		    },
	        onClickRow : function(rowIndex, rowData) {
				//加载完毕后获取所有的checkbox遍历
				var radio1 = $("input[name='selectRadioItem']")[rowIndex].disabled;
				//如果当前的单选框不可选，则不让其选中
				if (radio1 != true) {
					//让点击的行单选按钮选中
					$("input[name='selectRadioItem']")[rowIndex].checked = true;
					return false;
				} else {
					$("#securityBillDatagrid").datagrid("clearSelections");
					$("input[name='selectRadioItem']")[rowIndex].checked = false;
					return false;
				}
			},
	        onDblClickRow: function(index){
	        	editCheckItem();
	        }
		});
		
		// 中部 - 中侧 - 3检查依据明细
		securityBillDetailDatagrid = $('#securityBillDetailDatagrid').datagrid({
			url : '${dynamicURL}/risk/securityAssurance/list?search_EQ_type=3',
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
// 				{field: 'name', title: '检查依据',width:400, sortable: true},
				{field: 'remark', title: '检查标准',width:700, sortable: true}
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
					$("#securityBillDetailDatagrid").datagrid("clearSelections");
					$("input[name='selectRadioDetail']")[rowIndex].checked = false;
					return false;
				}
			},
	        onDblClickRow: function(index){
// 	        	editCheckItem();
	        }
		});

		$("form[for] button.queryBtn").on("click.datagrid-query", function () {
			top._search($(this).parents("form[for]"));
			securityBillDatagrid.datagrid("load", {'search_EQ_type' : -1});
			
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function () {
			top._clearSearch($(this).parents("form"));
        });
		
		$('#securityAssuranceFormId').combotree({
			panelWidth : 250,
			lines : true,
			panelHeight : 200,
			//下面这两个字段需要视情况修改
			valueField:'id',
		    nameField:'name',
			url : '${dynamicURL}/admin/risk/securityAssurance/securityAssurance/search?search_EQ_parentId=0'
		});
	  
	})
	
	
	//---------------------------------------------------------------------------------------------------------------------
 	//添加类型 西南   securityBillTypeDatagrid
    function addType() {
		var node = securityBillComboTree.combotree('tree').tree('getSelected');	// 获取树对象
//     	var row = securityBillComboTree.data("getSelected");
		if(node.id!=0){
			$("#addWindowType form.addForm").form("clear");
			$("#securityAssuranceEntityId").val(node.id);
    		$("#securityAssuranceFormId").combotree('setValue',node.id);
			$("#addWindowType").dialog("open");
		}
		else {
    		$.messager.alert('提示', '请选择安保专项检查类型！', 'error');
    	}
    }
	 //初始化form表单
    $("#addWindowType form.addForm").form({
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
                $('#addWindowType').dialog('close');
                securityBillTypeDatagrid.datagrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
	
    $("#addWindowType .BtnLine .submit").on("click", 
        _.debounce(function() {
        	$("#addWindowType form.addForm").submit();
       	},waitTime,true)
     );

    
    //修改
    function editType() {
        var row = securityBillTypeDatagrid.datagrid("getSelected");
        if (row) {
            var form = $("#addWindowType form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/risk/securityAssurance/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
        			$('#securityBill').combotree("reload");
                    form.form("load", response.obj);
                    $('#securityAssuranceFormId').combotree('setValue',response.obj.parentId);
                    $("#addWindowType").dialog("open");
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function delType(){
    	 var row = securityBillTypeDatagrid.datagrid("getSelected");
    	 if (row) {
    		 $.messager.confirm('提示','您要删除当前所选记录？',function(data){
    			 if (data) {
    				 $.ajax({
    					 url: "${dynamicURL}/admin/risk/securityAssurance/securityAssurance/deleteJudge",
    					 data: {ids: row.id},
    					 dataType: "json",
    					 success: function (response) {
    						 if(response.success){
    							 $.messager.alert('提示', '删除成功', 'info');
    							 securityBillTypeDatagrid.datagrid('reload');
    						 }
    						 else{
    							 $.messager.alert('提示',response.msg, 'info');
    						 }
                  		}
                 	});
        	 	 }
          	})
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
  	//排序
	function securityAssuranceSort(sortType,securityAssuranceId){
        if (securityAssuranceId) {
       	 	$.ajax({
                url: "${dynamicURL}/admin/risk/securityAssurance/securityAssurance/securityAssuranceSort",
                data: {sortType:sortType,securityAssuranceId: securityAssuranceId},
                dataType: "json",
                success: function (data) {
                	if(data.success){
                		securityBillTypeDatagrid.datagrid("reload");
                	}
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
	}
    
    //-----------------------------------------------------------------------------------------------------------
    
	// 检查项部分
 	function addCheckItem() {
 		var row = securityBillTypeDatagrid.datagrid("getSelected");
 		if(row){
 			$("#addWindowItem form.addForm").form("clear");
 			CKEDITOR.instances.remarkFormId.setData("");
 			$("#parentIdItem").val(row.id)
 			$("#addWindowItem").dialog("open");
 		}else{
 			$.messager.alert('提示', '请选择类型！', 'error');
 		}
    }
	 //初始化form表单
    $("#addWindowItem form.addForm").form({
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
                $('#addWindowItem').dialog('close');
                securityBillDatagrid.datagrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
	 
  	$("#addWindowItem .BtnLine .submit").on("click", 
  		_.debounce(function() {
  	     		$("#addWindowItem form.addForm").submit();
  	    },waitTime,true)
    );
    
    
    //修改
    function editCheckItem() {
        var row = securityBillDatagrid.datagrid("getSelected");
        if (row) {
            var form = $("#addWindowItem form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/risk/securityAssurance/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
                    form.form("load", response.obj);
//                     CKEDITOR.instances.remarkFormId.setData(response.obj.remark);
                    $("#addWindowItem").dialog("open");
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function delCheckItem(){
    	 top._del(securityBillDatagrid, {delUrl: "${dynamicURL}/risk/securityAssurance/delete"});
    }
    
    
	//-----------------------------------------------------------------------------------------------------------
    
	// 检查项明细 检查标准
 	function addDetail() {
 		var row = securityBillDatagrid.datagrid("getSelected");
 		if(row){
 			$("#addWindowDetail form.addForm").form("clear");
 			CKEDITOR.instances.remarkFormId.setData("");
 			$("#parentIdDetail").val(row.id)
 			$("#addWindowDetail").dialog("open");
 		}else{
 			$.messager.alert('提示', '请选择检查项！', 'error');
 		}
    }
	 //初始化form表单
    $("#addWindowDetail form.addForm").form({
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
                $('#addWindowDetail').dialog('close');
                securityBillDetailDatagrid.datagrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
	 
  	$("#addWindowDetail .BtnLine .submit").on("click", 
  		_.debounce(function() {
  	   		var maxlength = CKEDITOR.instances.remarkFormId.getData().length; //取得纯文本       
  			if(maxlength > 20000){
  				$.messager.alert('提示', '内容超出最大长度！', 'error');
  				return false;
  			}else
  	     		$("#addWindowDetail form.addForm").submit();
  	    },waitTime,true)
    );
    
    
    //修改
    function editDetail() {
        var row = securityBillDetailDatagrid.datagrid("getSelected");
        if (row) {
            var form = $("#addWindowDetail form.addForm");
            form.form("clear");
            $.ajax({
                url: "${dynamicURL}/risk/securityAssurance/detail",
                data: {id: row.id},
                dataType: "json",
                success: function (response) {
                    form.form("load", response.obj);
                    CKEDITOR.instances.remarkFormId.setData(response.obj.remark);
                    $("#addWindowDetail").dialog("open");
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function delDetail(){
    	 top._del(securityBillDetailDatagrid, {delUrl: "${dynamicURL}/risk/securityAssurance/delete"});
    }
</script>


