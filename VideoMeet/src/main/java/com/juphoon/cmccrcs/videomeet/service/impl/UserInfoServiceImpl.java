package com.juphoon.cmccrcs.videomeet.service.impl;

import com.juphoon.cmccrcs.videomeet.mapper.UserInfoMapper;
import com.juphoon.cmccrcs.videomeet.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2017/8/4.
 */
@Service
public class UserInfoServiceImpl implements UserInfoService {

    @Autowired
    private UserInfoMapper userInfoMapper;


    @Override
    public String login(String username)
    {

        return userInfoMapper.login(username);
    }
}
