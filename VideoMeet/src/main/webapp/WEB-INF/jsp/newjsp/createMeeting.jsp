<%@ page contentType="text/html;charset=UTF-8" language="java" %><html lang="en"><html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>创建新事项</title>
	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/index.css" />
	<link rel="stylesheet" href="/css/animate.css">
	<link rel="stylesheet" href="/css/dialog.css">
	<link rel="stylesheet" href="/css/date-time-picker.min.css">
	<link rel="stylesheet" href="/css/bootstrap-datetimepicker.min.css">
	<style>
		.nav-bar{
			height:60px;
			line-height:60px;
			color:rgb(255,255,255);
			background-color:rgb(0, 197, 195);
			margin-bottom:10px;
			font-size:16px;
		}
		#partner-num{
			font-weight: bold;
			border:none;
		}
		.sponsor{
			color:rgb(18, 150, 219);
		}
		.partner{
			color:rgb(19, 34, 122);
			animation-timing-function:linear;
			animation-iteration-count: infinite;
		}
		.add{
			color:rgb(26, 250, 41);
		}
		.delete{
			color:rgb(233, 143, 54);
		}
		.complete{
			display:none;
			color:rgb(26, 250, 41);
		}
		 .date-time input{
			color:rgb(153,153,153);
		}
		td.day.today{
			background-color: rgb(0, 80, 204);
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
	</style>
</head>
<body>
	<div class="nav-bar text-center">创建新事项</div>
	<div class="container">
		<form novalidate onsubmit="return false">
			<div class="form-group">
				<label for="title">会议主题</label>
				<input class="form-control" type="text"
				name="title" id="title" required placeholder="请输入会议主题">
			</div>
			<div class="form-group date-time">
				<label for="date">会议时间</label>
				<div class="row">
					<div class="col-xs-7">
						<input type="button" class="form-control text-left" id="date" name="date" required  value="选择会议日期">
					</div>
					<div class="col-xs-5">
						<input type="button" class="form-control text-left" id="time" name="time"
				required value="选择会议时间">
				</div>
				</div>
			</div>
			<div class="form-group">
				<label for="content">会议内容</label>
				<textarea class="form-control" name="content" id="content" cols="30" rows="3" placeholder="请输入会议内容" required></textarea>
			</div>
			<div class="partner-container">
				<div class="form-group">
					<label for="partner-num" class="control-label">参与人员&nbsp;&nbsp;</label>
					<input type="text" name="partner-num" id="partner-num" value="1">
				</div>

				<div class="row">
					<div class="sponsor col-xs-3 text-center center-block">
						<img src="/img/sponsor.png" alt="" class="">
						<p>我</p>
					</div>
					<div class="partner-list"></div>
					<div class="add col-xs-3 text-center center-block">
						<img src="/img/add.png" alt="" class="">
						<p>添加</p>
					</div>
					<div class="delete col-xs-3 text-center center-block">
						<img src="/img/delete.png" alt="" class="">
						<p>删除</p>
					</div>
					<div class="complete col-xs-3 text-center center-block">
						<img src="/img/complete.png" alt="" class="">
						<p>完成</p>
					</div>
					
				</div>
			</div>
			<div class="btn-group btn-block">
				<button type="submit" id="create" class="btn btn-primary btn-block">创建</button>
				<button type="cancel" class="btn btn-default btn-block">取消</button>
			</div>
		</form>
  
	</div>
</body>
<script src="/js/date-time-picker.min.js"></script>
<script type="text/javascript" src="/js/index.js" ></script>

<script src="/js/jquery-3.2.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/bootstrap-datetimepicker.min.js"></script>


<script>
	//解决zepto与jQuery的冲突
    $.noConflict();

	//移动端时间日期选择器
	$('#date').click(function () {
    var dt = new DateTimePicker.Date({
	      lang: 'zh-CN',
	      default: date.value
	    })
	    dt.on('selected', function (formatDate, now) {
	      console.log('selected date: ', formatDate, now)
	      date.value = formatDate
	    })
	  })
	  $('#time').click(function () {
	    var dt = new DateTimePicker.Time({
	      default: time.value
	    })
	    dt.on('selected', function (formatTime, now) {
	      console.log('selected time: ', formatTime, now)
	      time.value = formatTime
	    })
	  });

	  jQuery(document).ready(function($){
	  		// PC端时间日期选择器
		  $('#datetimepicker').datetimepicker({
		  		 language:'zh-CN',
	   			 format: 'yyyy-mm-dd hh:ii',
	   			 startDate:new Date(),
	   			 autoclose:true,
	   			 showMeridian:true,
	   			 todayBtn:true
			});

	  });


	var delSwitch=false;
	function getPatnerNumber(){
		return parseInt($('#partner-num').val());
	}
	$('.add').click(function(){
	
		checkAppInstalled();
	});
	$('.delete').click(function(){
		delSwitch=true;
		$('.partner').addClass('swing');
		$(this).hide();
		$('.add').hide();
		$('.complete').show();
		for(img of $('.partner-head')){	
			img.src='/img/do-delete.png';
		}
	});
	$('.complete').click(function(){
		delSwitch=false;
		$('.partner').removeClass('swing');
		$('.do-delete').hide();
		$(this).hide();
		$('.add').show();
		$('.delete').show();
		for(img of $('.partner-head')){	
			img.src='/img/partner.png';
		}
	});
	$(document).on("click", '#partner', function() {
  		if(delSwitch){
				console.log($(this));
				$('#partner-num').val(getPatnerNumber()-1);
				$(this).hide();
				$(this).remove();
            	var html = $(this).find('p').html();
            	var num;
				for(var i=0; contactArray.length; i++) {
				    if(contactArray[i].name == html) {
				        num = i;
				        break;
					}
				}
				contactArray.splice(num, 1);
            for(var i=0; contactArray.length; i++) {
                alert(contactArray[i].name)
            }
        }
    });


	$("#create").click(function () {
		var title = $("#title").val();
		var date = $("#datetimepicker").val();
		var content = $("#content").val();
		var contentText = "";
        if(title===""){
            contentText = '请输入会议主题';
        }else if(date===""){
            contentText = '请选择会议时间';
        }else if(content===""){
            contentText = '请输入会议内容';
        }else if(getPatnerNumber()===1){
            contentText = '请添加参与人员';
        }
        if(contentText != ""){
            $(document).dialog({
                overlayClose: true,
                content: contentText,
            });
            return;
        }
        $.ajax({
            type : "POST",
            url : "/VideoMeet/startVideoMeet",
            dataType : "json",
            data:{
                meetSubject:title,
                chairmanName:contactJsonObject[0].name,
                chairmanPhone:contactJsonObject[0].phone,
                chairmanInfo:JSON.stringify(contactJsonObject),
                members:JSON.stringify(contactArray)
            },
            success : function(data){
                if ('Failed' != data) {
                    window.location = "/VideoMeet/showVideoMeetInfoDetail/"+data['meetId']+"?currentPhone="+currentPhone;
                } else {
                    $(document).dialog({
                        overlayClose: true,
                        content: '创建会议失败',
                    });
                }
            },
            error : function(data){
                $(document).dialog({
                    overlayClose: true,
                    content: "服务器异常/n" + data.responseText,
                });
            }
        });

    });

	$(document).on('click','.mask,.popup-confirm',function(){
		$('.popup-confirm').addClass('active');
		$('.popup-container').hide(500);
		$('.popup-confirm').removeClass('active');
	});
    $("#cancel").click(function () {
        window.history.back();
    });



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

    var contactArray = new Array();
    function createMeetSubject(jsonType,jsonContactArray) {
        if (jsonContactArray == undefined || jsonContactArray == "") {
            window.location = 'error.jsp';
        }
        var json = eval('(' + jsonContactArray + ')');
        var flag = true;
        for(var i=0; i < json.length; i++) {
            for(var j =0; j<contactArray.length; j++) {
                if(contactArray[j].name == json[i].name) {
                    flag = false;
                    break;
                }
            }
            if(!flag) {
                continue;
            }

            contactArray.push(json[i]);
            $('.partner-list').append('<div class="partner col-xs-3 text-center center-block animated" id="partner">' +
                '<div class="do-delete"></div>' +
                '<img src="/img/partner.png" alt="" class="partner-head"><p>'+json[i].name+'</p></div>');
        }
        $('#partner-num').val(1 + contactArray.length);
    }


	function init() {
        //var buttonName = $('.mui-active')[0].id;
        //isSender = buttonName == "sendButton";

        if (!isAndroidInFeixin() && !isIOS()) {
            $(document).dialog({
                overlayClose: true,
                content: '当前浏览器非安卓或者IOS',
            });
            a();
        }
    }

    function a(){
        var contactInfo = '[{"name":"","phone":"'+currentPhone+'"}]';
        phoneInit("", contactInfo);
    }

    function rcsOptimizeReady() {
        if(isIOSInFeixin()){
            navigator.WebContainer.getEnterpriseContact("backID", "phoneInit");
        } else if (isAndroidInFeixin()) {
            window.WebContainer.getEnterpriseContact("backID", "phoneInit");
        }
    }

    var contactJsonObject;
    function phoneInit(backId, contactInfo){
        console.log(contactInfo);
        contactJsonObject = JSON.parse(contactInfo);
        currentPhone = contactJsonObject[0].phone;
    }

    $(function () {
        init();
    })
</script>
</html>