package dao.Vip;

import entity.User;

import java.sql.SQLException;
import java.util.List;

public interface VipDao {
    /**
     * 查询用户
     *
     * @return
     */
    List<User> getVipList(String userName,String userId) throws SQLException;

    /**
     * 修改用户
     * @param user
     * @return
     */
    int updateVip(User user);

    /**
     * 删除用户
     * @param id
     * @return
     */
    int deleteVip(Integer id);

    /**
     * 根据Id查询用户信息
     * @param id
     * @return
     */
    User getVipById(Integer id);

    /**
     * 根据name查询用户信息
     * @param name
     * @return
     */
    User getVipByName(String name);

    int getCount(String title,Integer id);

    /**
     * 查询vip用户数量
     * @return
     */
    int getVipCount();
}
