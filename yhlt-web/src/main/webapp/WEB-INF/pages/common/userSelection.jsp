<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<body>
	<div style="width:450px">
		<!-- 	人员选择  dialog-->
		<table width="100%" align="center" border="0" cellpadding="0" style="border-collapse: separate; border-spacing: 5px;" cellspacing="0">
			<tr>
				<td colspan="3">
					机构：<select  name="language" id="company" style="width: 136.3px; font-size: 14px;" contenteditable="false"></select> 
					部门：<select name="language" id="dept" style="width: 136.3px; font-size: 14px;" contenteditable="false"></select>
				</td>
			</tr>
			<tr>
				<td colspan="1">
					搜索：<input class="easyui-textbox"  id="searchBox" style="width: 136.3px"></input>
				</td>
				<td colspan="2">
					<button id="searchButton" class="easyui-linkbutton" plain="false">查询</button>
				</td>
			</tr>
			<tr>
				<td style="width: 181.8px">待选人员：</td>
				<td style="width: 18px;"></td>
				<td style="width: 181.8px">已选人员：</td>
			</tr>
			<tr>
				<td style="width: 181.8px">
					<select multiple="multiple" id="select1" style="width: 181.8px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;"></select>
				</td>
				<td style="width: 27px;">
					<button href="#" id="add_right" class="easyui-linkbutton">&gt;&nbsp;&nbsp;</button><br/><br/> 
					<button href="#" id="remove_left" class="easyui-linkbutton">&lt;&nbsp;&nbsp;</button><br/><br/> 
					<button href="#" id="add_all" class="easyui-linkbutton">&gt;&gt;</button><br/><br/>
					<button href="#" id="remove_all" class="easyui-linkbutton">&lt;&lt;</button><br/>
				</td>
				<td style="width: 181.8px">
					<select multiple="multiple" id="select2" style="width: 181.8px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;"></select>
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
		param["type"]='user';
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
	 var comanyCombo=$('#company').combotree({
		   panelWidth: 250,
		   panelHeight : 400,
		   idField: 'id',
		   nameField: 'name',
		   url: '${dynamicURL}/system/company/combotree?search_EQ_parentId=0',
		   onChange:function(newValue, oldValue){
		   		//级联加载
				$.get('${dynamicURL}/system/department/combotree',{'search_EQ_companyEntity.id':newValue},function(data){
					depCombo.combotree("clear").combotree('loadData',data);
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
      	 var depCombo = $('#dept').combotree({
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
      	 //查询按钮
    $("#searchButton").click(function() {
		var searchText = $('#searchBox').val();
		if(!searchText){
		}else{
			var c= comanyCombo.combotree("getValue");
			var d= depCombo.combotree("getValue");
			$.get('${dynamicURL}/system/user/search',{"search_EQ_companyEntity.id":c,"search_EQ_departmentEntity.id":d,"search_LIKE_name":searchText},function(data){
				$("#select1").empty();
				$.each(data,function(index,content){
						$("#select1").append("<option value='"+content.id+"'>"+content.name+"</option>");
			 	});
			},'json');
		}
	}); 
</script>
</body>
</html>