package com.juphoon.cmccrcs.videomeet.entity;

import java.util.ArrayList;
import java.util.List;

public class VideoMeetMemberExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public VideoMeetMemberExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andMemberIdIsNull() {
            addCriterion("member_id is null");
            return (Criteria) this;
        }

        public Criteria andMemberIdIsNotNull() {
            addCriterion("member_id is not null");
            return (Criteria) this;
        }

        public Criteria andMemberIdEqualTo(Integer value) {
            addCriterion("member_id =", value, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdNotEqualTo(Integer value) {
            addCriterion("member_id <>", value, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdGreaterThan(Integer value) {
            addCriterion("member_id >", value, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("member_id >=", value, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdLessThan(Integer value) {
            addCriterion("member_id <", value, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdLessThanOrEqualTo(Integer value) {
            addCriterion("member_id <=", value, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdIn(List<Integer> values) {
            addCriterion("member_id in", values, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdNotIn(List<Integer> values) {
            addCriterion("member_id not in", values, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdBetween(Integer value1, Integer value2) {
            addCriterion("member_id between", value1, value2, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberIdNotBetween(Integer value1, Integer value2) {
            addCriterion("member_id not between", value1, value2, "memberId");
            return (Criteria) this;
        }

        public Criteria andMemberNameIsNull() {
            addCriterion("member_name is null");
            return (Criteria) this;
        }

        public Criteria andMemberNameIsNotNull() {
            addCriterion("member_name is not null");
            return (Criteria) this;
        }

        public Criteria andMemberNameEqualTo(String value) {
            addCriterion("member_name =", value, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameNotEqualTo(String value) {
            addCriterion("member_name <>", value, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameGreaterThan(String value) {
            addCriterion("member_name >", value, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameGreaterThanOrEqualTo(String value) {
            addCriterion("member_name >=", value, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameLessThan(String value) {
            addCriterion("member_name <", value, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameLessThanOrEqualTo(String value) {
            addCriterion("member_name <=", value, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameLike(String value) {
            addCriterion("member_name like", value, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameNotLike(String value) {
            addCriterion("member_name not like", value, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameIn(List<String> values) {
            addCriterion("member_name in", values, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameNotIn(List<String> values) {
            addCriterion("member_name not in", values, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameBetween(String value1, String value2) {
            addCriterion("member_name between", value1, value2, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberNameNotBetween(String value1, String value2) {
            addCriterion("member_name not between", value1, value2, "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneIsNull() {
            addCriterion("member_phone is null");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneIsNotNull() {
            addCriterion("member_phone is not null");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneEqualTo(String value) {
            addCriterion("member_phone =", value, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneNotEqualTo(String value) {
            addCriterion("member_phone <>", value, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneGreaterThan(String value) {
            addCriterion("member_phone >", value, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneGreaterThanOrEqualTo(String value) {
            addCriterion("member_phone >=", value, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneLessThan(String value) {
            addCriterion("member_phone <", value, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneLessThanOrEqualTo(String value) {
            addCriterion("member_phone <=", value, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneLike(String value) {
            addCriterion("member_phone like", value, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneNotLike(String value) {
            addCriterion("member_phone not like", value, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneIn(List<String> values) {
            addCriterion("member_phone in", values, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneNotIn(List<String> values) {
            addCriterion("member_phone not in", values, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneBetween(String value1, String value2) {
            addCriterion("member_phone between", value1, value2, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneNotBetween(String value1, String value2) {
            addCriterion("member_phone not between", value1, value2, "memberPhone");
            return (Criteria) this;
        }

        public Criteria andMeetIdIsNull() {
            addCriterion("meet_id is null");
            return (Criteria) this;
        }

        public Criteria andMeetIdIsNotNull() {
            addCriterion("meet_id is not null");
            return (Criteria) this;
        }

        public Criteria andMeetIdEqualTo(Integer value) {
            addCriterion("meet_id =", value, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdNotEqualTo(Integer value) {
            addCriterion("meet_id <>", value, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdGreaterThan(Integer value) {
            addCriterion("meet_id >", value, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("meet_id >=", value, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdLessThan(Integer value) {
            addCriterion("meet_id <", value, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdLessThanOrEqualTo(Integer value) {
            addCriterion("meet_id <=", value, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdIn(List<Integer> values) {
            addCriterion("meet_id in", values, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdNotIn(List<Integer> values) {
            addCriterion("meet_id not in", values, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdBetween(Integer value1, Integer value2) {
            addCriterion("meet_id between", value1, value2, "meetId");
            return (Criteria) this;
        }

        public Criteria andMeetIdNotBetween(Integer value1, Integer value2) {
            addCriterion("meet_id not between", value1, value2, "meetId");
            return (Criteria) this;
        }

        public Criteria andIsReadIsNull() {
            addCriterion("is_read is null");
            return (Criteria) this;
        }

        public Criteria andIsReadIsNotNull() {
            addCriterion("is_read is not null");
            return (Criteria) this;
        }

        public Criteria andIsReadEqualTo(Integer value) {
            addCriterion("is_read =", value, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadNotEqualTo(Integer value) {
            addCriterion("is_read <>", value, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadGreaterThan(Integer value) {
            addCriterion("is_read >", value, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadGreaterThanOrEqualTo(Integer value) {
            addCriterion("is_read >=", value, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadLessThan(Integer value) {
            addCriterion("is_read <", value, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadLessThanOrEqualTo(Integer value) {
            addCriterion("is_read <=", value, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadIn(List<Integer> values) {
            addCriterion("is_read in", values, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadNotIn(List<Integer> values) {
            addCriterion("is_read not in", values, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadBetween(Integer value1, Integer value2) {
            addCriterion("is_read between", value1, value2, "isRead");
            return (Criteria) this;
        }

        public Criteria andIsReadNotBetween(Integer value1, Integer value2) {
            addCriterion("is_read not between", value1, value2, "isRead");
            return (Criteria) this;
        }

        public Criteria andMemberNameLikeInsensitive(String value) {
            addCriterion("upper(member_name) like", value.toUpperCase(), "memberName");
            return (Criteria) this;
        }

        public Criteria andMemberPhoneLikeInsensitive(String value) {
            addCriterion("upper(member_phone) like", value.toUpperCase(), "memberPhone");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}