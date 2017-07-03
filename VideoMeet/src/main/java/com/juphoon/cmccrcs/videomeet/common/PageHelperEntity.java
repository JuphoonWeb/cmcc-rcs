package com.juphoon.cmccrcs.videomeet.common;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/5/28 0028.
 */
public class PageHelperEntity implements Serializable {
    private static final long serialVersionUID = 7197267904932606923L;

    private Integer offset;

    private Integer limit;

    private Integer start;

    private Integer size;

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public enum PAGE_HELPER_PARAMTERS {
        OFFSET("offset"),
        LIMIT("limit"),
        START("start"),
        SIZE("size");

        private String value;

        private PAGE_HELPER_PARAMTERS(String value){
            this.value = value;
        }
        public String getValue(){
            return value;
        }
    }
}
