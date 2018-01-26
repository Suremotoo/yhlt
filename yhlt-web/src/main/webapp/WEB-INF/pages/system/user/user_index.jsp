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
			        	<form class="form-horizontal" for="userDatagrid">
			        		<table style="width: 800px; line-height: 40px;">
			                 <tr>
			                     <td>用户名:</td>
			                     <td>
			                         <input class="easyui-textbox" type="text" name="search_LIKE_name" style="width: 150px; height: 26px">
			                     </td>
			                     <td>联系电话:</td>
			                     <td>
			                         <input class="easyui-textbox" type="text" name="search_LIKE_mobile" style="width: 150px; height: 26px">
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
					 <security:ifAny authorization="用户管理_管理员">
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="add" onclick="add()" type="button" iconcls="icon-add" >新增</button>
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="edit" onclick="edit()" type="button" iconcls="icon-edit" >修改</button>
			         </security:ifAny>
			         <security:ifAny authorization="用户管理_管理员">
			         	<button class="easyui-linkbutton l-btn l-btn-small" id="remove" onclick="del()" type="button" iconcls="icon-delete" >删除</button>
			         </security:ifAny>
			         <security:ifAny authorization="用户管理_管理员">
			        	 <button class="easyui-linkbutton l-btn l-btn-small" id="resetPwd" onclick="resetPwd()" type="button" iconcls="icon-reload" >重置密码</button>
			         </security:ifAny>
			         <security:ifAny authorization="电子签名管理_管理员">
			        	 <button class="easyui-linkbutton l-btn l-btn-small" id="signature" onclick="signature()" type="button" iconcls="icon-tij" >电子签名</button>
			         </security:ifAny>
			        </div>
		        </div>
		        <div region="center" border="false">
		            <div style="padding: 5px; width: 100%; /**height: 505px;**/" class="easyui-layout layout" fit="true">
		                <table id="userDatagrid"></table>
		            </div>
		        </div>
		    </div>
		</div>	
	</div>
</div>
<!-- 添加修改 -->
<div id="addWindow" class="easyui-dialog" title="新增" style="width: 620px; height: 350px;" modal="true" closed="true">
    <form class="addForm" action="${dynamicURL}/system/user/signature/upload" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="userId" id="userId">
    	<table style="width:100%">
	        <tr>
	            <td style="text-align: center; height: 20px;">照片预览</td>
	        </tr>
	        <tr>
	            <td style="text-align: center; height: 180px;">
	                <div id="preview">
					    <img id="imghead" border=0 src="" width="240" height="180" />
					</div>
	            </td>
	        </tr>
	        <tr>
	            <td style="text-align: center; height: 30px;">
	    			<input type="file" name="file" id="myImage" onchange="previewImage(this)">
	   		    </td>
	        </tr>
    	</table>
	    <div class="BtnLine">
	        <button type="button" class="easyui-linkbutton submit">保存</button>
	        <button type="button" class="easyui-linkbutton" onclick="$('#addWindow').dialog('close');return false;">取消</button>
	    </div>
    </form>
