<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="${staticURL}/scripts/knob/jquery.knob.js" type="text/javascript"></script>
<style type="text/css">
 .demo-knob{
                text-align: center;
                margin-top: 10px;
                margin-bottom: 10px;
            }
.datagrid-row {
        height: 80px;
    }
</style>
<div id="container">
    <div id="tabs" class="easyui-tabs psnAccoundTab" style="width: 100%;">
        <div title="基本信息" style="padding: 20px; height: 650px;">
            <div class="BtnLine easyui-panel tc pt20 pb20">
                <button type="button" class="easyui-linkbutton" onClick="window.parent.reLoad('系统状况')">关闭</button>
            </div>
            <div style="padding: 5px;  /**width: 1000px;height: 850px;**/" class="easyui-panel">
                <div style="padding: 5px; width: 98%; height: auto" class="easyui-panel" id="no1" title="JVM内存信息">
                    <hr style="width:91%; border:0.5px solid #c6c6c6; float:left;" />
                    <table class="conDetailTable">
                        <tr>
                            <td width="15%" class="tr">JVM未使用内存：&nbsp;&nbsp;</td>
                            <td width="35%">
                                <div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.jvmFreeMem/serverStatusEntity.jvmMaxMem*100 }"></div>
                            </td>
                            <td>${serverStatusEntity.jvmFreeMem}M</td>
                        </tr>
                        <tr>
                            <td class="tr">JVM总内存：&nbsp;&nbsp;</td>
                            <td>
								<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.jvmTotalMem/serverStatusEntity.jvmMaxMem*100 }"></div>                            
							</td>
                            <td>${serverStatusEntity.jvmTotalMem}M</td>
                        </tr>
                        <tr>
                            <td class="tr">JVM最大内存：&nbsp;&nbsp;</td>
                            <td colspan="2">${serverStatusEntity.jvmMaxMem}M</td>
                        </tr>
                    </table>
                </div>
                <div style="padding: 5px; width: 98%; height: auto" class="easyui-panel" id="no1" title="系统内存${serverStatusEntity.totalMem}M">
                    <hr style="width:91%; border:0.5px solid #c6c6c6; float:left;" />
                    <table class="conDetailTable">
                        <tr>
                            <td width="15%" class="tr">系统内存-已使用：&nbsp;&nbsp;</td>
                            <td width="35%">
								<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.usedMem/serverStatusEntity.totalMem*100 }"></div>  
							</td>
                            <td>${serverStatusEntity.usedMem}M</td>
                        </tr>
                        <tr>
                            <td class="tr">系统内存-未使用：&nbsp;&nbsp;</td>
                            <td>
								<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.freeMem/serverStatusEntity.totalMem*100 }"></div>                            
							<td>${serverStatusEntity.jvmTotalMem}M</td>
                        </tr>
                    </table>
                </div>
                <div style="padding: 5px; width: 98%; height: auto" class="easyui-panel" id="no1" title="数据交换${serverStatusEntity.totalSwap}M">
                    <hr style="width:91%; border:0.5px solid #c6c6c6; float:left;" />
                    <table class="conDetailTable">
                        <tr>
                            <td width="15%" class="tr">数据交换-已使用：&nbsp;&nbsp;</td>
                            <td width="35%">
				            	<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.usedSwap/serverStatusEntity.totalSwap*100 }"></div>
							</td>
                            <td>${serverStatusEntity.usedSwap}M</td>
                        </tr>
                        <tr>
                            <td class="tr">数据交换-未使用：&nbsp;&nbsp;</td>
                            <td>
				            	<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.freeSwap/serverStatusEntity.totalSwap*100 }"></div>
							</td>
							<td>${serverStatusEntity.freeSwap}M</td>
                        </tr>
                    </table>
                </div>
                 <div style="padding: 5px; width: 98%; height: auto" class="easyui-panel" id="no1" title="系统情况">
                    <hr style="width:91%; border:0.5px solid #c6c6c6; float:left;" />
                    <table class="conDetailTable">
                        <tr>
                            <td width="15%" class="tr">系统时间：&nbsp;&nbsp;</td>
                            <td width="35%">
				            	${serverStatusEntity.serverTime}
							</td>
							<td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="tr">系统名称：&nbsp;&nbsp;</td>
                            <td>
				            	${serverStatusEntity.serverName}
							</td>
                        </tr>
                        <tr>
                            <td class="tr">操作系统：&nbsp;&nbsp;</td>
                            <td>
				            	${serverStatusEntity.serverOs}
							</td>
                        </tr>
                        <tr>
                            <td class="tr">Java安装路径：&nbsp;&nbsp;</td>
                            <td>
				            	${serverStatusEntity.javaHome}
							</td>
                        </tr>
                        <tr>
                            <td class="tr">Java临时文件：&nbsp;&nbsp;</td>
                            <td>
				            	${serverStatusEntity.javaTmpPath}
							</td>
                        </tr>
                        <tr>
                            <td class="tr">Java版本：&nbsp;&nbsp;</td>
                            <td>
				            	${serverStatusEntity.javaVersion}
							</td>
                        </tr>
                        <tr>
                            <td class="tr">CPU使用情况：&nbsp;&nbsp;</td>
                            <td>
				            	${serverStatusEntity.cpuUsage}
							</td>
                        </tr>
                        <tr>
                            <td class="tr">IP：&nbsp;&nbsp;</td>
                            <td>
				            	${serverStatusEntity.ip}
							</td>
                        </tr>
                    </table>
                </div>
                <div style="padding: 5px;height:auto;min-height:29%;" class="easyui-panel" id="sysStatusp" title="系统情况">
                    <hr style="width:91%; border:0.5px solid #c6c6c6; float:left;" />
                    <%-- <table class="conDetailTable">
                    	<thead>
							<tr>
								<th>名称</th>
								<th>编号ID</th>
								<th>频</th>
								<th>处理器供应商</th>
								<th>CPU model</th>
								<th>空闲率%</th>
								<th>使用率（格式化）%</th>
								<th>使用率（初始化）%</th>
							</tr>
						</thead>
                        <tbody>
							<c:forEach items="${serverStatusEntity.cpuInfos }" var="cpuVar"
								varStatus="index">
								<tr>
									<td>CPU${index.index+1 }</td>
									<td>${cpuVar.id }</td>
									<td>${cpuVar.totalMHz }MHz</td>
									<td>${cpuVar.vendor }</td>
									<td>${cpuVar.model }</td>
									<td>
										<input class="knob" data-width="100" data-fgColor="green" data-bgColor="#303030" data-readonly="true"
										data-skin="tron" data-thickness=".3"  value="${fn:substringBefore(cpuVar.idle,'%') }" >
									</td>
									<td><input class="knob" data-width="100" data-fgColor="green" data-bgColor="#303030" data-readonly="true"
										data-skin="tron" data-thickness=".3"  value="${fn:substringBefore(cpuVar.used,'.') }" ></td>
									<td>
										<input class="knob" data-width="100" data-fgColor="green" data-bgColor="#303030" data-readonly="true"
										data-skin="tron" data-thickness=".3"  value="${fn:substringBefore(cpuVar.usedOrigVal*100,'.') }" >
									</td>
								</tr>
							</c:forEach>
						</tbody>
                    </table> --%>
                    <table id="systatusDatagrid"></table>
                </div>
                <div style="padding: 5px;height:auto;min-height:15%;" class="easyui-panel" id="sysStatusp2" title="系统情况">
                    <hr style="width:91%; border:0.5px solid #c6c6c6; float:left;" />
                    <table id="systatusDatagrid2"></table>
                </div>
            <div class="BtnLine easyui-panel tc pt20 pb20">
                <button type="button" class="easyui-linkbutton" onClick="window.parent.reLoad('系统状况')">关闭</button>
            </div>
        </div>
    </div>
