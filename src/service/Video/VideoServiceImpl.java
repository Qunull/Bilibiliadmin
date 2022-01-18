package service.Video;

import dao.Video.VideoDao;
import dao.Video.VideoDaoImpl;
import entity.Video;

import java.sql.SQLException;
import java.util.List;

public class VideoServiceImpl implements VideoService{
    private VideoDao videoDao;

    public VideoServiceImpl(){
        videoDao = new VideoDaoImpl();
    }

    @Override
    public List<Video> getVideoList(String videoId,String videoTitle,String uploaderId) throws SQLException {
        return videoDao.getVideoList(videoId,videoTitle,uploaderId);
    }

    @Override
    public int deleteVideo(Integer id) {
        return videoDao.deleteVideo(id);
    }

    @Override
    public Video getVideoByTitle(String title) {
        return videoDao.getVideoByTitle(title);
    }

    @Override
    public Video getVideoById(int id) {
        return videoDao.getVideoById(id);
    }

    @Override
    public int getCount(String title, Integer categoryId) {
        return videoDao.getCount(title,categoryId);
    }

    @Override
    public int getVideoCount() {
        return videoDao.getVideoCount();
    }
}