</div>
<script type="text/javascript">
	var companyComboTree;
	var departmentTreegrid;
	var userDataGrid;
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
				userDataGrid.datagrid("load", {'search_EQ_departmentEntity.id' : rowIndex.id});
            }
		});
		userDataGrid = $('#userDatagrid').datagrid({
            url: '${dynamicURL}/system/user/list?sort=sortNumber',
            pagination: true,
            rownumbers : true,//行数  
            singleSelect:true, 
            fit:true,
            queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
            idField: 'id',
            columns: [[
                 {field: 'id', checkbox: true},
                 {field: 'loginName', title: '登录名', width: 200, align: 'center', sortable: true},
                 {field: 'name', title: '用户名', width: 200, align: 'center', sortable: true},
                 {field: 'companyEntity.name', title: '公司', width: 200, align: 'center', sortable: true, 
                	 	formatter: function (value, rec) { return rec.companyEntity['name'];}},
                 {field: 'departmentEntity.name', title: '部门', width: 200, align: 'center', sortable: true, 
                	 	formatter: function (value, rec) { return rec.departmentEntity['name'];}},
                 {field: 'sortNumber', title: '排序', width: 40, align: 'center', sortable: true},
             	 {field: 'opt', title: '操作', width: 100, align: 'center', sortable: true, 
                 	 formatter: function (value, rec) {
                 		 return '<button class="easyui-linkbutton l-btn l-btn-small" type="button" onclick="userSort(0,'+rec.id+')" >↑</button>&nbsp;&nbsp;'+
                 		 '<button class="easyui-linkbutton l-btn l-btn-small" type="button" onclick="userSort(1,'+rec.id+')">↓</button>';
                 }},
                 {field: 'gmtCreate', title: '更新时间', width: 200, align: 'center', sortable: true}
            ]],
            onDblClickRow: function(index){
				edit();
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
		window.parent.openT('新增人员', '${dynamicURL}/system/user/toAddPage','0','300','300')
// 		var companyId = companyComboTree.combotree("getValue");
// 		var companyName = companyComboTree.combotree("getText");
// 		var department = departmentTreegrid.treegrid("getSelected");
// 		if(companyId && companyName && department){
// 			$("#addWindow form.addForm").form("clear");
// 			//公司
// 			$("#companyEntityId").val(companyId);
// 			$("#companyEntityName").textbox('setValue',companyName);
// 			//部门
// 			$("#departmentEntityId").val(department.id);
// 			$("#departmentEntityName").textbox('setValue',department.name);
			
// 			$("#addWindow").dialog("open");
// 		}else{
// 			$.messager.alert('提示', '请选择公司及部门信息！', 'error');
// 		}
    }
	
	function userSort(sortType,userId){
        if (userId) {
       	 	$.ajax({
                url: "${dynamicURL}/system/user/userSort",
                data: {sortType:sortType,userId: userId},
                dataType: "json",
                success: function (data) {
                	if(data.success){
                		userDataGrid.datagrid("reload");
                	}
                }
            });
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
	}
	
	function signature(){
        var row = userDataGrid.treegrid("getSelected");
        if (row) {
    		$("#addWindow form.addForm").form("clear");
    		$("#imghead").attr("src","");
    		
       	 	$.ajax({
                url: "${dynamicURL}/system/user/signature/ajax",
                data: {id: row.id},
                dataType: "json",
                success: function (data) {
                	if(data.success){
                		$("#imghead").attr("src","${dynamicURL}"+data.path);
                	}
                }
            });
    		
    		$("#userId").val(row.id);
    		$("#addWindow").dialog("open");
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
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
                userDataGrid.datagrid('reload');
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
    $("#addWindow .BtnLine .submit").on("click", 
   		_.debounce(function() {
  			$("#addWindow form.addForm").submit();
        },waitTime,true)
    );
    
    //图片上传预览    IE是用了滤镜。
      function previewImage(file)
      {
        var MAXWIDTH  = 260; 
        var MAXHEIGHT = 180;
        var div = document.getElementById('preview');
        if (file.files && file.files[0])
        {
            div.innerHTML ='<img id=imghead>';
            var img = document.getElementById('imghead');
            img.onload = function(){
              var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
              img.width  =  rect.width;
              img.height =  rect.height;
//               img.style.marginLeft = rect.left+'px';
              img.style.marginTop = rect.top+'px';
            }
            var reader = new FileReader();
            reader.onload = function(evt){img.src = evt.target.result;}
            reader.readAsDataURL(file.files[0]);
        }
        else //兼容IE
        {
          var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
          file.select();
          var src = document.selection.createRange().text;
          div.innerHTML = '<img id=imghead>';
          var img = document.getElementById('imghead');
          img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
          var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
          status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
          div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-left:"+150+"px;"+sFilter+src+"\"'></div>";
        }
        
      }
      function clacImgZoomParam( maxWidth, maxHeight, width, height ){
          var param = {top:0, left:0, width:width, height:height};
          if( width>maxWidth || height>maxHeight )
          {
              rateWidth = width / maxWidth;
              rateHeight = height / maxHeight;
              
              if( rateWidth > rateHeight )
              {
                  param.width =  maxWidth;
                  param.height = Math.round(height / rateWidth);
              }else
              {
                  param.width = Math.round(width / rateHeight);
                  param.height = maxHeight;
              }
          }
          
          param.left = Math.round((maxWidth - param.width) / 2);
          param.top = Math.round((maxHeight - param.height) / 2);
          return param;
      }
      
      // 上传头像
	function selectImage(){
		if($("#myImage").val()==""){
			$.messager.alert('提示', "请选择图片！","info");
			return false;
		}
	  		  
		$.ajaxFileUpload({
		       url: "${dynamicURL}/system/file/uploadHeadImg?flag=0",
		       type: "post",
		       secureuri: false,
		       fileElementId: "myImage",
		       dataType: "text/plain",
		       callback: function(jsonstr) {
		           
		       },
		       complete: function (data) {//只要完成即执行，最后执行  
		      	// 接受headImgUrl
		      	 var obj = $.parseJSON($(data.responseText).html());
		       	 if(obj.success){
		       		$.messager.alert('提示', obj.msg, 'info',function(){
		       			$('#openPersonDiv').dialog('close');
		       		});
		       	 }else{
		       		$.messager.alert('提示', obj.msg, 'error');
		       	 }
		       	 $('#yl').attr("src",obj.path);
		       	 $('#headImgUrl').val(obj.path);
		      }
		});
    }
    
    
    //修改
    function edit() {
        var row = userDataGrid.treegrid("getSelected");
        if (row) {
            var form = $("#addWindow form.addForm");
            form.form("clear");
            window.parent.openT('修改人员', '${dynamicURL}/system/user/toEditPage?id='+row.id+'','0','300','300');
        } else {
            $.messager.alert('提示', '请选择要修改的记录！', 'error');
        }
    }
    
    //删除
    function del(){
    	var row = userDataGrid.treegrid("getSelected");
        if (row) {
        	$.messager.confirm("操作提示", "您要删除当前所选记录？", function (data) {
                if (data) {
               	 $.ajax({
                        url: "${dynamicURL}/system/user/delete",
                        data: {"ids": row.id},
                        dataType: "json",
                        success: function (data) {
                       	 	if(data.success){
                       	 		$.messager.alert('提示',"删除成功！","info");
                       	 		userDataGrid.datagrid('reload');
                       	 	}else{
                       	 		$.messager.alert("错误","删除失败！","error");
                       	 	}
                        }
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择要删除的记录！', 'error');
        }
    }
    
  	// 重置密码
    function resetPwd() {
        var row = userDataGrid.treegrid("getSelected");
        if (row) {
        	 $.messager.confirm("操作提示", "您确定要重置该用户密码吗？", function (data) {
                 if (data) {
                	 $.ajax({
                         url: "${dynamicURL}/system/user/resetPwd",
                         data: {id: row.id},
                         dataType: "json",
                         success: function (data) {
                        	 debugger;
                        	 $.messager.alert('提示', data.msg, 'info');
                         }
                     });
                 }
             });
        } else {
            $.messager.alert('提示', '请选择要密码重置的记录！', 'error');
        }
    }
</script>

