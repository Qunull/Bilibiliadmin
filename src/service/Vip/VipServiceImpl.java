package service.Vip;

import dao.User.UserDao;
import dao.User.UserDaoImpl;
import dao.Vip.VipDao;
import dao.Vip.VipDaoImpl;
import entity.User;
import service.User.UserService;

import java.sql.SQLException;
import java.util.List;

public class VipServiceImpl implements VipService {
    private VipDao vipDao;

    public VipServiceImpl(){
        vipDao = new VipDaoImpl();
    }

    @Override
    public List<User> getVipList(String userName,String userId) throws SQLException {
        return vipDao.getVipList(userName,userId);
    }

    @Override
    public int updateVip(User user) {
        return vipDao.updateVip(user);
    }

    @Override
    public int deleteVip(Integer id) {
        return vipDao.deleteVip(id);
    }

    @Override
    public User getVipById(Integer id) {
        return vipDao.getVipById(id);
    }

    @Override
    public User getVipByName(String name) {
        return vipDao.getVipByName(name);
    }

    @Override
    public int getCount(String title, Integer categoryId) {
        return vipDao.getCount(title,categoryId);
    }

    @Override
    public int getVipCount() {
        return vipDao.getVipCount();
    }
}
