<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
        <div region="north" border="false">
            <div id="queryHeader" style="padding: 10px; width: 100%; line-height: 40px;" class="easyui-panel">
            	<form class="form-horizontal" for="dictDatagrid">
            		<table style="width: 600px; line-height: 40px;">
	                    <tr>
	                        <td>名称:</td>
	                        <td>
	                            <input class="easyui-textbox" type="text" name="search_LIKE_name" style="width: 150px; height: 26px">
	                        </td>
	                        <td>
	                            <div class="BtnLine" style="border: 0px; margin: 0px; padding: 0px;text-align:left">
	                                <button type="button" class="easyui-linkbutton queryBtn" iconcls="icon-search" >搜索</button>
	                                <button type="button" class="easyui-linkbutton clearBtn" iconcls="icon-reload" >重置</button>
	                            </div>
	                        </td>
	                    </tr>
	                </table>
            	</form>
            </div>
            <div class="BtnLine btnBox tl" style="border-top:solid 1px #ddd;width:100%;">
             	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" group="">新增</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" group="">修改</button>
             	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="del()" type="button" iconcls="icon-delete" group="">删除</button>
            </div>
        </div>
        <div region="center" border="false">
            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
                <table id="dictDatagrid"></table>
            </div>
        </div>
    </div>
</div>

<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增" style="width: 620px; height: 190px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/system/dict/save" method="post">
    	<table class="table_edit">
	        <tr>
	            <td class="text_tr" style="width: 30%;">已选附件列表：</td>
	            <td>
	            	<div id="fileQueue" style="width: 100%"></div>
	            </td>
	        </tr>
	        <tr>
	        	<td class="text_tr" style="width: 30%;">附件上传：</td>
        	    <td>
	            	<div id="uploadify" style="width: 100%"></div>
	            </td>
	        </tr>
	    </table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton stop" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
<script type="text/javascript">
	//分页
	var datagrid;
	$(function () {
		/*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
        datagrid = $('#dictDatagrid').datagrid({
			url: '${dynamicURL}/system/file/list',
			queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
			fit:true,
			fitcolumns: true,
			pagination : true,
			rownumbers : true,
			lines:true,
			idField : 'id',
			columns: [ [
					{field: 'id', checkbox: true,width:50},
					{field: 'contentType', title: '类型',width:50},
					{field: 'module', title: '模块',width:100},
					{field: 'fileName', title: '文件名',width:400},
					{field: 'convertFileSize', title: '文件大小',align: 'right',width:100},
					{field: 'gmtCreate', title: '上传时间',align: 'center',width:200},
					{field: 'downloadUrl',title: '操作',align: 'center',width:50, 
						formatter: function (value, rec)
						{ return '<a name="download" href="#" onclick="fileDownload('+rec.id+')"></a>';}
					}
				]
			],
			onLoadSuccess:function(data){
            	$("a[name='download']").linkbutton({ plain:true, iconCls:'icon-download' });
            }
        });
        $("#uploadify").uploadify({
      	  	method: 'post',//默认post，可以改为get
            swf: '${staticURL}/uploadify/uploadify.swf?ver=' + Math.random(),
            uploader: '${dynamicURL}/system/file/upload',//后台处理的路径
            fileObjName: 'file',//文件对象名称,用于在服务器端获取文件
            formData: { 'module': 'system'},//指定上传文件附带的其他数据
            buttonText: '请选择您要上传的文件(可以选择多个文件)',//按钮上显示的文字，默认”SELECT FILES”
            height: 25,//显示的高度,默认 30
            width: '100%',//显示的高度,默认129
            //fileTypeDesc: 'Image Files',//文件类型的说明
            fileSizeLimit: '20MB',//上传单文件大小限制
            //fileTypeExts: '*.gif; *.jpg; *.png',//指定允许上传的文件类型。默认 *.*
            queueSizeLimit : 5, //队列中同时存在的文件个数限制  
            queueID: 'fileQueue',//文件队列DIV,默认自动生成
            auto: false,//表示在选择文件后是否自动上传，默认true
            multi: true,//是否支持多文件上传，默认为true 
//             overrideEvents : ['onDialogClose','onUploadError', 'onSelectError'],
//             onSelectError : uploadify_onSelectError,
//             onUploadError : uploadify_onUploadError,
            onUploadSuccess : function(file, data, response) { 
              // alert(response);
            },
            onQueueComplete: function (queueData) {
          	  	datagrid.datagrid("reload");
            }
        });
		$("form[for] button.queryBtn").on("click.datagrid-query", function () {
			top._search($(this).parents("form[for]"));
		});
		$("form[for] button.clearBtn").on("click.datagrid-query", function () {
			top._clearSearch($(this).parents("form"));
        });
	})
    function add() {
		$("#addWindow form.addForm").form("clear");
		$("#addWindow").dialog("open");
    }
	 //初始化form表单
    $("#addWindow form.addForm").form({
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
                $('#addWindow').dialog('close');
                dictDatagrid.datagrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
    $("#addWindow .BtnLine .submit").on("click",
 		_.debounce(function() {
 			$('#uploadify').uploadify('upload',"*");
       	},waitTime,true)
    );
    
    $("#addWindow .BtnLine #stop").on("click",function(){
    	$('#uploadify').uploadify('stop');
    });
    
    //删除
    function del(){
    	 top._del(datagrid, {delUrl: "${dynamicURL}/system/file/batchDelete"});
    }
	

    function fileDownload(id){
		$.ajax({
		   type: "post",
		   dataType:"json",
		   url: "${dynamicURL}/system/file/check",
		   data: "id="+id,
		   success: function(data){
			   if(data.success){
					location.href="${dynamicURL}/system/file/download?id="+id;
			   }else{
				$.messager.alert('提示', "文件不存在！", 'info');
			   }
		   }
		});	
    }
    
</script>

