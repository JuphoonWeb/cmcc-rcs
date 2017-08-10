package com.juphoon.cmccrcs.videomeet.controller;

import com.github.pagehelper.PageInfo;
import com.juphoon.cmccrcs.videomeet.common.MD5_encryption;
import com.juphoon.cmccrcs.videomeet.common.ResponseEntity;
import com.juphoon.cmccrcs.videomeet.entity.UserInfo;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfo;
import com.juphoon.cmccrcs.videomeet.entity.demo;
import com.juphoon.cmccrcs.videomeet.service.UserInfoService;
import com.juphoon.cmccrcs.videomeet.service.VideoMeetInfoService;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/7/28.
 * 后端管理员查询
 */
@Controller
@RequestMapping("/search")

public class SearchController {

    private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

    @Autowired
    private VideoMeetInfoService videoMeetInfoService;
    @Autowired
    private UserInfoService userInfoService;
    /*
     * 查询时间段间的用户使用情况（名字可选）
     */
    @RequestMapping("/list")
    @ResponseBody
    public ResponseEntity getSendVideoMeetList(@RequestParam(defaultValue = "1") Integer page,
                                               @RequestParam(defaultValue = "20") Integer size,
                                               @RequestParam String startTime,
                                               @RequestParam String endTime,
                                               HttpServletResponse response,
                                               @RequestParam(required = false) String name) {

        try {
            response.setHeader("Access-Control-Allow-Credentials","true");
            PageInfo<VideoMeetInfo> pageInfo = videoMeetInfoService.selectByTimeInfoList(page, size, startTime, endTime, name);
            return ResponseEntity.success(getMap(pageInfo));
             }
             catch (Exception e)
             {
            return ResponseEntity.fail(getFailMap());
             }
    }


    /*
     * 查询时间段间的每个用户使用次数情况
     * 返回姓名，次数
     */
    @RequestMapping("/countList")
    @ResponseBody
    public ResponseEntity getSendCountMeetList(@RequestParam(defaultValue = "1") Integer page,
                                               @RequestParam(defaultValue = "20") Integer size,
                                               @RequestParam String startTime,
                                               @RequestParam String endTime) {

        try {

            PageInfo<UserInfo> pageInfo = videoMeetInfoService.selectByTimeCountInfoList(page, size, startTime, endTime);
            return ResponseEntity.success(getMap(pageInfo));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.fail(getFailMap());
        }
    }


    private Map<String, Object> getMap(PageInfo pageInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("total", pageInfo.getTotal());
        map.put("list", pageInfo.getList());
        return map;
    }

    private Map<String, Object> getFailMap() {
        Map<String, Object> map = new HashMap<>();
        map.put("total", 0);
        map.put("list", Collections.emptyList());
        return map;
    }

    /*
     * 用户登录管理
     */
    @RequestMapping("/login")
    @ResponseBody
    public ResponseEntity getSendVideoMeetList(HttpServletResponse response,String username, String password) {


//        Cookie namecookie = new Cookie("name",username);
//       namecookie.setMaxAge(60*30);
//       namecookie.setPath("/");
//       response.addCookie(namecookie);
//      response.setHeader("Access-Control-Allow-Credentials","true");

        if (userInfoService.login(username) == null)
            {
            return ResponseEntity.fail();
           }

            String password1 = userInfoService.login(username);

            if (password1.equals(MD5_encryption.MD5(password))) {
                return ResponseEntity.success();
            }
                return ResponseEntity.fail();


    }


