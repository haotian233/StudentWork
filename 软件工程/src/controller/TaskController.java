package com.itcast.controller;

import java.io.*;
import java.nio.ByteBuffer;
import java.sql.Blob;
import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Hierarchy;
import org.hibernate.Hibernate;
import org.hibernate.type.BlobType;
import org.omg.PortableInterceptor.IORInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.itcast.entity.Task;
import com.itcast.service.TaskService;
import sun.plugin.dom.exception.HierarchyRequestException;

@Controller
public class TaskController {
    String FilePath = Constant.FilePath_linux;
    @Autowired
    private HttpServletRequest request;// 自动注入request
    @Autowired
    private HttpServletResponse response;// 自动注入response

    @Autowired
    private TaskService taskService;

    @RequestMapping(value = "/add_task")
    public String add_task() {
        return "add_task";

    }

    @RequestMapping(value = "/query_task")
    public String query_task() {
        return "query_task";

    }

    // 删除任务
    @RequestMapping(value = "/deleteTaskById", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String deleteTaskById(String id) {

        int num = taskService.deleteTaskById(id);
        if (num > 0) {
            return "{\"msg\":\"0\"}";
        }

        return "{\"msg\":\"-1\"}";

    }

    // 根据任务编号 查询 任务信息
    @RequestMapping(value = "/queryTaskById", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String queryTaskById(String id) {

        Task task = taskService.queryTaskById(id);

        if (task == null) {
            return "{\"msg\":\"-1\"}";
        }

        return "{\"msg\":\"0\",\"data\":" + task + "}";

    }

    // 修改任务
    @RequestMapping(value = "/editTask", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String editTask(HttpServletRequest request,
                           @RequestParam MultipartFile file) {

        String taskNum = request.getParameter("taskNum");
        String taskName = request.getParameter("taskName");
        String taskDescribe = request.getParameter("taskDescribe");
        String userId = request.getParameter("userId");

        // 构造 Task 对象
        Task task = new Task();
        task.setTaskNum(taskNum);
        task.setTaskName(taskName);
        task.setTaskDescribe(taskDescribe);

        String fileName = "TF";
        for (int i = 0; i < 10; i++) {
            fileName = fileName + new Random().nextInt(10);
        }
        String originalFilename = file.getOriginalFilename();
        fileName = fileName + new Date().getTime() + "_" + originalFilename;
        System.out.println("fileName：" + fileName);
        try {
            File f = new File(FilePath+"/files/task");
            // 如果没有该文件夹就创建
            if (!f.exists()) {
                f.mkdirs();
            }
            // 获取输出流
            OutputStream os = new FileOutputStream(FilePath+"/files/task/" + fileName);
            // 获取输入流 CommonsMultipartFile 中可以直接得到文件的流
            InputStream is = file.getInputStream();
            byte[] bts = new byte[1024];
            // 一个一个字节的读取并写入
            while (is.read(bts) != -1) {
                os.write(bts);
            }
            os.flush();
            os.close();
            is.close();

        } catch (Exception e) {

            e.printStackTrace();
        }
        task.setTaskFileName(fileName);

        task.setUserId(Integer.parseInt(userId));

        int num = taskService.editTask(task);
        if (num > 0) {

            return "{\"msg\":\"0\"}";
        }

        return "{\"msg\":\"-1\"}";

    }

    @RequestMapping(value = "/taskDownLoad", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public void taskDownLoad(String fileName, String flag) {
        String readPath = FilePath+"/files/task/" + fileName;
        String writePath = "";
        StringBuilder result = new StringBuilder();
        try {
            File file = new File(readPath);
            FileInputStream is = new FileInputStream(readPath);
            int len = is.available();
            // 获取输出流
            result.append(IOUtils.toString(is,"utf8"));
            response.reset();
            response.setContentType("application/octet-stream;charset=UTF-8");
            String res = result.toString();
            byte[] data = new byte[1024];
            is.read(data);
            System.out.println("bytes is : "+res.getBytes()[1]);
            Blob blob = Hibernate.createBlob(result.toString().getBytes());
            OutputStream toClient = response.getOutputStream();
            toClient.write(res.getBytes());
            toClient.close();
            is.close();
            // return "{\"data\":\""+res+"\"}";
            // return blob;
        } catch (Exception e) {
            e.printStackTrace();
            // return null;
        }
    }

    // 添加 任务
    @RequestMapping(value = "/addTask", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String addTask(HttpServletRequest request,
                          @RequestParam MultipartFile file) {

        String taskName = request.getParameter("taskName");
        String taskDescribe = request.getParameter("taskDescribe");
        String userId = request.getParameter("userId");

        String taskNum = "T";
        Random random = new Random();
        for (int i = 0; i < 10; i++) {
            taskNum += random.nextInt(9) + 1;
        }

        // 构造 Task 对象
        Task task = new Task();
        task.setTaskNum(taskNum);
        task.setTaskName(taskName);
        task.setTaskDescribe(taskDescribe);

        String fileName = "F";
        for (int i = 0; i < 10; i++) {
            fileName = fileName + new Random().nextInt(10);
        }
        String originalFilename = file.getOriginalFilename();
        fileName = fileName + new Date().getTime() + "_" + originalFilename;
        System.out.println("fileName：" + fileName);

        try {
            File f = new File(FilePath+"/files/task");
            // 如果没有该文件夹就创建
            if (!f.exists()) {
                f.mkdir();
            }
            // 获取输出流
            OutputStream os = new FileOutputStream(FilePath+"/files/task/" + fileName);
            // 获取输入流 CommonsMultipartFile 中可以直接得到文件的流
            InputStream is = file.getInputStream();
            byte[] bts = new byte[1024];
            // 一个一个字节的读取并写入
            while (is.read(bts) != -1) {
                os.write(bts);
            }
            os.flush();
            os.close();
            is.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        task.setTaskFileName(fileName);

        task.setUserId(Integer.parseInt(userId));
        int num = taskService.addTask(task);
        if (num > 0) {

            return "{\"msg\":\"0\"}";
        }

        return "{\"msg\":\"-1\"}";

    }


    @RequestMapping(value = "/queryTaskByLike", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String queryTaskByLike(String name, String userId, int page,
                                  int limit) {

        int offset = (page - 1) * limit;

        List<Task> list = taskService.queryTaskByLike(name, userId, offset,
                limit);
        int total = 0;// 总数
        if (list != null && list.size() > 0) {
            total = list.get(0).getTotal();
        }
        JSONArray jsonObject = JSONArray.fromObject(list);
        String jsonResult = jsonObject.toString();
        String result = "{\"code\":0,\"msg\":\"0\",\"count\":" + total
                + ",\"data\":" + jsonResult + "}";
        return result;

    }

}
