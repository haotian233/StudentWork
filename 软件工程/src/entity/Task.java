package com.itcast.entity;

public class Task {

    String taskNum;// 任务编号
    String taskName;// 任务名称
    String taskDescribe;// 任务介绍
    String taskFileName;// 任务(附件)文件名称
    String startTime;// 任务发布时间

    int userId;// 教师用户id
    String name;// 教师姓名

    int total;

    public String getTaskNum() {
        return taskNum;
    }

    public void setTaskNum(String taskNum) {
        this.taskNum = taskNum;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskDescribe() {
        return taskDescribe;
    }

    public void setTaskDescribe(String taskDescribe) {
        this.taskDescribe = taskDescribe;
    }

    public String getTaskFileName() {
        return taskFileName;
    }

    public void setTaskFileName(String taskFileName) {
        this.taskFileName = taskFileName;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "{\"taskNum\":\"" + taskNum + "\", \"taskName\":\"" + taskName
                + "\", \"taskDescribe\":\"" + taskDescribe
                + "\", \"taskFileName\":\"" + taskFileName
                + "\", \"startTime\":\"" + startTime + "\", \"userId\":\""
                + userId + "\", \"name\":\"" + name + "\", \"total\":\""
                + total + "\"}";
    }

}
