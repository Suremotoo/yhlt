<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="/tld/security.tld" %>

<style type="text/css">
#preview{}
#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
.a-upload {
    padding: 4px 10px;
    height: 20px;
    line-height: 20px;
    position: relative;
    cursor: pointer;
    color: #888;
    background: #fafafa;
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden;
    display: inline-block;
    *display: inline;
    *zoom: 1}.a-upload  input {
    position: absolute;
    font-size: 20px;
    right: 0;
    top: 0;
    opacity: 0;
    filter: alpha(opacity=0);
    cursor: pointer}.a-upload:hover {
    color: #444;
    background: #eee;
    border-color: #ccc;
    text-decoration: none}
</style>

<div id="container">
    <form class="editInfoFrm" action="${dynamicURL}/system/user/saveInfo" method="post">
    	<input type="hidden" name="id" value="${entity.id}"/>
    	<input type="hidden" id="headImgUrl" name="headImgUrl" value="${entity.headImgUrl}"/>
    	<input type="hidden" name="sortNumber" value="${entity.sortNumber}"/>
    	<input type="hidden" id="display" name="display" value="${entity.display}"/>
    	
        <div title="个人信息" style="padding: 20px; height: 650px;">
            <div style="padding: 5px;" class="easyui-panel">
                <div style="padding: 5px; width: 98%; height: auto" class="easyui-panel" id="no1" title="个人信息">
                    <hr style="width:91%; border:0.5px solid #c6c6c6; float:left;" />
                    <table class="conDetailTable">
                        <tr>
                            <td width="15%" class="tr">登录名：&nbsp;&nbsp;</td>
                            <td width="35%">
                                <input class="easyui-textbox" type="text" value="${entity.loginName}"  style="width: 270px; height: 26px" disabled="disabled" />
                            </td>
                            <td width="15%" class="tr">&nbsp;</td>
                            <td rowspan="4" width="35%" style="text-align: center;">
                                <div class="imgUploadBlock" onclick="$('#openPersonDiv').dialog('open');"><%-- onclick="$('#openPersonDiv').dialog('open');" --%>
                                    <img id="yl" src="" width="176" height="240"  />
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <td class="tr">公司名：&nbsp;&nbsp;</td>
                            <td>
                                <input class="easyui-textbox" type="text"  value="${entity.companyEntity.name}" style="width: 270px; height: 26px" disabled="disabled" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="tr">部门名：&nbsp;&nbsp;</td>
                            <td>
                                <input class="easyui-textbox" type="text" value="${entity.departmentEntity.name}" style="width: 270px; height: 26px" disabled="disabled" />
                            </td>

                        </tr>
                    </table>
                </div>
                <div style="padding: 5px; width: 98%; height: auto" class="easyui-panel" id="no2" title="基本资料">
                    <hr style="width:91%; border:0.5px solid #c6c6c6; float:left" />
                    <table class="conDetailTable">
                        <tr>
                            <td style="width: 15%;" class="tr">姓名：&nbsp;&nbsp;</td>
                            <td style="width: 35%;">
                                <input class="easyui-textbox" type="text" value="${entity.name}"  name="name" style="width: 270px; height: 26px" data-options="required:true,missingMessage:'姓名为必填项'" />
                            </td>
                            <td style="width: 15%;" class="tr">性别：&nbsp;&nbsp;</td>
                            <td style="width: 35%;">
                                <select  id="sex" name="sex" style="width:270px; height: 26px">
                                    <option value="1">男</option>
                                    <option value="2">女</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="tr">出生日期：&nbsp;&nbsp;</td>
                            <td style="">
                                <input class="easyui-datebox" data-options="editable:true" value="${entity.birthday}" type="text" id="birthday" name="birthday" style="width: 270px; height: 26px" />
                            </td>
                        </tr>
                    </table>
                </div>
              	<div style="padding: 5px; width: 98%; /**height: 220px**/" class="easyui-panel" title="联系信息">
                      <hr style="width: 91%; border: 0.5px solid #c6c6c6; float: left;" />
                      <table class="conDetailTable">
                          <tr>
                              <td width="15%" class="tr">手机号码：&nbsp;&nbsp;</td>
                              <td style="width:35%;">
                                  <input class="easyui-textbox" type="text" name="mobile" value="${entity.mobile}" style="width: 270px; height: 26px" />
                              </td>
                              <td width="15%" class="tr">单位电话：&nbsp;&nbsp;</td>
                              <td style="width:35%;">
                                  <input class="easyui-textbox" type="text" id="telephone" name="telephone" value="${entity.telephone}" style="width: 270px; height: 26px" />
                              </td>
                          </tr>
                          <tr>
                              <td class="tr">电子邮箱：&nbsp;&nbsp;</td>
                              <td>
                                  <input class="easyui-textbox" type="text" value="${entity.email}" id="email" name="email" style="width: 270px; height: 26px" />
                              </td>
                              <td class="tr">家庭住址：&nbsp;&nbsp;</td>
                              <td>
                                  <input class="easyui-textbox" type="text" id="homeAddress" value="${entity.homeAddress}" name="homeAddress" style="width: 270px; height: 26px" />
                              </td>
                          </tr>
                      </table>
                  </div>
            </div>
            <div class="BtnLine">
                <button type="button" class="easyui-linkbutton submit">保存</button>
                <button type="button" class="easyui-linkbutton" onClick="window.parent.reLoad('个人用户信息')">关闭</button>
            </div>
        </div>
       </form>
