package service.Home;

import dao.Home.HomeDao;
import dao.Home.HomeDaoImpl;

public class HomeServiceImpl implements HomeService{
    private HomeDao homeDao;

    public HomeServiceImpl(){
        homeDao = new HomeDaoImpl();
    }
    @Override
    public int getUserCount() {
        return homeDao.getUserCount();
    }

    @Override
    public int getVipCount() {
        return homeDao.getVipCount();
    }

    @Override
    public int getVideoCount() {
        return homeDao.getVideoCount();
    }
}
