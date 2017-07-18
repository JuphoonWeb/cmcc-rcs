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
	<link rel="stylesheet" href="/css/main.css">
	<style>
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
		.add-partner{
			color:rgb(26, 250, 41);
		}
		.delete{
			color:rgb(233, 143, 54);
		}
		.delete-sup{
			 position: absolute;
			 right:20px;top:0;
			 display: none;
		}
		.complete{
			display:none;
			color:rgb(26, 250, 41);
		}
		input.datetime,input.datetimepicker{
			color:rgb(153,153,153);
		}
		.btn-ok{
			background-color: rgb(0, 197, 195);
			color:rgb(255,255,255);
		}
		.add-popup-container{
			display: none;
		}
		.add-popup-mask{
			position:absolute;
			top:0;left:0;
			height:100%;width: 100%;
			background-color: rgba(0,0,0,.3);
			z-index: 99;
		}
		.add-popup-container .add-popup{
			position:absolute;
			top:50%;left:50%;
			transform:translate(-50%,-50%);
			width:300px;
			height:230px;
			background-color: rgb(255,255,255);
			border:1px solid rgb(153,153,153);
			padding:10px;
			border-radius: 10px;
			z-index:100;
		}
		.add-popup-container form{
			margin:0;
			width:100%;
		}
		.add-popup-container span.close{
			position:absolute;
			top:5px;right:10px;
			color:rgb(0,0,0);
		}
		.add-popup-container input{
			margin-bottom: 15px
		}
		.add-popup-container .add-tip{
			display:none;
		}
	</style>
