<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>


<div class="easyui-layout layout-custom-resize" data-options="fit:true">
	<div data-options="region:'west',split:false,collapsible:false" style="width: 230px;overflow: scroll;">
		<table id="fileTypeTreegrid"></table>
	</div>
	<div data-options="region:'center',split:false,collapsible:false" style="width: 400px;">
		<div class="easyui-layout layout" fit="true">
		    <div id="container" class="easyui-layout layout" fit="true">
		        <div region="north" border="false">
		            <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
			        	<form class="form-horizontal" for="fileInfoDatagrid">
					<table style="width: 800px; line-height: 40px;">
						<tr>
							<td>文件名称:</td>
							<td><input class="easyui-textbox" type="text"
								name="search_LIKE_fileName" style="width: 150px; height: 26px">
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
					<div class="BtnLine btnBox tl"
						style="border-top: solid 1px #ddd; width: 100%;">
						<button class="easyui-linkbutton l-btn l-btn-small" id="add"
							onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
						<!-- <button class="easyui-linkbutton l-btn l-btn-small" id="edit"
							onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button> -->
						<button class="easyui-linkbutton l-btn l-btn-small" id="edit"
							onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
					</div>
		        </div>
		        <div region="center" border="false">
		            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
		                <table id="fileInfoDatagrid"></table>
		            </div>
		        </div>
		    </div>
		</div>	
	</div>
</div>
<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增"
	style="width: 620px; height: 220px;" modal="true" closed="true">
	<form class="addForm" action="${dynamicURL}/file/upload"
		method="post" enctype="multipart/form-data">
		<input type="hidden" name="id" />
		<table class="table_edit">
			<tr>
				<td width="15%" class="tr">文件类型：&nbsp;&nbsp;</td>
				<td width="35%"><select id="fileTypeComboTree" name="typeId" style="width: 180px; height: 26px" data-options="required:true"></select></td>
			</tr>
				<tr>
				<td width="15%" class="tr">文件标题：&nbsp;&nbsp;</td>
				<td width="35%">
					<input name="title" id="titleFormId" style="width: 270px; height: 26px;"/>
				</td>
			</tr>
			<tr>
				<td width="15%" class="tr">附件上传：&nbsp;&nbsp;</td>
				<td width="35%">
					<input type="file" name="file" onchange="setTitleInfo(this)" style="width: 180px; height: 26px"/>
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

<script type="text/javascript">
	var fileTypeComboTree;
	var fileInfoDatagrid;
	
	$(function () {
		fileTypeComboTree = $('#fileTypeComboTree').combotree({
		 	idField:'id',
		    nameField:'name',
            url: '${dynamicURL}/file/fileType/combotree?search_EQ_parentId=0',
            onLoadSuccess: function (node, data) {
            	var data=$("#fileTypeComboTree").combotree('tree').tree("getRoot");
            	$("#fileTypeComboTree").combotree('setValue',data.id);
            }
        });
 		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		fileTypeTreegrid = $('#fileTypeTreegrid').treegrid({
	   		url: '${dynamicURL}/file/fileType/treegrid?search_EQ_parentId=0',
			pagination: false,
// 			rownumbers : true,
			fit:false,
			fitColumns:true,
			treeField: 'name',
			idField: 'id',
			columns: [
			    [
// 			        {field: 'id', checkbox: true},
			        {field: 'name', title: '名称',width:200, sortable: true,align:'left'},
			    ]
			],
            onSelect:function(rowIndex, rowData){
				fileInfoDatagrid.datagrid("load", {'search_EQ_typeId' : rowIndex.id});
            },
            onLoadSuccess: function () {
				fileTypeTreegrid.treegrid('collapseAll')
			}
		});
 		
 		// 文件列表
		fileInfoDatagrid = $('#fileInfoDatagrid').datagrid({
			url : '${dynamicURL}/file/list',
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
				{field: 'typeName',title: '文件类型',width: 150,sortable: true},
				{field: 'title',title: '文件标题',width: 150,sortable: true},
				{field: 'fileName',title: '文件名称',width: 150,sortable: true},
				{field: 'convertFileSize',title: '文件大小',width: 150,sortable: true},
				{field: 'gmtCreateUserName',title: '创建人',width: 150,sortable: true},
				{field: 'gmtCreate',title: '创建日期',width: 150,sortable: true},
				{field: 'downloadUrl',title: '操作',align: 'center',width:50,sortable: true, 
					formatter: function (value, rec)
					{ return '<a name="download" href="#" onclick="fileDownload('+rec.id+')"></a>';}
				}
			] ],
			onLoadSuccess:function(data){
            	$("a[name='download']").linkbutton({ plain:true, iconCls:'icon-download' });
            },
            
			onClickRow : function(rowIndex, rowData) {
				//加载完毕后获取所有的checkbox遍历
				var radio1 = $("input[type='radio']")[rowIndex].disabled;
				//如果当前的单选框不可选，则不让其选中
				if (radio1 != true) {
					//让点击的行单选按钮选中
					$("input[type='radio']")[rowIndex].checked = true;
					return false;
				} else {
					$("#fileInfoDatagrid").datagrid("clearSelections");
					$("input[type='radio']")[rowIndex].checked = false;
					return false;
				}
			},
			onDblClickRow : function(index) {
				//edit();
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
				fileInfoDatagrid.datagrid('reload');
			} else {
				$.messager.alert('提示', data.msg, 'error');
			}
		}
	});
	$("#addWindow .BtnLine .submit").on("click", _.debounce(function() {
		$("#addWindow form.addForm").submit();
	}, waitTime, true));
	
	//修改
	function edit() {
		var row = fileInfoDatagrid.datagrid("getSelected");
		if (row) {
			var form = $("#addWindow form.addForm");
			form.form("clear");
			$.ajax({
				url : "${dynamicURL}/file/detail",
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
		top._del(fileInfoDatagrid, {
			delUrl : "${dynamicURL}/file/delete"
		});
	}
	
	// 获取文件名
	function setTitleInfo(obj){
		var filePath=$(obj).val();
        var arr=filePath.split('\\');
        var fileName=arr[arr.length-1];
        var name = fileName.substr(0,fileName.lastIndexOf('.'));
		$("#titleFormId").val(name);
	}
	
	// 下载
    function fileDownload(id){
		$.ajax({
		   type: "post",
		   dataType:"json",
		   url: "${dynamicURL}/file/check",
		   data: "id="+id,
		   success: function(data){
			   if(data.success){
					location.href="${dynamicURL}/file/download?id="+id;
			   }else{
				$.messager.alert('提示', "文件不存在！", 'info');
			   }
		   }
		});	
    }


</script>

