<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta charset="utf-8">
    <script type="text/javascript" src="${staticURL}/script/jquery.portal.js"></script>
    <style>
        .portal{
			padding:0;
			margin:0;
			border:1px solid #99BBE8;
			overflow:auto;
		}
		.portal-noborder{
			border:0;
		}
		.portal-panel{
			margin-bottom:10px;
		}
		.portal-column-td{
			vertical-align:top;
		}	
		.portal-column{
			padding:10px 0 10px 10px;
			overflow:hidden;
		}
		.portal-column-left{
			padding-left:10px;
		}
		.portal-column-right{
			padding-right:10px;
		}
		.portal-proxy{
			opacity:0.6;
			filter:alpha(opacity=60);
		}
		.portal-spacer{
			border:3px dashed #eee;
			margin-bottom:10px;
		}
    </style>
<%--     <script src="${staticURL}/script/portal.js"></script> --%>
	<script>
		var resources;
		$(function(){
			$('#pp').portal({
				border:true,
				fit:true
			});
			$("#addBox").click(function(){
				$("#boxSettingWin").modal("show");
			});
			$('#boxSettingSave').click(function(){
				var id = $("#boxId").val();
		        var h = $("#boxHeight").slider("getValue");
		        h = h || 300;
		        var v = $("#boxWidth").slider("getValue");
					//console.log(v)
		        if(v==1){v=4;}else if(v==3){v=12;}else{v=6;}
		        if(id){
		            var boxBody=$("#"+id);
		            boxBody.css({height:h});
		            boxBody.data("height",h);
		        }else{
		            var t = $('#moduleTreeId').combotree('tree');	// get the tree object
		            var n = t.tree('getSelected');		// get selected node
		            var resid = n.id;
		            var title = n.name;
		            var container = n.container;
		            var icon = n.icon;
		            var boxData = {resid:resid,title:title,container:container,icon:icon,height:h,index:0};
		            var panel = addBox(boxData);
// 		            if(panel!=false){
// 		            	panel.panel('refresh',dynamicURL+"/portalModule/module?id="+resid);
// 		            }
		        }
				$("#boxSettingWin").modal("hide");
			});
		    $("#moduleTreeId").combotree({
		        textFiled:"name",
		        idFiled:"id",
		        state:"open",
		        icon:"icon"
		    });
		    //加载portal信息
		    $.post(dynamicURL+"portalModule/combo", function(data){
		    	if(data !=null && data!=''){
		    		resources = jQuery.parseJSON(data);
		    		$("#moduleTreeId").combotree('loadData',resources);
		    	}
		    });
		    //加载portal信息
		    $.post(dynamicURL+"userInfo/portalSetting", function(data){
		    	if(data !=null && data!='')
		    		init(JSON.parse(data));
		    });
			$('#saveBox').click(function(){
				save();
			});
			$('#saveBoxAll').click(function(){
				saveAll();
			});
			
		});
		function init(boxs){
			$.each(boxs,function(i,box){
				var panel = addBox(box);
			});
			$('#pp').portal('resize');
		}
		function addBox(data){
			 if(data.resid){
				var p = $('<div class="box-body"/>').appendTo('body');
				p.data("resid",data.resid).data("title",data.title).data("container",data.container).data("icon",data.icon).data("height",data.height);
				p.panel({
					iconCls:data.icon,
					title:data.title,
					height:data.height,
					url:dynamicURL+"/portalModule/module?id="+data.resid,
					closable:false,
					collapsible:true,
					minimizable:false,
					maximizable:false,
					tools:[{
						iconCls:'icon-remove',
						handler:function(){
							var div = $(this).parent().parent().parent();
							setTimeout(function(){
								div.remove();
								$('#pp').portal('resize');
							},1000);
						}
					}]
				});
				$('#pp').portal('add', {
					panel:p,
					columnIndex:data.index
				});
				$('#pp').portal('resize');
				p.panel('refresh',dynamicURL+"/portalModule/module?id="+data.resid);
				return p;
			}
			return false;
		}
		function save(){
			var boxs = [];
			var xIndex = 0;
			$('#pp').find("div[class*=portalDiv]").each(function(i,column){
				$(column).find(".box-body").each(function(){
					var box={};
// 					var boxData = {resid:resid,title:title,container:container,icon:icon,height:h,index:0};
					var boxBody = $(this);
					box.resid =boxBody.data("resid");
					box.title =boxBody.data("title");
					box.desc =boxBody.data("container");
					box.icon =boxBody.data("icon");
					box.height =boxBody.data("height") || 300;
					box.index = xIndex;
					boxs.push(box);
				})
				xIndex++;
			})
			boxs=JSON.stringify(boxs);
		    $.post(dynamicURL+"userInfo/savePortalSetting", {"boxs":boxs},function(data){
		    	var result = JSON.parse(data);
		    	if(result.success){
		    		$.messager.show({title : '提示',msg : '保存成功！'});
		    	}else{
		    		$.messager.alert('提示', '保存失败', 'error');
		    	}
		    });
		}
		function saveAll(){
			var boxs = [];
			var xIndex = 0;
			$('#pp').find("div[class*=portalDiv]").each(function(i,column){
				$(column).find(".box-body").each(function(){
					var box={};
// 					var boxData = {resid:resid,title:title,container:container,icon:icon,height:h,index:0};
					var boxBody = $(this);
					box.resid =boxBody.data("resid");
					box.title =boxBody.data("title");
					box.desc =boxBody.data("container");
					box.icon =boxBody.data("icon");
					box.height =boxBody.data("height") || 300;
					box.index = xIndex;
					boxs.push(box);
				})
				xIndex++;
			})
			boxs=JSON.stringify(boxs);
		    $.post(dynamicURL+"userInfo/savePortalSettingAll", {"boxs":boxs},function(data){
		    	var result = JSON.parse(data);
		    	if(result.success){
		    		$.messager.show({title : '提示',msg : '保存成功！'});
		    	}else{
		    		$.messager.alert('提示', '保存失败', 'error');
		    	}
		    });
		}

	</script>
