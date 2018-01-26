var myFns={};
(function(){
	var columns=["项目","分值","评分细则"];
	var types=["商务部分","技术部分","价格部分"];
	var errorColor="red";
	var Msg;
	var check;
    //Section 1 : 按下自定义按钮时执行的代码 
    var a= { 
        exec:function(editor){ 
        	var result=check(editor);
        	if(!!result){
        		Msg("表格数据校验通过！",1);
        	}
        } 
    }, 
    //Section 2 : 创建自定义按钮、绑定方法 
    checkBtn='checkBtn'; 
    CKEDITOR.plugins.add(checkBtn,{ 
        init:function(editor){ 
            editor.addCommand(checkBtn,a); 
            editor.ui.addButton(checkBtn,{ 
                label:'校验', 
                icon: this.path + 'icons/gou.png', 
                command:checkBtn 
            }); 
        } 
    }); 
    check=myFns.ckFn=function check(editor){
    	$("#errorMsg").css({"display":"none"});
		var data=$(editor.getData());
    	data=clear(data,editor);
		if(!data.is("table")){
			Msg("请填写【评分标准表格】！");
			return false;
		}
		if(data.find("tr:eq(0)>td").length!=3){
			Msg("表头不能修改！");
			data.find("tr:eq(0)").css({"background":errorColor});
			editor.setData(data.prop("outerHTML"));
			return false;
		}
		//检测分类完整-->>
		var typez=[];
		var trx=data.find("tr:gt(0)");
		for(var c=0,d=trx.length;c<d;c++){
			var tr=$(trx.get(c));
			var tds=tr.find("td");
			for(var e=0,f=tds.length;e<f;e++){
				//检验列数-->>
				if(tds.length!=4){
					tr.css({"background":errorColor});
					editor.setData(data.prop("outerHTML"));
					Msg("【列】不允许修改，请重新检查！");
					return false;
				}
				//检验列数--<<
				var td=$(tds.get(e));
				var htm=td.html();
				htm=htm.replace(/&nbsp;/g,'');
				htm=htm.replace(/\n/g,'');
				htm=htm.replace(/\t/g,'');
				htm=htm.replace(/\f/g,'');
				htm=htm.replace(/\r/g,'');
				if(!htm.replace(/&nbsp;/g,/\n\t\f\r/,'')){
					td.css({"background":errorColor});
					editor.setData(data.prop("outerHTML"));
					Msg("信息不完整！");
					return false;
				}
			}
			if(tr.find("td:eq(0):contains(商务部分)").length){
				typez.push("商务部分");
			}else if(tr.find("td:eq(0):contains(技术部分)").length){
				typez.push("技术部分");
			}else if(tr.find("td:eq(0):contains(价格部分)").length){
				typez.push("价格部分");
			}else{
				tr.css({"background":errorColor});
				editor.setData(data.prop("outerHTML"));
				Msg("存在无效信息，请重新检查！");
				return false;
			}
		}
		for(var a=0,b=types.length;a<b;a++){
			var tp=types[a];
			if(typez.join().indexOf(tp)==-1){
				Msg("请填写【"+tp+"】评分标准！");
				return false;
			}
		}
		//检测分类完整--<<
		var trs=data.find("tr:gt(0)");
		for(var i=0,j=trs.length;i<j;i++){
			var tr=$(trs[i]);
			var numOfTd=tr.find("td").length;
			var tdz=tr.find("td:eq("+(numOfTd-2)+")");
			var fz=tdz.children().html()||tdz.html();
			fz=fz.replace(/&nbsp;|\n|\t|\f|\r/g,'');
			if(tdz.children().length>1 || isNaN(fz)){
				Msg("【分值】只能填数字，请重新检查！");
				tdz.css({"background":errorColor});
				editor.setData(data.prop("outerHTML"));
				return false;
			}
		}
		var tds=data.find("tr:eq(0)>td");
		var c=0;
		var colstr=columns.join();
		for(var i=0,j=tds.length;i<j;i++){
			var td=tds.get(i);
			if(colstr.indexOf($(td).find("p>strong").html())!=-1){
				c++;
			}
		}
		if(c!=columns.length){
			Msg("【列】不完整，无法通过校验！");
			return false;
		}
		clear(data,editor);
		return true;
    }
    function clear(data,editor){
		var dt=data.prop("outerHTML").replace(/red/g,"");
		editor.setData(dt);
		return $(dt);
    }
	//#FFF3F3
	Msg=myFns.msg=function Msg(msg,type){
		var cont=$("#contentFormId + span");
		var top=cont.offset().top + 50;
		var left=cont.offset().left + 28;
		var fontColor=type==1?"#3C763D":"#A8403D";
		var bgColor=type==1?"#DFF0D8":"#F2DEDF";
		var emsg=$("#errorMsg");
		if(!emsg.length){
			$(document.body).append("<div tabindex='-1' id='errorMsg'  class='tooltip tooltip-right' style='width:auto;text-align:center;max-width:500px;min-width:200px;filter: alpha(opacity = 50);filter: alpha(opacity = 50);opacity: 0.5;-moz-opacity: 0.5;-khtml-opacity: 0.5;line-height:30px;display:none;position: absolute;top:"+top+"px;left:"+left+"px;z-index: 9900000;outline: none;opacity: 1;filter: alpha(opacity=100);padding:5px;border-width: 1px;border-style: solid;border-radius: 5px;-moz-border-radius: 5px 5px 5px 5px;-webkit-border-radius: 5px 5px 5px 5px;margin: -6px 0 0 -12px;border-radius: 5px 5px 5px 5px;display: block; color: "+fontColor+";border-color: rgb(204, 153, 51); background-color: "+bgColor+"'><div class='tooltip-content style='font-family:Microsoft YaHei;word-break: break-all;word-wrap: break-word;white-space: pre-wrap;width:200px'>"+msg+"</div></div>");
		}else{
			emsg.find("div:eq(0)").html(msg);
			emsg.css({"background-color":bgColor});
			emsg.css({"color":fontColor});
			emsg.css({"top":top});
			emsg.css({"left":left});
		}
		emsg.show();
		setTimeout(function(){$("#errorMsg").css({"display":"none"});},4000);
	}
})(); 