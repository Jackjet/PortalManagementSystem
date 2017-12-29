var IsAdminPower = 0;//只有管理员有发布新闻权限(0否；1是)

//var SystemWeb = "ZZMH";
//var SystemWeb = "DYYX";
//var SystemWeb = "YQYZ";
//var SystemWeb = "YQZJ";
//var SystemWeb = "PreSchool";

var SystemWeb = "HZNW";
//var SystemWeb="HZZS";
/**日期转换成时间字符串**/
/** date日期  **/
/** format要转换的字符串格式，默认为 "yyyy-MM-dd"格式，若没有需要的格式可自己添加 **/
function DateTimeConvert(date, format, iseval) {
    iseval = iseval == false ? false : true;
    if (iseval) {
        date = date.replace(/(^\s*)|(\s*$)/g, "");
        if (date == "") {
            return "";
        }
        if (date.indexOf("Date") != -1) {
            date = eval(date.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
        } else {
            date = new Date(Date.parse(date));
        }
    }
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString();
    var twoMonth = month.length == 1 ? "0" + month : month; //月份为1位数时，前面加0
    var day = (date.getDate()).toString();
    var twoDay = day.length == 1 ? "0" + day : day; //天数为1位数时，前面加0
    var hour = (date.getHours()).toString();
    var twoHour = hour.length == 1 ? "0" + hour : hour; //小时数为1位数时，前面加0
    var minute = (date.getMinutes()).toString();
    var twoMinute = minute.length == 1 ? "0" + minute : minute; //分钟数为1位数时，前面加0
    var second = (date.getSeconds()).toString();
    var twoSecond = second.length == 1 ? "0" + second : second; //秒数为1位数时，前面加0
    var dateTime;
    if (format == "yyyy-MM-dd HH:mm:ss") {
        dateTime = year + "-" + twoMonth + "-" + twoDay + " " + twoHour + ":" + twoMinute + ":" + twoSecond;
    } else if (format == "yyyy-MM-dd HH:mm") {
        dateTime = year + "-" + twoMonth + "-" + twoDay + " " + twoHour + ":" + twoMinute;
    } else if (format == "年月日") {
        dateTime = year + "年" + month + "月" + day + "日";
    } else if (format == "yyyy-MM") {
        dateTime = year + "-" + twoMonth
    } else if (format == "MM-dd") {
        dateTime = twoMonth + "-" + twoDay
    } else if (format == "MM/dd") {
        dateTime = twoMonth + "/" + twoDay
    }
    else if (format == "dd") {
        dateTime = twoDay;
    }
    else {
        dateTime = year + "-" + twoMonth + "-" + twoDay
    }
    return dateTime;
}

/*************************************IFrame弹框方法***********************************************************/
var curWinindex;
function OpenIFrameWindow(title, url, width, height) {
    //iframe层
    var index = layer.open({
        type: 2,
        title: title,
        shadeClose: false,
        shade: 0.2,
        area: [width, height],
        content: url //iframe的url
    });
    curWinindex = index;
}
function OpenIFrameWindow2(title, url, width, height) {
    //iframe层
    var index = layer.open({
        type: 2,
        title: title,
        shadeClose: false,
        closeBtn: 0,
        shade: 0.2,
        area: [width, height],
        content: url //iframe的url
    });
    curWinindex = index;
}
function CloseIFrameWindow() {
    layer.close(curWinindex);
}
function layerMsg(title) { //msg信息框
    layer.msg(title, {
        time: 0 //不自动关闭
        , btn: ['确定']
        , yes: function (index) {
            layer.close(index);
        }
    });
}
/****************************************结束********************************************************/

function OnError(XMLHttpRequest, textStatus, errorThrown) { }


//js 获取地址栏参数
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]);
    return null;
}


//序号
var pageNum = 1;
function pageIndex() {
    return pageNum++;
}

//列表名称长度修正
function NameLengthUpdate(Name, Length) {
    if (Name.length > Length) {
        return Name.substr(0, Length) + "...";
    }
    return Name;
}
function NewCheckAll(oInput) {
    var isCheckAll = function () {
        for (var i = 1, n = 0; i < oInput.length; i++) {
            oInput[i].checked && n++
        }
        oInput[0].checked = n == oInput.length - 1;
    };
    //全选
    oInput[0].onchange = function () {
        for (var i = 1; i < oInput.length; i++) {
            oInput[i].checked = this.checked;
        }
        isCheckAll()
    };
    //根据复选个数更新全选框状态
    for (var i = 1; i < oInput.length; i++) {
        oInput[i].onchange = function () {
            isCheckAll()
        }
    }
}
function AdminPower() {
    if (IsAdminPower == 1) {
        var username="";
        if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
            var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
            if (UserInfo != null) {
                username=UserInfo.LoginName;
            }
        }
        if (username == "admin") {
            return 1;
        }else {
            return 0;
        }
    } else {
        return 1;
    }
}

