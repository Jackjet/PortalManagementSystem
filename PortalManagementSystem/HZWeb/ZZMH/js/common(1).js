function enumSystemType(type) {
    var msg = "";
    switch (type) {
        case "学校简介": msg = 3; break;
        case "校园文化": msg = 69; break;
        case "通知公告": msg = 82; break;
        case "咨询电话": msg = 86; break;
        case "横幅图片": msg = 87; break;
        case "学校新闻": msg = 88; break;
        case "友情链接": msg = 81; break;
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
            $('#initheight').css({ 'minHeight': windowHeight - headerHeight - footerHeight - 14 + 'px' });
        } 
    })();
})