</div>
</div>
<script type="text/javascript">
var systatusDatagrid,systatusDatagrid2;
$(function() {
	var s=60;
    systatusDatagrid = $('#systatusDatagrid').datagrid({
    	data:${serverStatusJSON.cpuInfos},
		singleSelect : false,
		rownumbers:true,
		striped:true,
		fit:true,
		columns : [ [ {
			field : 'id',
			title : '编号ID',
			width : 100,
			align : 'left',
		}, {
			field : 'totalMHz',
			title : '频',
			width : 100,
			align : 'left',
		} , {
			field : 'vendor',
			title : '处理器供应商',
			width : 100,
			align : 'left',
		} , {
			field : 'model',
			title : 'CPU model',
			width : 220,
			align : 'left',
		}, {
			field : 'idle',
			title : '空闲率%',
			width : 100,
			align : 'left',
			formatter:function(v,r){
				v=v?v.substr(0,v.length-1):"";
				return "<input class=\"knob\" data-width=\""+s+"\" data-height=\""+s+"\" data-fgColor=\"green\" data-bgColor=\"#303030\" data-readonly=\"true\"\
					data-skin=\"tron\" data-thickness=\".3\"  value='"+v+"' >";
			} 
		}, {
			field : 'used',
			title : '使用率（格式化）%',
			width : 150,
			align : 'left',
			formatter:function(v,r){
				v=v?v.substr(0,v.length-1):"";
				return "<input class=\"knob\" data-width=\""+s+"\" data-height=\""+s+"\" data-fgColor=\"green\" data-bgColor=\"#303030\" data-readonly=\"true\"\
					data-skin=\"tron\" data-thickness=\".3\"  value='"+v+"' >";
			}
		} , {
			field : 'usedOrigVal',
			title : '使用率（初始化）%',
			width : 150,
			align : 'left',
			formatter:function(v,r){
				//v=v?v.substr(0,v.length-1):"";
				return "<input class=\"knob\" data-width=\""+s+"\" data-height=\""+s+"\" data-fgColor=\"green\" data-bgColor=\"#303030\" data-readonly=\"true\"\
					data-skin=\"tron\" data-thickness=\".3\"  value='"+v+"' >";
			}
		} ] ]
	});
    systatusDatagrid2 = $('#systatusDatagrid2').datagrid({
    	data:${serverStatusJSON.diskInfos},
		singleSelect : false,
		rownumbers:true,
		striped:true,
		fit:true,
		columns : [ [ {
			field : 'devName',
			title : '磁盘名称',
			width : 100,
			align : 'left',
		}, {
			field : 'dirName',
			title : '驱动器名称',
			width : 100,
			align : 'left',
		} , {
			field : 'sysTypeName',
			title : '系统类型',
			width : 100,
			align : 'left',
		} , {
			field : 'typeName',
			title : '类型',
			width : 220,
			align : 'left',
		}, {
			field : 'totalSize',
			title : '总大小(GB)',
			width : 100,
			align : 'left'
		},{
			field : 'usedSize',
			hidden:true
		}, {
			field : 'availSize',
			title : '已用||未用（单位GB）',
			width : 150,
			align : 'left',
			formatter:function(v,r,i){
				return r.usedSize+"||"+r.availSize;	
			}
		}  ] ]
	});
    $(".knob").knob({
		max: 100,
		min: 0,
		thickness: .3,
		fgColor: '#2B99E6',
		bgColor: '#303030',
		'release':function(e){
		}
    });
});
</script>

