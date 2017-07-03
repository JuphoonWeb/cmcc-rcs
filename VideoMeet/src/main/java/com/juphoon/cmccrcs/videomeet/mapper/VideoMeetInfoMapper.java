package com.juphoon.cmccrcs.videomeet.mapper;

import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfo;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfoExample;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfoVO;

import java.util.List;

public interface VideoMeetInfoMapper {
    int deleteByPrimaryKey(Integer meetId);

    int insert(VideoMeetInfo record);

    int insertSelective(VideoMeetInfo record);

    int insertAndGetMeetId(VideoMeetInfo record);

    List<VideoMeetInfo> selectByExampleWithBLOBs(VideoMeetInfoExample example);

    List<VideoMeetInfo> selectByExample(VideoMeetInfoExample example);

    List<VideoMeetInfoVO> selectByMemberPhone(String phone);

    VideoMeetInfo selectByPrimaryKey(Integer meetId);

    int updateByPrimaryKeySelective(VideoMeetInfo record);

    int updateByPrimaryKeyWithBLOBs(VideoMeetInfo record);

    int updateByPrimaryKey(VideoMeetInfo record);
}