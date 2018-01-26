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
</style>
<div class="easyui-layout layout" fit="true">
    <div id="container" class="easyui-layout layout" fit="true">
        <div region="center" border="false" style="overflow: auto;"> 
       		<div  style="padding: 10px; width: 98%;font-size: 24px;" class="easyui-panel">
		        <div id="p1" class="easyui-panel" title="JVM内存信息" style="width:98%;height:200px;padding:10px;"data-options="collapsible:true">
		            <table  style="width: 98%;">
				        <tr>
				            <td>JVM未使用内存</td>
				            <td>
				            	<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.jvmFreeMem/serverStatusEntity.jvmMaxMem*100 }"></div>
				            </td>
				            <td>${serverStatusEntity.jvmFreeMem}M</td>
				        </tr>
				        <tr>
				            <td>JVM总内存</td>
				            <td>
				            	<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.jvmTotalMem/serverStatusEntity.jvmMaxMem*100 }"></div>
				            </td>
				            <td>${serverStatusEntity.jvmTotalMem}M</td>
				        </tr>
				        <tr>
				            <td>JVM最大内存</td>
				            <td colspan="2">${serverStatusEntity.jvmMaxMem}M</td>
				        </tr>
				    </table>
		        </div>
		        <div id="p2" class="easyui-panel" title="系统内存${serverStatusEntity.totalMem}M" style="width:98%;height:200px;padding:10px;"data-options="collapsible:true">
		            <table  style="width: 98%;">
				        <tr>
				            <td>系统内存-已使用</td>
				            <td>
				            	<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.usedMem/serverStatusEntity.totalMem*100 }"></div>
				            </td>
				            <td>${serverStatusEntity.usedMem}M</td>
				        </tr>
				        <tr>
				            <td>系统内存-未使用</td>
				            <td>
				            	<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.freeMem/serverStatusEntity.totalMem*100 }"></div>
				            </td>
				            <td>${serverStatusEntity.freeMem}M</td>
				        </tr>
				    </table>
		        </div>
		        <div id="p3" class="easyui-panel" title="数据交换${serverStatusEntity.totalSwap}M" style="width:98%;height:200px;padding:10px;"data-options="collapsible:true">
		            <table  style="width: 98%;">
				        <tr>
				            <td>数据交换-已使用</td>
				            <td>
				            	<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.usedSwap/serverStatusEntity.totalSwap*100 }"></div>
				            </td>
				            <td>${serverStatusEntity.usedSwap}M</td>
				        </tr>
				        <tr>
				            <td>数据交换-未使用</td>
				            <td>
				            	<div id="p" class="easyui-progressbar" style="width:50%" data-options="value:${serverStatusEntity.freeSwap/serverStatusEntity.totalSwap*100 }"></div>
				            </td>
				            <td>${serverStatusEntity.freeSwap}M</td>
				        </tr>
				    </table>
		        </div>
		        <div id="p4" class="easyui-panel" title="系统情况" style="width:98%;height:250px;padding:10px;"data-options="collapsible:true">
		            <table  style="width: 98%">
						<thead>
							<tr>
								<td>系统时间</td>
								<td>${serverStatusEntity.serverTime}</td>
							</tr>
							<tr>
								<td>系统名称</td>
								<td>${serverStatusEntity.serverName}</td>
							</tr>
							<tr>
								<td>操作系统</td>
								<td>${serverStatusEntity.serverOs}</td>
							</tr>
							<tr>
								<td>Java安装路径</td>
								<td>${serverStatusEntity.javaHome}</td>
							</tr>
							<tr>
								<td>Java临时文件</td>
								<td>${serverStatusEntity.javaTmpPath}</td>
							</tr>
							<tr>
								<td>Java版本</td>
								<td>${serverStatusEntity.javaVersion}</td>
							</tr>
							<tr>
								<td>CPU使用情况</td>
								<td>${serverStatusEntity.cpuUsage}</td>
							</tr>
							<tr>
								<td>IP</td>
								<td>${serverStatusEntity.ip}</td>
							</tr>
						</thead>
					</table>
		        </div>
		        
		        <div id="p4" class="easyui-panel" title="系统情况" style="width:98%;height:100%;padding:10px;"data-options="collapsible:true">
		           <table style="width: 98%">
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
					</table>
		        </div>
		        
		        <div id="p4" class="easyui-panel" title="系统情况" style="width:98%;height:300px;padding:10px;"data-options="collapsible:true">
		           <table style="width: 98%">
						<thead>
							<tr>
								<th>磁盘名称</th>
								<th>驱动器名称</th>
								<th>系统类型</th>
								<th>类型</th>
								<th>总大小</th>
								<th>已用||未用（单位GB）</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${serverStatusEntity.diskInfos }" var="diskVar"
								varStatus="index">
								<tr>
									<td>${diskVar.devName }</td>
									<td>${diskVar.dirName }</td>
									<td>${diskVar.sysTypeName }</td>
									<td>${diskVar.typeName }</td>
									<td>${diskVar.totalSize }GB</td>
									<td>${diskVar.usedSize}||${diskVar.availSize}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
		        </div>
		        
		        
	        </div>
        </div>
    </div>
</div>
<script type="text/javascript">
	$(function() {
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

