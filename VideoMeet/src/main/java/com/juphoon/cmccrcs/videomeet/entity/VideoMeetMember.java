package com.juphoon.cmccrcs.videomeet.entity;

import java.io.Serializable;

public class VideoMeetMember implements Serializable {
    private Integer memberId;

    private String memberName;

    private String memberPhone;

    private Integer meetId;

    private Integer isRead;

    private String memberInfo;

    private static final long serialVersionUID = 1L;

    public VideoMeetMember(Integer memberId, String memberName, String memberPhone, Integer meetId, Integer isRead, String memberInfo) {
        this.memberId = memberId;
        this.memberName = memberName;
        this.memberPhone = memberPhone;
        this.meetId = meetId;
        this.isRead = isRead;
        this.memberInfo = memberInfo;
    }

    public VideoMeetMember(Integer memberId, String memberName, String memberPhone, Integer meetId, Integer isRead) {
        this.memberId = memberId;
        this.memberName = memberName;
        this.memberPhone = memberPhone;
        this.meetId = meetId;
        this.isRead = isRead;
    }

    public VideoMeetMember() {
        super();
    }

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName == null ? null : memberName.trim();
    }

    public String getMemberPhone() {
        return memberPhone;
    }

    public void setMemberPhone(String memberPhone) {
        this.memberPhone = memberPhone == null ? null : memberPhone.trim();
    }

    public Integer getMeetId() {
        return meetId;
    }

    public void setMeetId(Integer meetId) {
        this.meetId = meetId;
    }

    public Integer getIsRead() {
        return isRead;
    }

    public void setIsRead(Integer isRead) {
        this.isRead = isRead;
    }

    public String getMemberInfo() {
        return memberInfo;
    }

    public void setMemberInfo(String memberInfo) {
        this.memberInfo = memberInfo == null ? null : memberInfo.trim();
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
        VideoMeetMember other = (VideoMeetMember) that;
        return (this.getMemberId() == null ? other.getMemberId() == null : this.getMemberId().equals(other.getMemberId()))
            && (this.getMemberName() == null ? other.getMemberName() == null : this.getMemberName().equals(other.getMemberName()))
            && (this.getMemberPhone() == null ? other.getMemberPhone() == null : this.getMemberPhone().equals(other.getMemberPhone()))
            && (this.getMeetId() == null ? other.getMeetId() == null : this.getMeetId().equals(other.getMeetId()))
            && (this.getIsRead() == null ? other.getIsRead() == null : this.getIsRead().equals(other.getIsRead()))
            && (this.getMemberInfo() == null ? other.getMemberInfo() == null : this.getMemberInfo().equals(other.getMemberInfo()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getMemberId() == null) ? 0 : getMemberId().hashCode());
        result = prime * result + ((getMemberName() == null) ? 0 : getMemberName().hashCode());
        result = prime * result + ((getMemberPhone() == null) ? 0 : getMemberPhone().hashCode());
        result = prime * result + ((getMeetId() == null) ? 0 : getMeetId().hashCode());
        result = prime * result + ((getIsRead() == null) ? 0 : getIsRead().hashCode());
        result = prime * result + ((getMemberInfo() == null) ? 0 : getMemberInfo().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", memberId=").append(memberId);
        sb.append(", memberName=").append(memberName);
        sb.append(", memberPhone=").append(memberPhone);
        sb.append(", meetId=").append(meetId);
        sb.append(", isRead=").append(isRead);
        sb.append(", memberInfo=").append(memberInfo);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}