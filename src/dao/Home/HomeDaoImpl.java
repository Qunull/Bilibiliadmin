package dao.Home;

import dao.BaseDaoImpl;

import java.sql.ResultSet;
import java.sql.SQLException;

public class HomeDaoImpl extends BaseDaoImpl implements HomeDao {
    @Override
    public int getUserCount() {
        ResultSet rs = null;
        int count = 0;
        String sql = "select count(1) from user where userRole=1";
        rs = executeSelect(sql);
        try {
            if (rs.next()){
                count = rs.getInt(1);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            this.closeResource();
        }
        return count;
    }

    @Override
    public int getVipCount() {
        ResultSet rs = null;
        int count = 0;
        String sql = "select count(1) from user where userRole=2";
        rs = executeSelect(sql);
        try {
            if (rs.next()){
                count = rs.getInt(1);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            this.closeResource();
        }
        return count;
    }

    @Override
    public int getVideoCount() {
        ResultSet rs = null;
        int count = 0;
        String sql = "select count(1) from video ";
        rs = executeSelect(sql);
        try {
            if (rs.next()){
                count = rs.getInt(1);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            this.closeResource();
        }
        return count;
    }
}
