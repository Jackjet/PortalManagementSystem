<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryPartyUnion.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategoryPartyUnion" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <title>北京市昌平区财贸幼儿园</title>
    <link rel="stylesheet" href="/PreSchool/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/PreSchool/css/style.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <!--[if lt IE 9]><script src="/PreSchool/js/html5shiv.min.js"></script><![endif]-->
    <!--[if lte IE 8]><script src="/PreSchool/js/selectivizr-min.js"></script><![endif]-->
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="TwoLevelCommon.js"></script>
    <script src="/PreSchool/js/common.js"></script>
    <script src="/PreSchool/js/jquery.SuperSlide.2.1.1.js"></script>
    <!--通知公告-->
    <script id="item_data" type="text/x-jquery-tmpl">
        <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=PartyUnion_bg" target="_blank" title="${Title}">${Title}</a></li>
    </script>
    <!--支部建设-->
    <script id="li_50" type="text/x-jquery-tmpl">
         {{if rowNum==1}}
        <li class="first clearfix">
                            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PartyUnion_bg">
                                <dl>
                                    <dt><img src="${ImageUrl.split(',')[0]}" /></dt>
                                    <dd>
                                        <h2>${Description}</h2>
                                        <p>${CreativeHTML.replace(/<[^>]+>/g,'')}</p>
                                    </dd>
                                </dl>
                            </a>
                        </li>
         {{else}}
                        <li>
                            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PartyUnion_bg" title="${Description}">${Description}</a>
                            <span>${DateTimeConvert(CreateTime)}</span>
                        </li>
        {{/if}}
    </script>
    <!--团旗飘飘-->
    <script id="li_51" type="text/x-jquery-tmpl">
        {{if rowNum==1}}
        <li class="first clearfix">
                            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PartyUnion_bg">
                                <dl>
                                    <dt><img src="${ImageUrl.split(',')[0]}" /></dt>
                                    <dd>
                                        <h2>${Description}</h2>
                                        <p>${CreativeHTML.replace(/<[^>]+>/g,'')}</p>
                                    </dd>
                                </dl>
                            </a>
                        </li>
         {{else}}
                        <li>
                            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PartyUnion_bg" title="${Description}">${Description}</a>
                            <span>${DateTimeConvert(CreateTime)}</span>
                        </li>
        {{/if}}
    </script>
    <!--职工之家-->
    <script id="li_52" type="text/x-jquery-tmpl">
        {{if rowNum==1}}
        <li class="first clearfix">
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PartyUnion_bg">
                <dl>
                    <dt><img src="${ImageUrl.split(',')[0]}" /></dt>
                    <dd>
                        <h2>${Description}</h2>
                        <p>${CreativeHTML.replace(/<[^>]+>/g,'')}</p>
                    </dd>
                </dl>
            </a>
        </li>
        {{else}}
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PartyUnion_bg" title="${Description}">${Description}</a>
                <span>${DateTimeConvert(CreateTime)}</span>
            </li>
        {{/if}}
    </script>
    <!--党团工会风采-->
    <script id="li_53" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PartyUnion_bg" target="_blank">
                <div class="img">
                    <img src="${ImageUrl.split(',')[0]}" alt="" />
                </div>
                <p>${Description}</p>
            </a>
        </li>
    </script>
    <script>
        $(function () {
            $('#nav').load('/PreSchool/nav.html');
            $('#footer').load('/PreSchool/footer.html');
            $('#survey_wrap').load('/PreSchool/Survey.html');
        })
    </script>
