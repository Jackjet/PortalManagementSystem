function enumSystemType(type) {
    var msg = "";
    switch (type) {
        case "招生动态": msg = 19; break;
        case "招生快讯": msg = 18; break;
        case "特色专业": msg = 6; break;
        case "就业动态": msg = 20; break;
        case "政策解答": msg = 21; break;
        case "学习环境": msg = 12; break;
        case "校园风采": msg = 9; break;
        case "教师风采": msg = 10; break;
        case "学生风采": msg = 11; break;
    }
    return msg;
}

function escape2Html(str) {
    var arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' };
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t]; });
}