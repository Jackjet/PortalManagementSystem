// JavaScript Document






//右边扫二维码加关注 置顶

$(function(){

	var tophtml="<div id=\"izl_rmenu\" class=\"izl-rmenu\"><div class=\"btn btn-wx1\" onclick=\"window.location.href='http://58.117.146.51:8888'\"></div><div class=\"btn btn-wx\"><img class=\"pic\" src=\"/DYYX/images/weixin.jpg\" /></div><div class=\"btn btn-back\"></div><div class=\"btn btn-top\"></div></div>";
	$("#top").html(tophtml);
	$("#izl_rmenu").each(function(){
		$(this).find(".btn-wx").mouseenter(function(){
			$(this).find(".pic").fadeIn("fast");
		});
		$(this).find(".btn-wx").mouseleave(function(){
			$(this).find(".pic").fadeOut("fast");
		});
		$(this).find(".btn-back").mouseenter(function(){
			$(this).find(".back").fadeIn("fast");
		});
		$(this).find(".btn-back").mouseleave(function(){
			$(this).find(".back").fadeOut("fast");
		});

		$(this).find(".btn-top").click(function(){
			$("html, body").animate({
				"scroll-top":0
			},"fast");
		});
		$(this).find(".btn-back").click(function(){
			history.go(-1);
		});
	});
	var lastRmenuStatus=false;
	$(window).scroll(function(){//bug
		var _top=$(window).scrollTop();
		if(_top>200){
			$("#izl_rmenu").data("expanded",true);
		}else{
			$("#izl_rmenu").data("expanded",false);
		}
		if($("#izl_rmenu").data("expanded")!=lastRmenuStatus){
			lastRmenuStatus=$("#izl_rmenu").data("expanded");
			if(lastRmenuStatus){
				$("#izl_rmenu .btn-top").slideDown();
			}else{
				$("#izl_rmenu .btn-top").slideUp();
			}
		}
	});
});
$(function () {
    var initHeight = (function () {
        if ($('#header') && $('#footer')) {
            var headerHeight = parseInt($('#header').height()),
            footerHeight = parseInt($('#footer').height()),
            windowHeight = parseInt($(window).height());
            $('#initheight').css({ 'minHeight': windowHeight - headerHeight - footerHeight + 'px' });
        }
    })();
})













































