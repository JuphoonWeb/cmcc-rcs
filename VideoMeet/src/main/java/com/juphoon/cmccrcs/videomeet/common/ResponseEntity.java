package com.juphoon.cmccrcs.videomeet.common;

/**
 * Created by Administrator on 2017/7/28.
 */
public class ResponseEntity {

    private int code;
    private Object data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public static ResponseEntity success() {
        return new ResponseEntity(1,null);
    }

    public static ResponseEntity fail() {
        return new ResponseEntity(-1,null);
    }

    public static ResponseEntity success(Object data) {
        return new ResponseEntity(1,data);
    }

    public static ResponseEntity fail(Object data) {
        return new ResponseEntity(-1,data);
    }


    public static ResponseEntity cookieTimeFail()
    {
        return new ResponseEntity(-2,null);
    }


    public ResponseEntity(int code, Object data) {
        this.code = code;
        this.data = data;
    }
}


