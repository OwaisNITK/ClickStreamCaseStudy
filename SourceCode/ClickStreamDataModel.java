package com.click.stream.dataset.template;

// TODO: Auto-generated Javadoc
/** The Class ClickStreamDataModel. */
public class ClickStreamDataModel {

    /** The user id. */
    private String userId;

    /** The url. */
    private String url;

    /** The action. */
    private String action;

    /** The location. */
    private String location;

    /** The log date. */
    private String logDate;

    /** The log time. */
    private String logTime;

    /** The payment method. */
    private String paymentMethod;

    /** Gets the user id.
     *
     * @return the user id */
    public String getUserId() {
        return userId;
    }

    /** Sets the user id.
     *
     * @param userId
     *            the new user id */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /** Gets the url.
     *
     * @return the url */
    public String getUrl() {
        return url;
    }

    /** Sets the url.
     *
     * @param url
     *            the new url */
    public void setUrl(String url) {
        this.url = url;
    }

    /** Gets the action.
     *
     * @return the action */
    public String getAction() {
        return action;
    }

    /** Sets the action.
     *
     * @param action
     *            the new action */
    public void setAction(String action) {
        this.action = action;
    }

    /** Gets the location.
     *
     * @return the location */
    public String getLocation() {
        return location;
    }

    /** Sets the location.
     *
     * @param location
     *            the new location */
    public void setLocation(String location) {
        this.location = location;
    }

    /** Gets the log date.
     *
     * @return the log date */
    public String getLogDate() {
        return logDate;
    }

    /** Sets the log date.
     *
     * @param logDate
     *            the new log date */
    public void setLogDate(String logDate) {
        this.logDate = logDate;
    }

    /** Gets the log time.
     *
     * @return the log time */
    public String getLogTime() {
        return logTime;
    }

    /** Sets the log time.
     *
     * @param logTime
     *            the new log time */
    public void setLogTime(String logTime) {
        this.logTime = logTime;
    }

    /** Gets the payment method.
     *
     * @return the payment method */
    public String getPaymentMethod() {
        return paymentMethod;
    }

    /** Sets the payment method.
     *
     * @param paymentMethod
     *            the new payment method */
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    /** To string.
     *
     * @return the string */
    @Override
    public String toString() {
        return "{" + "\"userId\":\"" + userId + "\"," + "\"url\":\"" + url + "\"," + "\"action\":\"" + action + "\"," + "\"location\":\"" + location
                + "\"," + "\"logDate\":\"" + logDate + "\"," + "\"logTime\":\"" + logTime + "\"," + "\"paymentMethod\":\"" + paymentMethod + "\""
                + "}";
    }
}