</head>
<body>
	<div class="head-bar text-center hidden-sm hidden-xs">创建新事项</div>
	<div class="container">
		<form novalidate onsubmit="return false">
			<div class="form-group">
				<label for="title">会议主题</label>
				<input class="form-control" type="text"
				name="title" id="title" required placeholder="请输入会议主题">
			</div>
			<div class="form-group">
				<label for="">会议时间</label>
				<input class="form-control text-left datetime hidden-md hidden-lg" id="datetime" name="datetime" required placeholder="请选择会议时间">
				<input type="button" class="form-control text-left datetimepicker hidden-sm hidden-xs" id="datetimepicker" name="datetime" required value="请选择会议时间">
			</div>
			<div class="form-group">
				<label for="content">会议内容</label>
				<textarea class="form-control" name="content" id="content" cols="30" rows="3" placeholder="请输入会议内容" required></textarea>
			</div>
			<div class="partner-container">
				<div class="form-group">
					<label for="partner-num" class="control-label">参与人员&nbsp;&nbsp;</label>
					<input type="text" name="partner-num" id="partner-num" value="1" readonly>
				</div>

				<div class="row">
					<div class="sponsor col-xs-3 text-center center-block">
						<img src="/img/sponsor.png" alt="" class="">
						<p>我</p>
					</div>
					<div class="partner-list"></div>
					<div class="add-partner col-xs-3 text-center center-block" id="add-partner">
						<img src="/img/add.png" alt="" class="">
						<p>添加</p>
					</div>
					<div class="delete col-xs-3 text-center center-block" id="delete">
						<img src="/img/delete.png" alt="" class="">
						<p>删除</p>
					</div>
					<div class="complete col-xs-3 text-center center-block" id="complete">
						<img src="/img/complete.png" alt="" class="">
						<p>完成</p>
					</div>
					
				</div>
			</div>
			<div class="btn-group btn-block">
				<button type="submit" id="create" class="btn btn-ok btn-block">创建</button>
				<button type="cancel" id="cancel" class="btn btn-default btn-block">取消</button>
			</div>
		</form>
	</div>
	<div class="add-popup-container" id="add-popup-container">
		<div class="add-popup-mask" id="add-popup-mask"></div>
		<div class="add-popup" id="add-popup">
			<form action="" novalidate onsubmit="false">
					<legend>添加参与人员<span id="add-close" class="close">x</span></legend>
					<input type="text" class="form-control" name="name" id="add-name" placeholder="请输入姓名" required>
					<input type="text" class="form-control" name="phone" id="add-phone" placeholder="请输入手机号码" required>
				<div class="btn-group btn-group-justified">
					<div class="btn-group">
						<button type="submit" class="btn btn-ok" id="add-ok">确定</button>
					</div>
					<div class="btn-group">
						<button class="btn btn-default" id="add-cancel">取消</button>
					</div>
				</div>
			</form>
			<p class="add-tip" id="add-tip">请输入姓名</p>
		</div>
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

    //移动端和飞信时间选择器
    $("#datetime").click(function(){
    	window.WebContainer.forSetTime('yyyy-mm-dd HH:mm','backID','setTime');
    });

    function setTime(backID,dateStr){
    	$("#datetime").val(dateStr);
    }
    

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
	$('#add-partner').click(function(){
	
		checkAppInstalled();
	});
	$('#delete').click(function(){
		delSwitch=true;
		$('.partner').addClass('swing');
		$(this).hide();
		$('#add-partner').hide();
		$('#complete').show();
		for(img in $('.partner-head')){
            $('.partner-head')[img].src='/img/do-delete.png';

		}
	});
	$('#complete').click(function(){
		delSwitch=false;
		$('.partner').removeClass('swing');
		$('.do-delete').hide();
		$(this).hide();
		$('#add-partner').show();
		$('#delete').show();
		for(img in $('.partner-head')){
            $('.partner-head')[img].src='/img/partner.png';
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
//            for(var i=0; contactArray.length; i++) {
//                alert(contactArray[i].name)
//            }
        }
    });


	$("#create").click(function () {
		var title = $("#title").val();
		var date = $("#datetime").val() || $("#datetimepicker").val();
		var content = $("#content").val();
		var contentText = "";
        if(title===""){
            contentText = '请输入会议主题';
        }else if(date==="" || date==="请选择会议时间"){
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
            createMeetSubjectInPC();
        }
    }

    //PC端添加参与人员
    function createMeetSubjectInPC(){
    	$('#add-popup-container').show();
    }

    $(document).on('click','#add-popup-mask,#add-close',function(){
		$('#add-popup-container').hide();
	})
	$('#add-ok').click(function(){
		if($('#add-name').val()===""){
			alert('请输入姓名');
		}else if($('#add-phone').val()===""){
			alert('请输入手机号码');
			$('#add-phone').focus();
		}else{
			$ajax({});
		}
	})


    var contactArray = new Array();
    var phones = new Array();
    var index;
    function createMeetSubject(jsonType,jsonContactArray) {
        if (jsonContactArray == undefined || jsonContactArray == "") {
            window.location = 'error.jsp';
        }
        phones.length = 0;//清空数组
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
            phones.push(json[i]);
            $('.partner-list').append('<div class="partner col-xs-3 text-center center-block animated" id="partner">' +
            	'<div class="delete-sup"><img src="/img/delete-sup.png" alt=""></div>'+
                '<img src="/img/partner.png" alt="" class="partner-head" id="'+json[i].phone +'" height="48" width="48" style="border-radius: 50%" /><p>'+json[i].name+'</p></div>');
        }
        $('#partner-num').val(1 + contactArray.length);

        if(phones.length > 0) {
            index = 0
            setHeadRecursion(json[index].phone);
		}
    }

    var a
    //递归调用
    function setHeadRecursion(phone) {
        a = Date.parse(new Date());
        data = "/img/partner.png";// 没有头像的不走回调  初始化默认图片
        getHead(phone);
        setTimeout(function () {
            $("#" + phones[index].phone).attr("src", data);
            index ++;
            if(index <= phones.length)
                setHeadRecursion(phones[index].phone)
        }, 100)

    }

    function getHead(phone) {
		var jsonString = {backId:'head', backFunc:'getHeadByPhone', phone:phone };
        if(isIOSInFeixin()){
            navigator.WebContainer.getContactAvatar(JSON.stringify(jsonString));
        }else if(isAndroidInFeixin()){
			window.WebContainer.getContactAvatar(JSON.stringify(jsonString));
        }else{
            b();
        }
    }
    var data = "";
    function getHeadByPhone(jsonString) {
        jsonString=jsonString.replace(/[\n\r]/g, '');
        var json = JSON.parse(jsonString);
        if(json.status == "1") {
            data = "data:image/jpeg;base64,"+json.avatar;
		} else {
            data = "/img/partner.png";
		}

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