package com.juphoon.cmccrcs.videomeet.service.impl;

import com.juphoon.cmccrcs.videomeet.entity.VideoMeetMember;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetMemberExample;
import com.juphoon.cmccrcs.videomeet.mapper.VideoMeetMemberMapper;
import com.juphoon.cmccrcs.videomeet.service.VideoMeetMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by JeffWang on 2017/5/31.
 */
@Service
public class VideoMeetMemberServiceImpl implements VideoMeetMemberService {

    @Autowired
    private VideoMeetMemberMapper videoMeetMemberMapper;

    @Override
    public List<VideoMeetMember> selectMemberListByMeetId(int meetId) {
        VideoMeetMemberExample example = new VideoMeetMemberExample();
        VideoMeetMemberExample.Criteria criteria = example.createCriteria();
        criteria.andMeetIdEqualTo(meetId);
        List<VideoMeetMember> resultList = videoMeetMemberMapper.selectByExample(example);
        return resultList;
    }

    @Override
    public VideoMeetMember selectOneByMeeIdAndPhone(int meetId, String phone) {
        VideoMeetMemberExample example = new VideoMeetMemberExample();
        VideoMeetMemberExample.Criteria criteria = example.createCriteria();
        criteria.andMeetIdEqualTo(meetId);
        criteria.andMemberPhoneEqualTo(phone);
        List<VideoMeetMember> resultList = videoMeetMemberMapper.selectByExample(example);
        if (resultList != null && resultList.size() > 0) {
            return resultList.get(0);
        } else {
            return null;
        }
    }

    @Override
    public int saveMemberList(List<VideoMeetMember> videoMeetMemberList) {
        return videoMeetMemberMapper.insertBatch(videoMeetMemberList);
    }

    @Override
    public int unreadCountByMemberPhone(String phone) {
        return videoMeetMemberMapper.unreadCountByMemberPhone(phone);
    }

    @Override
    public int updateUnreadByMemberPhone(String phone) {
        VideoMeetMemberExample example = new VideoMeetMemberExample();
        VideoMeetMemberExample.Criteria criteria = example.createCriteria();
        criteria.andMemberPhoneEqualTo(phone);

        VideoMeetMember meetMember = new VideoMeetMember();
        meetMember.setIsRead(1);
        return videoMeetMemberMapper.updateByExampleSelective(meetMember, example);
    }

    @Override
    public int updateUnreadByMeetIdAndPhone(int meetId, String phone) {
        VideoMeetMemberExample example = new VideoMeetMemberExample();
        VideoMeetMemberExample.Criteria criteria = example.createCriteria();
        criteria.andMemberPhoneEqualTo(phone);
        criteria.andMeetIdEqualTo(meetId);

        VideoMeetMember meetMember = new VideoMeetMember();
        meetMember.setIsRead(1);
        return videoMeetMemberMapper.updateByExampleSelective(meetMember, example);
    }
}
