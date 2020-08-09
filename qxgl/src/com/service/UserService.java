package com.service;

import com.domain.User;

import java.util.List;

public interface UserService {

    /**
     * 登录验证
     * @param uname
     * @param upass
     * @return user对象  登录成功
     *         null      登录失败
     */
    public User checkLogin(String uname, String upass);

    public List<User> findUserAll();

    public void saveUser(User user) ;

    public void deleteUser(Integer uno) ;

    public User findUserById(Integer uno) ;

    public void updateUser(User user) ;

    public void deleteUsers(String unos);

}
