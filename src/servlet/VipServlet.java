package servlet;

import entity.User;
import service.User.UserService;
import service.User.UserServiceImpl;
import service.Vip.VipService;
import service.Vip.VipServiceImpl;
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

@WebServlet("/vip")
public class VipServlet extends HttpServlet {
    private VipService vipService = new VipServiceImpl();

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
                this.getVideoList(request, response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }else if(opr.equals("toUserModify")){
            String userId = request.getParameter("userId");
            User user = vipService.getVipById(Integer.valueOf(userId));
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

            User user = vipService.getVipById(Integer.valueOf(userId));
            user.setUserName(userName);
            user.setPhone(phone);
            user.setGender(Integer.valueOf(gender));
            user.setBirthday(birthday);
            user.setUserRole(Integer.valueOf(userRole));
            user.setFans(Integer.valueOf(fans));
            user.setSignature(signature);

            if (vipService.updateVip(user) > 0){
                out.print(true);
            }
        }
        out.flush();
        out.close();
    }
    public void modafySave(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        request.getRequestDispatcher("/jsp/usermodify.jsp").forward(request, response);
    }
    //查询所有视频信息
    private void getVideoList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String vipId = request.getParameter("userId");
        String vipName = request.getParameter("userName");

        List<User> vipList = vipService.getVipList(vipName, vipId);

        request.setAttribute("userList", vipList);

        request.setAttribute("vipId", vipId); // 用于标题条件的回显
        request.setAttribute("vipName", vipName);

        request.getRequestDispatcher("/jsp/vipList.jsp").forward(request, response);
    }
}
