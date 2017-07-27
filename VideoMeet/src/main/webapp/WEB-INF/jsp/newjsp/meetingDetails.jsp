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
		.bottom-menu-container{
			display: none;
		}
		.bottom-menu-mask{
			position:absolute;
			left:0;top:0;
			width:100%;height:100%;
			z-index:99;
			background-color: rgba(0,0,0,.3);
		}
		.bottom-menu{
			position:absolute;
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
        			<th>会议时间</th><td>${videoMeetInfo.meetDatetime}</td>
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

    		<div class="add add-partner mobile-add hidden-md hidden-lg">
                <a href="#"><img src="/img/mobile-add.svg" alt=""></a>
            </div>
    		<div class="add add-partner pc-add hidden-xs hidden-sm" title="添加联系人到会议">
                <a href="#"><img src="/img/pc-add.png" alt=""></a>
            </div>
	    </div>
    </div>
	<div class="bottom-menu-container" id="bottom-menu-container">
		<div class="bottom-menu-mask" id="bottom-menu-mask"></div>
			<ul class="bottom-menu list-group" id="bottom-menu">
				<li class="list-group-item delete" id="delete">删除</li>
			</ul>
	</div>

<script type="text/javascript" src="/js/index.js"></script>

<script type="text/javascript">
    var szJsonStr = '<s:property escapeJavaScript="false" escape="false" value="sendCommandList" />';
    var membersJsonArray = ${videoMeetInfo.members};
    var txt='';
    for (var index = 0; index < membersJsonArray.length; index++)
    {
//        txt+='<a class="list-group-item">'+membersJsonArray[index].name+'</a>';
        txt+='<div class="list-group-item"> <a href="">'+membersJsonArray[index].name+'</a> <span class="glyphicon  glyphicon-option-vertical pull-right" id="option-vertical"></span> </div>'
    }
    $("#demo").append(txt);
</script>


<script type="text/javascript">
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
            dailog("您不属于该视频会议的成员，无法加入会议");
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
                    dailog('发送通知成功');
                }
                else
                {
                    dailog('发送通知失败');
                }
            },
            error: function(xhr, type, errorThrown) {
                dailog('服务器内部连接超时，请稍后再试');
            }
        });
    }

	//新增联系人到会议
    $('.add-partner').click(function(){
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
        var currentMembersArray = $('#demo').children();
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
            dailog('所选联系人已在当前列表中');
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
//					    alert(data.members);
                        $("#demo").children().remove();
					    var jsonObj=JSON.parse(data.members);
					    var txt='';
                        for (var i = 0; i < jsonObj.length; i++)
                        {
                            txt+='<div class="list-group-item"> <a href="">'+jsonObj[i].name+'</a> <span id="test" class="glyphicon  glyphicon-option-vertical pull-right" id="option-vertical"></span> </div>'
                        }
                        $("#demo").append(txt);
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
    $(document).on('click','#option-vertical',function(){
        var currentItem=$(this).parent();
        $('#bottom-menu-container').show();
        $('#delete').on('click',function(){
            $('#bottom-menu-container').hide();
            $(document).dialog({
                type : 'confirm',
				overlayClose:true,
                content: '确定将该联系人从会议中删除吗？',
				onClickConfirmBtn:function(){
					members=${videoMeetInfo.members};
					var index=currentItem.index();
					$.ajax({
						type:'post',
						url:'/VideoMeet/deleteByMeetIdAndMemberPhone/${videoMeetInfo.meetId}',
						dataType:'json',
                        data:{
                            phone:members[index].phone,
                        },
						success:function(){
							currentItem.remove();
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
    })

</script>
</body>
</html>