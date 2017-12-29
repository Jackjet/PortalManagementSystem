function enumSystemType(type) {
    var msg = "";
    switch (type) {
        case "学习天地": msg = 32; break;
        case "教学活动": msg = 19; break;
        case "德育之窗": msg = 11; break;
        case "党建园地": msg = 38; break;
        case "校园风采": msg = 58; break;
        case "教师风采": msg = 59; break;
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

//禁止右键弹出菜单
document.oncontextmenu = new Function("event.returnValue=false;");
document.onselectstart = new Function("event.returnValue=false;");


//通知公告
function getData(startIndex, pageSize) {
    //初始化序号 
    pageNum = (startIndex - 1) * pageSize + 1;
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        dataType: "json",
        data: {
            "PageName": "DYYX/NoticesHandler.ashx",
            "func": "GetPageList",
            "PageIndex": startIndex,
            "PageSize": pageSize,
            "isPush": 1,
            "MenuId": 42
        },
        success: function (json) {
            if (json.result.errMsg == "success") {
                $("#list_data").html('');
                var items = json.result.retData.PagedData;
                if (items != null && items.length > 0) {
                    $("#item_data").tmpl(items).appendTo("#list_data");
                    if (items.length>1) {
                        $('.notice').slide({ mainCell: "ul", effect: "topLoop", vis: 1, autoPlay: true, interTime: 3500 });
                    }
                }
            }
            else {
                $("#list_data").html(" <li> 暂无数据！ </li>");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {

        }
    });
}
