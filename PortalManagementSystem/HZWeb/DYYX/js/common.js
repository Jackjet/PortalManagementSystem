function enumSystemType(type) {
    var msg = "";
    switch (type) {
        case "校园快讯": msg = 53; break;
        case "课程教学": msg = 3; break;
        case "德育在线": msg = 19; break;
        case "学生天地": msg = 4; break;
        case "党建园地": msg = 5; break;
        case "收获成果": msg = 34; break;
        case "多彩活动": msg = 37; break;
        case "域外之声": msg = 8; break;
        case "行政领导": msg = 38; break;
        case "职工之家": msg = 7; break;
        case "校园风貌": msg = 10; break;
        case "快速入口": msg = 60; break;
    }
    return msg;
}

function escape2Html(str) {
    var arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' };
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t]; });
}