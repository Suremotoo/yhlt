function graphTrace(pid){
	$.getJSON(dynamicURL + '/workflow/activitys?pid='+pid, function(data) {
		var imageUrl = dynamicURL + "/workflow/graph?pid="+pid+"&a="+Math.random(99999999);
		// 生成图片边框和节点自定义信息
		var positionHtml = '';
		var varsArray = new Array();
		$.each(data, function(i,v) {
			var $positionDiv = $('<div/>', {
		        'class': 'activity-attr'
		    }).css({
		        position: 'absolute',
		        left: (v.x),
		        top: (v.y),
		        width: (v.width),
		        height: (v.height),
		        backgroundColor: 'black',
		        opacity: 0,
		        zIndex: 1000
		    });
		    // 节点边框
		   /*var $border = $('<div/>', {
		        'class': 'activity-attr-border'
		    }).css({
		        position: 'absolute',
		        left: (v.x),
		        top: (v.y),
		        width: (v.width),
		        height: (v.height),
		        zIndex: 999
		    });
		    if (v.currentActiviti) {
		        $border.addClass('ui-corner-all-12').css({
		            border: '5px solid red'
		        });
		    }*/
		    positionHtml += $positionDiv.get(0).outerHTML;
		    varsArray[varsArray.length] = v.vars;
			
		});

		$('#workflowTraceDialog img').attr('src', imageUrl);
		$('#workflowTraceDialog #processImageBorder').html(positionHtml);

		$('#workflowTraceDialog .activity-attr').each(function(i, v) {
		    $(this).data('vars', varsArray[i]);
		});

	    // 此处用于显示每个节点的信息，如果不需要可以删除
		$('.activity-attr').tooltip(
		{
			position : 'right',
			content:'',
			onShow : function() {
			    var tipContent = "<table>";
				var vars = $(this).data('vars');
				var i = 0;
				var style = "";
	            $.each(vars,function(k, v) {
	            	if(i % 2 != 1){
	            		style = "background-color:#F2F2F2;font-size:13px;";
	            	}
	                if (v) {
	                    tipContent += "<tr style=" + style + "><td style='text-align:right;font-weight:bold;'>" + k + "&nbsp;&nbsp;</td><td>" + v + "<td/></tr>";
	                }
	                style = "font-size:13px;";
	                i = i + 1;
	            });
	            tipContent += "</table>"; 
				$(this).tooltip('tip').css({
					backgroundColor : '#FFFFA3',
					borderColor : '#F1D031'
				});
				$(this).tooltip("update",tipContent);
			}
		});
		
	});	
}