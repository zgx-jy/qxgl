package com.action;

import com.domain.Role;
import com.service.RoleService;
import com.service.impl.RoleServiceImpl;
import mymvc.ModelAndView;
import mymvc.Param;
import mymvc.RequestMapping;
import mymvc.ResponseBody;

import java.util.List;

public class RoleAction {
    private RoleService service = new RoleServiceImpl() ;
    @RequestMapping("roleList.do")
    public ModelAndView roleList(@Param("page")Integer page,@Param("rows")Integer rows,@Param("rno")Integer rno,@Param("rname")String rname ,@Param("description")String description){
        if(page == null){
            page = 1 ;
        }
        if(rows == null){
            rows = 3 ;
        }

        List<Role> roles = service.findRoles(page,rows,rno,rname,description);
        long total = service.total(rno,rname,description) ;
        int maxPage = (int) (total%rows==0? total/rows : (total/rows+1));

        ModelAndView mv = new ModelAndView() ;
        mv.setViewName("roleList.jsp");
        mv.addAttribute("page",page);
        mv.addAttribute("rows",rows);
        mv.addAttribute("maxPage",maxPage);
        mv.addAttribute("roles",roles);
        mv.addAttribute("rno",rno);
        mv.addAttribute("rname",rname);
        mv.addAttribute("description",description);

        return mv ;

    }
    @RequestMapping("noList.do")
    @ResponseBody
    public List<Role> noList(@Param("uno")int uno){
        return service.findUnlinkRolesByUser(uno);
    }

    @RequestMapping("yesList.do")
    @ResponseBody
    public List<Role> yesList(@Param("uno")int uno){
        return service.findLinkRolesByUser(uno);
    }

    @RequestMapping("setRoles.do")
    @ResponseBody
    public void setRoles(@Param("uno")int uno,@Param("rnos")String rnos){
        service.setRoles(uno,rnos);
    }

}
