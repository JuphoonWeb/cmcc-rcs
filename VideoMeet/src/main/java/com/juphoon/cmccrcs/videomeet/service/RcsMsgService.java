package com.juphoon.cmccrcs.videomeet.service;

import com.juphoon.cmccrcs.videomeet.utils.DatetimeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.io.UnsupportedEncodingException;
import java.util.Base64;

/**
 * Created by JeffWang on 2017/6/28.
 */
@Service
public class RcsMsgService {

    private final static String CAP_ACCESS_NUMBER = "125600400000025";
    private final static String CAP_MSG_URL_BUSINESS = "http://117.136.180.205:8080/capabilitydiscovery/messaging/v1.0/outbound/tel:"+CAP_ACCESS_NUMBER+"/requests";
    private final static String CAP_MESSAGE_URL_TEST= "http://117.136.180.205:8080/capabilitydiscovery/messaging/v1.0/outbound/tel:"+CAP_ACCESS_NUMBER+"/requests";

    public enum MsgMediaType {
        text,
        h5,
        template;
    }

    public enum DisplayMode {
        DEFAULT("0"),
        ONE2ONE("1");

        private String value;
        private DisplayMode(String value) {
            this.value = value;
        }
        public String value() {
            return this.value;
        }
    }

    public enum MessageType {
        Default,  //默认
        Notify,   //B2C应用内消息，平台将消息发给被叫终端，并抄送被叫的其它设备。
        Message,  //B2C增强消息，平台将消息发送给主被叫终端，并抄送主被叫的其它设备。
        Caller,   //平台将消息发送给主被叫，并抄送给主叫的其它设备。
        NoCopy    //平台将消息发送给被叫，但不抄送。
    }

    public enum AdditionalTerminal {

    }

    @Autowired
    private RestTemplate restTemplate;

    public boolean sendRcsMessage(String senderNumber, String recvNumber, MsgMediaType msgMediaType, String title, String summary, String content, String redirectUrl) {
        HttpHeaders headers = new HttpHeaders();
        // 这个对象有add()方法，可往请求头存入信息
        MediaType type = MediaType.parseMediaType(MediaType.APPLICATION_XML_VALUE+"; charset=UTF-8");
        headers.setContentType(type);
        headers.set("Accept-Charset", "UTF-8");
        String authInfo = createAuthorization();
        headers.add("Authorization", "Bearer "+authInfo);
        headers.add("Address","tel:+86"+recvNumber);

        String body = createMsgXmlWithMediaType(senderNumber, recvNumber, msgMediaType, title, summary, content, redirectUrl);
        HttpEntity<String> entity = new HttpEntity<String>(body, headers);
        try {
//            System.out.println("HttpEntity Headers :"+entity.getHeaders().toString());
//            System.out.println("HttpEntity Body :"+entity.getBody());
            ResponseEntity<String> responseEntity = restTemplate.exchange(CAP_MSG_URL_BUSINESS, HttpMethod.POST, entity, String.class);
            if (responseEntity.getStatusCode() == HttpStatus.CREATED) {
//                System.out.println("responseEntity："+responseEntity.toString());
                return true;
            } else {
//                System.out.println("error body："+responseEntity.getBody());
                return false;
            }
        } catch (RestClientException e) {
            if (e instanceof HttpServerErrorException) {
                HttpServerErrorException hse = (HttpServerErrorException)e;
                System.out.println("StatusCode:"+hse.getStatusCode());
                System.out.println("ResponseHeaders:"+hse.getResponseHeaders());
                System.out.println("ResponseBody:"+hse.getResponseBodyAsString());
            }
            return false;
        }
    }

