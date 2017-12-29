$(function () {
    $(".TwoLevelC").each(function (i, n) { //新闻
        BindPageData(n.id);
    });    
    //通知公告
    getData(1, 10);
    //空中课堂
    KZKT();
});
function BindPageData(objid) {
    var $obj = $("#" + objid);
    var menuid = objid.substring(objid.lastIndexOf("_")+1);
    var nobind = $obj.attr("nobind") || 0; //自定义绑定
    var imgstr = $obj.attr("imgstr") || ""; //图片不能为空
    var menuids = $obj.attr("menuids") || ""; //获取多个menuid 
    var pSize = $obj.attr("psize") || 0; //显示条数    
    var btype = $obj.attr("btype") || ""; //绑定数据类型（默认新闻， "link"为友情链接）
    var liid = objid.replace("ul_", "li_");
    var params ={PageName: "DYYX/AdvertisingHandler.ashx",func: "GetAdvertising",IsDelete: 0};
    if (btype == "link") {
        params["OneNavId"] = menuid;
        params["PageName"] = "/DYYX/AdminManagerHandler.ashx";        
    } else {
        params["MenuIds"] = menuids;
        params["ImageUrl"] = imgstr;
        params["isPush"] = 1;
        if (!menuids) {
            params["MenuId"] = menuid;
        }
    }       
    if (pSize != 0) {
        params["func"] = btype == "link" ? "GetLinkList" : "GetPageList";
        params["PageIndex"] = 1;
        params["PageSize"] = pSize;
    }    
    $.ajax({
        type: "Post",
        url: "/Common.ashx",        
        dataType: "json",
        data: params,
        success: function (json) {
            if (json.result.errNum.toString() == "0") {
                var items =pSize==0?json.result.retData:json.result.retData.PagedData;
                $obj.html('');
                if (nobind == 0) {
                    $('#' + liid).tmpl(items).appendTo('#' + objid);
                }                
                AfterBindingFun(menuid, items);
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) { }
    });
}
function AfterBindingFun(menuid, items) {
    switch (menuid) {
        case "1":
            $('#scroll_' + menuid).slide({ mainCell: ".scroll", effect: "leftLoop", vis: 7, autoPlay: true });
            break;
        case "53":
        case "69":
        case "72":
        case "108":
            $('#scroll_' + menuid).slide({ mainCell: ".scroll", effect: "leftLoop", vis: 5, autoPlay: true });
            break;
        case "70":
        case "82":
        case "101":
            $('#scroll_' + menuid).slide({ mainCell: ".scroll", effect: "leftLoop", vis: 4, autoPlay: true });
            break;
        case "73":
            $('#scroll_' + menuid).slide({ mainCell: ".scroll", effect: "leftLoop", vis: 9, autoPlay: true });
            break;
        case "59":
            
            $(".sliders1").slide({
                titCell: ".num ul", mainCell: ".slide", effect: "fold", autoPlay: true, delayTime: 1200, autoPage: true
            });
            break
        case "16":
        case "60":
        case "71":
        case "78":
        case "81":
        case "88":
        case "91":
        case "98":
        case "107":
        case "106":
            $(".slides").slide({
                titCell: ".num ul", mainCell: ".slide", effect: "fold", autoPlay: true, delayTime: 1200, autoPage: true
            });
            break;
        case "120":
        case "114":
            $('#scroll_' + menuid).slide({ mainCell: ".scroll", effect: "leftLoop", vis: 6, autoPlay: true });
            break;
        case "115":
            $('#scroll_' + menuid).slide({ mainCell: ".scroll", effect: "leftLoop", vis: 8, autoPlay: true });
            break;
        case "117":
            $('#scroll_' + menuid).slide({ mainCell: ".scroll", effect: "leftLoop", vis: 3, autoPlay: true });
            break;
    }
}
function escape2Html(str) {
    var arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' };
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t]; });
}
//去除所有标签只留文字
function delHtmlTag(str) {
    return str.replace(/<[^>]+>/g, "");//去掉所有的html标记
}
//空中课堂
function KZKT() {
    $.ajax({
        url: "/Common.ashx",
        type: "post",
        dataType: "json",
        data: {
            PageName: "DYYX/AdvertisingHandler.ashx",
            Func: "GetPageList",
            MenuIds: "133,134,135",
            PageIndex: 1,
            pageSize: 5,
            isPush: 1
        },
        success: function (json) {
            if (json.result.errMsg == "success") {
                $("#ul_45").html('');
                var pagedata = json.result.retData.PagedData;
                $("#li_45").tmpl(pagedata).appendTo("#ul_45");
                //
                $('#scroll_45' ).slide({ mainCell: ".scroll", effect: "leftLoop", vis: 4, autoPlay: true });
                //查看当前有无权限进行查看
                var LoginCookie_Cube = $.cookie('LoginCookie_Cube');
                $('#ul_45 li').each(function () {
                    $(this).children('a').click(function () {
                        //无权限不让进行跳转
                        if (LoginCookie_Cube != '' && LoginCookie_Cube != null && LoginCookie_Cube != undefined) {
                            var href = $(this).attr("tag");
                            window.location.href = href;
                        } else if (LoginCookie_Cube == null) {
                            alert("请先登录");
                        }
                        else {
                            alert("请先登录");
                        }
                    })
                });
            }
            else {
                $("#ul_45").html(" <li> 暂无数据！ </li>");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {

        }
    });
}
function getImageUrl(filepath) {
    if (filepath != null && filepath != "") {
        var imageurl = filepath.substring(0, filepath.lastIndexOf('.')) + ".jpg";
        return imageurl;
    }
    return "";
}