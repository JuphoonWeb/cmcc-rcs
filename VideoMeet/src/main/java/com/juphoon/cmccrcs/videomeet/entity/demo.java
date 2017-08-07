package com.juphoon.cmccrcs.videomeet.entity;

import java.util.Date;

/**
 * Created by Administrator on 2017/8/1.
 */
public class demo {


    private String meetSubject;
    private String chairmanName;
    private String chairmanPhone;
    private Date createDatetime;
    private String meetDatetime;
    private String endDatetime;

    public String getMeetSubject() {
        return meetSubject;
    }

    public void setMeetSubject(String meetSubject) {
        this.meetSubject = meetSubject;
    }

    public String getChairmanName() {
        return chairmanName;
    }

    public void setChairmanName(String chairmanName) {
        this.chairmanName = chairmanName;
    }



    public String getChairmanPhone() {
        return chairmanPhone;
    }

    public void setChairmanPhone(String chairmanPhone) {
        this.chairmanPhone = chairmanPhone;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public String getMeetDatetime() {
        return meetDatetime;
    }

    public void setMeetDatetime(String meetDatetime) {
        this.meetDatetime = meetDatetime;
    }

    public String getEndDatetime() {
        return endDatetime;
    }

    public void setEndDatetime(String endDatetime) {
        this.endDatetime = endDatetime;
    }

    public demo(String meetSubject, String chairmanName, String chairmanPhone, Date createDatetime, String meetDatetime, String endDatetime) {

        this.meetSubject = meetSubject;
        this.chairmanName = chairmanName;
        this.chairmanPhone = chairmanPhone;
        this.createDatetime = createDatetime;
        this.meetDatetime = meetDatetime;
        this.endDatetime = endDatetime;
    }
    @Override
    public String toString() {

        return "demo [ meetSubject=" + meetSubject + ", chairmanName=" + chairmanName + ",chairmanPhone="+chairmanPhone+",createDatetime="+createDatetime+",meetDatetime="+meetDatetime+",endDatetime="+endDatetime+"]";
    }

    public demo() {
    }

}