</div>
<div id="openPersonDiv"  class="easyui-window" closed="true" collapsible="false" modal="true" minimizable="false" maximizable="false" title="照片上传" style="width: 500px; height: 420px; padding: 10px; left: 300px;dis ">
    <table style="width:100%">
        <tr>
            <td style="text-align: center; height: 30px;">照片预览</td>
        </tr>
        <tr>
            <td style="text-align: center; height: 240px;">
                <!-- <img id="yl" src="/Style/images/nobody.jpg" width="240" height="240" /> -->
                <div id="preview">
				    <img id="imghead" border=0 src="${entity.headImgUrl }" width="176" height="240" />
				</div>
            </td>
        </tr>
        <tr>
            <td style="text-align: center; height: 30px;">
				<!-- <input id="myImage" name="file" type="file" onchange="previewImage(this)" style="margin-left:50px;display:none "/> -->
				<!-- <input type="file" onchange="previewImage(this)" />
				<input type="button" value="浏览" onclick="javascript: $('#myImage').click()" class="orangeLink" style="height: 26px;border:0px;padding:0px 15px;" /> -->
				 <a href="javascript:;" class="a-upload" >
				 	<div id="file">点击这里上传文件</div>
    				<input type="file" name="file" id="myImage" onchange="previewImage(this)">
    			</a>
   		   </td>
        </tr>
        <tr>
            <td style="text-align: center; height: 30px;">
                
                <div class="BtnLine easyui-panel tc pt20 pb20">
                    <button onclick="javascript: selectImage()" id="imgSave" class="easyui-linkbutton">确定</button>&nbsp;&nbsp;
                    <button type="submit" class="easyui-linkbutton" onclick="javascript: $('#openPersonDiv').dialog('close')">关闭</button>
                </div>
            </td>
        </tr>
    </table>
</div>
<script>

	$(function(){
    	if($("#headImgUrl").val() == ""){
    		$("#yl").attr("src","${staticURL }/img/nobody.jpg");
    		$("#imghead").attr("src","${staticURL }/img/nobody.jpg");
    	}else{
    		$("#yl").attr("src","${dynamicURL}"+$("#headImgUrl").val());
    		$("#imghead").attr("src","${dynamicURL}"+$("#headImgUrl").val());
    	}
	});
	$("#sex").val("${entity.sex}");
	//初始化form表单
    $("#container form.editInfoFrm").form({
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
            /* $(window).scrollTop(0);
            window.setTimeout(function(){
                if (data.success) {
               	 $.messager.alert('提示', "保存成功！", 'info');
               } else {
                   $.messager.alert('提示', "保存失败！", 'error');
               }},200) */
            if(data.success){
            	$.messager.alert('提示', data.msg,'info');
	        }else{
	        	$.messager.alert('提示', data.msg, 'error');
	        }
        }
    });
	
    $("#container .BtnLine .submit").on("click", 
       	_.debounce(function() {
       		$("#container form.editInfoFrm").submit();
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
//             img.style.marginLeft = rect.left+'px';
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
        var img = document.getElementById('imghead');//debugger;
        img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
        var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
        console.log(rect);
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
    		  $.messager.show({
  				title : '提示',
  				msg : '请选择图片！'
  			});
    		  return false;
    	  }
    		  
	      $.ajaxFileUpload({
	             url: "${dynamicURL}/system/user/uploadHeadImg?flag=1",
	             type: "post",
	             secureuri: false,
	             fileElementId: "myImage",
	             dataType: "text/plain",
	             callback: function(jsonstr) {
	                 
	             },
	             complete: function (data) {//只要完成即执行，最后执行  
	            	 var obj = $.parseJSON($(data.responseText).html());
	             	 if(obj.success){
	             		$.messager.alert('提示', obj.msg, 'info',function(){
	             			$('#openPersonDiv').dialog('close');
	             		});
	             	 }else{
	             		$.messager.alert('提示', obj.msg, 'error');
	             	 }
	             	$('#yl').attr("src","${dynamicURL}"+obj.path);
	             	$('#headImgUrl').val(obj.path);
	             }
	         });
      }
      
      
</script>