    /*
     * 下载查询的时间段间的用户使用情况（名字可选）
     */
    @RequestMapping("/download")
    public void downstudents(HttpServletRequest request, HttpServletResponse response,
                             @RequestParam String startTime,
                             @RequestParam String endTime,
                             @RequestParam(required = false) String name) throws IOException//3.用对象传输
    {
        //   ExportExcel<VideoMeetInfo> ex = new ExportExcel<VideoMeetInfo>();
        String[] headers = {"会议主题", "发起人姓名", "发起人手机", "会议创建时间", "会议开始时间", "会议结束时间"};
        PageInfo<VideoMeetInfo> pageInfo1 = videoMeetInfoService.selectByTime(startTime, endTime, name);
        List<VideoMeetInfo> pageInfo=pageInfo1.getList();
        List<demo> dataset = new ArrayList<demo>();
        for (int i = 0; i < pageInfo.size(); i++) {
            dataset.add(new demo(
                    pageInfo.get(i).getMeetSubject(),
                    pageInfo.get(i).getChairmanName(),
                    pageInfo.get(i).getChairmanPhone(),
                    pageInfo.get(i).getCreateDatetime(),
                    pageInfo.get(i).getMeetDatetime(),
                    pageInfo.get(i).getEndDatetime()
            ));
        }
        // 声明一个工作薄
        HSSFWorkbook workbook = new HSSFWorkbook();
        // 生成一个表格
        HSSFSheet sheet = workbook.createSheet();
        // 设置表格默认列宽度为15个字节
        sheet.setDefaultColumnWidth((short) 18);
        HSSFRow row = sheet.createRow(0);
        for (short i = 0; i < headers.length; i++) {
            HSSFCell cell = row.createCell(i);
            HSSFRichTextString text = new HSSFRichTextString(headers[i]);
            cell.setCellValue(text);
        }
        //遍历集合数据，产生数据行
        Iterator<demo> it = dataset.iterator();
        int index = 0;
        while (it.hasNext()) {
            index++;
            row = sheet.createRow(index);
            demo t = (demo) it.next();
            //利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值
            Field[] fields = t.getClass().getDeclaredFields();
            for (short i = 0; i < fields.length; i++) {
                HSSFCell cell = row.createCell(i);
                Field field = fields[i];
                String fieldName = field.getName();
                String getMethodName = "get"
                        + fieldName.substring(0, 1).toUpperCase()
                        + fieldName.substring(1);
                try {
                    Class tCls = t.getClass();
                    Method getMethod = tCls.getMethod(getMethodName,
                            new Class[]{});
                    Object value = getMethod.invoke(t, new Object[]{});
                    String textValue = null;

                    if (value instanceof Date) {
                        Date date = (Date) value;
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        textValue = sdf.format(date);
                    } else {
                        //其它数据类型都当作字符串简单处理

                        textValue = String.valueOf(value);

                    }
                    //如果不是图片数据，就利用正则表达式判断textValue是否全部由数字组成
                  /* if (textValue != null) {
                        Pattern p = Pattern.compile("^\\d+(\\.\\d+)?$");
                        Matcher matcher = p.matcher(textValue);
                        if (matcher.matches()) {
                            //是数字当作double处理
                            cell.setCellValue(Double.parseDouble(textValue));
                        } else {
                        */
                    HSSFRichTextString richString = new HSSFRichTextString(textValue);
                    HSSFFont font3 = workbook.createFont();
                    font3.setColor(HSSFColor.BLUE.index);
                    richString.applyFont(font3);
                    cell.setCellValue(richString);
                    //  }

                    //}
                } catch (SecurityException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (NoSuchMethodException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (IllegalArgumentException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (InvocationTargetException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
        Date date=null;
        Date date2=null;

        try {
            date=formatter.parse(startTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        try {
            date2=formatter.parse(endTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }


        String time=formatter.format(date);
        String time2=formatter.format(date2);
//		System.out.println(videoMeetInfoMapper.selectByTimeCount(startTime,endTime));
        //    System.out.println( "startTime:"+time);


        String fileName = "多方视频会议"+time + "~" + time2 + ".xls";

        // String headStr = "attachment; filename=\"" + fileName + "\"";
        String headStr = "attachment;filename=" + new String( fileName.getBytes("gb2312"), "ISO8859-1" );
        response.setContentType("application/octet-stream");
        response.setHeader("Content-disposition", headStr);
        //response.setHeader("Content-disposition", "attachment;filename=\\\"\" + fileName + \"\\\"\"");
        response.flushBuffer();
        workbook.write(response.getOutputStream());
    }
}