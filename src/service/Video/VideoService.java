package service.Video;

import entity.Video;

import java.sql.SQLException;
import java.util.List;

public interface VideoService {
    /**
     * 查询所有视频信息
     * @return
     */
    List<Video> getVideoList(String videoId,String videoTitle,String uploaderId) throws SQLException;

    /**
     * 根据id删除
     * @param id
     */
    int deleteVideo(Integer id);

    /**
     * 根据标题查询
     * @param title
     */
    Video getVideoByTitle(String title);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    Video getVideoById(int id);

    int getCount(String title,Integer categoryId);

    int getVideoCount();
}
