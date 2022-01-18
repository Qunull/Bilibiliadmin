package dao.Vip;

import com.mysql.cj.util.StringUtils;
import dao.BaseDaoImpl;
import dao.User.UserDao;
import entity.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VipDaoImpl extends BaseDaoImpl implements VipDao {
    @Override
    public List<User> getVipList(String userName,String userId)throws SQLException {
        String sql = "select * from user where userRole=2 ";
        List<Object> params = new ArrayList<>();
        if(!StringUtils.isNullOrEmpty(userId)){
            sql+= " and userId = ? ";
            params.add(userId);
        }
        if(!StringUtils.isNullOrEmpty(userName)){
            sql+= " and userName like CONCAT('%',?,'%')";
            params.add(userName);
        }
        List<User> userList = new ArrayList<>();

        ResultSet rs = executeSelect(sql,params.toArray());

        while (rs.next()) {
            User user = new User();
            user.setUserId(rs.getInt("userId"));
            user.setUserName(rs.getString("userName"));
            user.setPassWord(rs.getString("password"));
            user.setGender(rs.getInt("gender"));
            user.setPhone(rs.getString("phone"));
            user.setUserRole(rs.getInt("userRole"));
            user.setSignature(rs.getString("signature"));
            user.setHeadPic(rs.getString("headPic"));
            user.setContribution(rs.getString("contribution"));
            user.setFans(rs.getInt("fans"));
            user.setConcern(rs.getInt("concern"));
            user.setBirthday(rs.getString("birthday"));
            user.setNotice(rs.getString("notice"));

            userList.add(user);
        }
        closeResource();
        return userList;
    }

    @Override
    public int updateVip(User user) {
        String sql = "update user set userName=?,password=?,gender=?,phone=?," +
                "userRole=?,signature=?,headPic=?,contribution=?,fans=?,concern=?" +
                ",birthday=?,notice=? where userId=?";
        int count = executeModify(sql, user.getUserName(), user.getPassWord(), user.getGender(),
                user.getPhone(), user.getUserRole(), user.getSignature(), user.getHeadPic()
                , user.getContribution(), user.getFans(), user.getConcern(),user.getBirthday()
                ,user.getNotice(),user.getUserId());
        return count;
    }

    @Override
    public int deleteVip(Integer id) {
        String sql = "delete from user where id=?";
        int count = executeModify(sql, id);
        return count;
    }

    @Override
    public User getVipById(Integer id) {
        User user = null;
        try {
            String sql = "select * from user where userId=?";
            rs = this.executeSelect(sql, id);
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setUserName(rs.getString("userName"));
                user.setPassWord(rs.getString("password"));
                user.setGender(rs.getInt("gender"));
                user.setPhone(rs.getString("phone"));
                user.setUserRole(rs.getInt("userRole"));
                user.setSignature(rs.getString("signature"));
                user.setHeadPic(rs.getString("headPic"));
                user.setContribution(rs.getString("contribution"));
                user.setFans(rs.getInt("fans"));
                user.setConcern(rs.getInt("concern"));
                user.setBirthday(rs.getString("birthday"));
                user.setNotice(rs.getString("notice"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return user;
    }

    @Override
    public User getVipByName(String name) {
        User user = null;
        try {
            String sql = "select * from user where userName like concat('%',?,'%')";
            rs = this.executeSelect(sql, name);
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setUserName(rs.getString("userName"));
                user.setPassWord(rs.getString("password"));
                user.setGender(rs.getInt("gender"));
                user.setPhone(rs.getString("phone"));
                user.setUserRole(rs.getInt("userRole"));
                user.setSignature(rs.getString("signature"));
                user.setHeadPic(rs.getString("headPic"));
                user.setContribution(rs.getString("contribution"));
                user.setFans(rs.getInt("fans"));
                user.setConcern(rs.getInt("concern"));
                user.setBirthday(rs.getString("birthday"));
                user.setNotice(rs.getString("notice"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeResource();
        }
        return user;
    }

    @Override
    public int getCount(String title, Integer id) {
        ResultSet rs = null;
        int count = 0;
        String sql = "select count(1) from user where 1=1 ";
        List<Object> params = new ArrayList<>();
        if (title != null && !title.equals("")){
            sql += " and userName like CONCAT('%',?,'%') ";
            params.add(title);
        }
        if (id != null && id !=0){
            sql += " and userId = ? ";
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
    public int getVipCount() {
        int count = 0;
        String sql = "select count(userId) from user where userRole=2";
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
