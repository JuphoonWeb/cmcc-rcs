package com.juphoon.cmccrcs.videomeet.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by JeffWang on 2017/6/29.
 */
public class DatetimeUtils {

    public static String standardFormatDate() {
        return createFormatNowDate("yyyy-MM-dd HH:mm:ss");
    }

    public static String createFormatNowDate(String format) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        return simpleDateFormat.format(new Date());
    }
}
