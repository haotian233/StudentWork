package com.itcast.entity;

public class Work {

    String workNum;// 作业编号
    String workName;// 作业名称
    String workAnswer;// 作业内容
    String workFileName;// 作业(附件)文件名称
    String upTime;// 作业提交时间

    String taskNum;// 任务编号
    String taskName;// 任务名称
    String taskDescribe;// 任务介绍
    String taskFileName;// 任务(附件)文件名称
    String startTime;// 任务发布时间
    String teacherName;// 教师姓名

    int userId;// 学生用户id
    String name;// 学生姓名

    int total;

    public String getWorkNum() {
        return workNum;
    }

    public void setWorkNum(String workNum) {
        this.workNum = workNum;
    }

    public String getWorkName() {
        return workName;
    }

    public void setWorkName(String workName) {
        this.workName = workName;
    }

    public String getWorkAnswer() {
        return workAnswer;
    }

    public void setWorkAnswer(String workAnswer) {
        this.workAnswer = workAnswer;
    }

    public String getWorkFileName() {
        return workFileName;
    }

    public void setWorkFileName(String workFileName) {
        this.workFileName = workFileName;
    }

    public String getUpTime() {
        return upTime;
    }

    public void setUpTime(String upTime) {
        this.upTime = upTime;
    }

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

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
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
        return "{\"workNum\":\"" + workNum + "\", \"workName\":\"" + workName
                + "\", \"workAnswer\":\"" + workAnswer
                + "\", \"workFileName\":\"" + workFileName
                + "\", \"upTime\":\"" + upTime + "\", \"taskNum\":\"" + taskNum
                + "\", \"taskName\":\"" + taskName + "\", \"taskDescribe\":\""
                + taskDescribe + "\", \"taskFileName\":\"" + taskFileName
                + "\", \"startTime\":\"" + startTime + "\", \"teacherName\":\""
                + teacherName + "\", \"userId\":\"" + userId
                + "\", \"name\":\"" + name + "\", \"total\":\"" + total + "\"}";
    }

}
