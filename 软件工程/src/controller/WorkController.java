package com.itcast.controller;

import java.io.*;
import java.sql.Blob;
import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itcast.utils.MySimHash;
import net.sf.json.JSONArray;
import org.apache.commons.io.IOUtils;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itcast.entity.Work;
import com.itcast.service.WorkService;

@Controller
public class WorkController {
    String FilePath = Constant.FilePath_linux;
    @Autowired
    private HttpServletRequest request;// 自动注入request
    @Autowired
    private HttpServletResponse response;// 自动注入response

    @Autowired
    private WorkService workService;

    @RequestMapping(value = "/add_work")
    public String add_user() {
        return "add_user";

    }

    @RequestMapping(value = "/query_work")
    public String query_work() {
        return "query_work";

    }

    // 删除作业
    @RequestMapping(value = "/deleteWorkById", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String deleteWorkById(String id) {

        int num = workService.deleteWorkById(id);
        if (num > 0) {
            return "{\"msg\":\"0\"}";
        }

        return "{\"msg\":\"-1\"}";

    }

    // 根据作业编号 查询 作业信息
    @RequestMapping(value = "/queryWorkById", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String queryWorkById(String id) {

        Work work = workService.queryWorkById(id);
        if (work == null) {
            return "{\"msg\":\"-1\"}";
        }
        return "{\"msg\":\"0\",\"data\":" + work + "}";

    }

    // 修改作业
    @RequestMapping(value = "/editWork", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String editWork(HttpServletRequest request,
                           @RequestParam MultipartFile file) {

        String workNum = request.getParameter("workNum");
        String workName = request.getParameter("workName");
        String workAnswer = request.getParameter("workAnswer");
        String taskNum = request.getParameter("taskNum");
        String userId = request.getParameter("userId");

        // 构造 Work 对象
        Work work = new Work();
        work.setWorkNum(workNum);
        work.setWorkName(workName);
        work.setWorkAnswer(workAnswer);
        String fileName = "WF";
        for (int i = 0; i < 10; i++) {
            fileName = fileName + new Random().nextInt(10);
        }
        String originalFilename = file.getOriginalFilename();
        fileName = fileName + new Date().getTime() + "_" + originalFilename;
        System.out.println("fileName：" + fileName);

        try {
            File f = new File(FilePath+"/files/work");
            // 如果没有该文件夹就创建
            if (!f.exists()) {
                f.mkdirs();
            }
            // 获取输出流
            OutputStream os = new FileOutputStream(FilePath+"/files/work/" + fileName);
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

        work.setWorkFileName(fileName);

        work.setTaskNum(taskNum);
        work.setUserId(Integer.parseInt(userId));

        int num = workService.editWork(work);
        if (num > 0) {
            return "{\"msg\":\"0\"}";
        }
        return "{\"msg\":\"-1\"}";

    }

    @RequestMapping(value = "/workDownLoad", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public void workDownLoad(String fileName, String flag) {
        String readPath = FilePath+"/files/work/" + fileName;
        String writePath = "";
        StringBuilder result = new StringBuilder();
        try {

            FileInputStream is = new FileInputStream(readPath);
            // 获取输出流
            result.append(IOUtils.toString(is,"utf8"));
            response.reset();
            response.setContentType("application/octet-stream;charset=UTF-8");
            is.close();
            String res = result.toString();
            System.out.println(res);
            Blob blob = Hibernate.createBlob(result.toString().getBytes());
            OutputStream toClient = response.getOutputStream();
            toClient.write(res.getBytes());
            toClient.close();
            // return "{\"data\":\""+res+"\"}";
        } catch (Exception e) {
            e.printStackTrace();
            // return null;
        }
    }

    // 添加 作业
    @RequestMapping(value = "/addWork", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String addWork(HttpServletRequest request,
                          @RequestParam MultipartFile file) {

        String workName = request.getParameter("workName");
        String workAnswer = request.getParameter("workAnswer");
        String taskNum = request.getParameter("taskNum");
        String userId = request.getParameter("userId");

        String workNum = "W";
        Random random = new Random();
        for (int i = 0; i < 10; i++) {
            workNum += random.nextInt(9) + 1;
        }

        // 构造 Work 对象
        Work work = new Work();
        work.setWorkNum(workNum);
        work.setWorkName(workName);
        work.setWorkAnswer(workAnswer);
        work.setTaskNum(taskNum);
        String fileName = "WF";
        for (int i = 0; i < 10; i++) {
            fileName = fileName + new Random().nextInt(10);
        }
        String originalFilename = file.getOriginalFilename();
        fileName = fileName + new Date().getTime() + "_" + originalFilename;
        System.out.println("fileName：" + fileName);

        try {
            File f = new File(FilePath+"/files/work");
            // 如果没有该文件夹就创建
            if (!f.exists()) {
                f.mkdirs();
            }
            // 获取输出流
            OutputStream os = new FileOutputStream(FilePath+"/files/work/" + fileName);
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

        work.setWorkFileName(fileName);

        work.setTaskNum(taskNum);
        work.setUserId(Integer.parseInt(userId));
        int num = workService.addWork(work);
        if (num > 0) {

            return "{\"msg\":\"0\"}";
        }

        return "{\"msg\":\"-1\"}";

    }

    @RequestMapping(value = "/queryWorkByLike", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String queryWorkByLike(String name, String userId, String teacherId,String taskNum,
                                  int page, int limit) {

        int offset = (page - 1) * limit;

        List<Work> list = workService.queryWorkByLike(name, userId, teacherId,taskNum,
                offset, limit);
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

    // 重复率检测
    @RequestMapping(value = "/checkRate", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String checkRate(String name, String workNum, String taskNum, int page, int limit) {
        String readPath = FilePath+"/files/work/";
        String jsonResult = "[";
        int total = 0;
        List<Work> list = workService.queryWorkByLike(name, "","", taskNum,
                0, 1000);
        total = list.size();
        Work work = workService.queryWorkById(workNum);
        String studentName = work.getName();
        String path1 = readPath + work.getWorkFileName();
        String s1 = "";
        String s2 = "";
        try {
            //File f1 = new File(path1);
            FileInputStream fis = new FileInputStream(path1);
            InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
            BufferedReader br = new BufferedReader(isr);//构造一个BufferedReader类来读取文件
            String s = "";
            while ((s = br.readLine()) != null) {//使用readLine方法，一次读一行
                s1 += s;
            }
            br.close();

        } catch (Exception e) {
            e.printStackTrace();
            return "{\"msg\":\"-1\"}";
        }
        int tt = 0;
        for (int i = 0; i < list.size(); i++) {
            Work w = list.get(i);
            if (!w.getWorkNum().equals(workNum)) {
                tt++;
                String workFileName = w.getWorkFileName();
                String path2 = readPath + workFileName;
                path1 = path1.replaceAll("\\\\", "\\\\\\\\");
                path2 = path2.replaceAll("\\\\", "\\\\\\\\");
                jsonResult += "{\"name\":\"" + studentName + "\",\"fileName\":\"" + path1 + "\",";
                jsonResult += "\"comName\":\"" + w.getName() + "\",\"comFileName\":\"" + path2 + "\",";

                try {
                    s2 = "";
                    //File f2 = new File(path2);
                    FileInputStream fis = new FileInputStream(path2);
                    InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
                    BufferedReader br = new BufferedReader(isr);//构造一个BufferedReader类来读取文件
                    String s = "";
                    while ((s = br.readLine()) != null) {//使用readLine方法，一次读一行
                        s2 += s;
                    }
                    br.close();

                    System.out.println("s1:" + s1);
                    System.out.println("s2:" + s2);
                    MySimHash hash1 = new MySimHash(s1, 64);
                    MySimHash hash2 = new MySimHash(s2, 64);
                    double xsd = hash1.getSemblance(hash2);
                    // xsd = 100 - xsd;
                    jsonResult += "\"xsd\":\"" + xsd + "\"}";
                    if (tt < list.size() - 1) {
                        jsonResult += ",";
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    return "{\"msg\":\"-1\"}";
                }
            }
        }
        jsonResult += "]";
        String result = "{\"code\":0,\"msg\":\"0\",\"count\":" + total
                + ",\"data\":" + jsonResult + "}";
        return result;

    }
}
