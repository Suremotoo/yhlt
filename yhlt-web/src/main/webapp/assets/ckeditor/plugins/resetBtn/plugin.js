(function($){
    var a= { 
        exec:function(editor){
        	$.ajax({
				url: dynamicURL+"code/noticeCodeTemplate.json",
				dataType:"text",
				contentType:"application/x-www-form-urlencoded; charset=utf8", 
				async:false,
				success:function(data){
					editor.setData(data);
				}
			});   
        } 
    }, 
    resetBtn='resetBtn'; 
    CKEDITOR.plugins.add(resetBtn,{ 
        init:function(editor){ 
            editor.addCommand(resetBtn,a); 
            editor.ui.addButton(resetBtn,{ 
                label:'模板', 
                icon: this.path + 'icons/reload.png', 
                command:resetBtn
            }); 
        } 
    }); 
})($); 