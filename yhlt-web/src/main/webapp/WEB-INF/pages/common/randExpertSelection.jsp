<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<body>
	<div style="width:450px">
		<!-- 	人员选择  dialog-->
		<table width="100%" align="center" border="0" cellpadding="0" style="border-collapse: separate; border-spacing: 5px;" cellspacing="0">
			<tr>
				<td colspan="2">
					分类：<select  name="language" id="company" style="width: 300px; font-size: 14px;" contenteditable="false"></select> 
				</td>
				<td colspan="1">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					个数：<input class="easyui-textbox"  id="searchNums" style="width: 300px;font-size: 14px;" prompt="请输入随机抽取个数，默认为3"></input>
				</td>
					<td colspan="1">
					<button id="searchButton" class="easyui-linkbutton" plain="false">随机选取</button>
				</td>
			</tr>
			<tr>
				<td colspan="3">已选人员：</td>
			</tr>
			<tr>
				<td colspan="3">
					<select multiple="multiple" id="select1" style="width: 420px; height: 254.5px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;"></select>
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
		$("#select1 option").each(function(i, d) {
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
	 var comanyCombo=$('#company').combobox({
		   panelWidth: 250,
		   panelHeight : 400,
		   valueField: 'id',
		   textField: 'name',
		   url: '${dynamicURL}/expert/expertType/search',
		   onLoadSuccess:function(){
			   var data = $('#company').combobox('getData');	//默认选取第一个类型
				if (data.length > 0) {
					$('#company').combobox('select', data[0].id);
				}
		   }
		});
      	 //查询按钮
    $("#searchButton").click(function() {
			$.post('${dynamicURL}/expert/expertTypeUser/randExpert',{"nums":$("#searchNums").val(),"typeId":comanyCombo.combobox("getValue")},function(data){
				$("#select1").empty();
				$.each(data,function(index,content){
						$("#select1").append("<option value='"+content.id+"'>"+content.name+"</option>");
			 	});
			},'json');
	}); 
</script>
</body>
</html>