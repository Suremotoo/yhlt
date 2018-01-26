<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title></title>
</head>

<body>
    <div class="content-body content-sub-body">
    	<section class="corner-all">
            <table id="${module.container }" class="datagrid-custom-resize"></table>
        </section>
	</div>
	
	<script>
	    $(function () {
	    	${module.content}
	    	
	    	
		});
	</script>
	
<style>
<!--
    #tip{  
        position: absolute;  
        width: 300px;  
        max-width: 400px;  
        text-align: left;  
        padding: 4px;  
        border: #87CEEB solid 1px;  
        border-radius: 1px;  
        background: #ffffff;  
        z-index: 9999999
    }  
    #tip ul{  
        margin: 0;  
        padding: 0;  
    }  
    #tip ul li{  
        font-family:'Microsoft YaHei', 微软雅黑, 'Microsoft JhengHei', 宋体;  
        font-size:15px;  
        list-style: none;  
        padding-left: 40px;  
    }  
-->
</style>  
</body>
</html>