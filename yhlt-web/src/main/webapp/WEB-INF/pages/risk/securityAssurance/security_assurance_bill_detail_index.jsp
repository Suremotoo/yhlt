<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="/tld/security.tld" %>
<style type="text/css">
.
* {
	margin: 0;
	padding: 0;
}

#billTable {
	margin: auto;
	width: 680px;
	table-layout: fixed;
	border-collapse: collapse;
}

tr,td,th {
	border: 1px solid #000;
	padding: 5px;
	text-align: center;
}
/*  符合 */
.status0{
	color:green;
}
/*  不符合 */
.status1{
	color:orange;
}
/*  未检查 */
.status2{
	color:red;
}
/*  不适用 */
.status3{
	color:#963;
}
</style>
<div id="wrap">
	<form action="" method="post">
		<table cellspacing="0" id="billTable">
			<thead>
				<tr style="border: none">
					<th colspan="4" style="border: none">检查记录单</th>
				</tr>
				<tr>
					<th>被检查单位</th>
					<th>管理员</th>
					<th>检查日期</th>
					<th>${requestScope.bill.billDate }</th>
				</tr>
				<tr>
					<th>序号</th>
					<th>检查内容和依据</th>
					<th>检查标准</th>
					<th>检查记录/结果</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="billName" items="${requestScope.allBills }" varStatus="index">
					<tr>
						<td>${billName.securityAssuranceTypeTwoId }</td>
						<td>【检查内容】 <br />${billName.securityAssuranceTypeTwoName } <br />
						【检查依据】 <br />${billName.securityAssuranceGistName }
						</td>
						<td>${billName.securityAssuranceStandardName }</td>
						<td><span title="status${billName.status }">${billName.statusWrapper }</span></td>
					</tr>
			</c:forEach>
			<tr>
				<td colspan="4" style="text-align: left"><p>处理意见:</p><textarea style="width:100%;border:0"></textarea></td>
			</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" style="text-align: left"><p>被检查员签字:</p><img style="width:300px;height:300px" src="xxx.jpg" alt="被检查单位签名"/></td>
				</tr>
			</tfoot>
		</table>
		<div class="BtnLine">
             	<security:ifAny authorization="用户管理_管理员">
                	<button type="button" class="easyui-linkbutton submit">保存</button>
	            </security:ifAny> 
                <button type="button" class="easyui-linkbutton" onClick="window.parent.parent.reLoad('安保专项检查单详情');">关闭</button>
         </div>
	</form>
</div>
<script>

//函数说明：合并指定表格（表格id为_w_table_id）指定列（列数为_w_table_colnum）的相同文本的相邻单元格
//参数说明：_w_table_id 为需要进行合并单元格的表格的id。如在HTMl中指定表格 id="data" ，此参数应为 #data 
//参数说明：_w_table_colnum 为需要合并单元格的所在列。为数字，从最左边第一列为1开始算起。
function _w_table_rowspan(_w_table_id,_w_table_colnum){
  _w_table_firsttd = "";
  _w_table_currenttd = "";
  _w_table_SpanNum = 0;
  _w_table_Obj = $(_w_table_id + " tr td:nth-child(" + _w_table_colnum + ")");
  _w_table_Obj.each(function(i){
    if(i==0){
      _w_table_firsttd = $(this);
      _w_table_SpanNum = 1;
    }else{
      _w_table_currenttd = $(this);
      if(_w_table_firsttd.text()==_w_table_currenttd.text()){
        _w_table_SpanNum++;
        _w_table_currenttd.hide(); //remove();
        _w_table_firsttd.attr("rowSpan",_w_table_SpanNum);
      }else{
        _w_table_firsttd = $(this);
        _w_table_SpanNum = 1;
      }
    }
  }); 
}
//函数说明：合并指定表格（表格id为_w_table_id）指定行（行数为_w_table_rownum）的相同文本的相邻单元格
//参数说明：_w_table_id 为需要进行合并单元格的表格id。如在HTMl中指定表格 id="data" ，此参数应为 #data 
//参数说明：_w_table_rownum 为需要合并单元格的所在行。其参数形式请参考jQuery中nth-child的参数。
//     如果为数字，则从最左边第一行为1开始算起。
//     "even" 表示偶数行
//     "odd" 表示奇数行
//     "3n+1" 表示的行数为1、4、7、10.......
//参数说明：_w_table_maxcolnum 为指定行中单元格对应的最大列数，列数大于这个数值的单元格将不进行比较合并。
//     此参数可以为空，为空则指定行的所有单元格要进行比较合并。
function _w_table_colspan(_w_table_id,_w_table_rownum,_w_table_maxcolnum){
  if(_w_table_maxcolnum == void 0){_w_table_maxcolnum=0;}
  _w_table_firsttd = "";
  _w_table_currenttd = "";
  _w_table_SpanNum = 0;
  $(_w_table_id + " tr:nth-child(" + _w_table_rownum + ")").each(function(i){
    _w_table_Obj = $(this).children();
    _w_table_Obj.each(function(i){
      if(i==0){
        _w_table_firsttd = $(this);
        _w_table_SpanNum = 1;
      }else if((_w_table_maxcolnum>0)&&(i>_w_table_maxcolnum)){
        return "";
      }else{
        _w_table_currenttd = $(this);
        if(_w_table_firsttd.text()==_w_table_currenttd.text()){
          _w_table_SpanNum++;
          _w_table_currenttd.hide(); //remove();
          _w_table_firsttd.attr("colSpan",_w_table_SpanNum);
        }else{
          _w_table_firsttd = $(this);
          _w_table_SpanNum = 1;
        }
      }
    });
  });
}
$(document).ready(function(){ 
 _w_table_rowspan("#billTable",1);
 _w_table_rowspan("#billTable",2);
 
 var arr = $('#billTable td span');
 $.each(arr, function(index, val) {
     var status = $(val).attr('title');
     $(val).addClass(status);
 });
 
});
</script>