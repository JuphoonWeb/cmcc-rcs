<%@ page contentType="text/html;charset=UTF-8" language="java" %><html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>创建新事项</title>
	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" href="/css/animate.css">
	<link rel="stylesheet" href="/css/index.css" />

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
		.popup-container{
			display: none;
		}
		.mask{
			width:100%;height:100%;
			position:absolute;
			top:0;left:0;
			z-index: 99;
			background-color: rgba(0,0,0,.3);
		}
		.popup{
			position:absolute;
			top:50%;left:50%;
			transform:translate(-50%,-50%);
			width:90%;height:170px;
			z-index:100;
			background-color: rgb(255,255,255);
			font-size: 18px;

		}
		.popup-title{
			height:50px;
			line-height: 50px;
			color:rgb(255,255,255);
			background-color:rgb(0, 197, 195);
		}
		.popup-content{
			height:70px;
			line-height: 70px;
			font-size: 16px;
			color:rgb(133,133,133);
		}
		.popup-confirm{
			height:50px;
			line-height: 50px;
			border-top:rgb(0, 197, 195) solid 1px;
		}
		.popup-confirm.active{
			background-color: rgb(234,234,234);
		}
	</style>
</head>
<body>
	<div class="nav-bar text-center">创建新事项</div>
	<div class="container">
		<form action="" novalidate onsubmit="return false">

			<div class="form-group">
				<label for="title">会议主题</label>
				<input class="form-control" type="text"
				name="title" id="title" required placeholder="请输入会议主题">
			</div>
			<div class="form-group">
				<label for="datetimepicker">会议时间</label>

				<input class="form-control" type="datetime" name="datetime" id="datetimepicker" placeholder="点击选择会议时间" readonly required>

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
					<div class="partner-list">
					</div>

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
				<button class="btn btn-primary btn-block" id="create">创建</button>
				<button class="btn btn-default btn-block" id="cancel">取消</button>
			</div>
		</form>
		<div class="popup-container">
			<div class="mask">
				<div class="popup text-center">
					<div class="popup-title">提示</div>
					<div class="popup-content" id="popup-content"></div>
					<div class="popup-confirm">确定</div>
				</div>
			</div>
		</div>

	</div>
</body>

<script src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" src="/js/index.js" ></script>

<script>
	var delSwitch=false;
    var currentPhone = '${currentPhone}';
	$('#datetimepicker').datetimepicker({
		 language:'zh-CN',
  		 format: 'yyyy-mm-dd hh:ii',
  		 autoclose: true,
  		 startDate:new Date(),
  		 todayBtn:'linked',
  		 forceParse:false,
  		 showMeridian:true,
	});
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

  		console.log('clicked');
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
        if(title===""){
            $('#popup-content').text('请输入会议主题');
            $('#title').focus();
            return;
        }else if(date===""){
            $('#popup-content').text('请选择会议时间');
            $('#datetimepicker').focus();
            return;
        }else if(content===""){
            $('#popup-content').text('请输入会议内容');
            $('#content').focus();
            return;
        }else if(getPatnerNumber()===1){
            $('#popup-content').text('请添加参与人员');
           // return;
        }
        alert(contactJsonObject[0].name);
        alert(JSON.stringify(contactJsonObject));
        alert(JSON.stringify(contactJsonObject));
        alert(JSON.stringify(contactArray));
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
                alert(data)
                if ('Failed' != data) {
                    window.location = "/VideoMeet/showVideoMeetInfoDetail/"+data['meetId']+"?currentPhone="+currentPhone;
                } else {
                    alert('创建会议失败');
                }
            },
            error : function(data){
                alert("服务器异常/n" + data.responseText);
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
        $('#partner-num span').html(getPatnerNumber()+json.length);
    }


    function init() {
        //var buttonName = $('.mui-active')[0].id;
        //isSender = buttonName == "sendButton";

        if (!isAndroidInFeixin() && !isIOS()) {
            alert('当前浏览器非安卓或者IOS');
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