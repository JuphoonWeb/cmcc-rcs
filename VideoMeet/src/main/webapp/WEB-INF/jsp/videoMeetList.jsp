<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black/"/>
    <link rel="stylesheet" href="/lib/mui/mui.min.css" />
    <link rel="stylesheet" href="/css/index.css" />
    <script type="text/javascript" src="/lib/jquery/jquery-3.1.1.min.js" ></script>
    <script type="text/javascript" src="/lib/mui/mui.min.js" ></script>
    <script type="text/javascript" src="/js/index.js" ></script>
    <title>多方视频会议</title>
</head>
<body>
<header class="mui-bar mui-bar-nav">
    <div class="mui-title">
        <div class="mui-segmented-control" style="width: 60%;margin-top:2px;position: static;line-height: 40px;">
            <a id="sendButton" class="mui-control-item mui-col-xs-6 mui-active">我发起的</a>
            <div id="recvButton" class="mui-control-item mui-col-xs-6">
                <a>我收到的</a>
                <span id="unreadBadge" class="mui-badge mui-badge-danger" style="position: absolute;margin-left:-10px;display: none"></span>
            </div>
        </div>
    </div>
    <a id="createMeetBtn" class="mui-btn mui-btn-link mui-pull-right" onclick="checkAppInstalled()">创建会议</a>
</header>
<!--<div class="mui-content">-->
<!--<div class="mui-content-padded" style="margin: 5px;">-->
<!--<div class="mui-input-row mui-search">-->
<!--<input type="search" class="mui-input-clear" placeholder="搜索会议名称/成员号码">-->
<!--</div>-->
<div id="pullrefresh" class="mui-content mui-scroll-wrapper">
    <div class="mui-scroll">
        <!--数据列表-->
        <ul class="mui-table-view mui-table-view-chevron">
        </ul>
    </div>
</div>
<!--</div>-->
<!--</div>-->
</body>

