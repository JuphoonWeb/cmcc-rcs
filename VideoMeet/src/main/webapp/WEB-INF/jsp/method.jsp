<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black/"/>
    <link rel="stylesheet" href="/lib/mui/mui.min.css" />
    <link rel="stylesheet" href="/css/index.css" />
    <script type="text/javascript" src="/lib/jquery/jquery-3.1.1.min.js" ></script>
    <script type="text/javascript" src="/lib/mui/mui.min.js" ></script>
    <script type="text/javascript" src="/js/index.js" ></script>
    <title>菊风视频会议</title>
</head>
<body>
</body>
<script type="text/javascript">
    function rcsOptimizeReady() {
        if(isIOSInFeixin()){
            showObjProperty(navigator.WebContainer);
        }else if(isAndroidInFeixin()){
            showObjProperty(window.WebContainer);
        }
    }

    function showObjProperty(Obj)
    {
        var propertyList='';
        for(var i in Obj){
            if(Obj.i !=null)
                propertyList='<p>'+propertyList+i+'属性：'+Obj.i+'</p>';
            else
                propertyList='<p>'+propertyList+i+'方法</p>';
        }
        propertyList += '<p><a href="test">应用跳转</a></p>';
        $("body").html(propertyList);
    }

</script>
</html>