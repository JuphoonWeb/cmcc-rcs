<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black/"/>
    <link rel="stylesheet" href="/lib/mui/mui.min.css"/>
    <link rel="stylesheet" href="/css/index.css"/>
    <script type="text/javascript" src="/lib/jquery/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="/lib/mui/mui.min.js"></script>
    <script type="text/javascript" src="/js/index.js"></script>
    <title>【视频会议】${videoMeetInfo.meetSubject}</title>

    <style type="text/css">
        .video-meet-title {
            font-size: 16px;
            font-weight:bold;
            color: #000000;
        }

        .video-meet-detail {
            font-size: 14px;
            color: #000000;
            margin-left: 20px;
        }
    </style>
</head>
<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="display: none"></a>
    <%--<a id="notifyMeetBtn" class="mui-btn mui-btn-link mui-pull-right">发送通知</a>--%>
    <%--<a id="joinMeetBtn" class="mui-btn mui-btn-link mui-pull-right" style="display: none">加入会议</a>--%>
    <h1 class="mui-title">会议详情</h1>
</header>
<div id="mainContent" class="mui-content" style="display: none;">
    <ul id="videoMeetInfo" class="mui-table-view">
        <li id="videoMeetId" class="mui-table-view-cell">会议ID</li>
        <li id="videoMeetSubject" class="mui-table-view-cell" style="word-wrap: break-word">会议主题</li>
        <li id="videoMeetChairman" class="mui-table-view-cell">发起人</li>
        <li id="videoMeetDatetime" class="mui-table-view-cell">会议时间</li>
    </ul>
    <div style="margin-top: 10px">
        <button id="joinMeetBtn" class="btn mui-btn-primary mui-col-xs-5" style="margin-left: 8.333333%;">加入会议</button>
        <button id="notifyMeetBtn" class="btn mui-btn-success mui-col-xs-5">重新发送通知</button>
    </div>

    <div class="title">成员列表</div>
    <ul id="videoMeetMembers" class="mui-table-view">
    </ul>
</div>

<div id="tipContent" class="mui-content"
     style="height:100%;width: 100%;position:fixed;display:none;">
    <div style="display:table-cell; vertical-align:middle;">
        <h3 style="text-align: center;margin-bottom:40px;color: #bd2d30;">关于召开"${videoMeetInfo.meetSubject}"会议的通知</h3>
        <p class="video-meet-title">一、会议时间</p>
        <p class="video-meet-detail">${videoMeetInfo.meetDatetime}</p>
        <p class="video-meet-title">二、会议地点</p>
        <p class="video-meet-detail">请使用和飞信负一屏企业应用《多方视频会议》接入</p>
        <p class="video-meet-title">三、会议发起人</p>
        <p class="video-meet-detail">${videoMeetInfo.chairmanName}&nbsp&nbsp&nbsp&nbsp${videoMeetInfo.chairmanPhone}</p>
        <p class="video-meet-title">四、参会人员</p>
        <p id="membersDetail" class="video-meet-detail"></p>
        <p class="video-meet-title" style="margin-top: 20px;margin-left:20px">特此通知</p>
        <p style="margin-top: 30px">注: </p>
        <p>1. 由于在iOS消息界面无法直接打开多方视频会议应用，请统一从《负一屏->企业应用->多方视频会议》加入会议</p>
    </div>
