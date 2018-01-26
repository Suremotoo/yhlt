(function(){
    var a= { 
        exec:function(editor){ 
        	editor.setData(defaultData);
        } 
    }, 
    refreshBtn='refreshBtn'; 
    CKEDITOR.plugins.add(refreshBtn,{ 
        init:function(editor){ 
            editor.addCommand(refreshBtn,a); 
            editor.ui.addButton(refreshBtn,{ 
                label:'刷新', 
                icon: this.path + 'icons/reload.png', 
                command:refreshBtn
            }); 
        } 
    }); 
})(); 