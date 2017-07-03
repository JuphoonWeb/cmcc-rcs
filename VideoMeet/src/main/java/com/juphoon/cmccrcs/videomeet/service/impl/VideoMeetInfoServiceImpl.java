package com.juphoon.cmccrcs.videomeet.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfo;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfoExample;
import com.juphoon.cmccrcs.videomeet.entity.VideoMeetInfoVO;
import com.juphoon.cmccrcs.videomeet.mapper.VideoMeetInfoMapper;
import com.juphoon.cmccrcs.videomeet.service.VideoMeetInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/5/28 0028.
 */
@Service
public class VideoMeetInfoServiceImpl implements VideoMeetInfoService {

    @Autowired
    private VideoMeetInfoMapper videoMeetInfoMapper;

    @Override
    public List<VideoMeetInfo> selectSendVideoMeetInfoList(String phone, int start, int size) {
        PageHelper.startPage(start, size).setOrderBy("meet_id desc");
        VideoMeetInfoExample example = new VideoMeetInfoExample();
        VideoMeetInfoExample.Criteria criteria = example.createCriteria();
        criteria.andChairmanPhoneEqualTo(phone);
        List<VideoMeetInfo> resultList = videoMeetInfoMapper.selectByExample(example);
        PageInfo<VideoMeetInfo> pageInfo = new PageInfo<VideoMeetInfo>(resultList);
        if (pageInfo.getTotal() - (start-1)*size < 0) {
            return new ArrayList<VideoMeetInfo>();
        } else {
            return pageInfo.getList();
        }
    }

    @Override
    public List<VideoMeetInfoVO> selectRecvVideoMeetInfoList(String phone, int start, int size) {
        PageHelper.startPage(start, size).setOrderBy("meet_id desc");
        List<VideoMeetInfoVO> resultList = videoMeetInfoMapper.selectByMemberPhone(phone);
        PageInfo<VideoMeetInfoVO> pageInfo = new PageInfo<VideoMeetInfoVO>(resultList);

        if (pageInfo.getTotal() - (start-1)*size < 0) {
            return new ArrayList<VideoMeetInfoVO>();
        } else {
            return pageInfo.getList();
        }
    }

    @Override
    public VideoMeetInfo selectOneByMeetId(int meetId) {
        VideoMeetInfoExample example = new VideoMeetInfoExample();
        VideoMeetInfoExample.Criteria criteria = example.createCriteria();
        criteria.andMeetIdEqualTo(meetId);
        List<VideoMeetInfo> resultList = videoMeetInfoMapper.selectByExampleWithBLOBs(example);
        if (resultList != null && resultList.size() > 0) {
            return resultList.get(0);
        } else {
            return null;
        }
    }

    @Override
    public int saveVideoMeetInfo(VideoMeetInfo info) {
        return videoMeetInfoMapper.insertAndGetMeetId(info);
    }
}
