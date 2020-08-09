package com.action;

import com.domain.Menu;
import com.domain.User;
import com.service.MenuService;
import com.service.impl.MenuServiceImpl;
import mymvc.Param;
import mymvc.RequestMapping;
import mymvc.ResponseBody;
import mymvc.SessionAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

import java.util.List;

public class MenuAction {

    private MenuService service = new MenuServiceImpl() ;

    @RequestMapping("menuList.do")
    @ResponseBody
    public List<Menu> menuList(){
        List<Menu> menus = service.findMenus() ;
        return menus ;
    }

    @RequestMapping("addMenu.do")
    @ResponseBody
    public int addMenu(Menu menu){
        return service.saveMenu(menu);
    }

    @RequestMapping("menuOne.do")
    @ResponseBody
    public Menu menuOne(@Param("mno") int mno){
        return service.findMenuById(mno) ;
    }

    @RequestMapping("menuUpdate.do")
    public void menuUpdate(Menu menu){
        service.updateMenu(menu);
    }

    @RequestMapping("menuDelete.do")
    public void menuDelete(@Param("mno") int mno){
        service.deleteMenu(mno);
    }

    @RequestMapping("setMenus.do")
    @ResponseBody
    public void setMenus(@Param("rno")int rno ,@Param("mnos") String mnos){
        service.setMenus(rno,mnos);
    }

    @RequestMapping("yesMenus.do")
    @ResponseBody
    public List<Integer> yesMenus(@Param("rno")int rno){
        return service.findMenuNosByRole(rno) ;
    }

    @RequestMapping("userMenus.do")
    @ResponseBody
    public List<Menu> userMenus(HttpServletRequest req){
        User user = (User) req.getSession().getAttribute("loginUser");
        return service.findMenusByUser(user.getUno());
    }
}
