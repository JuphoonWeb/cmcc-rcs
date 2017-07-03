package com.juphoon.cmccrcs.videomeet.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class VideoMeetInfoExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public VideoMeetInfoExample() {
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

        public Criteria andMeetSubjectIsNull() {
            addCriterion("meet_subject is null");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectIsNotNull() {
            addCriterion("meet_subject is not null");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectEqualTo(String value) {
            addCriterion("meet_subject =", value, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectNotEqualTo(String value) {
            addCriterion("meet_subject <>", value, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectGreaterThan(String value) {
            addCriterion("meet_subject >", value, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectGreaterThanOrEqualTo(String value) {
            addCriterion("meet_subject >=", value, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectLessThan(String value) {
            addCriterion("meet_subject <", value, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectLessThanOrEqualTo(String value) {
            addCriterion("meet_subject <=", value, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectLike(String value) {
            addCriterion("meet_subject like", value, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectNotLike(String value) {
            addCriterion("meet_subject not like", value, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectIn(List<String> values) {
            addCriterion("meet_subject in", values, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectNotIn(List<String> values) {
            addCriterion("meet_subject not in", values, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectBetween(String value1, String value2) {
            addCriterion("meet_subject between", value1, value2, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectNotBetween(String value1, String value2) {
            addCriterion("meet_subject not between", value1, value2, "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordIsNull() {
            addCriterion("meet_password is null");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordIsNotNull() {
            addCriterion("meet_password is not null");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordEqualTo(String value) {
            addCriterion("meet_password =", value, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordNotEqualTo(String value) {
            addCriterion("meet_password <>", value, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordGreaterThan(String value) {
            addCriterion("meet_password >", value, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordGreaterThanOrEqualTo(String value) {
            addCriterion("meet_password >=", value, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordLessThan(String value) {
            addCriterion("meet_password <", value, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordLessThanOrEqualTo(String value) {
            addCriterion("meet_password <=", value, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordLike(String value) {
            addCriterion("meet_password like", value, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordNotLike(String value) {
            addCriterion("meet_password not like", value, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordIn(List<String> values) {
            addCriterion("meet_password in", values, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordNotIn(List<String> values) {
            addCriterion("meet_password not in", values, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordBetween(String value1, String value2) {
            addCriterion("meet_password between", value1, value2, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordNotBetween(String value1, String value2) {
            addCriterion("meet_password not between", value1, value2, "meetPassword");
            return (Criteria) this;
        }

        public Criteria andChairmanNameIsNull() {
            addCriterion("chairman_name is null");
            return (Criteria) this;
        }

        public Criteria andChairmanNameIsNotNull() {
            addCriterion("chairman_name is not null");
            return (Criteria) this;
        }

        public Criteria andChairmanNameEqualTo(String value) {
            addCriterion("chairman_name =", value, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameNotEqualTo(String value) {
            addCriterion("chairman_name <>", value, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameGreaterThan(String value) {
            addCriterion("chairman_name >", value, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameGreaterThanOrEqualTo(String value) {
            addCriterion("chairman_name >=", value, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameLessThan(String value) {
            addCriterion("chairman_name <", value, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameLessThanOrEqualTo(String value) {
            addCriterion("chairman_name <=", value, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameLike(String value) {
            addCriterion("chairman_name like", value, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameNotLike(String value) {
            addCriterion("chairman_name not like", value, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameIn(List<String> values) {
            addCriterion("chairman_name in", values, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameNotIn(List<String> values) {
            addCriterion("chairman_name not in", values, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameBetween(String value1, String value2) {
            addCriterion("chairman_name between", value1, value2, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanNameNotBetween(String value1, String value2) {
            addCriterion("chairman_name not between", value1, value2, "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneIsNull() {
            addCriterion("chairman_phone is null");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneIsNotNull() {
            addCriterion("chairman_phone is not null");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneEqualTo(String value) {
            addCriterion("chairman_phone =", value, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneNotEqualTo(String value) {
            addCriterion("chairman_phone <>", value, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneGreaterThan(String value) {
            addCriterion("chairman_phone >", value, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneGreaterThanOrEqualTo(String value) {
            addCriterion("chairman_phone >=", value, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneLessThan(String value) {
            addCriterion("chairman_phone <", value, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneLessThanOrEqualTo(String value) {
            addCriterion("chairman_phone <=", value, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneLike(String value) {
            addCriterion("chairman_phone like", value, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneNotLike(String value) {
            addCriterion("chairman_phone not like", value, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneIn(List<String> values) {
            addCriterion("chairman_phone in", values, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneNotIn(List<String> values) {
            addCriterion("chairman_phone not in", values, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneBetween(String value1, String value2) {
            addCriterion("chairman_phone between", value1, value2, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneNotBetween(String value1, String value2) {
            addCriterion("chairman_phone not between", value1, value2, "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeIsNull() {
            addCriterion("meet_datetime is null");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeIsNotNull() {
            addCriterion("meet_datetime is not null");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeEqualTo(String value) {
            addCriterion("meet_datetime =", value, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeNotEqualTo(String value) {
            addCriterion("meet_datetime <>", value, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeGreaterThan(String value) {
            addCriterion("meet_datetime >", value, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeGreaterThanOrEqualTo(String value) {
            addCriterion("meet_datetime >=", value, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeLessThan(String value) {
            addCriterion("meet_datetime <", value, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeLessThanOrEqualTo(String value) {
            addCriterion("meet_datetime <=", value, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeLike(String value) {
            addCriterion("meet_datetime like", value, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeNotLike(String value) {
            addCriterion("meet_datetime not like", value, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeIn(List<String> values) {
            addCriterion("meet_datetime in", values, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeNotIn(List<String> values) {
            addCriterion("meet_datetime not in", values, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeBetween(String value1, String value2) {
            addCriterion("meet_datetime between", value1, value2, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeNotBetween(String value1, String value2) {
            addCriterion("meet_datetime not between", value1, value2, "meetDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeIsNull() {
            addCriterion("create_datetime is null");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeIsNotNull() {
            addCriterion("create_datetime is not null");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeEqualTo(Date value) {
            addCriterion("create_datetime =", value, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeNotEqualTo(Date value) {
            addCriterion("create_datetime <>", value, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeGreaterThan(Date value) {
            addCriterion("create_datetime >", value, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeGreaterThanOrEqualTo(Date value) {
            addCriterion("create_datetime >=", value, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeLessThan(Date value) {
            addCriterion("create_datetime <", value, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeLessThanOrEqualTo(Date value) {
            addCriterion("create_datetime <=", value, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeIn(List<Date> values) {
            addCriterion("create_datetime in", values, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeNotIn(List<Date> values) {
            addCriterion("create_datetime not in", values, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeBetween(Date value1, Date value2) {
            addCriterion("create_datetime between", value1, value2, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andCreateDatetimeNotBetween(Date value1, Date value2) {
            addCriterion("create_datetime not between", value1, value2, "createDatetime");
            return (Criteria) this;
        }

        public Criteria andIsDeleteIsNull() {
            addCriterion("is_delete is null");
            return (Criteria) this;
        }

        public Criteria andIsDeleteIsNotNull() {
            addCriterion("is_delete is not null");
            return (Criteria) this;
        }

        public Criteria andIsDeleteEqualTo(Integer value) {
            addCriterion("is_delete =", value, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteNotEqualTo(Integer value) {
            addCriterion("is_delete <>", value, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteGreaterThan(Integer value) {
            addCriterion("is_delete >", value, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteGreaterThanOrEqualTo(Integer value) {
            addCriterion("is_delete >=", value, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteLessThan(Integer value) {
            addCriterion("is_delete <", value, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteLessThanOrEqualTo(Integer value) {
            addCriterion("is_delete <=", value, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteIn(List<Integer> values) {
            addCriterion("is_delete in", values, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteNotIn(List<Integer> values) {
            addCriterion("is_delete not in", values, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteBetween(Integer value1, Integer value2) {
            addCriterion("is_delete between", value1, value2, "isDelete");
            return (Criteria) this;
        }

        public Criteria andIsDeleteNotBetween(Integer value1, Integer value2) {
            addCriterion("is_delete not between", value1, value2, "isDelete");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeIsNull() {
            addCriterion("delete_datetime is null");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeIsNotNull() {
            addCriterion("delete_datetime is not null");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeEqualTo(Date value) {
            addCriterion("delete_datetime =", value, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeNotEqualTo(Date value) {
            addCriterion("delete_datetime <>", value, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeGreaterThan(Date value) {
            addCriterion("delete_datetime >", value, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeGreaterThanOrEqualTo(Date value) {
            addCriterion("delete_datetime >=", value, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeLessThan(Date value) {
            addCriterion("delete_datetime <", value, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeLessThanOrEqualTo(Date value) {
            addCriterion("delete_datetime <=", value, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeIn(List<Date> values) {
            addCriterion("delete_datetime in", values, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeNotIn(List<Date> values) {
            addCriterion("delete_datetime not in", values, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeBetween(Date value1, Date value2) {
            addCriterion("delete_datetime between", value1, value2, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andDeleteDatetimeNotBetween(Date value1, Date value2) {
            addCriterion("delete_datetime not between", value1, value2, "deleteDatetime");
            return (Criteria) this;
        }

        public Criteria andMeetSubjectLikeInsensitive(String value) {
            addCriterion("upper(meet_subject) like", value.toUpperCase(), "meetSubject");
            return (Criteria) this;
        }

        public Criteria andMeetPasswordLikeInsensitive(String value) {
            addCriterion("upper(meet_password) like", value.toUpperCase(), "meetPassword");
            return (Criteria) this;
        }

        public Criteria andChairmanNameLikeInsensitive(String value) {
            addCriterion("upper(chairman_name) like", value.toUpperCase(), "chairmanName");
            return (Criteria) this;
        }

        public Criteria andChairmanPhoneLikeInsensitive(String value) {
            addCriterion("upper(chairman_phone) like", value.toUpperCase(), "chairmanPhone");
            return (Criteria) this;
        }

        public Criteria andMeetDatetimeLikeInsensitive(String value) {
            addCriterion("upper(meet_datetime) like", value.toUpperCase(), "meetDatetime");
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