</div>
<script type="text/javascript">
    var currentPhone = '${currentPhone}';
    var currentName = '${currentName}';
    var isChairman = '${isChairman}';
    var isMeetMember = false;

    $(document).ready(function () {
        var meetIdNode = document.body.querySelector("#videoMeetId");
        meetIdNode.innerHTML = '会议ID: ${videoMeetInfo.meetId}';

        var meetSubjectNode = document.body.querySelector("#videoMeetSubject");
        meetSubjectNode.innerHTML = '会议主题: ${videoMeetInfo.meetSubject}';

        var chairmanNode = document.body.querySelector("#videoMeetChairman");
        chairmanNode.innerHTML = '发起人: ${videoMeetInfo.chairmanPhone} ${videoMeetInfo.chairmanName}';

        var datetimeNode = document.body.querySelector("#videoMeetDatetime");
        datetimeNode.textContent = '会议时间: ${videoMeetInfo.meetDatetime}';

        var membersNode = document.body.querySelector('#videoMeetMembers');
        var membersDetail = document.body.querySelector('#membersDetail');
        var membersJsonArray = eval('${videoMeetInfo.members}');
        for (var index = 0; index < membersJsonArray.length; index++) {
            var memberJson = membersJsonArray[index];
            var memberName = memberJson['name'];
            var memberPhone = memberJson['phone'];
            var memberCompany = memberJson['company'];
            var memberLi = document.createElement("li");
            memberLi.className = 'mui-table-view-cell meetCard';
            memberLi.innerHTML = '<span>' + memberName + '</span><p>' + memberPhone + '</p>';
            memberLi.addEventListener('tap', function () {
//                startChatView(memberPhone);
            });
            membersNode.appendChild(memberLi);

            membersDetail.innerHTML = membersDetail.innerHTML + "【" + memberCompany + '】' + memberName;
            if (index != membersJsonArray.length - 1) {
                membersDetail.innerHTML = membersDetail.innerHTML + "、";
            }
            if (currentPhone == memberJson['phone'] || currentPhone == ${videoMeetInfo.chairmanPhone}) {
                isMeetMember = true;
            }
        }

        var joinMeetBtn = document.body.querySelector("#joinMeetBtn");
        var notifyMeetBtn = document.body.querySelector("#notifyMeetBtn");
        joinMeetBtn.addEventListener('tap', function () {
            if (isMeetMember) {
                checkAppInstalled();
            } else {
                mui.alert("您不属于该视频会议的成员，无法加入会议");
            }
        });

        if (isChairman == '1') {
            $(joinMeetBtn).css("margin-left","8.333333%");
            notifyMeetBtn.addEventListener('tap', function () {
                sendMeetNotify();
            });
        } else {
            $(notifyMeetBtn).hide();
            $(joinMeetBtn).css("margin-left","29.166666%");
        }

//        if (currentPhone != '') {
            hideTipContent();
//        } else {
//            $("#tipContent").css("display","table");
//        }
//        alert("CurrentPhone:"+currentPhone);
    });

    function afterRecvAppStatus() {
        joinVideoMeet();
    }

    function joinVideoMeet() {
        var meetId = '${videoMeetInfo.meetId}';
        var meetPassword = '${videoMeetInfo.meetPassword}';
        var displayName;
        if (currentPhone == '') {
            displayName = '';
        } else {
            displayName = currentName == '' ? currentPhone : currentName;
        }
        openAppWithJoinMeet(meetId, "", displayName);
    }

    function startChatView(phone) {
        var jsonStr = '{"backId":"backId","backFunc":"backFunc","phone":"' + phone + '"})';
        if (isAndroidInFeixin()) {
            window.WebContainer.startChatView(jsonStr);
        } else if (isIOSInFeixin()) {
            navigator.WebContainer.startChatView(jsonStr);
        } else if (isAndroid()) {
            window.location = "smsto://" + phone;
        } else if (isIOS()) {
            window.location = "sms://" + phone;
        }
    }

    function hideTipContent() {
        $("#tipContent").css("display","none");
        $("#mainContent").show();
        $("#joinMeetBtn").show();
        $(".mui-pull-left").show();
    }

    function sendMeetNotify() {
        $.ajax({
            data:{},
            url:'../sendMeetNotify/'+${videoMeetInfo.meetId},
            type: 'get', //HTTP请求类型
            timeout: 5000, //超时时间设置为10秒；
            success: function(data) {
                console.log(data);
                if ('ok' == data) {
                    mui.alert('发送通知成功');
                } else {
                    mui.alert('发送通知失败');
                }
            },
            error: function(xhr, type, errorThrown) {
                mui.alert('服务器内部连接超时，请稍后再试');
            }
        });
    }
</script>
</body>
</html>