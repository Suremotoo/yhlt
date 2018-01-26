<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<body>
	<div style="width:90%">
		<!-- 	人员选择  dialog-->
		<table width="100%" align="center" border="0" cellpadding="0" style="border-collapse: separate; border-spacing: 5px;" cellspacing="0">
			<tr>
				<td colspan="1">
					类型:<select name = "type" id ="supplierTypeId" style="width: 350px; font-size: 14px;"></select>
				</td>
				<td></td>
				<td>机构:<select  name="language" id="company" style="width: 350px; font-size: 14px;" contenteditable="false"></select></td>
				
			</tr>
			<tr>
				<td>
					一级:<select id="firstCata" name="firstCata" style="width: 350px; font-size: 14px;"></select>
					
				</td>
				<td></td>
				<td>二级:<select id="secondCata" name="secondCata" style="width: 350px; font-size: 14px;"></select></td>
			</tr>
			<tr>
				<td colspan="2">
					搜索:<input class="easyui-textbox"  id="searchBox" style="width: 350px;font-size: 14px;"></input>
				</td>
				<td colspan="1">
					<button id="searchButton" class="easyui-linkbutton" plain="false">查询</button>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					个数:<input class="easyui-textbox"  id="searchNums" style="width: 350px;font-size: 14px;" prompt="请输入随机抽取个数，默认为3"></input>
				</td>
				<td colspan="1">
					<button id="searchButtonRand" class="easyui-linkbutton" plain="false">随机抽取</button>
				</td>
			</tr>
			<tr>
				<td style="width: 251.8px">待选供应商：</td>
				<td style="width: 18px;"></td>
				<td style="width: 251.8px">已选供应商：</td>
			</tr>
			<tr>
				<td style="width: 181.8px">
					<select multiple="multiple" id="select1" style="width: 390px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;"></select>
				</td>
				<td style="width: 27px;">
					<button href="#" id="add_right" class="easyui-linkbutton">&gt;&nbsp;&nbsp;</button><br/><br/> 
					<button href="#" id="remove_left" class="easyui-linkbutton">&lt;&nbsp;&nbsp;</button><br/><br/> 
					<button href="#" id="add_all" class="easyui-linkbutton">&gt;&gt;</button><br/><br/>
					<button href="#" id="remove_all" class="easyui-linkbutton">&lt;&lt;</button><br/>
				</td>
				<td style="width: 181.8px">
					<select multiple="multiple" id="select2" style="width: 390px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;"></select>
				</td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: right;"><br/>
					<button id="rySubmit" class="easyui-linkbutton" plain="false">确定</button>&nbsp;&nbsp;
					<button id="cancel" class="easyui-linkbutton" plain="false" onclick="window.close();">取消</button>
				</td>
			</tr>
		</table>
	</div>
