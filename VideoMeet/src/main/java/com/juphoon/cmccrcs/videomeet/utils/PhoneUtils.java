package com.juphoon.cmccrcs.videomeet.utils;

/**
 * Created by Juphoon on 2017/9/18.
 */
public class PhoneUtils {


    public static String getRcsPhone(String phone) {

        if(phone.startsWith("+") || phone.startsWith("00")) {
            return phone;
        }

        return  "+86" + phone;

    }

}