<script type="text/javascript">
    var contactJsonObject = null;
    var currentPhone = '${currentPhone}';
    var isSender = true;
    var page = 1;
    var size = 20;
    var unreadCount = 0;

    $(document).ready(function(){
        init();

        var sendButton = document.body.querySelector("#sendButton");
        sendButton.addEventListener('tap', function () {
            requestData(true);
        });
        var recvButton = document.body.querySelector("#recvButton");
        recvButton.addEventListener('tap', function () {
            requestData(false);
        });
    });

    function rcsOptimizeReady() {
        if (currentPhone != '')
            return;

        if(isIOSInFeixin()){
            navigator.WebContainer.getEnterpriseContact("backID", "phoneInit");
        } else if (isAndroidInFeixin()) {
            window.WebContainer.getEnterpriseContact("backID", "phoneInit");
        }
    }

    function init() {
        var buttonName = $('.mui-active')[0].id;
        isSender = buttonName == "sendButton";

        if (!isAndroidInFeixin() && !isIOS()) {
            alert('当前浏览器非安卓或者IOS');
            a();
        }
    }

    function a(){
//        var contactInfo = '[{"address":"","headImg":"","id":"640509","email":"","name":"朱佳龙","phone":"18551646304","headColor":"","company":"超级会议测试企业","birthday":"","position":"","enterpriseId":"37454"}]';
        var contactInfo = '[{"name":"","phone":"'+currentPhone+'"}]';
        phoneInit("", contactInfo);
    }

    function locationAppDescribe() {
        window.location = "../iOSAppInstructions";
    }

    function phoneInit(backId, contactInfo){
        console.log(contactInfo);
        contactJsonObject = JSON.parse(contactInfo);
        currentPhone = contactJsonObject[0].phone;
        requestData(true);
    }

    function afterRecvAppStatus() {
        selectEnterpriseContactMulti();
//        rcsContactGeneralSelector();
    }

    function selectEnterpriseContactMulti(){
        if(isIOSInFeixin()){
            navigator.WebContainer.selectEnterpriseContactMulti("多方视频会议","16","backID", "createMeetSubject", "");
        }else if(isAndroidInFeixin()){
            window.WebContainer.selectEnterpriseContactMulti("多方视频会议","16","backID", "createMeetSubject", "");
        }else{
            b();
        }
    }

    function rcsContactGeneralSelector(){
        if(isIOSInFeixin()){
            navigator.WebContainer.rcsContactGeneralSelector("多方视频会议","16","backID", "createMeetSubject", "");
        }else if(isAndroidInFeixin()){
            window.WebContainer.rcsContactGeneralSelector("多方视频会议","16","backID", "createMeetSubject", "");
        }else{
            b();
        }
    }

    function createMeetSubject(jsonType,jsonContactArray) {
//        e.detail.gesture.preventDefault(); //修复iOS 8.x平台存在的bug，使用plus.nativeUI.prompt会造成输入法闪一下又没了
        var btnArray = ['取消', '确定'];
        mui.prompt('', '请输入会议主题', '提示框', btnArray, function(e) {
            if (e.index == 1) {
                createVideoMeeting(e.value, jsonContactArray);
            }
        })
    }

    /* 'MULTI' */
    function createVideoMeeting(meetSubject, jsonContactArray) {
        console.log(jsonContactArray);

        if (jsonContactArray == undefined || jsonContactArray == "") {
            window.location = 'error.jsp';
        }

//        openAppWithCreateMeet(meetPassword, contactJsonObject[0].name, contactJsonObject[0].phone, jsonContactArray);

        var mask = mui.createMask();//遮罩层
        mui.ajax({
            data:{
                meetSubject:meetSubject,
                chairmanName:contactJsonObject[0].name,
                chairmanPhone:contactJsonObject[0].phone,
                chairmanInfo:JSON.stringify(contactJsonObject),
                members:jsonContactArray
            },
            url:'../startVideoMeet',
            dataType: 'json', //服务器返回json格式数据
            type: 'post', //HTTP请求类型
            timeout: 5000, //超时时间设置为10秒；
            beforeSend: function() {
                //plus.nativeUI.showWaiting("加载中", options);
                mask.show();//显示遮罩层
            },
            complete: function() {
                //plus.nativeUI.closeWaiting();
                mask.close();//关闭遮罩层
            },
            success: function(data) {
                console.log(data);
                if ('Failed' != data) {
//                    var displayName=data['chairmanName'] ==''?data['chairmanPhone']:data['chairmanName'];
//                    openAppWithJoinMeet(data['meetId'], "", displayName);
                    window.location = "../showVideoMeetInfoDetail/"+data['meetId']+"?currentPhone="+currentPhone;
                } else {
                    mui.alert('创建会议失败');
                }
            },
            error: function(xhr, type, errorThrown) {
                mui.alert('服务器内部连接超时，请稍后再试');
            }
        });
    }


    mui.init({
        pullRefresh: {
            container: '#pullrefresh',
            down: {
                callback: pulldownRefresh
            },
            up: {
                contentrefresh: '正在加载...',
                callback: pullupLoadMore
            }
        }
    });

    function requestData(sender) {
        isSender = sender;
        page = 1;

        var mask = mui.createMask();//遮罩层
        mui.ajax(isSender?"../getSendVideoMeetList/"+currentPhone:"../getRecvVideoMeetList/"+currentPhone,{
            data:{
                start:page,
                size:size
            },
            dataType: 'json', //服务器返回json格式数据
            type: 'post', //HTTP请求类型
            timeout: 5000, //超时时间设置为10秒；
            beforeSend: function() {
                mask.show();//显示遮罩层
            },
            complete: function() {
                mask.close();//关闭遮罩层
            },
            success: function(data) {
                loadData(data, true);
            },
            error: function(xhr, type, errorThrown) {
                mui.alert('服务器连接超时，请稍后再试');
            }
        });
    }

    function loadData(data, isRefresh) {
        console.log(data);
        unreadCount = data.unreadCount;
        updateUnreadCount();

        var videoMeetInfoList = data.videoMeetInfoList;

        var listView = $('.mui-table-view');
        if (isRefresh) {
            mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
            if (videoMeetInfoList.length == 0) {
                $(".mui-scroll").css("height","100%");
                $(".mui-table-view").css("height","100%");

                listView.html('<div id="tipContent" style="height:100%;width: 100%;position:fixed;display:table;">'+
                    '<div style="display:table-cell; vertical-align:middle;text-align: center">'+
                    '<h4>暂无任何记录</h4>'+
                    '</div></div>');
            } else {
                listView.html('');
                $(".mui-scroll").css("height","");
                $(".mui-table-view").css("height","");
            }
        }

        for(var index=0; index<videoMeetInfoList.length; index++) {
            var videoMeetInfo = videoMeetInfoList[index];
            var li = $('<li></li>');
            li.addClass("mui-table-view-cell");
            li.attr("target", videoMeetInfo.meetId);
            if (videoMeetInfo.isRead == 1) {
                li.addClass("isRead");
            }
            li.append('<div><div class="meetId">会议ID：'+videoMeetInfo.meetId+'</div>' +
                '<div class="meetDatetime">'+videoMeetInfo.meetDatetime+'</div>'+
                '<div class="meetSubject">会议主题：'+videoMeetInfo.meetSubject+'</div>');
            if (!isSender) {
                li.append('<div class="meetChairman">发起人：'+videoMeetInfo.chairmanPhone+'  '+videoMeetInfo.chairmanName+'</div>');
            }
            li.append('</div>');
            listView.append(li);
        }

        mui('.mui-table-view').on('tap','.mui-table-view-cell',function(){
            var meetId = this.getAttribute("target");
            if (!isSender && !$(this).hasClass("isRead") && unreadCount>0) {
                unreadCount = unreadCount-1;
                $(this).addClass("isRead");
            }
            updateUnreadCount();
            mui.openWindow({
                url:'../showVideoMeetInfoDetail/'+meetId+'?currentPhone='+currentPhone
            });
        });

        mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
    }

    function updateUnreadCount() {
        if (unreadCount <= 0) {
            $('#unreadBadge').hide();
        } else {
            $('#unreadBadge').text(unreadCount);
            $('#unreadBadge').show();
        }
    }

    /**
     * 下拉刷新具体业务实现
     */
    function pulldownRefresh() {
        page = 1;
        mui.ajax(isSender?"../getSendVideoMeetList/"+currentPhone:"../getRecvVideoMeetList/"+currentPhone,{
            data:{
                start:page,
                size:size
            },
            dataType: 'json', //服务器返回json格式数据
            type: 'post', //HTTP请求类型
            timeout: 5000, //超时时间设置为5秒
            success: function(data) {
                loadData(data, true);
            },
            error: function(xhr, type, errorThrown) {
                mui.alert('服务器连接超时，请稍后再试');
                mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
            }
        });
    }
    /**
     * 上拉加载具体业务实现
     */
    function pullupLoadMore() {
        page = page+1;
        mui.ajax(isSender?"../getSendVideoMeetList/"+currentPhone:"../getRecvVideoMeetList/"+currentPhone,{
            data:{
                start:page,
                size:size
            },
            dataType: 'json', //服务器返回json格式数据
            type: 'post', //HTTP请求类型
            timeout: 5000, //超时时间设置为5秒
            success: function(data) {
                loadData(data, false);
            },
            error: function(xhr, type, errorThrown) {
                mui.alert('服务器连接超时，请稍后再试');
                mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
            }
        });
    }

</script>
</html>