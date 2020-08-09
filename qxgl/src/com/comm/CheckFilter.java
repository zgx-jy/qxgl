package com.comm;

import com.domain.Menu;
import com.domain.User;
import com.service.MenuService;
import com.service.impl.MenuServiceImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 登录，权限验证
 */
@WebFilter("*.do")
public class CheckFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        resp.setContentType("text/html;charset=utf-8");
        //当前拦截器的请求
        String url = req.getServletPath() ;// /roleList.do
        url = url.replace("/","");//roleList.do
        if(url.indexOf("login.do") != -1){
            //此次是一个登录请求，所有的用户都有登录权限，不需要验证
            filterChain.doFilter(req,resp);
            return ;
        }

        //判断当前拦截器的请求是否符合当前用户拥有的菜单权限
        User user = (User) req.getSession().getAttribute("loginUser");
        if(user == null){
            //还没有登录，提示重新登录
            resp.getWriter().write("<script>alert('还没有登录，请先登录'); location.href='index.jsp' </script>");
            return ;
        }

        MenuService service = new MenuServiceImpl();
        List<Menu>  menus = (List<Menu>) req.getSession().getAttribute("menus");
        List<Menu> allMenus = (List<Menu>) req.getSession().getAttribute("allMenus");
        //判断当前的请求是否在权限管理的管理机制内容
        for(Menu m : allMenus){
            if(m.getMhref() != null && !"".equals(m.getMhref()) && m.getMhref().indexOf(url) != -1){
                //证明当前的请求需要验证权限


                for(Menu menu : menus){
                    if(menu.getMhref() != null && !"".equals(menu.getMhref()) && menu.getMhref().indexOf(url) != -1){
                        //当前用户的菜单权限中包括当前的请求，可以继续完成请求操作
                        filterChain.doFilter(req,resp);
                        return ;
                    }
                }

                //此次请求不在当前用户允许的菜单权限内
                resp.getWriter().write("<script>alert('没有足够的权限，请联系管理员'); </script>");

                return ;
            }
        }

        //当前请求不需要验证权限，放过
        filterChain.doFilter(req,resp);



    }
}

