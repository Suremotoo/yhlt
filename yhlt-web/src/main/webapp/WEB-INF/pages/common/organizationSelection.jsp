<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="easyui-layout" style="width:480px;height:550px;">
	<div data-options="region:'north'" style="width:470px;height:35px">
		<div class="easyui-panel">
			<a href="#" id="SELECTION_TYPE1" class="easyui-linkbutton" data-options="plain:true">机构</a>
			<a href="#" id="SELECTION_TYPE2" class="easyui-linkbutton" data-options="plain:true">部门</a>
			<a href="#" id="SELECTION_TYPE3" class="easyui-linkbutton" data-options="plain:true">角色</a>
			<a href="#" id="SELECTION_TYPE4" class="easyui-linkbutton" data-options="plain:true">人员</a>
			<a href="#" id="SELECTION_TYPE5" class="easyui-linkbutton" data-options="plain:true">岗位</a>
		</div>
	</div>
	<div data-options="region:'center'" >
		<div id="SELECTION_PANEL"></div>
	</div>
</div>
<script type="text/javascript">
<!--
$("#SELECTION_TYPE1").on("click",function(){
	unselect();
	$(this).linkbutton("select");
	$('#SELECTION_PANEL').panel({ 
		fit:true,
		href:'${dynamicURL}/datapermissionRule/companySelection',
		queryParams:{'data':'${data}'},
		method:'POST'
	});
});
$("#SELECTION_TYPE2").on("click",function(){
	unselect();
	$(this).linkbutton("select");
	$('#SELECTION_PANEL').panel({ 
		fit:true,
		href:'${dynamicURL}/datapermissionRule/departmentSelection',
		queryParams:{'data':'${data}'},
		method:'POST'
	});
});
$("#SELECTION_TYPE3").on("click",function(){
	unselect();
	$(this).linkbutton("select");
	$('#SELECTION_PANEL').panel({ 
		fit:true,
		href:'${dynamicURL}/datapermissionRule/roleSelection',
		queryParams:{'data':'${data}'},
		method:'POST'
	});
});
$("#SELECTION_TYPE4").on("click",function(){
	unselect();
	$(this).linkbutton("select");
	$('#SELECTION_PANEL').panel({ 
		fit:true,
		href:'${dynamicURL}/datapermissionRule/userSelection',
		queryParams:{'data':'${data}'},
		method:'POST'
	});
});
function unselect(){
	$("[id^=SELECTION_TYPE]").each(function(i,d){
		$(d).linkbutton("unselect");
	});
}
//-->
</script>