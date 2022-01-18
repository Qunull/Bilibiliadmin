package servlet;

import entity.User;
import entity.Video;
import service.User.UserService;
import service.User.UserServiceImpl;
import util.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String opr = request.getParameter("opr");
        if (opr.equals("userList")) {
            try {
                this.getUserList(request, response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }else if(opr.equals("toUserModify")){
            String userId = request.getParameter("userId");
            User user = userService.getUserById(Integer.valueOf(userId));
            request.setAttribute("user",user);
            request.getRequestDispatcher("/jsp/usermodify.jsp").forward(request,response);
        }else if (opr.equals("uModifySave")){
            String userId = request.getParameter("userId");
            String userName = request.getParameter("userName");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String birthday = request.getParameter("birthday");
            String userRole = request.getParameter("userRole");
            String signature = request.getParameter("signature");
            String fans = request.getParameter("fans");

            User user = userService.getUserById(Integer.valueOf(userId));
            user.setUserName(userName);
            user.setPhone(phone);
            user.setGender(Integer.valueOf(gender));
            user.setBirthday(birthday);
            user.setUserRole(Integer.valueOf(userRole));
            user.setFans(Integer.valueOf(fans));
            user.setSignature(signature);

            if (userService.updateUser(user) > 0){
                out.print(true);
            }
        }else if (opr.equals("delete")){
            String userId = request.getParameter("userId");
            if (userService.deleteUser(Integer.valueOf(userId)) > 0){
                out.print(true);
            }
        }
        out.flush();
        out.close();
    }
    //查询所有视频信息
    private void getUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String userId = request.getParameter("userId");
        String userName = request.getParameter("userName");

        List<User> userList = userService.getUserList(userName, userId);

        request.setAttribute("userList", userList);

        request.setAttribute("userId", userId); // 用于标题条件的回显
        request.setAttribute("userName", userName);

        request.getRequestDispatcher("/jsp/userList.jsp").forward(request, response);
    }
}
