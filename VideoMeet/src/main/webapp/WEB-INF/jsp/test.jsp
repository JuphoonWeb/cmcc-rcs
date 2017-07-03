<%--
  Created by IntelliJ IDEA.
  User: JeffWang
  Date: 2017/6/28
  Time: 下午2:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>模板消息测试</title>
    <script src="/lib/jquery/jquery-3.1.1.min.js"></script>
    <script src="/lib/bootstrap/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/lib/bootstrap/bootstrap.min.css"/>
</head>
<body>
<div class="container">
    <form id="form" class="form-signin" method="post" onsubmit="return false;">
        <input name="senderNumber" type="text" class="form-control" placeholder="senderNumber" value="18620153494">
        <input name="recvNumber" type="text" class="form-control" placeholder="recvNumber" value="15657821663">
        <input name="title" type="text" class="form-control" placeholder="title" value="title">
        <input name="summary" type="text" class="form-control" placeholder="summary" value="summary">
        <input name="content" type="text" class="form-control" placeholder="content" value="content">
        <input name="redirectUrl" type="text" class="form-control" placeholder="redirectUrl" value="http://www.baidu.com">
        <button class="btn btn-lg btn-primary btn-block" type="button" data-loading-text="发送中...">发送</button>
    </form>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $(".btn-block").click(function () {
            $(this).button('loading');//禁用按钮并显示提交中

            $.ajax({
                type: "post",
                data: $("#form").serializeArray(),
                dataType: "json",
                url: "sendRcsMsg",
                success: function (data) {
                    console.log(data);
                    if (data == "1") {
                        alert("发送成功");
                    } else {
                        alert("发送失败");
                    }
                    $(".btn-block").button('reset');//重置按钮
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("error");
                    $(".btn-block").button('reset');//重置按钮
                }
            });
        });
    });


</script>
</html>
