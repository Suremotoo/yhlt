// JavaScript Document

 //加入收藏
        function AddFavorite(sURL, sTitle) {
            sURL = encodeURI(sURL); 
        try{   
            window.external.addFavorite(sURL, sTitle);   
        }catch(e) {   
            try{   
                window.sidebar.addPanel(sTitle, sURL, "");   
            }catch (e) {   
                alert("加入收藏失败，请使用Ctrl+D进行添加,或手动在浏览器里进行设置.");}}}
    //设为首页
    function SetHome(url){
        if (document.all) {
            document.body.style.behavior='url(#default#homepage)';
               document.body.setHomePage(url);
        }else{
            alert("您好,您的浏览器不支持自动设置页面为首页功能,请您手动在浏览器里设置该页面为首页!");}}


$('#time').jclock({withDate:true, withWeek:true});

jQuery(".navBar").slide({ 
		titCell:".nav .m", // 鼠标触发对象
		mainCell:".subNav", // 切换对象包裹层
		delayTime:0, // 效果时间
		triggerTime:0, //鼠标延迟触发时间
		returnDefault:true,  //返回默认状态
		//defaultPlay:false,// 第一次运行是否执行效果
		trigger:"click"// 切换响应方式
		/*
	   ,endFun:function(i,c){
		   console.log(i);
		   console.log(c);
	    	$('#test').addClass("on");
	    }*/
});

//焦点图
jQuery(".focusBox").slide({ titCell:".num li", mainCell:".pic",effect:"fold", autoPlay:true,trigger:"click",
			startFun:function(i){
				 jQuery(".focusBox .txt li").eq(i).animate({"bottom":0}).siblings().animate({"bottom":-36});
			}
		});

//TAB选项卡
jQuery(".slideTxtBox").slide({effect:"fade",trigger:"click"});

//首页入园企业
jQuery(".qy").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"left",autoPlay:true,scroll:3,vis:3,trigger:"click"});

//首页企业文化
jQuery(".index-main .qywh .list").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"left",autoPlay:true,scroll:1,vis:1,trigger:"click"});

//首页图片新闻无缝滚动
jQuery(".pic-news").slide({mainCell:".bd ul",autoPlay:true,effect:"leftMarquee",vis:5,interTime:50});

/* 封面页TAB切换 */
$("#tabRank li").hover(function(){ $(this).addClass("on").siblings().removeClass("on")},function(){ });
/* Tab切换 */
$("#tabRank").slide({ titCell:"dt h3", mainCell:"dd",autoPlay:false,trigger:"click",effect:"left",delayTime:300 });


jQuery(".picCenter dl").slide({ mainCell:"ul", effect:"leftLoop"});

/* 大事记 */
$(function(){
    /*$().timelinr({
		autoPlay: 'false', //改为ture就是自动滚动
		autoPlayDirection: 'forward',
		startAt: 4
	})*/
	$("#top").removeClass("on");
});
