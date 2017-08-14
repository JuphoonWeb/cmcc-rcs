<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/11
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>会议详情</title>
	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="/css/dialog.css">
    <link rel="stylesheet" href="/css/date-time-picker.min.css">

	<style>
		.join{
            color:rgb(255,255,255);
            background-color: rgb(0, 197, 195);
        }
        .partner{
            margin-top: 30px;
        }
        .partner a:hover{
            background-color: rgb(234,234,234);
        }

		.hide{
			display:none;
		}
        
        .mini-menu-container{
            display: none;
        }
        .mini-menu-mask{
            position: fixed;
            top:0;left:0;
            width: 100%;height:100%;
            z-index:99;
        }
        .mini-menu{
            position: fixed;
            right:40px;bottom:50px;
            z-index: 100;
        }
        .mini-menu li{
            color:white;
            background-color: rgb(51, 122, 183);
        }
        .bottom-menu-container{
            display: none;
        }
        .bottom-menu-mask{
            position:fixed;
            left:0;top:0;
            width:100%;height:100%;
            z-index:99;
            background-color: rgba(0,0,0,.3);
        }
        .bottom-menu{
            position:fixed;
            width:100%;
            bottom:0px;left:0;
            margin:0;
            z-index:100;
        }
        .glyphicon-option-vertical,.bottom-menu li{
            cursor: pointer;
        }
        .bottom-menu li:hover{
            background-color: rgb(234,234,234);
        }        
        a{
            color:rgb(0,0,0);
        }
        
        .rotate{
            animation:rotate .2s linear;
        }
        @keyframes rotate{
            from{
                transform: rotate(0deg);
            }
            to{
                transform: rotate(90deg);
            }
        }

        /* 解决date-time-picker与bootstrap的冲突 */
        .date-picker-days-title i,.picker-row i{
            display: inline-block;
            height:24px;
        }
        /* 使得弹窗主题色与应用主题色一致 */
        div.picker-head,i.picker-active span{
            background-color: rgb(0, 197, 195);
        }

        @media(min-width: 992px){
            .meeting-detail-container{
                width:70%;
                margin:50px auto;
            }
        }

	</style>

</head>
<body>
    <div class="head-bar text-center hidden-xs hidden-sm">会议详情</div>
    <div class="container">
        <div class="meeting-detail-container">	
            <table class="detail table">
        		<tr>
        			<th>会议ID</th><td> ${videoMeetInfo.meetId}</td>
        		</tr>
        		<tr>
        			<th>会议主题</th><td> ${videoMeetInfo.meetSubject}</td>
        		</tr>
        		<tr>
        			<th>发起人</th><td>${videoMeetInfo.chairmanName}</td>
        		</tr>
        		<tr>
        			<th>开始时间</th><td id="begin-datetime">${videoMeetInfo.meetDatetime}</td>
        		</tr>
                <tr>
                    <th>结束时间</th><td id="end-datetime">${videoMeetInfo.endDatetime}</td>
                </tr>


        	</table>
        	<div class="btn-group btn-group-justified">
        		<div class="btn-group">
        			<button id="joinMeetBtn" class="btn join">加入会议</button>
        		</div>
        		<div class="btn-group">
        			<button id="notifyMeetBtn" class="btn btn-default resend">重新发送通知</button>
        		</div>
        	</div>

        	<div class="partner list-group">
        		<b>成员列表</b>
        		<!--<a class="list-group-item">${videoMeetInfo.members}.toString</a> -->
        		<div id="demo">
        		</div>

        	</div>

    		<div class="add mobile-add hidden-md hidden-lg">
                <a href="#"><img src="/img/mobile-add.svg" alt=""></a>
            </div>
    		<div class="add pc-add hidden-xs hidden-sm" title="添加联系人到会议">
                <a href="#"><img src="/img/pc-add.png" alt=""></a>
            </div>
	    </div>
    </div>
    
    <div class="mini-menu-container" id="mini-menu-container">
        <div class="mini-menu-mask" id="mini-menu-mask"></div>
        <ul class="list-group mini-menu ">
            <li class="list-group-item add-partner" id="add-partner">添加会议成员</li>
            <li class="list-group-item change-end-time" id="change-end-time">更改结束时间</li>
        </ul>
    </div>


	<div class="bottom-menu-container" id="bottom-menu-container">
		<div class="bottom-menu-mask" id="bottom-menu-mask"></div>
			<ul class="bottom-menu list-group" id="bottom-menu">
				<li class="list-group-item delete" id="delete">删除</li>
			</ul>
	</div>

