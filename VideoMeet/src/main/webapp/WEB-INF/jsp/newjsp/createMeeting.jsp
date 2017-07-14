<%@ page contentType="text/html;charset=UTF-8" language="java" %><html lang="en"><html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>创建新事项</title>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/dialog.css">
	<link href="css/date-time-picker.min.css" rel="stylesheet">
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

		/* 解决date-time-picker与bootstrap的冲突 */
		.date-picker-days-title i,.picker-row i{
			display: inline-block;
			height:24px;
		}
	</style>
</head>
<body>
	<div class="nav-bar text-center">创建新事项</div>
	<div class="container">
		<form action="" novalidate onsubmit="return check()">
			<div class="form-group">
				<label for="title">会议主题</label>
				<input class="form-control" type="text"
				name="title" id="title" required placeholder="请输入会议主题">
			</div>
			<div class="form-group date-time">
				<label for="">会议时间</label>
				<div class="row">
					<div class="col-xs-7">
						<input type="button" class="form-control text-left" id="date" name="date" required  value="点击选择会议日期">
					</div>
					<div class="col-xs-5">
						<input type="button" class="form-control text-left" id="time" name="time"
				required value="点击选择会议时间">
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
						<img src="image/sponsor.png" alt="" class="">
						<p>我</p>
					</div>
					<div class="partner-list"></div>
					<div class="add col-xs-3 text-center center-block">
						<img src="image/add.png" alt="" class="">
						<p>添加</p>
					</div>
					<div class="delete col-xs-3 text-center center-block">
						<img src="image/delete.png" alt="" class="">
						<p>删除</p>
					</div>
					<div class="complete col-xs-3 text-center center-block">
						<img src="image/complete.png" alt="" class="">
						<p>完成</p>
					</div>
					
				</div>
			</div>
			<div class="btn-group btn-block">
				<button type="submit" id="submit" class="btn btn-primary btn-block">创建</button>
				<button type="reset" class="btn btn-default btn-block">取消</button>
			</div>
		</form>
  
	</div>
</body>
<script src="js/zepto.min.js"></script>
<script src="js/dialog.min.js"></script>
<script src="js/date-time-picker.min.js"></script>

<script>
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

	var delSwitch=false;
	function getPatnerNumber(){
		return parseInt($('#partner-num').val());
	}
	$('.add').click(function(){
		$('.partner-list').append('<div class="partner col-xs-3 text-center center-block animated" id="partner"><div class="do-delete"></div><img src="image/partner.png" alt="" class="partner-head"><p>其他人</p></div>');
		$('#partner-num').val(getPatnerNumber()+1);
	
	});
	$('.delete').click(function(){
		delSwitch=true;
		$('.partner').addClass('swing');
		$(this).hide();
		$('.add').hide();
		$('.complete').show();
		for(img of $('.partner-head')){	
			img.src='image/do-delete.png';
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
			img.src='image/partner.png';
		}
	});
	$(document).on("click", '#partner', function() {
  		if(delSwitch){
				console.log($(this));
				$('#partner-num').val(getPatnerNumber()-1);
				$(this).hide();
				$(this).remove();
			}
    });
	
	function check(){
		var result=false;
		var contentText="";
		if($('#title').val()===""){
			contentText='请输入会议主题';
			$('#title').focus();
		}
		else if($('#date').val()===""){
			contentText='请选择会议日期';
			$('#date').focus();
		}else if($('#time').val()===""){
			contentText='请选择会议时间';
			$('#time').focus();
		}
		else if($('#content').val()===""){
			contentText='请输入会议内容';
			$('#content').focus();
		}else if(getPatnerNumber()===1){
			contentText='请添加参与人员';
		}else{
			result=true;
		}
		if(!result){	    
			$(document).dialog({
        		overlayClose: true,
        		content: contentText,
   			});
	    }
	    return result;
	}
</script>
</html>