<script type="text/javascript">
	//确定按钮
	$("#rySubmit").click(function() {
		var param={};
		var i='${data}';
		var a = [];
		$("#select2 option").each(function(i, d) {
			a.push(d.value);
		});
		param["ids"]=a;
		param["data"]=i;
		param["type"]='supplier';
		if(a.length){
            //调用父页面方法
            CallOpenerMethod(param)
		}
	});
	//移到右边
	$('#add_right').click(function() {
		//获取选中的选项，删除并追加给对方
		$('#select1 option:selected').appendTo('#select2');
	});
	//移到左边
	$('#remove_left').click(function() {
		$('#select2 option:selected').appendTo('#select1');
	});
	//全部移到右边
	$('#add_all').click(function() {
		//获取全部的选项,删除并追加给对方
		$('#select1 option').appendTo('#select2');
	});
	//全部移到左边
	$('#remove_all').click(function() {
		$('#select2 option').appendTo('#select1');
	});
	//双击选项
	$('#select1').dblclick(function() { //绑定双击事件
		//获取全部的选项,删除并追加给对方
		$("option:selected", this).appendTo('#select2'); //追加给对方
	});
	//双击选项
	$('#select2').dblclick(function() {
		$("option:selected", this).appendTo('#select1');
	});

	 var comanyCombo=$('#company').combobox({
		valueField:'id',
		textField:'name',
		onLoadSuccess:function(){
			var datas = comanyCombo.combobox("getValues");
			if(datas){
				comanyCombo.combobox('select',${_user.companyEntity.id});
			}
		}
		});
	//一级分类_下拉列表框
	var firstCata=$("#firstCata").combobox({
		valueField:'id',
		textField:'name',
		selectOnNavigation:true,
		onSelect:function(rec){
			secondCata.combobox("clear");
			var url= "${dynamicURL}/adminsupplier/category/search?search_EQ_parentId="+rec.id
			secondCata.combobox("reload",url);
		},onLoadSuccess:function(){
			secondCata.combobox("clear");	//一级分类加载完成，清空二级分类
		}
	});
	//二级分类_下拉列表框
	var secondCata = $("#secondCata").combobox({
		valueField:'id',
		textField:'name',
	});
	//类型下拉框
	var supplierTypeId = $("#supplierTypeId").combobox({
		url:"${dynamicURL}/system/dict/combobox?type=CATEGORY_TYPE",
		valueField:'id',
		textField:'name',
		onLoadSuccess:function(){
			var data = $('#supplierTypeId').combobox('getData');	//默认选取第一个类型
			if (data.length > 0) {
				$('#supplierTypeId').combobox('select', data[0].id);
			}
			var url= "${dynamicURL}/adminsupplier/category/search?search_EQ_parentId=0&search_EQ_typeEntity.id="+data[0].id;//加载完成，级联加载一级分类框
			firstCata.combobox("clear");
			firstCata.combobox("reload",url);
			var companyUrl = "${dynamicURL}/system/company/permission/companyPermission?typeId="+data[0].id;	//级联加载公司选择框
			comanyCombo.combobox("reload",companyUrl);
		},
		onSelect:function(record){
			var url= "${dynamicURL}/adminsupplier/category/search?search_EQ_parentId=0&search_EQ_typeEntity.id="+record.id;	//触发onselect 事件时，清除 一级分类、二级分类、机构
			firstCata.combobox("clear");
			secondCata.combobox("clear");
			firstCata.combobox("reload",url);
			var companyUrl = "${dynamicURL}/system/company/permission/companyPermission?typeId="+record.id;
			comanyCombo.combobox("clear");
			comanyCombo.combobox("reload",companyUrl);//重新加载公司下拉
		}
	})
      	 //查询按钮
    $("#searchButton").click(function() {
			appendSupplier();
	}); 
	//查询提取方法
	function appendSupplier(){
		var c= comanyCombo.combotree("getValue");
		var firstCata= $("#firstCata").combobox("getValue");
		var secondCata= $("#secondCata").combobox("getValue");
		var str = $("#searchBox").val();
		var typeId = $("#supplierTypeId").combobox("getValue");
		$.post('${dynamicURL}/notice/bid/chooseSupplier/chooseSupplier',
			{
			"search_catagoryTwoId":secondCata,
			"search_catagoryOneId":firstCata,
			"search_companyId":c,
			"search_companyName":str,
			"search_typeId":$("#supplierTypeId").combobox("getValue")
			},
			function(data){
			$("#select1").empty();
			$.each(data,function(index,content){
					$("#select1").append("<option value='"+content.id+"'>"+content.companyName+"</option>");
		 	});
		},'json');
	}
	
	//随机提取方法
	function appendSupplierRand(){
		var c= comanyCombo.combotree("getValue");
		var firstCata= $("#firstCata").combobox("getValue");
		var secondCata= $("#secondCata").combobox("getValue");
		var str = $("#searchBox").val();
		var typeId = $("#supplierTypeId").combobox("getValue");
		$.post('${dynamicURL}/notice/bid/chooseSupplier/chooseRandSupplier',
			{
			"search_catagoryTwoId":secondCata,
			"search_catagoryOneId":firstCata,
			"search_companyId":c,
			"search_companyName":str,
			"search_typeId":$("#supplierTypeId").combobox("getValue"),
			"nums":$("#searchNums").val()
			},
			function(data){
			$("#select2").empty();
			$.each(data,function(index,content){
				$("#select2").append("<option value='"+content.id+"'>"+content.companyName+"</option>");
		 	});
		},'json');
	}
	
	$("#searchButtonRand").click(function(){
		appendSupplierRand();
	})
	
</script>
</body>
</html>