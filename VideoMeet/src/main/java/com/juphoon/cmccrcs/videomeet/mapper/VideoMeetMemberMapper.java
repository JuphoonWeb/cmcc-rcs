package com.juphoon.cmccrcs.videomeet.mapper;

import com.juphoon.cmccrcs.videomeet.entity.VideoMeetMember;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetMemberExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface VideoMeetMemberMapper {
    int countByExample(VideoMeetMemberExample example);

    int unreadCountByMemberPhone(String phone);

    int deleteByPrimaryKey(Integer memberId);

    int insert(VideoMeetMember record);

    int insertSelective(VideoMeetMember record);

    int insertBatch(List<VideoMeetMember> videoMeetMembers);

    List<VideoMeetMember> selectByExampleWithBLOBs(VideoMeetMemberExample example);

    List<VideoMeetMember> selectByExample(VideoMeetMemberExample example);

    VideoMeetMember selectByPrimaryKey(Integer memberId);

    int updateByExampleSelective(@Param("record") VideoMeetMember record, @Param("example") VideoMeetMemberExample example);

    int updateByExampleWithBLOBs(@Param("record") VideoMeetMember record, @Param("example") VideoMeetMemberExample example);

    int updateByExample(@Param("record") VideoMeetMember record, @Param("example") VideoMeetMemberExample example);

    int updateByPrimaryKeySelective(VideoMeetMember record);

    int updateByPrimaryKeyWithBLOBs(VideoMeetMember record);

    int updateByPrimaryKey(VideoMeetMember record);
}