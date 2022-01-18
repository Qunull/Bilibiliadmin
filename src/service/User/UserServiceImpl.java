package service.User;

import dao.User.UserDao;
import dao.User.UserDaoImpl;
import entity.User;
import service.User.UserService;

import java.sql.SQLException;
import java.util.List;

public class UserServiceImpl implements UserService {
    private UserDao userDao;

    public UserServiceImpl(){
        userDao = new UserDaoImpl();
    }

    @Override
    public List<User> getUserList(String userName,String userId) throws SQLException {
        return userDao.getUserList(userName,userId);
    }

    @Override
    public int updateUser(User user) {
        return userDao.updateUser(user);
    }

    @Override
    public int deleteUser(Integer id) {
        return userDao.deleteUser(id);
    }

    @Override
    public User getUserById(Integer id) {
        return userDao.getUserById(id);
    }

    @Override
    public User getUserByName(String name) {
        return userDao.getUserByName(name);
    }

    @Override
    public int getCount(String title, Integer categoryId) {
        return userDao.getCount(title,categoryId);
    }

    @Override
    public int getUserCount() {
        return userDao.getUserCount();
    }
}
