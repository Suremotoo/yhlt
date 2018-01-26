<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>
<html>
<head>
<title></title>
</head>
<body>
	<div class="content sub-content">
    <div class="content-body content-sub-body">
                <fieldset id="queryHeader">
                    <!--for="datagrid" 表示为那个datagrid做筛选查询 -->
                    <form class="form-horizontal" for="mailDatagrid">
                        <section class="corner-all">
							<legend><span class="content-body-bg">查询</span></legend>
							<legend class="content-body-bg tool"><a href="javascript:void(0);" class="panel-tool-collapse"></a></legend>
                            <div class="row-fluid">
                                <div class="small-span6 span3">
                                    <label class="label-control" for="titleId" title="主题">主题</label>
                                        <input name="search_LIKE_title" id="titleId" class="form-control"  type="text" />
                                </div>
                                <div class="small-span6 span3">
                                    <label class="label-control" for="contentId" title="内容">内容</label>
                                        <input name="search_LIKE_content" id="contentId"  class="form-control" type="text" />
                                </div>
                                <div class="small-span6 span3">
                               		<label class="label-control" for="receiveUserId" title="接收者">接收者</label>
                       			        <input name="search_LIKE_receiveUser" id="receiveUserId"  class="form-control" type="text" />
                                </div>
                                
                                    <!--class="queryBtn" 表示查询，会自动注册事件触发查询   class="clearBtn" 表示清空查询条件，会自动注册事件触发清空-->
                                    <button type="button" class="btn queryBtn">查询</button>
                                    <button type="button" class="btn clearBtn">重置</button>
                            </div>
                        </section>
                    </form>
                </fieldset>
                <!-- -当前table列表- -->
                <!-- datagrid-custom-resize 表示需要额外处理自适应问题 -->
                <section class="corner-all">
                    <table id="mailDatagrid" class="datagrid-custom-resize" ></table>
                </section>
            </div>
        </div>
        <!-- -当前table列表右击菜单- -->
        <div id="menu" class="easyui-menu" style="width:120px;display: none;">
            <div onclick="del();" iconCls="icon-remove">删除</div>
            <div onclick="edit();" iconCls="icon-edit">编辑</div>
        </div>
        
        
        <!-- combogrid toolbar 外键关联 查询条件中 对 combogrid 添加toolbar -->
        
        <!-- form start -->
        <!-- 添加修改 -->
        <div id="addWindow" class="modal modal-700-175 " style="display: none;">
            <div class="modal-header">
                <a class="close" data-dismiss="modal">×</a>
                <h3>系统邮件</h3>
            </div>
            <div class="modal-body">
                <form class="form-horizontal addForm" action="${dynamicURL}/system/mail/sendMailToUser" method="post">
                    <section class="corner-all">
                    	<legend><span class="content-body-bg">邮件内容填写</span></legend>
                        <div class="row-fluid">
                        	<div class="small-span12 span12">
                        		<label class="label-control" for="receiveUserId" title="发送给">请在此输入接受邮件人的邮件地址</label>
                        		<input name="receiveUser" id="receiveUserId" type="text" class="form-control easyui-validatebox" data-options="required:true"/>
                    		</div>
                    	</div>
                    	<div class="row-fluid">
		                    <div class="small-span12 span12">
		                        <label class="label-control"  title="主题">请在此处为邮件设置一个主题</label>
		                        <input name="title" id="titleId" class="form-control  easyui-validatebox" data-options="required:true">
		                    </div>
		                </div>
		                <div class="row-fluid">
                            <div class="small-span12 span12">
                             	<label class="label-control" for="contentId" title="邮件内容" >具体的邮件内容请在此处填写</label>
                                <textarea name="content" id="contentId"  class="form-control easyui-validatebox" data-options="required:true"  cols="200" rows="3"></textarea>
                            </div>
                        </div>
                    </section>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-success submit" >发送</a>
                <a href="#" class="btn" data-dismiss="modal">撤销</a>
            </div>
        </div>
         <div id="detailWindow" class="modal modal-700-175 " style="display: none;">
            <div class="modal-header">
                <a class="close" data-dismiss="modal">×</a>
                <h3>系统邮件</h3>
            </div>
            <div class="modal-body">
                <form class="form-horizontal addForm">
                    <section class="corner-all">
                    	<legend><span class="content-body-bg">邮件内容详情</span></legend>
                        <div class="row-fluid">
                        	<div class="small-span12 span12">
                        		<label class="label-control"  title="发送给">接受邮件人的邮件地址</label>
                        		<input name="receiveUser" type="text" class="form-control easyui-validatebox" data-options="required:true"/>
                    		</div>
                    	</div>
                    	<div class="row-fluid">
		                    <div class="small-span12 span12">
		                        <label class="label-control"  title="主题">邮件主题</label>
		                        <input name="title"  class="form-control  easyui-validatebox" data-options="required:true">
		                    </div>
		                </div>
		                <div class="row-fluid">
                            <div class="small-span12 span12">
                             	<label class="label-control"  title="邮件内容" >具体的邮件内容请在此处填写</label>
                                <textarea name="content"  class="form-control easyui-validatebox" data-options="required:true"  cols="200" rows="3" ></textarea>
                            </div>
                        </div>
                    </section>
                </form>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn" data-dismiss="modal">返回</a>
            </div>
        </div>
	<script>
		var datagrid
		  $(function () {
		        /*------------------初始化当前table 列表  datagrid 变量为全局变量-------------------*/
		        datagrid = $('#mailDatagrid').datagrid({
		            url: '${dynamicURL}/system/mail/list',
		            title: '系统邮件列表 ',
		            pagination: true,
		            rownumbers : true,//行数  
		            queryForm: "#queryHeader form",//列筛选时附带加上搜索表单的条件
		            custom_fit: true,//额外处理自适应性
		            custom_heighter: "#queryHeader",//额外处理自适应性（计算时留出元素#queryHeader高度）
		            custom_height: 5,//额外处理自适应性（计算时留5px高度）
		            singleSelect:true, 
		            idField: 'id',
		            columns: [[
		                 {field: 'id', checkbox: true},
		                 {field: 'title', title: '主题  ', width: 200, align: 'center', sortable: true},
		                 {field: 'content', title: '内容 ', width: 400, align: 'center', sortable: true},
		                 {field: 'receiveUser', title: '接收者 ', width: 200, align: 'center', sortable: true},
		                 {field: 'sendName', title: '发送人', width: 200, align: 'center', sortable: true},
		                 {field: 'gmtCreate', title: '发送时间', width: 200, align: 'center', sortable: true}
		            ]],
		            toolbar : [ 
					<security:ifAny authorization="用户管理_管理员">            
		            {
		                text : '增加',
		                iconCls : 'elusive-plus',
		                handler : function() {
		                    add();
		                }
		            }, '-', 
		            </security:ifAny>
		            {
		                text: '刷新',
		                iconCls: 'elusive-refresh',
		                handler: function () {
		                    datagrid.datagrid('reload');
		                }
		            }],
		            //行右击菜单
		            onRowContextMenu : function(e, rowIndex, rowData) {
		                e.preventDefault();
		                $(this).datagrid('unselectAll');
		                $(this).datagrid('selectRow', rowIndex);
		                $('#menu').menu('show', {
		                    left : e.pageX,
		                    top : e.pageY
		                });
		            },
		            onDblClickRow: function(index){
						detail();
		            }
		            
		        });
		        
		        $("#addWindow form.addForm").form({
		            onSubmit: function(){
		                var isValid = $(this).form('validate');
		                if (!isValid){
		                    $.messager.progress('close');   
		                }
		                return isValid; 
		            },
		            success:function(data){
		                if(typeof data =="string"){
		                    data = JSON.parse(data);
		                }
		                $.messager.progress('close');
		                if(data.success){
		                    $(this).form("load",data.obj);
		                    $.messager.show({title : '提示',msg : '保存成功！'});
		                    datagrid.datagrid("reload");
		                    $("#addWindow").modal("hide");
		                }else{
		                    $.messager.alert('提示', data.msg, 'error');
		                }
		            }
		        });
		        
		        $("#addWindow .modal-footer .submit").on("click",function(){
		        	$("#addWindow form.addForm").submit();
		        });
		        
		        
		        
		        //注册主筛选条件表单的 查询和清空事件
		        $("form[for] button.queryBtn").on("click.datagrid-query",function(){
		            major._search($(this).parents("form[for]"));
		        });
		        $("form[for] button.clearBtn").on("click.datagrid-query",function(){
		            major._clearSearch($(this).parents("form"));
		        });
		        //注册combogrid筛选条件表单的 查询和清空事件
		        $("form.gridTb .easyui-linkbutton[iconcls='elusive-search']").on("click.datagrid-query",function(){
		            major._search($(this).parents("form.gridTb"),$(this).parents(".datagrid-toolbar").next(".datagrid-view").find("> table"));
		        })
		        $("form.gridTb .easyui-linkbutton[iconcls='elusive-repeat']").on("click.datagrid-query",function(){
		            major._clearSearch($(this).parents("form.gridTb"));
		        })
		        
		        major.preventComboPanel();//阻止combo面板的click事件冒泡
		    });
		    function del(){
		        major._del(datagrid,{delUrl:"${dynamicURL}/system/imMessage/delete"});
		    }
		    function add(){
		        $("#addWindow form.addForm").form("clear");
		        $("#addWindow").modal("show");
		    }
		    function detail()
		    {
		    	var row = datagrid.datagrid("getSelected");
				if (row) {
					var form = $("#detailWindow form.addForm");
					form.form("clear");
					$.ajax({
						url : "${dynamicURL}/system/mail/detail",
						data : {
							'id' : row.id
						},
						dataType : "json",
						success : function(msg) {
							form.form("load",msg.obj);
							$("#detailWindow").modal("show");
						}
					});
				} else {
					$.messager.alert('提示', '请选择要查看的记录！', 'error');
				}
		    }
	</script>
</body>
</html>