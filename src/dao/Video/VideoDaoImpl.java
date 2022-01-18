package dao.Video;

import com.mysql.cj.util.StringUtils;
import dao.BaseDaoImpl;
import entity.Video;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VideoDaoImpl extends BaseDaoImpl implements VideoDao {
    @Override
    public List<Video> getVideoList(String videoId,String videoTitle,String uploaderId) throws SQLException {
        String sql = "select * from video where 1=1 ";
        List<Object> params = new ArrayList<>();
            if (!StringUtils.isNullOrEmpty(videoId)){
                sql+= " and videoId = ? ";
                params.add(videoId);
            }
            if (!StringUtils.isNullOrEmpty(videoTitle)){
                sql+=" and videoTitle like concat('%',?,'%') ";
                params.add(videoTitle);
            }
            if (!StringUtils.isNullOrEmpty(uploaderId)){
                sql+=" and uploaderId = ? ";
                params.add(uploaderId);
            }
            List<Video> videoList = new ArrayList<>();

            ResultSet rs = executeSelect(sql,params.toArray());

            while (rs.next()) {
                Video video = new Video();
                video.setVideoId(rs.getInt("videoId"));
                video.setVideoTitle(rs.getString("videoTitle"));
                video.setLikes(rs.getInt("likes"));
                video.setUploadTime(rs.getTime("uploadTime"));
                video.setUploaderId(rs.getInt("uploaderId"));
                video.setPath(rs.getString("path"));

                videoList.add(video);
            }

            this.closeResource();


        return videoList;
    }
    @Override
    public int deleteVideo(Integer id) {
        String sql = "delete from video where id=?";
        int count = executeModify(sql,id);
        return count;
    }

    @Override
    public Video getVideoByTitle(String title) {
        Video video = null;
        try {
            String sql = "select * from video where videoTitle like concat('%',?,'%')";
            rs = this.executeSelect(sql,title);
            if (rs.next()){
                video = new Video();
                video.setVideoId(rs.getInt("videoId"));
                video.setVideoTitle(rs.getNString("videoTitle"));
                video.setLikes(rs.getInt("likes"));
                video.setUploadTime(rs.getTime("uploadTime"));
                video.setUploaderId(rs.getInt("uploaderId"));
                video.setPath(rs.getNString("path"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return video;
    }

    @Override
    public Video getVideoById(int id) {
        Video video = null;
        try {
            String sql = "select * from video where videoTitle=?";
            rs = this.executeSelect(sql,id);
            if (rs.next()){
                video = new Video();
                video.setVideoId(rs.getInt("videoId"));
                video.setVideoTitle(rs.getNString("videoTitle"));
                video.setLikes(rs.getInt("likes"));
                video.setUploadTime(rs.getTime("uploadTime"));
                video.setUploaderId(rs.getInt("uploaderId"));
                video.setPath(rs.getNString("path"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }

        return video;
    }

    @Override
    public int getCount(String title, Integer id) {
        ResultSet rs = null;
        int count = 0;
        String sql = "select count(1) from video where 1=1 ";
        List<Object> params = new ArrayList<>();
        if (title != null && !title.equals("")){
            sql += " and title like CONCAT('%',?,'%') ";
            params.add(title);
        }
        if (id != null && id !=0){
            sql += " and videoId = ? ";
            params.add(id);
        }
        try {
            rs = executeSelect(sql,params.toArray());
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            this.closeResource();
        }
        return count;
    }

    @Override
    public int getVideoCount() {
        int count = 0;
        String sql = "select count(videoId) from video ";
        rs = this.executeSelect(sql);
        try {
            if (rs.next()){
                count = rs.getInt(1);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            closeResource();
        }
        return count;
    }
}
