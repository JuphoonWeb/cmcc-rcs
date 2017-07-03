/**
 * Created by JeffWang on 2017/6/6.
 */
mui.init();

var phoneType = navigator.userAgent.toLocaleLowerCase();

//增加通用链接的生成,
var creatMeetingScheme = "juphoonultimateshow://creatMeeting?",
    joinMeetingScheme="juphoonultimateshow://joinMeeting?";
var androidAppDownloadUrl = "https://www.pgyer.com/KXq0",
    iOSAppDownloadUrl="https://www.pgyer.com/97L0";
var appPackageName = "com.juphoon.ultimateshow.cmcc";

var createScheme=function(options,isCreate){
    var urlScheme=isCreate?creatMeetingScheme:joinMeetingScheme;
    for(var item in options){
        urlScheme=urlScheme+item + '=' + options[item] + "&";
    }
    urlScheme = urlScheme.substring(0, urlScheme.length - 1);
    urlScheme = encodeURI(urlScheme);
    return urlScheme;
}

function isChrome() {
    return phoneType.match(/chrome\/([\d.]+)/);
}

function isGreaterThanIOS9() {
    return navigator.userAgent.match(/OS 9_\d[_\d]* like Mac OS X/i)
}

function isIOS() {
    return /iphone|ipod|ipad/.test(phoneType);
}

function isAndroid() {
    return /android/.test(phoneType)
}

function isIOSInFeixin() {
    return isIOS() && navigator.WebContainer  != null;
}

function isAndroidInFeixin() {
    return isAndroid() && window.WebContainer != null;
}

function isExistMethod(method) {
    if (isAndroidInFeixin()) {
        for (var i in window.WebContainer) {
            if (i == method) {
                return true;
            }
        }
    } else if (isIOSInFeixin()) {
        for (var i in navigator.WebContainer) {
            if (i == method) {
                return true;
            }
        }
    }
    return false;
}

function checkAppInstalled() {
    if(isAndroidInFeixin()){
        window.WebContainer.getAppStatus('{"appUrl":"'+appPackageName+'", "backFunc":"recvAppStatus"}');
    }else {
        afterRecvAppStatus();
    }
}

function recvAppStatus(status) {
    var statusJson = JSON.parse(status);
    if (statusJson['status'] == 0) {
        var btnArray = ['否', '是'];
        mui.confirm('是否跳转到下载页面？', '应用未安装', btnArray, function(e) {
            if (e.index == 1 && isAndroid()) {
                window.location.href = androidAppDownloadUrl;
            }
        });
    } else {
        afterRecvAppStatus();
    }
}

function openAppWithCreateMeet(meetPassword, chairmanName, chairmanPhone, members) {
    var options = {"meetPassword":meetPassword,"chairmanName":chairmanName,"chairmanPhone":chairmanPhone,"members":members};
    var localUrl = createScheme(options, true);

    var jsonObj = {"url":localUrl,"backId":"backId","backFunc":"openURLSchemebackFunc"};
    var jsonStr = JSON.stringify(jsonObj);
    if(isIOSInFeixin()){
        navigator.WebContainer.openURLScheme(jsonStr);
    }else if(isAndroidInFeixin()){
        window.WebContainer.openURLScheme(jsonStr);
    }else {
        // if(isIOS() && isGreaterThanIOS9()){
        //     //判断是否为ios9以上的版本,跟其他判断一样navigator.userAgent判断,ios会有带版本号
        //     localUrl = createScheme(options,true);//代码还可以优化一下
        // }

        if (isIOS()) {
            locationiOSDownloadWebPage();
        } else {
            locationAndroidDownloadWebPage();
        }
        window.location = localUrl;
    }
}

function openAppWithJoinMeet(meetId, meetPassword, displayName) {
    var options = {"meetId":meetId,"meetPassword":meetPassword,"displayName":displayName};
    var localUrl = createScheme(options, false);

    var jsonObj = {"url":localUrl,"backId":"backId","backFunc":"openURLSchemebackFunc"};
    var jsonStr = JSON.stringify(jsonObj);
    if(isIOSInFeixin()){
        navigator.WebContainer.openURLScheme(jsonStr);
    } else if(isAndroidInFeixin()){
        window.WebContainer.openURLScheme(jsonStr);
    } else {
        if (isIOS()) {
            locationiOSDownloadWebPage();
        } else {
            locationAndroidDownloadWebPage();
        }
        window.location = localUrl;
    }
}

function rcsMsgFwd(meetId, meetSubject, meetChairman) {
    var msg = "【会议ID】" + meetId + "\r\n" +
        "【会议主题】" + meetSubject + "\r\n" +
        "【会议发起人】" + meetChairman + "\r\n" +
        "【会议地址点击进入】http://122.227.209.194:8086/videoMeet/showVideoMeetInfoDetail/"+meetId+"\r\n";
    if(isIOSInFeixin()){
        navigator.WebContainer.rcsMsgFwd('{"type":"1","msg":"'+msg+'","backId":"backId","backFunc":"rcsMsgFwdFunc"}');
    } else if(isAndroidInFeixin()){
        window.WebContainer.rcsMsgFwd('{"type":"1","msg":"'+msg+'","backId":"backId","backFunc":"rcsMsgFwdFunc"}');
    } else {

    }
}

function openURLSchemebackFunc(status) {
    var statusJson = JSON.parse(status);
    if (statusJson['status'] == 0) {
        if (isIOSInFeixin()) {
            var btnArray = ['否', '是'];
            mui.confirm('应用【未安装】或者【未信任】，是否跳转到安装说明界面？', '应用打开失败', btnArray, function (e) {
                if (e.index == 1) {
                    setTimeout(function () {
                        window.location.href="../iOSAppInstructions";
                    },300);
                }
            });
        } else {
            mui.alert('应用打开失败');
        }
    }
}

function rcsMsgFwdFunc(backId, status) {
    if (status == 1) {
        alert("通知发送成功");
    } else {
        alert("通知发送失败");
    }
}

function locationAndroidDownloadWebPage() {
    setTimeout(function () {
        var btnArray = ['否', '是'];
        mui.confirm('是否跳转到下载页面？', '应用未安装', btnArray, function (e) {
            if (e.index == 1) {
                window.location.href = androidAppDownloadUrl;
            }
        });
    }, 2000);
}

function locationiOSDownloadWebPage() {
    setTimeout(function () {
        var btnArray = ['否', '是'];
        mui.confirm('是否跳转到下载页面？', '应用未安装', btnArray, function (e) {
            if (e.index == 1) {
                window.location.href = iOSAppDownloadUrl;
            }
        });
    }, 2000);
}