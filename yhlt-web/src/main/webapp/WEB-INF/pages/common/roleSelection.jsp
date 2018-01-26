<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title></title>

</head>
<body>
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
			param["type"]='role';
			if(a.length){
				$.ajax({
					url:'${dynamicURL}/datapermissionRuleUser/save1',
					data:$.param(param,true),
					type:'POST',
					success:function(msg){
						$.messager.alert("提示","保存成功！");
					},
					error:function(msg){
						$.messager.alert("提示","保存失败！");
					}
				});
			}
		});
		//移到右边
		$('#add').click(function() {
			//获取选中的选项，删除并追加给对方
			$('#select1 option:selected').appendTo('#select2');
		});
		//移到左边
		$('#remove').click(function() {
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
            lines : true,
            panelHeight : 400,
            //下面这两个字段需要视情况修改
            idField: 'id',
            textFiled: 'name',
            parentField:'parentId',
            url: '${dynamicURL}/system/company/combotree',
            onChange:function(newValue, oldValue){
            	//角色加载
    			$.get('${dynamicURL}/system/role/search',{'search_EQ_companyId':newValue},function(data){
    				$("#select1").empty();
    				$.each(eval(data),function(i,d){
							$("#select1").append("<option value='"+d.id+"'>"+d.name+"</option>");
    				});
    			},'json');
    		}
            //数据较多时打开下面两个属性分页 和 特殊属性prevQuery（不好描述）
            //pagination : true,
            //prevQuery:{},
           
         });
       	 //查询按钮
       	$("#searchButton").click(function() {
			var searchText = $('#searchBox').val();
			if(!searchText){
			}else{
				var v= comanyCombo.combotree("getValue");
				$.get('${dynamicURL}/system/role/search',{"search_EQ_companyId":v,"search_LIKE_name":searchText},function(data){
					$("#select1").empty();
					$.each(data,function(index,content){
							$("#select1").append("<option value='"+content.id+"'>"+content.name+"</option>");
				 	});
				},'json');
			}
		}); 
	</script>
		<table width="100%" align="center" border="0" cellpadding="0"
			style="border-collapse: separate; border-spacing: 5px;"
			cellspacing="0">
			<tr>
				<td colspan="3">机构：<select
					name="language" id="company" style="width: 150px; font-size: 14px;"
					contenteditable="false"></select>
				</td>
			</tr>
			<tr>
				<td colspan="1">搜索：<input class="easyui-textbox" id="searchBox"
					style="width: 150px"></input></td>
				<td colspan="2">
					<a id="searchButton" class="easyui-linkbutton" plain="false">查询</a>
				</td>
			</tr>
			<tr>
				<td style="width: 200px">待选角色：</td>
				<td style="width: 20px;"></td>
				<td style="width: 200px">已选角色：</td>
			</tr>
			<tr>
				<td style="width: 200px"><select multiple="multiple"
					id="select1"
					style="width: 200px; height: 280px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;">
				</select></td>
				<td style="width: 30px;"><a href="#" id="add"
					class="easyui-linkbutton">&gt;&nbsp;&nbsp;</a><br /> <br /> <a
					href="#" id="remove" class="easyui-linkbutton">&lt;&nbsp;&nbsp;</a><br />
					<br /> <a href="#" id="add_all" class="easyui-linkbutton">&gt;&gt;</a><br />
					<br /> <a href="#" id="remove_all" class="easyui-linkbutton">&lt;&lt;</a><br />
				</td>
				<td style="width: 200px"><select multiple="multiple"
					id="select2"
					style="width: 200px; height: 280px; border: 2px #95B8E7 outset; padding: 10px; font-size: 14px;">
				</select></td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: right;"><br> <br>
					<a id="rySubmit" class="easyui-linkbutton" plain="false">确定</a>&nbsp;&nbsp;<a
					class="easyui-linkbutton" plain="false" onclick="window.close();">取消</a></td>
			</tr>
		</table>
</body>
</html>