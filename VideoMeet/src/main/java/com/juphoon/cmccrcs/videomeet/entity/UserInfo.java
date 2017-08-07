package com.juphoon.cmccrcs.videomeet.entity;

/**
 * Created by Administrator on 2017/8/3.
 */
public class UserInfo {


    public UserInfo(String username, Integer count) {
        this.username = username;
        this.count = count;
    }

    private String username;
    private Integer count;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }



    @Override
    public String toString() {
        return "UserInfo{" +
                "username='" + username + '\'' +
                ", count=" + count +
                '}';
    }

}
