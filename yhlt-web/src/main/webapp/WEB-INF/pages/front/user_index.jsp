<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<div class="index-main clearfix">

	<div class="sidebar fl">
		<dl class="border" id="noticeCategory">
	    	<dt>部门</dt>
	    	<dd><a id='' href="javascript:void(0);" onclick="getUserInfo('','0')">全部人员</a></dd>
	    	 <c:forEach var="department" items="${department}">
			      <dd><a id='${department.id}' href="javascript:void(0);" onclick="getUserInfo('${department.id}','0')">${department.name}</a></dd>
			 </c:forEach>
	    </dl>
	</div>
	
	<!-- 用户列表  -->
	<div id="userList" class="right fr border" style="text-align:center">
		<input type="hidden" name="selectTypeId">
		<input type="hidden" name="firstTypeId">
		<ul class="text-list"></ul>
		<div id="Pagination" class="pagination" style="font-size: 15px;"></div>
	</div>
	
</div>

<script type="text/javascript">
	//缓存
	$.ajaxSetup ({
	    cache: false
	});
	
	var pageSize = 5;
	var index = 0;
	$(function(){
		getUserInfo('',0);
	});
	
	
	/*
	 * 分页回调函数
	 */
	function pageselectCallback(page_index, jq){
        var departmentId = $("input[name='selectTypeId']").val();
        callBack(departmentId,page_index);
        $("#Pagination").find(":first").attr("style","margin-left:33%;");
        return false;
    }
	
	/*
	 * 加载公告列表
	 */
	function getUserInfo(departmentId,pageNum){
		$("input[name='selectTypeId']").val("-");
		callBack(departmentId,pageNum);
	}
	
	// 回调函数
	function callBack(departmentId,pageNum){
		// var i = index ++;
		var name = "${name}";
		/* if(parseInt(i) > 1)
			name=''; */
		// 颜色处理
		var dds = $("#noticeCategory").find("dd")
		$.each(dds,function(i,item){
 			$(item).attr("style","-");
 			if($(item).find("a").attr("id") == departmentId){
 				$(item).attr("style","background:#E6E6E6");
 			}
		});
		
		var dataParam = {"page":pageNum,"rows":pageSize};
		if(departmentId){
			dataParam["search_EQ_departmentEntity.id"]=departmentId;
		}
		if(name){
			dataParam["search_LIKE_name"]=name;
		}
		$.ajax({
			type : "POST",
			url : '${dynamicURL}/front/getUserInfos',
			data : dataParam,// winState不设置
			dataType : 'json',
			async : true,
			success : function(data) {
				var cc = [];
			    $.each(data.rows,function(i,item){
 		            cc.push('<li style="">');
					cc.push('<table style="width: 100%;font-size: 15px;">');
					cc.push('<tr>');
					cc.push('<td colspan=5 style="padding:10px 5px;border:1;">');
					var img = item.headImgUrl;
					if(img != null){
						img = "${dynamicURL}" + item.headImgUrl;
					}else{
						img = "${staticURL}/style/images/indPic03.png";
					}
					cc.push('<img src="'+img+'" style="width:167px;float:left">');
					cc.push('<div style="float:left;margin-left:20px;"><p><span class="c-label height35"><em class="elusive-user"></em></span></p>');
					cc.push('<p><span class="c-label height35">姓名:</span>'+item.name+'</p>');
					cc.push('<p><span class="c-label height35">科室:</span>'+item.departmentEntity['name']+'</p>');
					cc.push('<p><span class="c-label height35">职务:</span>'+item.positionEntity['name']+'</p>');
					cc.push('<p><span class="c-label height35">办公电话:</span>'+item.telephone+'</p>');
					cc.push('<p><span class="c-label height35">手机:</span>'+item.mobile+'</p>');
					cc.push('</div>');
					cc.push('</td>');
					cc.push('</tr>');
					cc.push('</table>');
					cc.push('</li>');
				});
				var html = cc.join('');
				$("#userList .text-list").html(html);
			    
			    $("#userList").show();

				var frontTypeId = $("input[name='selectTypeId']").val();
				$("input[name='selectTypeId']").val(departmentId);
				
				if(frontTypeId != departmentId)
					$("#Pagination").html("");
				if($("#Pagination").html()=="" && data.rows!=0){
					 $("#Pagination").pagination(data.total, {
							num_edge_entries: 1, //边缘页数
							num_display_entries: 4, //主体页数
							callback: pageselectCallback,
							items_per_page: pageSize, //每页显示1项
							prev_text: "前一页",
							next_text: "后一页"
					 });
				}

				
			}/* ,
			error : function() {//请求失败处理函数
				alert("加载数据失败！");
			} */
		});
	}

</script>
<style type="text/css">
    .c-label{
        display:inline-block;
        width:100px;
        font-weight:bold;
/*         margin-top: 20px; */
    }
    .height35{
       height: 35px;
    }
</style>

