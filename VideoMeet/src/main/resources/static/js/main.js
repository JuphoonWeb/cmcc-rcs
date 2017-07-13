var currentIndex=0;	//当前列表的索引
$('.list').eq(currentIndex).show('fast');
//标签点击事件
$('.tab').click(function(event){
	currentIndex=$(this).index();

	$('.mobile-tab').eq(currentIndex).addClass('selected');
	$('.pc-tab').eq(currentIndex).addClass('selected');
	$('.mobile-tab').not($('.mobile-tab').eq(currentIndex)).removeClass('selected');
	$('.pc-tab').not($('.pc-tab').eq(currentIndex)).removeClass('selected');

	$('.list').not($('.list').eq(currentIndex)).hide();
	$('.list').eq(currentIndex).show('fast');		
});
//滚动到底部
function scrollToEnd() {
	var h = $(document).height() - $(window).height();
	$(document).scrollTop(h);
}