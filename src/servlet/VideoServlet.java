package servlet;

import com.mysql.cj.util.StringUtils;
import entity.User;
import entity.Video;
import service.Video.VideoService;
import service.Video.VideoServiceImpl;
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


@WebServlet("/video")
public class VideoServlet extends HttpServlet {
    private VideoService videoService = new VideoServiceImpl();

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
        if (opr.equals("videoList")) {
            try {
                this.getVideoList(request, response);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }else if(opr.equals("toVideoModify")){
        }
    }

    //查询所有视频信息
    private void getVideoList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String videoId = request.getParameter("videoId");
        String videoTitle = request.getParameter("videoTitle");
        String uploaderId = request.getParameter("uploaderId");

        List<Video> videoList = videoService.getVideoList(videoId,videoTitle,uploaderId);

        request.setAttribute("videoList", videoList);

        request.setAttribute("videoId", videoId); // 用于标题条件的回显
        request.setAttribute("videoTitle", videoTitle);
        request.setAttribute("uploaderId",uploaderId);

        request.getRequestDispatcher("/jsp/upVideo.jsp").forward(request, response);
    }

    //根据id查询
    private Video getVideoById(HttpServletRequest request, HttpServletResponse response){
        //获取参数
        String nid = request.getParameter("id");
        Integer id = null;
        if (!StringUtils.isNullOrEmpty(nid)){
            id = Integer.valueOf(nid);
        }
        //调用业务层的 业务方法
        Video video = videoService.getVideoById(id);
        return video;
    }
}
