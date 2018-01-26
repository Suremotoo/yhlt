<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>


<div class="easyui-layout layout-custom-resize" data-options="fit:true">
	<div data-options="region:'west',split:false,collapsible:false" style="width: 250px;overflow: scroll;">
		<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
			公司：<select id="companyComboTree" style="width: 180px; height: 26px" data-options="required:true" ></select>
        </div>
		<table id="departmentTreegrid"></table>
	</div>
	<div data-options="region:'center',split:false,collapsible:false" style="width: 400px;">
		<div class="easyui-layout layout" fit="true">
		    <div id="container" class="easyui-layout layout" fit="true">
		        <div region="north" border="false">
		            <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
			        	<form class="form-horizontal" for="securityBillDatagrid">
					<table style="width: 800px; line-height: 40px;">
						<tr>
							<td>名称:</td>
							<td><input class="easyui-textbox" type="text"
								name="search_LIKE_name" style="width: 150px; height: 26px">
							</td>
							<td>
								<div class="BtnLine"
									style="border: 0px; margin: 0px; padding: 0px; text-align: left">
									<button type="button" class="easyui-linkbutton queryBtn"
										iconcls="icon-search">搜索</button>
									<button type="button" class="easyui-linkbutton clearBtn"
										iconcls="icon-reload">重置</button>
								</div>
							</td>
						</tr>
					</table>
				</form>
			        </div>
					<div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
					 <security:ifAny authorization="用户管理_管理员">
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" >新增</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="remove" onclick="del()" type="button" iconcls="icon-delete" >删除</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="showBillDetail()" type="button" iconcls="icon-edit" >查看检查单详情</button>
			         </security:ifAny>
			        </div>
		        </div>
		        <div region="center" border="false">
		            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
		                <table id="securityBillDatagrid"></table>
		            </div>
		        </div>
		    </div>
		</div>	
	</div>
</div>
<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增"
	style="width: 620px; height: 350px;" modal="true" closed="true">
	<form class="addForm" action="${dynamicURL}/risk/securityAssurance/bill/saveBill"
		method="post">
		<input type="hidden" name="id" />
		<table class="table_edit">
			<tr>
				<td class="text_tr" style="width: 30%;">检查日期：</td>
				<td><input name="billDate" type="text" class="form-control easyui-datetimebox"
						style="width: 270px; height: 26px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<td class="text_tr">状态：</td>
				<td><select name="status"
					id="typeFormId" style="width: 270px; height: 26px"
					data-options="required:true" >
					<option value="0">检查中</option>
					<option value="1">检查完成</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text_tr">创建人：</td>
				<td>
					<input class="text" type="text" readonly="readonly" onclick="editUser(1)" name="createName"
						style="width: 270px; height: 26px" placeholder="点击选择会议发起人" />
					<input type="hidden" name="createById"> 
					<input type="hidden" name="editUserFlag">
				</td>
			</tr>
			<tr>
				<td width="15%" class="tr">公司名：&nbsp;&nbsp;</td>
				<td width="35%"><input name="companyEntity.name" id="companyFormName" 
					readonly="readonly" style="width: 270px; height: 26px;"/>
					<input type="hidden" name="companyEntity.id" id="companyFormId"> 
				</td>
			</tr>
			<tr>
				<td width="15%" class="tr">部门名：&nbsp;&nbsp;</td>
				<td width="35%"><input name="departmentEntity.name" id="departmentFormName" 
				readonly="readonly" style="width: 270px; height: 26px"/>
				<input type="hidden" name="departmentEntity.id" id="departmentFormId">
				</td>
			</tr>
			<tr>
				<td width="15%" class="tr">类型：&nbsp;&nbsp;</td>
				<td width="35%"><select id="securityAssuranceComboTree" style="width: 180px; height: 26px"></select></td>
			</tr>
			
		</table>
		<div class="BtnLine">
			<button type="button" class="easyui-linkbutton submit">保存</button>
			<button type="button" class="easyui-linkbutton"
				onclick="$('#addWindow').dialog('close');return false;">取消</button>
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
			<td colspan="3">机构：<select name="language" id="company"
				style="width: 136.3px; font-size: 14px;" contenteditable="false"></select>
				部门：<select name="language" id="dept"
				style="width: 136.3px; font-size: 14px;" contenteditable="false"></select>
			</td>
		</tr>
		<tr>
			<td colspan="1">搜索：<input class="easyui-textbox" id="searchBox"
				style="width: 136.3px"></input>
			</td>
			<td colspan="2"><button id="searchButton"
					class="easyui-linkbutton" plain="false">查询</button></td>
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
				<button href="#" id="addUser" class="easyui-linkbutton">&gt;&nbsp;&nbsp;</button>
				<br /> 
				<br />
				<button href="#" id="removeUser" class="easyui-linkbutton">&lt;&nbsp;&nbsp;</button>
				<br /> 
				<br /> 
				<!-- <button href="#" id="add_all" class="easyui-linkbutton">&gt;&gt;</button><br /> <br />
				 <button href="#" id="remove_all" class="easyui-linkbutton">&lt;&lt;</button><br /> -->
			</td>
			<td style="width: 181.8px"><select multiple="multiple"
				id="select2"
				style="width: 181.8px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;">
			</select></td>
		</tr>
		<tr>
			<td colspan="3" style="text-align: right;"><br />
				<button id="rySubmit" class="easyui-linkbutton" plain="false">确定</button>&nbsp;&nbsp;
				<button id="cancel" class="easyui-linkbutton" plain="false"
					onclick="window.close();">取消</button></td>
		</tr>
	</table>
