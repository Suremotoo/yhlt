<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="/tld/security.tld" %>
<div class="easyui-layout layout" fit="true">
	<div id="container" class="easyui-layout layout" fit="true">
		<div region="north" border="false">
			<div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
				<form class="form-horizontal" for="meetingInfoDatagrid">
					<table style="width: 1200px; line-height: 40px;">
						<tr>
							<td>会议主题:</td>
							<td><input class="easyui-textbox" type="text"
								name="search_LIKE_title" style="width: 180px; height: 26px">
							</td>
							<td>会议类型:</td>
							<td>
							<select name="search_EQ_type" style="width: 180px; height: 26px">
							  <option value="0">邀请会议</option>
							  <option value="1">自主会议</option>
							</select>
							</td>
							<td>会议纪要状态:</td>
							<td>
							  <select name="search_EQ_status" style="width: 180px; height: 26px">
							    <option value="0">草稿</option>
							    <option value="1">发布</option>
							  </select>
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
			
			<%--   <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
            	<security:ifAny authorization="会议管理_管理员">
	             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
             		<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
             	</security:ifAny>
             	<security:ifAny authorization="会议管理_管理员">
             		<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
             	</security:ifAny>
            </div> --%>
            
            <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
            </div>
		</div>
		<div region="center" border="false">
			<div style="padding: 5px; width: 100%;" class="easyui-layout layout"
				fit="true">
				<table id="meetingInfoDatagrid"></table>
			</div>
		</div>
	</div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增"
	style="width: 620px; height: 450px;" modal="true" closed="true">
	<form class="addForm" action="${dynamicURL}/meeting/info/save"
		method="post">
		<input type="hidden" name="id" id="meetingInfoId" />
		<table class="table_edit">
			<tr>
				<td class="text_tr" style="width: 30%;">会议编号：</td>
				<td>
					<input class="easyui-textbox" type="text" name="uuid"
					id="uuid" style="width: 270px; height: 26px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<td class="text_tr">会议主题：</td>
				<td>
					<input class="easyui-textbox" type="text" name="title"
					style="width: 270px; height: 26px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<td class="text_tr">会议记录人：</td>
				<td>
					<input class="text" type="text" readonly="readonly" onclick="editUser(1)" name="recordUserName"
						style="width: 270px; height: 26px" placeholder="点击选择会议发起人" />
					<input type="hidden" name="userId"> <input type="hidden" name="editUserFlag">
				</td>
			</tr>
			<tr>
				<td class="text_tr">开始时间：</td>
				<td>
					<input name="startDate" id="startFormId" type="text" class="form-control easyui-datetimebox"
						style="width: 270px; height: 26px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<td class="text_tr">结束时间：</td>
				<td>
					<input name="endDate" id="endFormId" type="text" class="form-control easyui-datetimebox"
					style="width: 270px; height: 26px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<td class="text_tr">开会地点：</td>
				<td>
					<input class="easyui-textbox" type="text" name="meetingRoom" style="width: 270px; height: 26px"
					data-options="required:true" />
				</td>
			</tr>
			<tr>
				<td class="text_tr">备注：</td>
				<td>
					<input class="easyui-textbox" type="text" name="remark"
					style="width: 270px; height: 26px"/>
				</td>
			</tr>
			<tr>
				<td class="text_tr">会议状态：</td>
				<td>
					<select name="status" id="statusFormId" style="width: 270px; height: 26px;" data-options="required:true">
						<option value="0">草稿</option>
						<option value="1">发布</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text_tr">会议类型：</td>
				<td>
					<select name="type" class="easyui-validatebox" id="typeFormId" style="width: 270px; height: 26px;" data-options="required:true">
							<option value="0">邀请会议</option>
							<option value="1">自主会议</option>
					</select>
				</td>
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
	//分页
	var meetingInfoDatagrid;
	$(function() {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		meetingInfoDatagrid = $('#meetingInfoDatagrid').datagrid({
							url : '${dynamicURL}/meeting/info/list',
							queryForm : "#queryHeader form",//列筛选时附带加上搜索表单的条件
							fit : true,
						//  fitcolumns: true,
							pagination : true,
							rownumbers : true,
							singleSelect : true,
							lines : true,
							idField : 'id',
							columns : [ [
							        {field : 'id',formatter : function Ra(val, row, index) {
											return '<input type="radio" name="selectRadio" id="selectRadio"' + index + '/>';
										}},
									{field : 'uuid',title : '会议编号',width : 200,sortable : true},
									{field : 'title',title : '主题',width : 200,sortable : true},
									{field : 'recordUserName',title : '会议记录人',width : 200,sortable : true},
									{field : 'startDate',title : '开始时间',width : 200,sortable : true},
									{field : 'endDate',title : '结束时间',width : 200,sortable : true},
									{field : 'meetingRoom',title : '会议地点',width : 200,sortable : true},
									{field : 'statusWrapper',title : '会议纪要状态',width : 200,sortable : true,
										formatter : function(value, row) {
											var color = "green"; //字体颜色
											if(row.status=='0'){
												color="red";
											}
											return "<span style='color:"+color+"'>"+row.statusWrapper+"</span>";
										}
									},
									{field : 'typeWrapper',title : '会议类型',width : 200,sortable : true,
										formatter : function(value, row) {
											var color = "#963"; //字体颜色
											if(row.type=='0'){
												color="blue";
											}
											return "<span style='color:"+color+"'>"+row.typeWrapper+"</span>";
										}
									}, {field : 'remark',title : '备注',width : 200,sortable : true} 
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
									$("#meetingInfoDatagrid").datagrid(
											"clearSelections");
									$("input[type='radio']")[rowIndex].checked = false;
									return false;
								}
							},
							onDblClickRow : function(index) {
								edit();
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
				meetingInfoDatagrid.datagrid('reload');
			} else {
				$.messager.alert('提示', data.msg, 'error');
			}
		}
	});
	// 检查会议的uuid判断是否有重复会议
	$("#addWindow .BtnLine .submit").on("click", _.debounce(function() {
	 	 if ($("#meetingInfoId").val() == null || $("#meetingInfoId").val() == "") {
			$.post('${dynamicURL}/meeting/info/check', {
				'uuid' : $('#uuid').val()
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

	//修改
	function edit() {
		var row = meetingInfoDatagrid.datagrid("getSelected");
		if (row) {
			var form = $("#addWindow form.addForm");
			form.form("clear");
			$.ajax({
				url : "${dynamicURL}/meeting/info/detail",
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
		top._del(meetingInfoDatagrid, {
			delUrl : "${dynamicURL}/meeting/info/delete"
		});
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
depCom = $('#dept').combotree(
			{
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
				$("input[name='recordUserName']").val($(d).text());
				$("input[name='userId']").val($(d).val());
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

