function enumSystemType(type) {
    var msg = "";
    switch (type) {
        case "教学工作": msg = 11; break;
        case "德育工作": msg = 16; break;
        case "科研工作": msg = 20; break;
        case "成校管理": msg = 39; break;
        case "社会培训": msg = 35; break;
        case "党建园地": msg = 45; break;
        //case "学生风采": msg = 60; break;
        //case "通知公告": msg = 62; break;
        //case "首页滚动图片": msg = 73; break;
        //case "新闻快讯": msg = 82; break;
    }
    return msg;
}

function escape2Html(str) {
    var arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' };
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t]; });
}

$(function () {
    var initHeight = (function () {
        if ($('#header') && $('#footer')) {
            var headerHeight = parseInt($('#header').height()),
            footerHeight = parseInt($('#footer').height()),
            windowHeight = parseInt($(window).height());
            $('.center_con').css({ 'minHeight': windowHeight - headerHeight - footerHeight + 'px' });
            $('#initheight').css({ 'minHeight': windowHeight - headerHeight - footerHeight + 'px' });
        } 
    })();
})