</head>

<body style="background: #ffffff;" class="easyui-layout">
    <!-- content-header -->
    <!-- content-breadcrumb -->
    <div region="north" class="title" border="false" style="overflow-y:hidden;height: 38px;">
        <!--breadcrumb-nav-->
        <ul class="breadcrumb-nav pull-right" style="border: none;">
            <li class="btn-group">
                <a href="#" class="btn btn-small btn-link" id="addBox">
                    <i class="icofont-plus"></i>添加组件
                </a>
            </li>
            <del>|</del>
            <li class="btn-group">
                <a href="#" class="btn btn-small btn-link" id="saveBox">
                    <i class="icofont-save"></i>保存
                </a>
            </li>
            <del>|</del>
            <li class="btn-group">
                <a href="#" class="btn btn-small btn-link" id="saveBoxAll">
                    <i class="icofont-save"></i>同步到所有用户
                </a>
            </li>
        </ul>
        <!--/breadcrumb-nav-->
        
    	<!--breadcrumb-->
        <ul class="breadcrumb">
            <li><a href="#"><i class="icofont-home"></i>Portal工作台</a> </li>
        </ul>
        <!--/breadcrumb-->
    </div>
    <!-- /content-breadcrumb -->

    <!-- content-body -->
   <div region="center" border="false">
        <!-- tab resume content -->
		<div id="pp" style="position:relative">
			<div style="width:33%;" class="portalDiv">
				
			</div>
			<div style="width:34%;" class="portalDiv">
				
			</div>
			<div style="width:33%;" class="portalDiv">
				
			</div>
		</div>
		<!-- /tab stat -->
    </div><!--/content-body -->

    <!-- box 设置-->
    <div id="boxSettingWin" class="modal fix-modal400 " style="display: none; ">
        <div class="modal-header">
            <a class="close" data-dismiss="modal">×</a>
            <a class="max">▣</a>
            <h3>组件设置</h3>
        </div>
        <div class="modal-body" style="overflow-y:hidden;" >
            <form>
                <input id="boxId" type="hidden"/>
                <div class="control-group">
                    <label class="control-label">组件:</label>
                    <div class="controls">
                        <input id="moduleTreeId" style="width:200px;"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">宽度:</label>
                    <div class="controls">
                        <input class="easyui-slider" id="boxWidth" style="width:300px;" data-options="showTip:false,min:1,max:3,rule: ['小','|','中','|','大']">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">高度:</label>
                    <div class="controls">
                        <input class="easyui-slider" id="boxHeight" style="width:300px;" data-options="showTip:false,step:50,min:100,max:500,rule: [100,'|',200,'|',300,'|',400,'|',500]">
                    </div>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn btn-success" id="boxSettingSave" >保存</a>
            <a href="#" class="btn" data-dismiss="modal">关闭</a>
        </div>
    </div>
</body>
</html>