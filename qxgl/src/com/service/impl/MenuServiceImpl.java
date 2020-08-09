package com.service.impl;

import com.dao.MenuDao;
import com.domain.Menu;
import com.service.MenuService;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuServiceImpl implements MenuService {
    private MenuDao dao = new SqlSession().getMapper(MenuDao.class);
    @Override
    public List<Menu> findMenus() {
        return dao.findMenus();
    }

    @Override
    public int saveMenu(Menu menu) {
        dao.saveMenu(menu);
        return dao.findIdByMname(menu.getMname());
    }

    @Override
    public Menu findMenuById(int mno) {
        return dao.findMenuById(mno);
    }

    @Override
    public void updateMenu(Menu menu) {
        dao.updateMenu(menu);
    }

    @Override
    public void deleteMenu(int mno) {
        List<Menu> menus = dao.findMenus() ;
        removeMenu(mno,menus);
    }

    @Override
    public void setMenus(int rno, String mnos) {
        //先清空之前的关系分配
        dao.deleteRelationship(rno);
        //在增加新你分配关系
        String[] mnoArray = mnos.split(",") ;
        for(String mno:mnoArray){
            Map<String,Integer> params = new HashMap<String,Integer>();
            params.put("rno",rno) ;
            params.put("mno",Integer.parseInt(mno)) ;
            dao.addRelationship(params);
        }
    }

    @Override
    public List<Integer> findMenuNosByRole(int rno) {
        return dao.findMenuNosByRole(rno);
    }

    @Override
    public List<Menu> findMenusByUser(int uno) {
        return dao.findMenusByUser(uno);
    }

    private void removeMenu(int mno,List<Menu> menus){
        for(int i=0;i<menus.size();i++){
            Menu menu = menus.get(i) ;
            if(menu.getPno() == mno){
                removeMenu(menu.getMno(),menus) ;
            }
        }
        //此时一定没有子菜单
        dao.deleteMenu(mno);
    }


}
