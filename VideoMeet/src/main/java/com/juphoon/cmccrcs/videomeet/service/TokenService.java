package com.juphoon.cmccrcs.videomeet.service;

import com.juphoon.cmccrcs.videomeet.config.MyBatisConfiguration;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by JeffWang on 2017/6/27.
 */
@Component
public class TokenService {

    private static final Logger logger = LoggerFactory.getLogger(TokenService.class);

    @Autowired
    private RestTemplate restTemplate;

    private final static String CMPASSPORT_TOKEN_VALIDATE_URL = "https://wap.cmpassport.com:8443/api/tokenValidate";
    private final static String CMPASSPORT_SOURCE_ID = "001073";
    private final static String CMPASSPORT_APP_TYPE = "2";
    private final static String CMPASSPORT_VERSION = "1.0";

    public final static String IAM_REQ_TOKEN_URL_BUSINESS = "http://117.136.180.220:8080/services/OauthAPIV1/token";
    public final static String IAM_REQ_TOKEN_URL_TEST = "http://120.197.90.58:9080/services/OauthAPIV1/token";
    public final static String IAM_APPR_ID = "32";
    public final static String IAM_APP_PASSWORD = "4I595795055u53J2F044S243IBa58Y59";
    public static String IAM_ACCESS_TOKEN;


    private String createCmPassportRequestBody(String token) {
        String uuid = UUID.randomUUID().toString();

        JSONObject jsonObj = new JSONObject();

        JSONObject headerJsonObj = new JSONObject();
        headerJsonObj.put("apptype", CMPASSPORT_APP_TYPE);
        headerJsonObj.put("msgid", uuid);
        headerJsonObj.put("sourceid", CMPASSPORT_SOURCE_ID);
        headerJsonObj.put("systemtime", new SimpleDateFormat("yyyyMMddhhmmssSSS").format(new Date()));
        headerJsonObj.put("version", CMPASSPORT_VERSION);

        JSONObject bodyJsonObj = new JSONObject();
        bodyJsonObj.put("token", token);

        jsonObj.put("header", headerJsonObj);
        jsonObj.put("body", bodyJsonObj);
        return jsonObj.toString();
    }

    /**
     * 统一认证Token校验接口
     *
     * @param token
     * @return
     */
    public ResponseEntity<String> tokenValidateByCmPassport(String token) {
        HttpHeaders headers = new HttpHeaders();
        // 这个对象有add()方法，可往请求头存入信息
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
        // 解决中文乱码的关键
        String body = createCmPassportRequestBody(token);
        HttpEntity<String> entity = new HttpEntity<String>(body, headers);
        // body是Http消息体例如json串
        return restTemplate.exchange(CMPASSPORT_TOKEN_VALIDATE_URL, HttpMethod.POST, entity, String.class);
    }

    public String requestMsisdnByCmPassport(String token) {
        ResponseEntity<String> responseEntity = tokenValidateByCmPassport(token);
        HttpStatus httpStatus = responseEntity.getStatusCode();
        if (httpStatus == HttpStatus.OK) {
            JSONObject jsonObject = JSONObject.fromObject(responseEntity.getBody());
            JSONObject headerJsonObj = jsonObject.getJSONObject("header");
            String resultCode = headerJsonObj.getString("resultcode");
            if ("103000".equals(resultCode)) {
                JSONObject bodyJsonObj = jsonObject.getJSONObject("body");
                String msisdn = bodyJsonObj.getString("msisdn");
                return msisdn;
            }
        }
        return null;
    }

    private String createIAMRequestBody() {
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("app_id", IAM_APPR_ID);
        jsonObj.put("app_password", IAM_APP_PASSWORD);
        jsonObj.put("grant_type", "client_credentials");
        return jsonObj.toString();
    }

    public void requestTokenByIAM() {
        HttpHeaders headers = new HttpHeaders();
        // 这个对象有add()方法，可往请求头存入信息
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);

        String requestBody = createIAMRequestBody();
        HttpEntity<String> entity = new HttpEntity<String>(requestBody, headers);
        try {

            ResponseEntity<String> responseEntity = restTemplate.exchange(IAM_REQ_TOKEN_URL_BUSINESS, HttpMethod.POST, entity, String.class);
            logger.debug("StatusCode:"+responseEntity.getStatusCode());
            if (responseEntity.getStatusCode() == HttpStatus.OK) {
                String responseBody = responseEntity.getBody();
                JSONObject jsonObject = JSONObject.fromObject(responseBody);
                logger.debug("body:" + responseEntity.getBody());

                String accessToken = (String) jsonObject.get("access_token");
                int expireDuring = Integer.valueOf((String) jsonObject.get("expires_in"));
                TokenService.IAM_ACCESS_TOKEN = accessToken;
            } else {
                logger.debug("body:" + responseEntity.getBody());
            }
        } catch (RestClientException e) {
            if (e instanceof HttpServerErrorException) {
                HttpServerErrorException hse = (HttpServerErrorException)e;
                logger.debug("StatusCode:"+hse.getStatusCode());
                logger.debug("ResponseHeaders:"+hse.getResponseHeaders());
                logger.debug("ResponseBody:"+hse.getResponseBodyAsString());
            }
        }
    }
}
