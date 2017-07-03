package com.juphoon.cmccrcs.videomeet;

//import com.github.pagehelper.PageHelper;
//import com.github.pagehelper.PageInfo;
//import VideoMeetInfo;
//import VideoMeetInfoExample;
//import VideoMeetInfoMapper;
import com.juphoon.cmccrcs.videomeet.service.RcsMsgService;
import com.juphoon.cmccrcs.videomeet.service.TokenService;
import net.sf.json.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SpringbootApplicationTests {

	@Autowired
	private TokenService tokenService;

	@Autowired
	private RcsMsgService rcsMsgService;

	@Test
	public void sendRcsMessage() {
//		String senderNumber = "15757855329";
//		String recvNumber = "15657821663";
//		RcsMsgService.MsgMediaType msgMediaType = RcsMsgService.MsgMediaType.text;
//		String title = "中国移动通信集团公司计划建设部(通知)";
//		String summary = "【李兴明】提交新待办【中国移动通信集团公司计划建设部(通知)】，请处理！";
//		String content = "您有【李兴明】提交的新待办【中国移动通信集团公司计划建设部(通知)】需要处理，点击链接直接办理！";
//		String redirectUrl = "http://120.27.131.68:8086/videoMeet/indexList/15657821662";
//		rcsMsgService.sendRcsMessage(senderNumber, recvNumber, msgMediaType, title ,summary, content, redirectUrl);
//		String a = "UA token=\"84840100013202003752454D78524559344E7A64464F545644516A59324E6A6B7A40687474703A2F2F3231312E3133362E31302E3133313A383038302F403033030004033C9CB9040006303130303031FF0020893736F2FF9C50EE4971868E99116916040BB38F20185656CA3CC2EDFD938398\"";
//		String s = a.substring(a.indexOf("\"")+1,a.lastIndexOf("\""));
//		System.out.println(s);
	}
}
