<%@ page contentType="text/html;charset=UTF-8" language="java" %><html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>我创建的事项</title>
	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/dropload.css">
	<link rel="stylesheet" href="css/main.css">
	<style>
		.item{
			position: relative;
*/		}
		.item-title{
			color:rgb(0, 197, 195);
			font-weight: bold;
			font-size:16px;
		}
		.item-status{
			position: absolute;
			top:50%;right:10px;
			transform: translateY(-50%);
			width:48px;height:48px;
			color:rgb(51, 122, 183);
			
		}
		@media (min-width:992px){
			.list-container{
				position:relative;
				top:-75px;
			}
		}


	</style>
</head>
<body>
	<div class="head-bar text-center">我创建的事项</div>
	<div class="container text-center">
		<div class="tab-container clearfix">
			<!-- 移动端页面显示的标签 -->
			<div class="mobile-tab-container row hidden-md hidden-lg">
				<div class="tab mobile-tab col-xs-4 selected">我创建</div>
				<div class="tab mobile-tab col-xs-4">我参与</div>
				<div class="tab mobile-tab col-xs-4">已归档</div>
			</div>
			<!-- PC端页面显示的标签 -->
			<ul class="pc-tab-container nav nav-pills nav-stacked navbar-left  hidden-xs hidden-sm">
				<li class="tab pc-tab selected">我创建</li>
				<li class="tab pc-tab">我参与</li>
				<li class="tab pc-tab">已归档</li>
			</ul>		
		</div>
		<div class="list-container">
			<div class="list list-1 text-left">
				<div class="item">
					<a href="meetingDetails.html">
						<div class="item-title">事项标题</div>
						<div class="item-partner">参与人员</div>
						<div class="item-time">Apr.16 08:30 AM</div>
						<div class="item-status pull-right text-center">
							<img class="center-block" src="image/processing.png" alt="">
							<p>进行中</p>
						</div>
					</a>
				</div>
				<div class="item">
					<a href="meetingDetails.html">
						<div class="item-title">事项标题</div>
						<div class="item-partner">参与人员</div>
						<div class="item-time">Apr.16 08:30 AM</div>
						<div class="item-status pull-right text-center">
							<img class="center-block" src="image/processing.png" alt="">
							<p>进行中</p>
						</div>
					</a>
				</div>
			</div>
			<div class="list list-2 text-left">
				<div class="item">
					<a href="meetingDetails.html">
						<div class="item-title">事项标题</div>
						<div class="item-partner">参与人员</div>
						<div class="item-time">Apr.16 08:30 AM</div>
						<div class="item-status pull-right text-center">
							<img class="center-block" src="image/processing.png" alt="">
							<p>进行中</p>
						</div>
					</a>
				</div><div class="item">
					<a href="meetingDetails.html">
						<div class="item-title">事项标题</div>
						<div class="item-partner">参与人员</div>
						<div class="item-time">Apr.16 08:30 AM</div>
						<div class="item-status pull-right text-center">
							<img class="center-block" src="image/processing.png" alt="">
							<p>进行中</p>
						</div>
					</a>
				</div><div class="item">
					<a href="meetingDetails.html">
						<div class="item-title">事项标题</div>
						<div class="item-partner">参与人员</div>
						<div class="item-time">Apr.16 08:30 AM</div>
						<div class="item-status pull-right text-center">
							<img class="center-block" src="image/processing.png" alt="">
							<p>进行中</p>
						</div>
					</a>
				</div>
			</div>
			<div class="list list-3 text-left">
				<div class="item">
					<a href="meetingDetails.html">
						<div class="item-title">事项标题</div>
						<div class="item-partner">参与人员</div>
						<div class="item-time">Apr.16 08:30 AM</div>
						<div class="item-status pull-right text-center">
							<img class="center-block" src="image/processing.png" alt="">
							<p>进行中</p>
						</div>
					</a>
				</div>
			</div>
		</div>
		<ul class="pagination hidden-xs hidden-sm">
			<li class="disabled" ><a href="">&laquo;</a></li>
			<li class="active"><a href="">1</a></li>
			<li><a href="">2</a></li>
			<li><a href="">3</a></li>
			<li><a href="">4</a></li>
			<li><a href="">5</a></li>
			<li><a href="">&raquo;</a></li>
		</ul>
		<div class="add hidden-md hidden-lg"><a href="createMeeting.html"><img src="image/add-2.png" alt=""></a></div>
	</div>
</body>
<script src="/js/jquery-3.2.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/dropload.min.js"></script>
<script src="/js/main.js"></script>
<script>
	
	//下拉刷新，上拉加载事件对象
	var droploadDownObj={
		scrollArea:document,
		autoLoad:false,
		loadUpFn:function(me){
			var result = '<div class="item animated bounceInDownBig"><div class="item-title">事项标题</div><div class="item-partner">参与人员</div><div class="item-time">Apr.16 08:30 AM</div><div class="item-status pull-right text-center"><img class="center-block" src="image/processing.png" alt=""><p>进行中</p></div></div>';
	        setTimeout(function() {
	            $('.list').eq(currentIndex).append(result);
	            me.resetload();
	        }, 500);
	  		scrollToEnd();
		},
		loadDownFn:function(me){
			var result = '<div class="item animated bounceInUpBig"><div class="item-title">事项标题</div><div class="item-partner">参与人员</div><div class="item-time">Apr.16 08:30 AM</div><div class="item-status pull-right text-center"><img class="center-block" src="image/processing.png" alt=""><p>进行中</p></div></div>';
	        setTimeout(function() {
	            $('.list').eq(currentIndex).append(result);
	            me.resetload();
	        }, 500);
	  		scrollToEnd();
		}
		
	};
	$('.list-1').dropload(droploadDownObj);
	$('.list-2').dropload(droploadDownObj);
	$('.list-3').dropload(droploadDownObj);
</script>
</html>