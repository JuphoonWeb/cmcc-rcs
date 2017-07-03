package com.juphoon.cmccrcs.videomeet.entity;

import java.io.Serializable;
import java.util.Date;

public class VideoMeetInfo implements Serializable {
    private Integer meetId;

    private String meetSubject;

    private String meetPassword;

    private String chairmanName;

    private String chairmanPhone;

    private String chairmanInfo;

    private String meetDatetime;

    private Date createDatetime;

    private Integer isDelete;

    private Date deleteDatetime;

    private String members;

    private static final long serialVersionUID = 1L;

    public VideoMeetInfo(Integer meetId, String meetSubject, String meetPassword, String chairmanName, String chairmanPhone, String meetDatetime, Date createDatetime, Integer isDelete, Date deleteDatetime, String chairmanInfo, String members) {
        this.meetId = meetId;
        this.meetSubject = meetSubject;
        this.meetPassword = meetPassword;
        this.chairmanName = chairmanName;
        this.chairmanPhone = chairmanPhone;
        this.chairmanInfo = chairmanInfo;
        this.meetDatetime = meetDatetime;
        this.createDatetime = createDatetime;
        this.isDelete = isDelete;
        this.deleteDatetime = deleteDatetime;
        this.members = members;
    }

    public VideoMeetInfo(Integer meetId, String meetSubject, String meetPassword, String chairmanName, String chairmanPhone, String meetDatetime, Date createDatetime) {
        this.meetId = meetId;
        this.meetSubject = meetSubject;
        this.meetPassword = meetPassword;
        this.chairmanName = chairmanName;
        this.chairmanPhone = chairmanPhone;
        this.meetDatetime = meetDatetime;
        this.createDatetime = createDatetime;
    }

    public VideoMeetInfo(String meetSubject, String chairmanName, String chairmanPhone, String chairmanInfo, String meetDatetime, String members) {
        this.meetSubject = meetSubject;
        this.chairmanName = chairmanName;
        this.chairmanPhone = chairmanPhone;
        this.chairmanInfo = chairmanInfo;
        this.meetDatetime = meetDatetime;
        this.createDatetime = new Date();
        this.members = members;
    }

    public VideoMeetInfo() {
        super();
    }

    public Integer getMeetId() {
        return meetId;
    }

    public void setMeetId(Integer meetId) {
        this.meetId = meetId;
    }

    public String getMeetSubject() {
        return meetSubject;
    }

    public void setMeetSubject(String meetSubject) {
        this.meetSubject = meetSubject == null ? null : meetSubject.trim();
    }

    public String getMeetPassword() {
        return meetPassword;
    }

    public void setMeetPassword(String meetPassword) {
        this.meetPassword = meetPassword == null ? null : meetPassword.trim();
    }

    public String getChairmanName() {
        return chairmanName;
    }

    public void setChairmanName(String chairmanName) {
        this.chairmanName = chairmanName == null ? null : chairmanName.trim();
    }

    public String getChairmanPhone() {
        return chairmanPhone;
    }

    public void setChairmanPhone(String chairmanPhone) {
        this.chairmanPhone = chairmanPhone == null ? null : chairmanPhone.trim();
    }

    public String getChairmanInfo() {
        return chairmanInfo;
    }

    public void setChairmanInfo(String chairmanInfo) {
        this.chairmanInfo = chairmanInfo == null ? null : chairmanInfo.trim();
    }

    public String getMeetDatetime() {
        return meetDatetime;
    }

    public void setMeetDatetime(String meetDatetime) {
        this.meetDatetime = meetDatetime == null ? null : meetDatetime.trim();
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

    public Date getDeleteDatetime() {
        return deleteDatetime;
    }

    public void setDeleteDatetime(Date deleteDatetime) {
        this.deleteDatetime = deleteDatetime;
    }

    public String getMembers() {
        return members;
    }

    public void setMembers(String members) {
        this.members = members == null ? null : members.trim();
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        VideoMeetInfo other = (VideoMeetInfo) that;
        return (this.getMeetId() == null ? other.getMeetId() == null : this.getMeetId().equals(other.getMeetId()))
            && (this.getMeetSubject() == null ? other.getMeetSubject() == null : this.getMeetSubject().equals(other.getMeetSubject()))
            && (this.getMeetPassword() == null ? other.getMeetPassword() == null : this.getMeetPassword().equals(other.getMeetPassword()))
            && (this.getChairmanName() == null ? other.getChairmanName() == null : this.getChairmanName().equals(other.getChairmanName()))
            && (this.getChairmanPhone() == null ? other.getChairmanPhone() == null : this.getChairmanPhone().equals(other.getChairmanPhone()))
            && (this.getMeetDatetime() == null ? other.getMeetDatetime() == null : this.getMeetDatetime().equals(other.getMeetDatetime()))
            && (this.getCreateDatetime() == null ? other.getCreateDatetime() == null : this.getCreateDatetime().equals(other.getCreateDatetime()))
            && (this.getIsDelete() == null ? other.getIsDelete() == null : this.getIsDelete().equals(other.getIsDelete()))
            && (this.getDeleteDatetime() == null ? other.getDeleteDatetime() == null : this.getDeleteDatetime().equals(other.getDeleteDatetime()))
            && (this.getMembers() == null ? other.getMembers() == null : this.getMembers().equals(other.getMembers()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getMeetId() == null) ? 0 : getMeetId().hashCode());
        result = prime * result + ((getMeetSubject() == null) ? 0 : getMeetSubject().hashCode());
        result = prime * result + ((getMeetPassword() == null) ? 0 : getMeetPassword().hashCode());
        result = prime * result + ((getChairmanName() == null) ? 0 : getChairmanName().hashCode());
        result = prime * result + ((getChairmanPhone() == null) ? 0 : getChairmanPhone().hashCode());
        result = prime * result + ((getMeetDatetime() == null) ? 0 : getMeetDatetime().hashCode());
        result = prime * result + ((getCreateDatetime() == null) ? 0 : getCreateDatetime().hashCode());
        result = prime * result + ((getIsDelete() == null) ? 0 : getIsDelete().hashCode());
        result = prime * result + ((getDeleteDatetime() == null) ? 0 : getDeleteDatetime().hashCode());
        result = prime * result + ((getMembers() == null) ? 0 : getMembers().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", meetId=").append(meetId);
        sb.append(", meetSubject=").append(meetSubject);
        sb.append(", meetPassword=").append(meetPassword);
        sb.append(", chairmanName=").append(chairmanName);
        sb.append(", chairmanPhone=").append(chairmanPhone);
        sb.append(", meetDatetime=").append(meetDatetime);
        sb.append(", createDatetime=").append(createDatetime);
        sb.append(", isDelete=").append(isDelete);
        sb.append(", deleteDatetime=").append(deleteDatetime);
        sb.append(", members=").append(members);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}