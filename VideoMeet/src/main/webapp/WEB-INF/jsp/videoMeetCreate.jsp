<%--
  Created by IntelliJ IDEA.
  User: JeffWang
  Date: 2017/6/29
  Time: 下午5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>创建视频会议</title>
    <script src="/lib/jquery/jquery-3.1.1.min.js"></script>
    <script src="/lib/bootstrap/bootstrap.min.js"></script>
    <script src="/lib/mui/mui.min.js" ></script>
    <link rel="stylesheet" href="/lib/bootstrap/bootstrap.min.css"/>
    <link rel="stylesheet" href="/lib/mui/mui.min.css" />
</head>
<body>
<div class="container">
    <div class="col-xs-9 col-sm-9">
        <table id="table" class="table">
            <tbody>
            <form id="videoMeetForm">
                <tr>
                    <th width="20%" align="right">会议主题：</th>
                    <td width="80%" align="left">
                        <input type="text" name="meetSubject" id="meetSubject" class="form-control" placeholder="请输入会议主题">
                    </td>
                </tr>
                <tr>
                    <th width="20%" align="right">会议时间：</th>
                    <td width="80%" align="left">
                        <span>2017年06月29日 18:10</span>
                        <input type="hidden" name="meetDatetime" id="meetDatetime" class="form-control">
                    </td>
                </tr>
                <tr>
                    <th width="20%" align="right">会议描述：</th>
                    <td id="" width="80%" align="left">
                        <textarea name="meetDescription" class="form-control" rows="4"></textarea>
                    </td>
                </tr>
                <tr>
                    <th width="20%" align="right"></th>
                    <td width="80%" align="left">
                        <div class="col-sm-offset-2">
                            <a class="btn btn-success" href="#" id="submitButton" data-loading-text="提交中...">提交</a>
                        </div>
                    </td>
                </tr>
            </form>
            </tbody>
        </table>
    </div>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function() {

    });

    function submitMeetInfo() {

        var mask = mui.createMask();//遮罩层
        mui.ajax({
            data:{
                meetSubject:meetSubject,
                chairmanName:contactJsonObject[0].name,
                chairmanPhone:contactJsonObject[0].phone,
                chairmanInfo:JSON.stringify(contactJsonObject[0]),
                members:jsonContactArray
            },
            url:'../startVideoMeet',
            dataType: 'json', //服务器返回json格式数据
            type: 'post', //HTTP请求类型
            timeout: 5000, //超时时间设置为10秒；
            beforeSend: function() {
                mask.show();//显示遮罩层
            },
            complete: function() {
                mask.close();//关闭遮罩层
            },
            success: function(data) {
                console.log(data);
                if ('Failed' != data) {
                    window.location = "../showVideoMeetInfoDetail/"+data['meetId']+"/"+currentPhone;
                } else {
                    mui.alert('创建会议失败');
                }
            },
            error: function(xhr, type, errorThrown) {
                mui.alert('服务器内部连接超时，请稍后再试');
            }
        });
    }
</script>
</html>