<script type="text/javascript" src="/js/index.js"></script>
<script src="/js/date-time-picker.min.js"></script>
<script type="text/javascript">
    var szJsonStr = '<s:property escapeJavaScript="false" escape="false" value="sendCommandList" />';
    var membersJsonArray = ${videoMeetInfo.members};
    var txt='';
    for (var index = 0; index < membersJsonArray.length; index++)
    {
        txt+='<div class="list-group-item"> <a href="">'+membersJsonArray[index].name+'</a> <span onclick="optionVerticalHandler(this)" id="test" class="glyphicon  glyphicon-option-vertical pull-right" id="option-vertical"></span> </div>'

    }
    $("#demo").append(txt);

    var currentPhone = '${currentPhone}';
    var currentName = '${currentName}';
    var isMeetMember = false;
    var szJsonStr = '<s:property escapeJavaScript="false" escape="false" value="sendCommandList" />';
    var membersJsonArray = ${videoMeetInfo.members};
    for (var index = 0; index < membersJsonArray.length; index++)
    {
        if (currentPhone == membersJsonArray[index].phone || currentPhone == ${videoMeetInfo.chairmanPhone})
        {
            isMeetMember = true;
            break;
        }
    }
    var joinMeetBtn = document.body.querySelector("#joinMeetBtn");
    var notifyMeetBtn = document.body.querySelector("#notifyMeetBtn");
    joinMeetBtn.addEventListener("click", function () {
        if (isMeetMember)
        {
            checkAppInstalled();
        }
        else
        {
            dialog("您不属于该视频会议的成员，无法加入会议");
        }
    });
    var isChairman=0;
    if(currentPhone == ${videoMeetInfo.chairmanPhone})
    {
        isChairman=1;
        // }
        //if (isChairman == '1')
        // {
//        $(joinMeetBtn).css("margin-left","8.333333%");
        notifyMeetBtn.addEventListener("click", function () {
            sendMeetNotify();
        });
    }
    else
    {
        $(notifyMeetBtn).parent().hide();
        $(joinMeetBtn).addClass("btn-block");
        $(joinMeetBtn).parent().removeClass("btn-group");
        $(".add").hide();
        $(".glyphicon-option-vertical").hide();
    }


    function afterRecvAppStatus()
    {
        joinVideoMeet();
    }
    //notifyMeetBtn.addEventListener("click", function () {
    //   sendMeetNotify();
    //  });

    function joinVideoMeet() {
        var meetId = '${videoMeetInfo.meetId}';
        var meetPassword = '${videoMeetInfo.meetPassword}';
        var displayName;
        if (currentPhone == '')
        {
            displayName = '';
        }
        else
        {
            displayName = currentName == '' ? currentPhone : currentName;
        }
        openAppWithJoinMeet(meetId, "", displayName);
    }

    function sendMeetNotify() {
        $.ajax({
            data:{},
            url:'/VideoMeet/sendMeetNotify/'+${videoMeetInfo.meetId},
            type: 'get', //HTTP请求类型
            timeout: 5000, //超时时间设置为10秒；
            success: function(data) {
                console.log(data);
                if ('ok' == data)
                {
                    dialog('发送通知成功');
                }
                else
                {
                    dialog('发送通知失败');
                }
            },
            error: function(xhr, type, errorThrown) {
                dialog('服务器内部连接超时，请稍后再试');
            }
        });
    }
    $('.add').click(function(){
        $(this).addClass('rotate');
        setTimeout(function(){$('#mini-menu-container').toggle()},200);
        $(this).on('animationend',function(){
            $(this).removeClass('rotate');
        })
        $('#mini-menu-mask').click(function(){
            $('#mini-menu-container').hide();
        })
    })
    <%--$('#change-end-time').click(function(){--%>
        <%--$('#mini-menu-container').hide();--%>
        <%--var defaultTime=$('#begin-datetime').text();--%>
        <%--var datePicker = new DateTimePicker.Date({--%>
            <%--lang:'zh-CN',--%>
            <%--formate:'yyyy-MM-dd',--%>
            <%--default:defaultTime,--%>
        <%--})--%>
        <%--datePicker.on('selected',function(formatDate){--%>
            <%--var timePicker = new DateTimePicker.Time({--%>
                <%--lang:'zh-CN',--%>
                <%--formate:'HH:mm',--%>
                <%--default:defaultTime,--%>
            <%--})--%>
            <%--timePicker.on('selected',function(formatTime){--%>
                <%--var endDatetime=formatDate+' '+formatTime+':00';--%>
                <%--if(endDatetime <= $('#begin-datetime').text()){--%>
                    <%--dialog('结束时间不能在开始时间之前，请重新选择');--%>
                <%--}--%>
                <%--$('#end-datetime').text(endDatetime);--%>
                <%--$.ajax({--%>
                    <%--type:'post',--%>
                    <%--url:'/VideoMeet/delayEndMeetTime/${videoMeetInfo.meetId}',--%>
                    <%--dataType:'json',--%>
                    <%--data:{--%>
                        <%--endDatetime:endDatetime,--%>
                    <%--},--%>
                    <%--success:function(data){--%>
                    <%--},--%>
                    <%--error:function(data){--%>
                        <%--$(document).dialog({--%>
                        <%--overlayClose: true,--%>
                        <%--content: "服务器异常\n" + JSON.parse(data.responseText).status,--%>
                        <%--});--%>
                    <%--}--%>

                <%--})--%>
            <%--})--%>
        <%--})--%>

    <%--})--%>

    $('#change-end-time').click(function(){
        $('#mini-menu-container').hide();
        if(isIOSInFeixin()){
            navigator.WebContainer.forSetTime('time','backID','setEndTime');

        }else if(isAndroidInFeixin()) {
            window.WebContainer.forSetTime('time', 'backID', 'setEndTime');
        }
    });

    function setEndTime(backID,dateStr){
        if(dateStr === '') {
            return;
        }else if($('#end-datetime').text() != '' &&
            ($('#end-datetime').text() < $('#begin-datetime').text()) ){
            dialog('结束时间不能在开始时间之前')
        }else{

            $.ajax({
                type:'post',
                url:'/VideoMeet/delayEndMeetTime/${videoMeetInfo.meetId}',
                dataType:'json',
                data:{
                    endDatetime:dateStr,
                },
                success:function(data){
                    $('#end-datetime').text(dateStr);
                },
                error:function(data){
                    $(document).dialog({
                        overlayClose: true,
                        content: "服务器异常\n" + JSON.parse(data.responseText).status,
                    });
                }

            })
        }
    }
	//新增联系人到会议
    $('#add-partner').click(function(){
        $('#mini-menu-container').hide();
        if(isIOSInFeixin()){
            navigator.WebContainer.selectEnterpriseContactMulti("选择","16","backADD", "addContactToList","");
        }else if(isAndroidInFeixin()){
            window.WebContainer.selectEnterpriseContactMulti("选择","16","backADD", "addContactToList", "");
        }
    });
    function addContactToList(jsonType,jsonContactArray) {
        if (jsonContactArray == undefined || jsonContactArray == "") {
            window.location = 'error.jsp';
        }

        //检测所选联系人是否已在列表中
        var contactArray=JSON.parse(jsonContactArray);
        var currentMembersArray = $('#demo a');
		var newContactArray=[];
		var flag=true;
		for(var i=0;i<contactArray.length;i++){
		    flag=true;
		    for(var j=0;j<currentMembersArray.length;j++){
		        if(contactArray[i].name===currentMembersArray[j].text){
		            flag=false;
		            break;
				}
			}
			if(!flag){
		        continue;
			}
			newContactArray.push(contactArray[i]);
		}
		if(newContactArray.length===0){
            dialog('所选联系人已在当前列表中');
			return;
		}else{

        	$(document).dialog({
				type:'confirm',
				content:'确定添加所选联系人到会议？',
				onClickConfirmBtn:function(){

                <%--updateVideoMeet(${videoMeetInfo.meetId},jsonContactArray);--%>
				$.ajax({
					type:'post',
					url:'/VideoMeet/updateVideoMeet/${videoMeetInfo.meetId}',
					dataType:'json',
					data:{
                        members:JSON.stringify(newContactArray),
					},
					success:function(data){
                        $("#demo").children().remove();
					    var jsonObj=JSON.parse(data.members);
					    var txt='';
                        for (var i = 0; i < jsonObj.length; i++)
                        {
                            txt+='<div class="list-group-item"> <a href="">'+jsonObj[i].name+'</a> <span onclick="optionVerticalHandler(this)" id="test" class="glyphicon  glyphicon-option-vertical pull-right" id="option-vertical"></span> </div>'
                        }
                        $("#demo").html(txt);
					},
                    error : function(data){
                        $(document).dialog({
                            overlayClose: true,
                            content: "服务器异常\n" + JSON.parse(data.responseText).status,
                        });
                    }
				})

			}
		})
		}
    }

    //成员列表右侧三点菜单按钮逻辑
    function optionVerticalHandler(el){
        var currentItem=el.parentNode;
        $('#bottom-menu-container').show();
        $('#delete').on('click',function(){
            $('#bottom-menu-container').hide();
            $(document).dialog({
                type : 'confirm',
                overlayClose:true,
                content: '确定将该联系人从会议中删除吗？',
                onClickConfirmBtn:function(){
                    var index=$('.list-group-item').index(currentItem);
                    $.ajax({
                        type:'post',
                        url:'/VideoMeet/deleteByMeetIdAndMemberPhone/${videoMeetInfo.meetId}',
                        dataType:'json',
                        data:{
                            phone:${videoMeetInfo.members}[index].phone,
                        },
                        success:function(data){
                            $("#demo").children().remove();
                            var jsonObj=JSON.parse(data.members);
                            var txt='';
                            for (var i = 0; i < jsonObj.length; i++)
                            {
                                txt+='<div class="list-group-item"> <a href="">'+jsonObj[i].name+'</a> <span onclick="optionVerticalHandler(this)" id="test" class="glyphicon  glyphicon-option-vertical pull-right" id="option-vertical"></span> </div>'
                            }
                            $("#demo").html(txt);
                        },
                        error:function(data){
                            $(document).dialog({
                                overlayClose: true,
                                content: "服务器异常\n" + JSON.parse(data.responseText).status,
                            });
                        }
                    })
                }
            });
            $('#delete').off();
        })
        $('#bottom-menu-mask').on('click',function(){
            $('#bottom-menu-container').hide();
            $('#delete').off();
        })
    }

</script>
</body>
</html>