$(function () {
    
    initHeight();
    $(window).resize(function () {
        initHeight();
    })
})
function initHeight() {
    var headerH = $('#header').height(), footerH = $('#footer').height(), winH = $(window).height();
    if ($('#header') || $('#footer')) {
        $('.center_con').css('minHeight', winH - headerH - footerH);
    }
}