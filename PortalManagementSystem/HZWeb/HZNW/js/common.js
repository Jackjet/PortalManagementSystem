function enumSystemType(type) {
    var msg = "";
    switch (type) {
        case "学校新闻": msg = 73; break;
        case "德育天地": msg = 41; break;
        case "教育科研": msg = 26; break;
        case "国际合作": msg = 58; break;
        case "招生就业": msg = 33; break;
        case "学校简介": msg = 3; break;
        case "德育动态": msg = 44; break;
        case "校园公告": msg = 129; break;
        case "校内视频": msg = 130; break;
        case "学部设置": msg = 21; break;
    }
    return msg;
}

function enumStr(id) {
    var msg = "";
    switch (id) {
        case "22": msg = "JYXB"; break;
        case "23": msg = "YSXB"; break;
        case "24": msg = "FWXB"; break;
        case "25": msg = "JSXB"; break;
    }
    return msg;
}

function escape2Html(str) {
    var arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' };
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t]; });
}

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