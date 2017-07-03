<%--
  Created by IntelliJ IDEA.
  User: JeffWang
  Date: 2017/6/21
  Time: 下午2:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black/"/>
    <link rel="stylesheet" href="/lib/mui/mui.min.css"/>
    <link rel="stylesheet" href="/css/index.css"/>
    <script type="text/javascript" src="/lib/jquery/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="/lib/mui/mui.min.js"></script>
    <script type="text/javascript" src="/js/index.js"></script>
    <title>iOS版本安装说明</title>
    <style type="text/css">
        .block-item {
            margin-bottom: 15px;
            line-height: 1.44;
            position: relative;
            display: block;
            padding: 0 15px;
            color: #333;
            min-height: 23px;
        }

        .block-counter {
            float: left;
            margin-right: 8px;
            width: 20px;
            height: 20px;
            font-size: 12px;
            line-height: 20px;
            border-radius: 999px;
            background: #67bd59;
            color: #fff;
            text-align: center
        }

        .block-img {
            width: 100%;
            margin-top: 15px;
        }

        .block-text {
            padding: 0;
            margin: 0;
            word-break: break-all;
            color: #1b1b1b;
            font-size: 1em;
        }

        .download-button {
            margin-top:15px;
            vertical-align: middle;
            font-size: 18px;
            border-radius: 10px;
            line-height: 24px;
        }
    </style>
</head>
<body>
<div class="mui-content" style="display: inline-block">
    <div class="block-item" style="display: table;width: 100%;text-align: center">
        <button type="button" class="mui-btn mui-btn-primary download-button" onclick="toAppDownloadPage()">点击跳转至下载界面</button>
    </div>
    <div class="block-item">
        <span class="block-counter">1</span>
        <p class="block-text">跳转至应用下载安装界面</p>
        <img class="block-img" src="/img/1.png"/>
    </div>
    <div class="block-item">
        <span class="block-counter">2</span>
        <p class="block-text">下载APP后点击图标，会出现下图的提示</p>
        <img class="block-img" src="/img/2.jpg"/>
    </div>
    <div class="block-item">
        <span class="block-counter">3</span>
        <p class="block-text">在手机桌面上找到“设置”并且点击“设置”图标进入系统设置 ，如下图。</p>
        <img class="block-img" src="/img/3.png"/>
    </div>
    <div class="block-item">
        <span class="block-counter">4</span>
        <p class="block-text">找到“通用”，进入“通用”，再进入“设备管理"，详见下图。</p>
        <img class="block-img" src="/img/4.png"/>
    </div>
    <div class="block-item">
        <span class="block-counter">5</span>
        <p class="block-text">在“描述文件”中选择刚才第2步中提示的企业名称，如下图点击该企业名称页面跳转到新的窗口&nbsp;</p>
        <img class="block-img" src="/img/5.png"/>
    </div>
    <div class="block-item">
        <span class="block-counter">6</span>
        <p class="block-text">点击屏幕中间的蓝色文字选择信任这个企业开发者 ，如下图标红的位置。&nbsp;</p>
        <img class="block-img" src="/img/6.png"/>
    </div>
    <div class="block-item">
        <span class="block-counter">7</span>
        <p class="block-text">在弹出的框中点击“信任” ，如下图标红的位置。&nbsp;</p>
        <img class="block-img" src="/img/7.png"/>
    </div>
    <div class="block-item">
        <span class="block-counter">8</span>
        <p class="block-text">稍等片刻屏幕显示如下图，这时候就可以正常使用这个APP了 。&nbsp;</p>
        <img class="block-img" src="/img/8.png"/>
    </div>
    <div class="block-item" style="display: table;width: 100%;text-align: center">
        <button type="button" class="mui-btn mui-btn-primary download-button" onclick="toAppDownloadPage()">点击跳转至下载界面</button>
    </div>
</div>
</body>
<script type="text/javascript">
    function toAppDownloadPage() {
        if (isIOSInFeixin()) {
            navigator.WebContainer.openURLScheme('{"url":"'+iOSAppDownloadUrl+'","backId":"backId","backFunc":""}');
        } else {
            window.location.href = iOSAppDownloadUrl;
        }
    }

</script>
</html>
