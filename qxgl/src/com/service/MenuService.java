package com.service;

import com.domain.Menu;

import java.util.List;

public interface MenuService {
    public List<Menu> findMenus();

    public int saveMenu(Menu menu) ;

    public Menu findMenuById(int mno);

    public void updateMenu(Menu menu);

    public void deleteMenu(int mno);

    public void setMenus(int rno,String mnos);

    public List<Integer> findMenuNosByRole(int rno );

    public List<Menu> findMenusByUser(int uno) ;
}