</div>
<script type="text/javascript">
	var securityAssuranceComboTree; //类型选择下拉框
	var companyComboTree;
	var departmentTreegrid;
	var securityBillDatagrid;
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
			        {field: 'name', title: '部门名称',width:200, sortable: true,align:'left'},
			    ]
			],
			onBeforeLoad:function(){
				return isLoad;
			},
            onSelect:function(rowIndex, rowData){
				securityBillDatagrid.datagrid("load", {'search_EQ_departmentEntity.id' : rowIndex.id});
            }
		});
 		
		securityBillDatagrid = $('#securityBillDatagrid').datagrid({
			url : '${dynamicURL}/risk/securityAssurance/bill/list',
			queryForm : "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit : true,
// 			fitcolumns: true,
			pagination : true,
			rownumbers : true,
			singleSelect : true,
			lines : true,
			idField : 'id',
			columns : [ [
				{field: 'id',formatter: function Ra(val, row, index) {
					return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';
				}},
				{field: 'billDate',title: '检查单日期',width: 200,sortable: true},
				{field: 'companyEntity.name',title: '公司名',width: 150,sortable: true,
					formatter: function (value, rec) { return rec.companyEntity['name'];}	
				},
				{field: 'departmentEntity.name',title: '部门名',width: 150,sortable: true,
					formatter: function (value, rec) { return rec.departmentEntity['name'];}	
				},
				{field: 'status',title: '状态',width: 150,sortable: true,
					formatter : function(value, row) {
						var color = "green"; //字体颜色
						if(row.status=='0'){
							color="red";
						}
						return "<span style='color:"+color+"'>"+row.statusWrapper+"</span>";
					}	
				},
				{field: 'createName',title: '创建人',width: 150,sortable: true},
				{field: 'gmtCreate',title: '创建日期',width: 150,sortable: true}
			] ],
			onClickRow : function(rowIndex, rowData) {
				//加载完毕后获取所有的checkbox遍历
				var radio1 = $("input[type='radio']")[rowIndex].disabled;
				//如果当前的单选框不可选，则不让其选中
				if (radio1 != true) {
					//让点击的行单选按钮选中
					$("input[type='radio']")[rowIndex].checked = true;
					return false;
				} else {
					$("#securityBillDatagrid").datagrid("clearSelections");
					$("input[type='radio']")[rowIndex].checked = false;
					return false;
				}
			},
			onDblClickRow : function(index) {
				showBillDetail();
				}
			});
		// 安保类型选择框
		securityAssuranceComboTree = $('#securityAssuranceComboTree').combotree({
			 panelWidth: 200,
	         lines : true,
	         panelHeight : 300,
	         //下面这两个字段需要视情况修改
	         idField: 'id',
	         nameField: 'name',
	         url: '${dynamicURL}/risk/securityAssurance/combotree?search_EQ_parentId=0',
	         onChange:function(newId,oldId) {
	        	/* if(newId!=0){
	        		securityAssuranceCheckDatagrid.datagrid("load", {'search_EQ_parentId' : newId});
	        	}else{
	        		securityAssuranceCheckDatagrid.datagrid("load",{"url":'${dynamicURL}/risk/securityAssurance/list?search_EQ_type=1'});
	        	} 
	        	securityAssuranceCheckDatagrid.datagrid('clearSelections');
	        	checkingBasisDatagrid.datagrid('clearSelections');
	        	checkingStandardDatagrid.datagrid('clearSelections'); */
	         },
	         onLoadSuccess: function (node, data) {
	        	var data=$("#securityAssuranceComboTree").combotree('tree').tree("getRoot");
	        	$("#securityAssuranceComboTree").combotree('setValue',data.id);
	        }
	    });

		$("form[for] button.queryBtn").on("click.datagrid-query", function() {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function() {
			top._clearSearch($(this).parents("form"));
		});
		
	})
	
	function add() {
		$("#addWindow form.addForm").form("clear");
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
				securityBillDatagrid.datagrid('reload');
			} else {
				$.messager.alert('提示', data.msg, 'error');
			}
		}
	});
	$("#addWindow .BtnLine .submit").on("click", _.debounce(function() {
		$("#addWindow form.addForm").submit();
	}, waitTime, true));


	//删除
	function del() {
		top._del(securityBillDatagrid, {
			delUrl : "${dynamicURL}/risk/securityAssurance/bill/delete"
		});
	}
	
	// 查看检查单详情
	function showBillDetail(){
		var row = securityBillDatagrid.datagrid("getSelected");
		if (row) {
			var form = $("#addWindow form.addForm");
			form.form("clear");
		    window.parent.openT('安保专项检查单详情', '${dynamicURL}/risk/securityAssurance/billDetail/findBillDetail?securityBillId='+row.id+'','0','300','300');
		} else {
			$.messager.alert('提示', '请选择要查看的检查单！', 'error');
		}
	}
	
	var depCom; // 部门
	var company; // 公司
	company = $('#company').combotree({
						panelWidth : 250,
						panelHeight : 400,
						idField : 'id',
						nameField : 'name',
						url : '${dynamicURL}/system/company/combotree?search_EQ_parentId=0',
						onChange : function(newValue, oldValue) {
							//级联加载
							$.get('${dynamicURL}/system/department/combotree',{'search_EQ_companyEntity.id' : newValue}, function(data) {
										depCom.combotree("clear").combotree('loadData', data);
									}, 'json');
							//人员加载
							$.get('${dynamicURL}/system/user/search', {
								'search_EQ_companyEntity.id' : newValue
							}, function(data) {
								$("#select1").empty();
								$.each(eval(data), function(i, d) {
									$("#select1").append("<option value='"+d.id+"'>"+d.name+"</option>");
								});
							}, 'json');
						}
					});
	
		depCom = $('#dept').combotree({
				panelWidth : 250,
				lines : true,
				panelHeight : 400,
				idField : 'id',
				nameField : 'name',
				onChange : function(newValue, oldValue) {
					//人员加载
					$.get('${dynamicURL}/system/user/search', {
						'search_EQ_departmentEntity.id' : newValue
					}, function(data) {
						$("#select1").empty();
						$.each(eval(data), function(i, d) {
							$("#select1").append("<option value='"+d.id+"'>"+d.name+"</option>");
						});
					}, 'json');
				}
			});
	
	//人员选择
	//确定按钮
	$("#rySubmit").click(function() {
		var flag = $("input[name='editUserFlag']").val();
		$("#select2 option").each(function(i, d) {
			if (flag == "1") {
				$("input[name='createName']").val($(d).text());
				$("input[name='createById']").val($(d).val());
				$.ajax({
					url : "${dynamicURL}/system/user/detail",
					data : {
						id : $(d).val()
					},
					dataType : "json",
					success : function(response) {
						$('#companyFormName').val(response.obj.companyEntity.name);
						$('#companyFormId').val(response.obj.companyEntity.id);
						$('#departmentFormName').val(response.obj.departmentEntity.name);
						$('#departmentFormId').val(response.obj.departmentEntity.id);
					}
				});
			}
		});
		$("#w").window("close");
	});
	//取消
	$("#cancel").click(function() {
		$("#w").window("close");
	});
	//移到右边
	$('#addUser').click(function() {
		//获取选中的选项，删除并追加给对方
		var size = $("#select2 option").size()
		if (size > 0) {
			$.messager.alert('提示', '只能选择一个用户！', 'info');
		} else {
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
		if (size > 0) {
			$.messager.alert('提示', '只能选择一个用户！', 'info');
		} else {
			$("option:selected", this).appendTo('#select2'); //追加给对方
		}

	});
	
	//双击选项
	$('#select2').dblclick(function() {
		$("option:selected", this).appendTo('#select1');
	});
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

