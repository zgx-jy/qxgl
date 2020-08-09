package com.service.impl;

import com.dao.UserDao;
import com.domain.User;
import com.service.UserService;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private UserServiceImpl(){}
    private static UserServiceImpl service = new UserServiceImpl();
    public static UserServiceImpl getService(){
        return service ;
    }


    private UserDao dao = new SqlSession().getMapper(UserDao.class) ;
    @Override
    public User checkLogin(String uname, String upass) {
        Map<String,String> params = new HashMap<String,String>() ;
        params.put("uname",uname) ;
        params.put("upass",upass) ;
        return dao.findUserByNameAndPass(params);
    }

    @Override
    public List<User> findUserAll() {
        return dao.findUserAll();
    }

    @Override
    public void saveUser(User user) {
        dao.saveUser(user);
    }

    @Override
    public void deleteUser(Integer uno) {
        dao.deleteUser(uno);
    }

    @Override
    public User findUserById(Integer uno) {
        return dao.findUserById(uno);
    }

    @Override
    public void updateUser(User user) {
        dao.updateUser(user);
    }

    @Override
    //unos="1,2,3,4,5"
    //delete from t_user where uno in (1,2,3,4,5)
    public void deleteUsers(String unos) {
        String[] unoArray = unos.split(",") ;
        int i = 0 ;
        do{
            int uno = Integer.parseInt( unoArray[i] ) ;
            dao.deleteUser(uno);
            i++ ;
        }while(i < unoArray.length) ;

    }
}
