<%@ page contentType="text/html;charset=UTF-8" language="java" %><html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>多方视频会议</title>
	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/dropload.css">
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="/css/animate.css">
	<style>
		.item-time{
			color:rgb(0, 197, 195);
			font-size:16px;
		}
        .badge{
            background-color: rgb(0, 197, 195);
        }
        .unread-icon-xs{
            position:relative;
            top:-22px;
            right:0px;
        }
        .unread-icon-md{
            position:relative;
            top:-27px;
            right:15px   
        }
        

		@media (min-width:992px){
			.item-time{
                font-size: 20px;
            }		
        }
	</style>
</head>
<body>
	<div class="head-bar-container text-center">
        <div class="head-bar hidden-xs hidden-sm">多方视频会议</div>
        <div class="tab-container clearfix">
            <!-- 移动端页面显示的标签 -->
            <div class="mobile-tab-container row hidden-md hidden-lg">
                <div class="tab mobile-tab col-xs-6 selected">我发起的</div>
                <div class="tab mobile-tab col-xs-6">我收到的 <span class="badge">3</span></div>
            </div>
        </div>
    </div>
	<div class="container text-center">
        <div class="tab-container clearfix" id="tab-container">
            <!-- PC端页面显示的标签 -->
            <ul class="pc-tab-container nav nav-pills nav-stacked navbar-left  hidden-xs hidden-sm">
                <li class="tab pc-tab selected">我发起的</li>
                <li class="tab pc-tab">我收到的</li>
            </ul>       
        </div>
		<div class="list-container" id="list-container">
			<div class="list list-1 text-left animated" id="list-1"></div>
			<div class="list list-2 text-left animated"></div>
		</div>
		<div class="add hidden-md hidden-lg"><a href="/VideoMeet/createMeeting"><img src="/img/add-2.png" alt=""></a></div>
        <div class="to-top hidden-sm hidden-xs" title="回到顶部"><img src="/img/to-top.png" alt=""></div>
	</div>
</body>
<!-- <script src="/js/jquery-3.2.1.min.js"></script> -->

