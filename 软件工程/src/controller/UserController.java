package com.itcast.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.itcast.entity.User;
import com.itcast.service.UserService;

@Controller
@SessionAttributes("user")
public class UserController {
    @Autowired
    private HttpServletRequest request;// 自动注入request
    @Autowired
    private HttpServletResponse response;// 自动注入response

    @Autowired
    private UserService userService;

    // 一进去见到的页面
    @RequestMapping(value = "/")
    public String getIndex() {
        return "login";

    }

    @RequestMapping(value = "/login")
    public String login() {
        return "login";

    }

    @RequestMapping(value = "/add_user")
    public String add_user() {
        return "add_user";

    }

    @RequestMapping(value = "/userInfo")
    public String userInfo() {
        return "userInfo";

    }

    // 注册页面
    @RequestMapping(value = "/register")
    public String register() {
        return "register";

    }

    // 主页面
    @RequestMapping(value = "/main")
    public String main() {
        return "main";

    }

    // 退出系统
    @RequestMapping(value = "/outLogin")
    public String outLogin(HttpSession session, SessionStatus sessionStatus) {

        session.removeAttribute("user");// 我这里是先取出httpsession中的user属性
        session.invalidate(); // 然后是让httpsession失效
        sessionStatus.setComplete();// 最后是调用sessionStatus方法

        return "login";
    }

    // 登录校验
    @RequestMapping(value = "/loginCon", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String login(String username, String password, HttpSession session) {
        // 根据用户名 和 密码 查询 用户信息
        User user = userService.queryUserByUsernameAndPwd(username, password);
        // 判断 该用户是否存在
        if (user == null) {
            return "{\"msg\":\"-1\"}";
        }
        // 校验通过,把登录用户信息设置到session中
        session.setAttribute("user", user);
        // 跳转到 主界面
        return "{\"msg\":\"0\"}";

    }

    // 注册
    @RequestMapping(value = "/registerCon", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String register(String username, String password, String name,
                           String status) {
        // 根据用户名 查询 该用户名是否已经注册
        User user = userService.queryUserByUsername(username);
        if (user != null) {
            // msg:1 该用户名已经注册
            return "{\"msg\":\"1\"}";
        }
        // 构造 User 对象
        user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setStatus(status);
        // 插入新用户
        int num = userService.addUser(user);
        if (num > 0) {
            // msg:0 用户注册成功
            return "{\"msg\":\"0\"}";
        }
        // msg:-1 用户注册失败
        return "{\"msg\":\"-1\"}";

    }

    // 删除用户
    @RequestMapping(value = "/deleteUserById", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String deleteUserById(int id) {

        int num = userService.deleteUserById(id);
        if (num > 0) {
            return "{\"msg\":\"0\"}";
        }

        return "{\"msg\":\"-1\"}";

    }

    // 根据用户id 查询 用户信息
    @RequestMapping(value = "/queryUserById", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String queryUserById(int id) {

        User user = userService.queryUserById(id);
        // 根据用户id 查询 用户信息 失败
        if (user == null) {
            return "{\"msg\":\"-1\"}";
        }
        // 根据用户id 查询 用户信息 成功
        return "{\"msg\":\"0\",\"data\":" + user + "}";

    }

    // 修改用户
    @RequestMapping(value = "/editUser", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String editUser(int id, String username, String password, String name) {

        // 构造 User 对象
        User user = new User();
        user.setId(id);
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        int num = userService.editUser(user);
        if (num > 0) {
            // msg:0 修改用户成功
            return "{\"msg\":\"0\"}";
        }
        // msg:-1 修改用户失败
        return "{\"msg\":\"-1\"}";

    }

    // 添加 用户
    @RequestMapping(value = "/addUser", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String addUser(String username, String password, String name,
                          String status) {

        // 构造 User 对象
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setStatus(status);
        int num = userService.addUser(user);
        if (num > 0) {

            return "{\"msg\":\"0\"}";
        }

        return "{\"msg\":\"-1\"}";

    }

    @RequestMapping(value = "/queryUserByLike", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String queryUserByLike(String status, String name, int page,
                                  int limit) {

        int offset = (page - 1) * limit;

        List<User> list = userService.queryUserByLike(status, name, offset,
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
