$.divselect = function(divselectid,inputselectid) {
	var inputselect = $(inputselectid);
	$(divselectid+" cite").click(function(){
		$(divselectid+" ul").toggle("fast");
	});
	$(divselectid+" ul li a").click(function(){
		var txt = $(this).text();
		$(divselectid+" cite").html(txt);
		var value = $(this).attr("value");
		inputselect.val(value);
		inputselect.change();
		$(divselectid+" ul").toggle("fast");
	});
};