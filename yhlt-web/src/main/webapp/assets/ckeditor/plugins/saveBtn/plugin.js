(function(){
	var columns=["项目","分值","评分细则"];
	var types=["商务部分","技术部分","价格部分"];
	var errorColor="red";
    //Section 1 : 按下自定义按钮时执行的代码 
    var a= { 
        exec:function(editor){
        	var htm=editor.getData();
        	var result=myFns.ckFn(editor);
        	if(result){
        		myFns.msg("表格数据校验通过！",1);
        		save(htm);
        	}
        } 
    }, 
    saveBtn='saveBtn'; 
    CKEDITOR.plugins.add(saveBtn,{ 
        init:function(editor){ 
            editor.addCommand(saveBtn,a); 
            editor.ui.addButton(saveBtn,{ 
                label:'保存', 
                icon: this.path + 'icons/sava15.png', 
                command:saveBtn
            }); 
        } 
    }); 
	function save(ht){
		var pmp={};
		pmp["html"]=ht;
		pmp.noticeId=noticeId;
		$.ajax({
			url:dynamicURL+"/notice/score/template/analytic",
			dataType:"JSON",
			data:pmp,
			cache:false,
			type:"POST",
			success:function(msg){
				if(msg.success){
					myFns.msg("保存成功！",1);
				}else{
					myFns.msg(msg.msg);
				}
			}
		});
	}
})(); 