</head>
<body id="PartyUnion_bg">
    <div id="PartyUnion_bgwrap">

    
    <header id="header">
        <div class="motto_logo clearfix center">
            <a class="logo fl" href="/PreschoolIndex.aspx">
                <img src="/PreSchool/images/logo.png" />
            </a>
        </div>
        <nav id="nav"></nav>
    </header>
    <div class="content" id="content">
        <div class="clear"></div>
        <div class="notice_wrap">
            <span class="fl label">通知公告
            </span>
            <div class="notice">
                <ul id="list_data"></ul>
            </div>
        </div>
        <div class="module clearfix">
            <div class="right_duty fl">
                <h2 class="title">义务</h2>
                <div class="content">
                    1.认真学习马克思列宁主义、毛泽东思想、邓小平理论，学习党的路线、方针、政策及决议，学习党的基本知识， 学习科学、文化和业务知识，努力提高为人民服务的本领。 
                    <br />
                    2.贯彻执行党的基本路线和各项方针、政策，带头参加改 革开放和社会主义现代化建设，带动群众为经济发展和社 会进步艰苦奋斗，在生产、工作、学习和社会生活中起先 锋模范作用。
                    <br />
                    3.坚持党和人民的利益高于一切，个人利益服从党和人民 的利益，吃苦在前，享受在后，克己奉公，多做贡献。  
                    <br />
                    4.自觉遵守党的纪律和国家的法律，严格保守党和国家的 秘密，执行党的决定，服从组织分配，积极完成党的任务。  
                    <br />
                    5.维护党的团结和统一，对党忠诚老实，言行一致，坚决 反对一切派别组织和小集团活动，反对阳奉阴违的两面派 行为和一切阴谋诡计。  
                    <br />
                    6.切实开展批评和自我批评，勇于揭露和纠正工作中的缺 点、错误，坚决同消极腐败现象作斗争。  
                    <br />
                    7.密切联系群众，向群众宣传党的主张，遇事同群众商量， 及时向党反映群众的意见和要求，维护群众的正当利益。  
                    <br />
                    8.发扬社会主义新风尚，提倡共产主义道德，为了保护国 家和人民的利益，在一切困难和危险的时候挺身而出，英勇斗争，不怕牺牲。
                </div>
            </div>
            <div class="partyoath_wrap fl">
                <div class="partyoath_img">
                    <img src="/PreSchool/images/nationalflag.jpg" alt="" />
                </div>
                <div class="partyoath">
                    <h2 class="title">入党誓词</h2>
                    <div class="content">
                        我志愿加入中国共产党，拥护党的纲领，遵守党的章程，履行党员义务，执行党的决定，严守党的纪律，保守党的秘密，对党忠诚，积极工作，为共产主义奋斗终身，随时准备为党和人民牺牲一切，永不叛党。
                    </div>
                </div>
            </div>
            <div class="right_duty fl">
                <h2 class="title">权利</h2>
                <div class="content">
                    1.参加党的有关会议，阅读党的有关文件，接受党的教育和培训。 
                    <br />
                    2. 在党的会议上和党报党刊上，参加关于党的政策问题的讨论。
                    <br />
                    3. 对党的工作提出建议和倡议。 
                    <br />
                    4. 在党的会议上有根据地批评党的任何组织和任何党员，向党负责的揭发、检举党的任何组织和任何党员违法乱纪的事实，要求处分违法乱纪的党员，要求罢免或撤换不称职的干部。 
                    <br />
                    5. 行使表决权、选举权，有被选举权。 
                    <br />
                    6. 在党组织讨论决定对党员的党纪处分或作出鉴定时， 本人有权参加和进行申辩，其他党员可以为他作证和辩护。<br />
                    7. 对党的决议和政策如有不同意见，在坚决执行的前提 下，可以声明保留，并且可以把自己的意见向党的上级组 织直至中央提出。 
                    <br />
                    8. 向党的上级组织直至中央提出请求、申诉和控告，并要求有关组织给以负责的答复。  党的任何一级组织直至中央都无权剥夺党员的上述权利。    
                    <br />
                    ------《中国共产党章程》
                </div>
            </div>
        </div>
        <div class="module clearfix mt15">
            <div class="module1 fl">
                <h2 class="title">
                    <span class="fl title4">支部建设</span>
                    <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=50&bgname=PartyUnion_bg" class="fr" target="_blank">更多</a>
                </h2>
                <div class="content">
                    <ul id="ul_50" psize="4" imgstr="yes" class="lists1 TwoLevelC"></ul>
                </div>
            </div>
            <div class="module1 fl ml20">
                <h2 class="title">
                    <span class="fl title5">团旗飘飘</span>
                    <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=51&bgname=PartyUnion_bg" class="fr" target="_blank">更多</a>
                </h2>
                <div class="content">
                    <ul id="ul_51" psize="4" imgstr="yes" class="lists1 TwoLevelC"></ul>
                </div>
            </div>
            <div class="module1 fl ml20">
                <h2 class="title ">
                    <span class="fl title4">职工之家</span>
                    <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=52&bgname=PartyUnion_bg" class="fr" target="_blank">更多</a>
                </h2>
                <div class="content">
                    <ul id="ul_52" psize="4" imgstr="yes" class="lists1 TwoLevelC"></ul>
                </div>
            </div>
        </div>
        <div class="module party clearfix">
            <div class="lists_img">
                <div class="lists_img_wrap">
                    <div class="lists_img_inner">
                        <h2 class="title6">
                            <span>党团工会风采
                            </span>
                            <a href="/PreSchool/SitePages/BeforeList.aspx?id=53&bgname=PartyUnion_bg" target="_blank">更多</a>
                        </h2>
                        <div class="slider" id="scroll_53">
                            <ul id="ul_53" imgstr="yes" class="clearfix scroll TwoLevelC"></ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer id="footer"></footer>
    </div>
    <!--在线调查-->
    <div id="survey_wrap"></div>
        </div>
</body>

</html>

