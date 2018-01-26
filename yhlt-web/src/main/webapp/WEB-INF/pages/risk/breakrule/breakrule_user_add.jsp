<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="/tld/security.tld"%>
<style type="text/css">
	#descript-wrap div{
		float: left;
	}
	#descript-wrap #descript-title{
		margin:0 5%;
	}
	#descript-wrap #descript-content{
	 width:80%;
	 margin: 0 auto;
	}
</style>
<div id="addWindow">
	<form action="${dynamicURL}/risk/breakrule/save" method="post" class="editInfoFrm">
		<div title="违规检查单信息" style="padding: 20px; height: 680px;">
			<div style="padding: 5px;" class="easyui-panel">
			<!-- 违规人信息 -->
				<div style="padding: 5px; width: 98%; height: auto"
					class="easyui-panel" id="no1" title="违规人信息">
					<hr style="width: 91%; border: 0.5px solid #c6c6c6; float: left;" />
					<table class="conDetailTable" style="margin:0 10%">
						<tr>
							<td width="15%" class="tr">违规人名：&nbsp;&nbsp;</td>
							<td width="35%">
								<input class="text" type="text" readonly="readonly" onclick="editUser(1)" name="userName"
									style="width: 270px; height: 26px" placeholder="点击选择违规人" data-options="required:true"/>
								<input type="hidden" name="userId"> 
								<input type="hidden" name="editUserFlag">
							</td>
						</tr>
						<tr>
							<td width="15%" class="tr">公司名：&nbsp;&nbsp;</td>
							<td width="35%"><input name="companyName" readonly="readonly" id="companyFormName"
								style="width: 270px; height: 26px;background-color: #ccc" />
							</td>
						</tr>
						<tr>
							<td width="15%" class="tr">部门(单位)：&nbsp;&nbsp;</td>
							<td width="35%"><input name="departmentName" readonly="readonly" id="departmentFormName"
								style="width: 270px; height: 26px;background-color: #ccc"  />
							</td>
						</tr>
						<tr>
							<td width="15%" class="tr">通行证号：&nbsp;&nbsp;</td>
							<td width="35%">
							<input name="code" readonly="readonly" id="userCode" style="width: 270px; height: 26px;background-color: #ccc"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 违规违章内容 -->
				<div style="padding: 5px; width: 98%; height: auto"
					class="easyui-panel" id="no1" title="违规违章内容">
					<hr style="width: 91%; border: 0.5px solid #c6c6c6; float: left;" />
					<table class="conDetailTable" style="margin:0 10%" >
						<tr>
							<td width="15%" class="tr">违规时间：&nbsp;&nbsp;</td>
							<td width="35%">
							<input name="breakruleDatetime" type="text" class="form-control easyui-datetimebox"
								style="width: 270px; height: 26px" data-options="required:true" />
							</td>
						</tr>
						<tr>
							<td width="15%" class="tr">违规地点：&nbsp;&nbsp;</td>
							<td width="35%"><input name="location" style="width: 270px; height: 26px" data-options="required:true" />
							</td>
						</tr>
						<tr>
							<td width="15%" class="tr">有无后果：&nbsp;&nbsp;</td>
							<td width="35%">
								<select name="riskStatus" class="easyui-validatebox" id="typeFormId" style="width: 270px; height: 26px;" data-options="required:true">
									<option value="0">无</option>
									<option value="1">有</option>
								</select>
							</td>
						</tr>
					</table>
				</div>
				<!-- 违规违章惩罚 -->
				<div style="padding: 5px; width: 98%; height: auto"
					class="easyui-panel" id="no1" title="违规违章惩罚">
					<hr style="width: 91%; border: 0.5px solid #c6c6c6; float: left;" />
					<table class="conDetailTable" style="margin:0 10%">
						<tr>
							<td width="15%" class="tr">通行证扣分：&nbsp;&nbsp;</td>
							<td width="35%">
							<select name="breakruleScore" style="width: 270px; height: 26px" data-options="required:true">
								<option value="0.5">0.5</option>
								<option value="1">1</option>
								<option value="1.5">1.5</option>
								<option value="2">2</option>
								<option value="2.5">2.5</option>
								<option value="3">3</option>
								<option value="3.5">3.5</option>
								<option value="4">4</option>
								<option value="4.5">4.5</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
							</select>
							</td>
						</tr>
						<tr>
							<td width="15%" class="tr">扣分依据：&nbsp;&nbsp;</td>
							<td width="35%"><input name="breakruleInfo" style="width: 270px; height: 26px" data-options="required:true" />
							</td>
						</tr>
						<tr>
					</table>
					<div id="descript-wrap">
						<div id="descript-title">违规违章描述：</div>
	        			<div id="descript-content">
	        					<textarea id="remarkFormId" name="remark" class="form-control" style="width: 1000px; height: 400px"></textarea>
	        			</div>
	        		</div>
				</div>
			</div>
			<div class="BtnLine">
				<security:ifAny authorization="用户管理_管理员">
					<button type="button" class="easyui-linkbutton submit">保存</button>
				</security:ifAny>
				<button type="button" class="easyui-linkbutton"
					onClick="window.parent.parent.reLoad('添加违规检查单');">关闭</button>
			</div>
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
//添加违规信息描述文本输入框
CKEDITOR.replace('remarkFormId', {
	height : 200,
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
	
	//初始化form表单
    $("#addWindow form.editInfoFrm").form({
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
            if(data.success){
            	$.messager.alert('提示', data.msg,'info');
	        }else{
	        	$.messager.alert('提示', data.msg,'error');
	        }
        }
    });
// 提交
	$("#addWindow .BtnLine .submit").on("click", _.debounce(function() {
			$("#addWindow form.editInfoFrm").submit();
	}, waitTime, true));

//人员选择
//确定按钮
$("#rySubmit").click(function() {
	var flag = $("input[name='editUserFlag']").val();
	$("#select2 option").each(function(i, d) {
		if (flag == 1) {
			$("input[name='userName']").val($(d).text());
			$("input[name='userId']").val($(d).val());
			$.ajax({
				url : "${dynamicURL}/system/user/detail",
				data : {
					id : $(d).val()
				},
				dataType : "json",
				success : function(response) {
					$('#userCode').val(response.obj.cardNo);
					$('#companyFormName').val(response.obj.companyEntity.name);
					$('#departmentFormName').val(response.obj.departmentEntity.name);
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