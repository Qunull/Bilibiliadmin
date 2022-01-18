package service.Home;

public interface HomeService {
    /**
     * 查询普通用户数量
     * @return
     */
    int getUserCount();
    /**
     * 查询vip用户数量
     * @return
     */
    int getVipCount();
    /**
     * 获取视频数量
     * @return
     */
    int getVideoCount();
}