    private String createAuthorization() {
        String authInfo = TokenService.IAM_APPR_ID + ":" + TokenService.IAM_ACCESS_TOKEN;
        try {
            return Base64.getEncoder().encodeToString(authInfo.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }

    private String createMsgXmlWithMediaType(String senderNumber, String recvNumber, MsgMediaType mediaType, String title, String summary, String content, String redirectUrl) {

//        String thumbLink = "http://117.136.240.59/Open/Authorize?appid=11334&amp;response_type=code&amp;scope=snsapi_base&amp;redirect_uri="+redirectUrl;
//        String thumbLink = "http://gz.feixin.10086.cn/Open/Authorize?appid=11334&amp;response_type=code&amp;scope=snsapi_base&amp;redirect_uri="+redirectUrl;
        String thumbLink = redirectUrl;
        String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                "<msg:outboundMessageRequest xmlns:msg=\"urn:oma:xml:rest:netapi:messaging:1\">" +
                "<address>tel:+86"+recvNumber+"</address>" +
                "<destAddress>tel:+86"+recvNumber+"</destAddress>" +
                "<senderAddress>tel:+86"+senderNumber+"</senderAddress>" +
                "<outboundIMMessage>" +
                "<imFormat>IM</imFormat>" +
                "<contentType>application/commontemplate+xml</contentType>" +
                "<shortMessageSupported>false</shortMessageSupported>" +
                "<storeSupported>true</storeSupported>" +
                "<receiptRequest>false</receiptRequest>" +
                "<messageType>"+MessageType.Default+"</messageType>"+
                "<bodyText>" +
                "<![CDATA[<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                "<commontemplate xmlns=\"urn:ietf:params:xml:ns:templateInfo\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:cp=\"urn:ietf:params:xml:ns:capacity\">" +
                "<extensionType>ActiveMessage</extensionType>" +
                "<extensionVer>V1.0</extensionVer>" +
                "<extensionInfo>" +
                "<Forwardable>0</Forwardable>" +
                "<AccessNo>"+CAP_ACCESS_NUMBER+"</AccessNo>" +
                "<DisplayMode>"+DisplayMode.DEFAULT.value()+"</DisplayMode>" +
                "<ActMsg>" +
                "<Version>V1.0</Version>" +
                "<Title>"+title+"</Title>" +
                "<ThumbLink>"+thumbLink+"</ThumbLink>" +
                "<Summary>"+summary+"</Summary>" +
                "<Timestamp>"+ DatetimeUtils.standardFormatDate()+"</Timestamp>"+
                "<MediaType>"+mediaType+"</MediaType>";
                if (mediaType == MsgMediaType.text) {
                    xml = xml + "<Text>" + content + "</Text>";
                }
                else if (mediaType == MsgMediaType.h5) {
                    xml = xml + "<H5Link>"+redirectUrl+"</H5Link>";
                }
                else if (mediaType == MsgMediaType.template) {
                    xml = xml + "<TemplateMessage>"+
                            "<title>"+title+"</title>"+
                            "<first>"+summary+"</first>"+
                            "<keyword1>keyword1</keyword1>"+
                            "<keyword2>keyword2</keyword2>"+
                            "<keyword3>keyword3</keyword3>"+
                            "<keyword4>keyword4keyword4keyword4keyword4keyword4</keyword4>"+
                            "<keyword5>keyword5keyword5keyword5keyword5keyword5keyword5keyword5keyword5keyword5keyword5keyword5keyword5keyword5</keyword5>"+
                            "<remark>remark</remark>"+
                            "<btnname1>detail</btnname1>"+
                            "<btntype1>0</btntype1>"+
                            "<btnaction1>www.baidu.com</btnaction1>"+
                            "<btnname1>do</btnname1>"+
                            "<btntype1>3</btntype1>"+
                            "<btnaction1>juphoonultimateshow://joinMeeting?meetId=241&meetPassword=&displayName=jeff</btnaction1>"+
                            "</TemplateMessage>";
                }
        xml = xml +"</ActMsg>" +
                "</extensionInfo>" +
                "</commontemplate>]]>" +
                "</bodyText>" +
                "</outboundIMMessage>" +
                "</msg:outboundMessageRequest>";
        return xml;
    }
}