<script src="/js/zepto.min.js"></script>
<script src="/js/dialog.min.js"></script>
<!-- <script src="/js/bootstrap.min.js"></script> -->
<script src="/js/dropload.min.js"></script>
<script src="/js/main.js"></script>
<script>
    $(function(){
        var currentPhone = '${currentPhone}';
        var sendPage = 0;
        var recPage = 0;
        var size = 20;
        var itemIndex = 0;
        var tab1LoadEnd = false;
        var tab2LoadEnd = false;

        
        // tab
        $('.tab').on('click',function(){
            var $this = $(this);
            itemIndex = $this.index();
			$('.mobile-tab').eq(itemIndex).addClass('selected');
			$('.pc-tab').eq(itemIndex).addClass('selected');
			$('.mobile-tab').not($('.mobile-tab').eq(itemIndex)).removeClass('selected');
			$('.pc-tab').not($('.pc-tab').eq(itemIndex)).removeClass('selected');
            //$this.addClass('selected').siblings('.pc-tab').removeClass('selected');
            $('.list').eq(itemIndex).show().siblings('.list').hide();
            // 如果选中菜单一
            if(itemIndex == '0'){
                // 如果数据没有加载完
                if(!tab1LoadEnd){
                    // 解锁
                    dropload.unlock();
                    dropload.noData(false);
                }else{
                    // 锁定
                    dropload.lock('down');
                    dropload.noData();
                }
                // 如果选中菜单二
            }else if(itemIndex == '1'){
                if(!tab2LoadEnd){
                    // 解锁
                    dropload.unlock();
                    dropload.noData(false);
                }else{
                    // 锁定
                    dropload.lock('down');
                    dropload.noData();
                }
            }
            // 重置
            dropload.resetload();
        });
        var dropload = $('.list-container').dropload({
            scrollArea : window,
            loadUpFn:function(me){
                if(itemIndex == '0') {
                    $.post('/VideoMeet/getSendVideoMeetList/' + currentPhone, {start: 1, size: size}, function (data) {
                        var obj = JSON.parse(data);
                        result = "";
                        for (var i = 0; i < obj.videoMeetInfoList.length; i++) {
                            result += '<div class="item"><a href="/VideoMeet/showVideoMeetInfoDetail/'+obj.videoMeetInfoList[i].meetId +'"><div class="row"><div class="col-xs-10 col-md-11"><div class="item-time"><b>' + obj.videoMeetInfoList[i].meetDatetime + '</b></div><div class="item-theme">会议主题:' + obj.videoMeetInfoList[i].meetSubject + '</div><div class="item-id">会议ID&nbsp;&nbsp;&nbsp;&nbsp;' + obj.videoMeetInfoList[i].meetId + '</div></div><div class="col-xs-2"><img class="unread-icon-xs hidden-md hidden-lg" src="/img/unread-xs.png" alt=""><img class="unread-icon-md hidden-xs hidden-sm" src="/img/unread-md.png" alt=""></div></div></a></div>';
                        }
                        $('.list').eq(itemIndex).empty();
                        $('.list').eq(itemIndex).append(result);
                        sendPage = 1;
                        me.resetload();
                        me.unlock();
                        me.noData(false);
                        //scrollToEnd();
                    });
                } else if(itemIndex == '1') {
                    $.post('/VideoMeet/getRecvVideoMeetList/' + currentPhone, {start: 1, size: size}, function (data) {
                        var obj = JSON.parse(data);
                        result = "";
                        for (var i = 0; i < obj.videoMeetInfoList.length; i++) {
                            result += '<div class="item"><a href="/VideoMeet/showVideoMeetInfoDetail/'+obj.videoMeetInfoList[i].meetId +'"><div class="row"><div class="col-xs-10 col-md-11"><div class="item-time"><b>' + obj.videoMeetInfoList[i].meetDatetime + '</b></div><div class="item-theme">会议主题:' + obj.videoMeetInfoList[i].meetSubject + '</div><div class="item-id">会议ID&nbsp;&nbsp;&nbsp;&nbsp;' + obj.videoMeetInfoList[i].meetId + '</div></div><div class="col-xs-2 col-md-1"><img class="unread-icon-xs hidden-md hidden-lg" src="/img/unread-xs.png" alt=""><img class="unread-icon-md hidden-xs hidden-sm" src="/img/unread-md.png" alt=""></div></div></a></div>';

                        }
                        $('.list').eq(itemIndex).empty();
                        $('.list').eq(itemIndex).append(result);
                        pageIndex = 1;
                        me.resetload();
                        me.unlock();
                        me.noData(false);
                        recPage = 1;
                    });
				}



            },
            loadDownFn : function(me){
                // 加载菜单一的数据
                if(itemIndex == '0'){
                    sendPage ++;
                    $.post('/VideoMeet/getSendVideoMeetList/' + currentPhone, {start:sendPage, size:size},function(data){
                        var obj=JSON.parse(data);
                        result = "";

                        if(obj.videoMeetInfoList.length > 0) {
                            for(var i=0; i < obj.videoMeetInfoList.length; i++){
                                result += '<div class="item"><a href="/VideoMeet/showVideoMeetInfoDetail/'+obj.videoMeetInfoList[i].meetId +'"><div class="row"><div class="col-xs-10 col-md-11"><div class="item-time"><b>' + obj.videoMeetInfoList[i].meetDatetime + '</b></div><div class="item-theme">会议主题:' + obj.videoMeetInfoList[i].meetSubject + '</div><div class="item-id">会议ID&nbsp;&nbsp;&nbsp;&nbsp;' + obj.videoMeetInfoList[i].meetId + '</div></div><div class="col-xs-2 col-md-1"><img class="unread-icon-xs hidden-md hidden-lg" src="/img/unread-xs.png" alt=""><img class="unread-icon-md hidden-xs hidden-sm" src="/img/unread-md.png" alt=""></div></div></a></div>';

                            }
                        } else {
                            tab1LoadEnd = true;
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                        }
						// 插入数据到页面，放到最后面
						console.log(itemIndex);
						$('.list').eq(itemIndex).append(result);
						// 每次数据插入，必须重置
						me.resetload();
                    });

                    // 加载菜单二的数据
                }else if(itemIndex == '1'){
                    recPage ++;
                    $.post('/VideoMeet/getRecvVideoMeetList/' + currentPhone, {start:recPage, size:size},function(data){
                        var obj=JSON.parse(data);
                        result = "";

                        if(obj.videoMeetInfoList.length > 0) {
                            for(var i=0; i < obj.videoMeetInfoList.length; i++){
                                result += '<div class="item"><a href="/VideoMeet/showVideoMeetInfoDetail/'+obj.videoMeetInfoList[i].meetId +'"><div class="row"><div class="col-xs-10 col-md-11"><div class="item-time"><b>' + obj.videoMeetInfoList[i].meetDatetime + '</b></div><div class="item-theme">会议主题:' + obj.videoMeetInfoList[i].meetSubject + '</div><div class="item-id">会议ID&nbsp;&nbsp;&nbsp;&nbsp;' + obj.videoMeetInfoList[i].meetId + '</div></div><div class="col-xs-2 col-md-1"><img class="unread-icon-xs hidden-md hidden-lg" src="/img/unread-xs.png" alt=""><img class="unread-icon-md hidden-xs hidden-sm" src="/img/unread-md.png" alt=""></div></div></a></div>';
                            }
                        } else {
                            tab2LoadEnd = true;
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                        }
                            // 插入数据到页面，放到最后面
						console.log(itemIndex);
						$('.list').eq(itemIndex).append(result);
						// 每次数据插入，必须重置
						me.resetload();
                    });

                }
            }
        });
    });
</script>
</html>