function enumSystemType(type) {
    var msg = "";
    switch (type) {
        case "学习天地": msg = 32; break;
        case "教学活动": msg = 19; break;
        case "德育之窗": msg = 11; break;
        case "党建园地": msg = 38; break;
        case "校园风采": msg = 58; break;
        case "教师风采": msg = 27; break;
        case "学生风采": msg = 60; break;
        case "通知公告": msg = 62; break;
        case "首页滚动图片": msg = 73; break;
        case "最新导读": msg = 79; break;
    }
    return msg;
}

function escape2Html(str) {
    var arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' };
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t]; });
}

$(function () {
    
    var initHeight = (function () {
        if ($('#header_top')) {
            var windowHeight = parseInt($(window).height());
            $('#centerwrap').css({ 'minHeight': windowHeight - 541 + 'px' });
        }
        
    })();
})
