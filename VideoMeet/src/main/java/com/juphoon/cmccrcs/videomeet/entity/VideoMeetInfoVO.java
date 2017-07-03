package com.juphoon.cmccrcs.videomeet.entity;

import java.util.Date;

/**
 * Created by JeffWang on 2017/6/20.
 */
public class VideoMeetInfoVO extends VideoMeetInfo {

    private Integer isRead;

    public VideoMeetInfoVO(Integer meetId, String meetSubject, String meetPassword, String chairmanName, String chairmanPhone, String meetDatetime, Date createDatetime, Integer isRead) {
        super(meetId, meetSubject, meetPassword, chairmanName, chairmanPhone, meetDatetime, createDatetime);
        this.isRead = isRead;
    }

    public Integer getIsRead() {
        return isRead;
    }

    public void setIsRead(Integer isRead) {
        this.isRead = isRead;
    }


}
