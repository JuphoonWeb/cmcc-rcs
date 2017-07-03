package com.juphoon.cmccrcs.videomeet.controller;

import com.juphoon.cmccrcs.videomeet.common.PageHelperEntity;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfo;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfoVO;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetMember;
import com.juphoon.cmccrcs.videomeet.service.RcsMsgService;
import com.juphoon.cmccrcs.videomeet.service.VideoMeetInfoService;
import com.juphoon.cmccrcs.videomeet.service.VideoMeetMemberService;
import com.juphoon.cmccrcs.videomeet.service.TokenService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/5/28 0028.
 */
@Controller
@RequestMapping("/VideoMeet")
public class MainController {

    @Autowired
    private VideoMeetInfoService videoMeetInfoService;
    @Autowired
    private VideoMeetMemberService videoMeetMemberService;
    @Autowired
    private TokenService tokenService;
    @Autowired
    private RcsMsgService rcsMsgService;

    @RequestMapping("/index")
    public String index(HttpServletRequest request, Model model) {
        Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String headerName = headerNames.nextElement();
            String headerValue = request.getHeader(headerName);//取出头信息内容
            System.out.println("headerName:"+headerName+" headerValue:"+headerValue);
        }
        String authInfo = request.getHeader("authorization");
        System.out.println("authorization:"+authInfo);
        return "index";
    }

    @RequestMapping("/test")
    public String test() {
        return "test";
    }

    @RequestMapping("/error")
    public String error() {
        return "error";
    }

    @RequestMapping(value="/videoMeetList/{phone}", method = RequestMethod.GET)
    public String videoMeetList(HttpSession httpSession, @PathVariable String phone, Model model) {
        model.addAttribute("currentPhone", phone);
        httpSession.setAttribute("currentPhone", phone);
        return "videoMeetList";
    }

    @RequestMapping("/videoMeetList")
    public String videoMeetList(Model model) {
        return "videoMeetList";
    }

    @RequestMapping("/method")
    public String method() {
        return "method";
    }

    @RequestMapping("/iOSAppInstructions")
    public String iOSAppInstructions() {
        return "iOSAppInstructions";
    }

    @RequestMapping("/showVideoMeetList/{phone}")
    public ModelAndView showVideoMeetList(@PathVariable String phone) {
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("currentPhone", phone);
        ModelAndView modelAndView = new ModelAndView("/videoMeetList", map);
        return modelAndView;
    }

    @RequestMapping ( "/getSendVideoMeetList/{phone}")
    @ResponseBody
    public String getSendVideoMeetList(@PathVariable String phone) {
        PageHelperEntity pageHelperEntity = getPageHelperParamEntity();
        int start = 1,size = 20;
        if (pageHelperEntity != null) {
            start = pageHelperEntity.getStart();
            size = pageHelperEntity.getSize();
        }
        int unreadCount = videoMeetMemberService.unreadCountByMemberPhone(phone);
        List<VideoMeetInfo> videoMeetInfoList = videoMeetInfoService.selectSendVideoMeetInfoList(phone, start, size);

        JSONObject jsonObject = new JSONObject();
        jsonObject.element("unreadCount", unreadCount);
        jsonObject.element("videoMeetInfoList",videoMeetInfoList);
        return jsonObject.toString();
    }

    @RequestMapping ( "/getRecvVideoMeetList/{phone}")
    @ResponseBody
    public String getRecvVideoMeetList(@PathVariable String phone) {
        PageHelperEntity pageHelperEntity = getPageHelperParamEntity();
        int start = 1,size = 20;
        if (pageHelperEntity != null) {
            start = pageHelperEntity.getStart();
            size = pageHelperEntity.getSize();
        }
//        if (start == 1) {
//            videoMeetMemberService.updateUnreadByMemberPhone(phone);
//        }
        int unreadCount = videoMeetMemberService.unreadCountByMemberPhone(phone);
        List<VideoMeetInfoVO> videoMeetInfoList = videoMeetInfoService.selectRecvVideoMeetInfoList(phone, start, size);

        JSONObject jsonObject = new JSONObject();
        jsonObject.element("unreadCount", unreadCount);
        jsonObject.element("videoMeetInfoList",videoMeetInfoList);
        return jsonObject.toString();
    }

    @RequestMapping ( "/showVideoMeetInfoDetail/{meetId}")
    public ModelAndView showVideoMeetInfoDetail(HttpServletRequest request, @PathVariable int meetId, @RequestParam("currentPhone")String currentPhone) {
        Map<String,Object> model = new HashMap<String, Object>();
        VideoMeetInfo videoMeetInfo = videoMeetInfoService.selectOneByMeetId(meetId);
        model.put("videoMeetInfo", videoMeetInfo);

        if (StringUtils.isEmpty(currentPhone)) {
            String authInfo = request.getHeader("authorization");
            System.out.println("authInfo:"+authInfo);
            if (!StringUtils.isEmpty(authInfo)) {
                int firstQuotation = authInfo.indexOf("\"")+1;
                int secendQuotation = authInfo.lastIndexOf("\"");
                String token = authInfo.substring(firstQuotation,secendQuotation);
                System.out.println("token:"+token);
                currentPhone = tokenService.requestMsisdnByCmPassport(token);
            }
        }

        if (!StringUtils.isEmpty(currentPhone)) {
            videoMeetMemberService.updateUnreadByMeetIdAndPhone(meetId, currentPhone);

            if (videoMeetInfo.getChairmanPhone().equals(currentPhone)) {
                model.put("isChairman", "1");
                model.put("currentName", videoMeetInfo.getChairmanName());
            } else {
                VideoMeetMember member = videoMeetMemberService.selectOneByMeeIdAndPhone(meetId, currentPhone);
                model.put("currentName", member.getMemberName());
                model.put("isChairman", "0");
            }
            model.put("currentPhone", currentPhone);
        }

//        List<VideoMeetMember> videoMeetMemberList = videoMeetMemberService.selectMemberListByMeetId(meetId);
//        map.put("videoMeetMemberList", JSONArray.fromObject(videoMeetMemberList).toString());
        return new ModelAndView("videoMeetDetail", model);
    }

    @RequestMapping (value = "/startVideoMeet", method = RequestMethod.POST)
    @ResponseBody
    public Object startVideoMeet(@RequestParam("meetSubject") String meetSubject,
                                 @RequestParam ("chairmanName") String chairmanName,
                                 @RequestParam ("chairmanPhone") String chairmanPhone,
                                 @RequestParam ("chairmanInfo") String chairmanInfo,
                                 @RequestParam ("members") String members) {
        if (meetSubject.length() > 40) {
            return new ResponseEntity<String>("Failed", HttpStatus.FORBIDDEN);
        }

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String meetDateTime = format.format(new Date());
        VideoMeetInfo videoMeetInfo = new VideoMeetInfo(meetSubject, chairmanName, chairmanPhone, chairmanInfo, meetDateTime, members);
        int result = videoMeetInfoService.saveVideoMeetInfo(videoMeetInfo);
        if (result <=0 ) {
            return new ResponseEntity<String>("Failed", HttpStatus.FORBIDDEN);
        }

        List<VideoMeetMember> videoMeetMemberList = new ArrayList<>();
        JSONArray jsonArray = JSONArray.fromObject(members);
        Iterator<Object> it = jsonArray.iterator();
        while (it.hasNext()) {
            JSONObject jsonObject = (JSONObject) it.next();
            VideoMeetMember videoMeetMember = new VideoMeetMember();
            videoMeetMember.setMeetId(videoMeetInfo.getMeetId());
            videoMeetMember.setMemberName(jsonObject.getString("name"));
            videoMeetMember.setMemberPhone(jsonObject.getString("phone"));
            videoMeetMember.setMemberInfo(jsonObject.toString());
            videoMeetMemberList.add(videoMeetMember);
        }

        result = videoMeetMemberService.saveMemberList(videoMeetMemberList);
        if (result <=0 ) {
            return new ResponseEntity<String>("Failed", HttpStatus.FORBIDDEN);
        }
        sendMeetNotifyMsg(videoMeetInfo, videoMeetMemberList);
        return new ResponseEntity<String>(JSONObject.fromObject(videoMeetInfo).toString(), HttpStatus.OK);
    }

    @RequestMapping("/sendMeetNotify/{meetId}")
    @ResponseBody
    public String sendMeetNotify(@PathVariable int meetId) {
        VideoMeetInfo videoMeetInfo = videoMeetInfoService.selectOneByMeetId(meetId);
        List<VideoMeetMember> videoMeetMemberList = videoMeetMemberService.selectMemberListByMeetId(meetId);
        sendMeetNotifyMsg(videoMeetInfo, videoMeetMemberList);
        return "ok";
    }

    @RequestMapping("/sendRcsMsg")
    @ResponseBody
    public String sendRcsMsg(@RequestParam("senderNumber")String senderNumber,
                             @RequestParam("recvNumber")String recvNumber,
                             @RequestParam("title")String title,
                             @RequestParam("summary")String summary,
                             @RequestParam("content")String content,
                             @RequestParam("redirectUrl")String redirectUrl) {
        boolean result = rcsMsgService.sendRcsMessage(senderNumber, recvNumber, RcsMsgService.MsgMediaType.text,
                title, summary, content, redirectUrl);
        return result?"1":"0";
    }

    protected HttpServletRequest getRequest() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        return request;
    }

    protected PageHelperEntity getPageHelperParamEntity(){
        Map<String, String[]> map = getRequest().getParameterMap();
        Map<String,Object> returnMap = new HashMap<String,Object>();
        Iterator<Map.Entry<String,String[]>> entries = map.entrySet().iterator();
        Map.Entry entry;
        String name = "";
        String value = "";
        PageHelperEntity pageHelperEntity = null;
        while (entries.hasNext()) {
            entry = (Map.Entry) entries.next();
            name = (String) entry.getKey();
            Object valueObj = entry.getValue();
            if(PageHelperEntity.PAGE_HELPER_PARAMTERS.OFFSET.getValue().equals(name)
                    || PageHelperEntity.PAGE_HELPER_PARAMTERS.LIMIT.getValue().equals(name)
                    || PageHelperEntity.PAGE_HELPER_PARAMTERS.SIZE.getValue().equals(name)
                    || PageHelperEntity.PAGE_HELPER_PARAMTERS.START.getValue().equals(name))
            {
                if(pageHelperEntity == null){
                    pageHelperEntity = new PageHelperEntity();
                }
            }
            if(valueObj instanceof String[]){
                String[] ssValueObj = (String[]) valueObj;
                if(PageHelperEntity.PAGE_HELPER_PARAMTERS.OFFSET.getValue().equals(name)){
                    pageHelperEntity.setOffset(Integer.parseInt(ssValueObj[0]));
                }
                if(PageHelperEntity.PAGE_HELPER_PARAMTERS.START.getValue().equals(name)){
                    pageHelperEntity.setStart(Integer.parseInt(ssValueObj[0]));
                }
                if(PageHelperEntity.PAGE_HELPER_PARAMTERS.SIZE.getValue().equals(name)){
                    pageHelperEntity.setSize(Integer.parseInt(ssValueObj[0]));
                }
                if(PageHelperEntity.PAGE_HELPER_PARAMTERS.LIMIT.getValue().equals(name)){
                    pageHelperEntity.setLimit(Integer.parseInt(ssValueObj[0]));
                }
            }

        }
        return pageHelperEntity;
    }

    protected String getTokenFromRequestParam() {
        Map<String, String[]> paramMap = getRequest().getParameterMap();
        Iterator<Map.Entry<String,String[]>> entries = paramMap.entrySet().iterator();
        while (entries.hasNext()) {
            Map.Entry entry = (Map.Entry) entries.next();
            String key = (String) entry.getKey();
            Object valueObj = entry.getValue();
            System.out.println("key:"+key+" value:"+valueObj.toString());
        }
        return getRequest().getParameter("token");
    }

    protected void sendMeetNotifyMsg(final VideoMeetInfo videoMeetInfo, final List<VideoMeetMember> videoMeetMemberList) {
        final String title = "【视频会议邀请】关于召开\""+ videoMeetInfo.getMeetSubject() + "\"会议的通知";
        final String summary = "会议ID：" + videoMeetInfo.getMeetId() + "\r\n" +
                "会议时间：" + videoMeetInfo.getMeetDatetime() + "\r\n" +
                "会议发起人：" + videoMeetInfo.getChairmanName() + " " + videoMeetInfo.getChairmanPhone()+"\r\n";
        final String redirectUrl = "http://122.227.209.194:8088/VideoMeet/showVideoMeetInfoDetail/"+videoMeetInfo.getMeetId()+"?currentPhone=";
        final String senderNumber = videoMeetInfo.getChairmanPhone();
        new Thread(new Runnable() {
            @Override
            public void run() {
                for (VideoMeetMember videoMeetMember:videoMeetMemberList) {
                    String recvNumber = videoMeetMember.getMemberPhone();
                    try {
                        Thread.sleep(100);
                        rcsMsgService.sendRcsMessage(senderNumber, recvNumber, RcsMsgService.MsgMediaType.text, title, summary, "", redirectUrl);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }).start();
    }
}
