package com.juphoon.cmccrcs.videomeet.service;

import com.juphoon.cmccrcs.videomeet.entity.VideoMeetMember;

import java.util.List;

/**
 * Created by JeffWang on 2017/5/31.
 */
public interface VideoMeetMemberService {

    public List<VideoMeetMember> selectMemberListByMeetId(int meetId);

    public VideoMeetMember selectOneByMeeIdAndPhone(int meetId, String phone);

    public int saveMemberList(List<VideoMeetMember> videoMeetMemberList);

    public int unreadCountByMemberPhone(String phone);

    public int updateUnreadByMemberPhone(String phone);

    public int updateUnreadByMeetIdAndPhone(int meetId, String phone);
}
