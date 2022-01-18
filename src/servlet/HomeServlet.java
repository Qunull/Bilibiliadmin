package servlet;

import service.Home.HomeService;
import service.Home.HomeServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private HomeService homeService = new HomeServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String opr = request.getParameter("opr");
        if (opr.equals("count")){
            int usercount = homeService.getUserCount();
            int vipcount = homeService.getVipCount();
            int videocount = homeService.getVideoCount();
            request.setAttribute("usercount",usercount);
            request.setAttribute("vipcount",vipcount);
            request.setAttribute("videocount",videocount);
            request.getRequestDispatcher("/jsp/welcome-1.jsp").forward(request,response);
        }
    }
}
