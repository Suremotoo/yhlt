<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="easyui-layout layout" fit="true">
	<div id="container" class="easyui-layout layout" fit="true">
		<div region="north" border="false">
			<div id="queryHeader"
				style="padding: 10px; width: 100%; line-height: 40px;"
				class="easyui-panel">
				<form class="form-horizontal" for="breakruleDatagrid">
					<table style="width: 800px; line-height: 40px;">
						<tr>
							<td>名称:</td>
							<td><input class="easyui-textbox" type="text"
								name="search_LIKE_userName" style="width: 150px; height: 26px">
							</td>
							<td>通行证编号:</td>
							<td><input class="easyui-textbox" type="text"
								name="search_LIKE_code" style="width: 150px; height: 26px">
							</td>
							<td>
								<div class="BtnLine"
									style="border: 0px; margin: 0px; padding: 0px; text-align: left">
									<button type="button" class="easyui-linkbutton queryBtn" iconcls="icon-search">搜索</button>
									<button type="button" class="easyui-linkbutton clearBtn" iconcls="icon-reload">重置</button>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="BtnLine btnBox tl"
				style="border-top: solid 1px #ddd; width: 100%;">
				<button class="easyui-linkbutton l-btn l-btn-small" id="add"
					onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
				<button class="easyui-linkbutton l-btn l-btn-small" id="edit"
					onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
			</div>
		</div>
		<div region="center" border="false">
			<div style="padding: 5px; width: 100%;" class="easyui-layout layout"
				fit="true">
				<table id="breakruleDatagrid"></table>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	//分页
	var breakruleDatagrid;
	$(function() {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		breakruleDatagrid = $('#breakruleDatagrid').datagrid({
			url : '${dynamicURL}/risk/breakrule/list',
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
				{field: 'code',title: '通行证编号',width: 200,sortable: true}, 
				{field: 'companyName',title: '公司',width: 200,sortable: true}, 
				{field: 'departmentName',title: '部门',width: 200,sortable: true},
				{field: 'userName',title: '当事人姓名',width: 200,sortable: true}, 
				{field: 'riskStatusWrapper',title: '有无后果',width: 200,sortable: true}, 
				{field: 'breakruleDatetime',title: '违章时间',width: 200,sortable: true}, 
				{field: 'location',title: '违章地点',width: 200,sortable: true}, 
				{field: 'breakruleScore',title: '通行证扣分',width: 200,sortable: true}, 
				{field: 'breakruleInfo',title: '扣分依据',width: 200,sortable: true}, 
				{field: 'remark',title: '违规违章描述',width: 200,sortable: true}, 
				{field: 'gmtCreate',title: '创建时间',width: 200,sortable: true},
				{field: 'gmtCreateUserName',title: '创建人姓名',width: 200,sortable: true}
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
					$("#breakruleDatagrid").datagrid("clearSelections");
					$("input[type='radio']")[rowIndex].checked = false;
					return false;
				}
			 }
			});

		$("form[for] button.queryBtn").on("click.datagrid-query", function() {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function() {
			top._clearSearch($(this).parents("form"));
		});
	})
	
	// 新增
	function add() {
		window.parent.openT('添加违规检查单', '${dynamicURL}/risk/breakrule/toAddPage','0','300','300');
	}
	//删除
	function del() {
		top._del(breakruleDatagrid, {
			delUrl : "${dynamicURL}/risk/breakrule/delete"
		});
	}
</script>

