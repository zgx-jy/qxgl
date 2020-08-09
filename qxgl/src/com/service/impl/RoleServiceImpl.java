package com.service.impl;

import com.dao.RoleDao;
import com.dao.impl.RoleDaoImpl;
import com.domain.Role;
import com.service.RoleService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleServiceImpl implements RoleService {
    private RoleDao dao = new RoleDaoImpl();
    @Override
    public List<Role> findRoles(int page, int rows, Integer rno, String rname, String description) {
        //page和rows 变成数据库所需要的starth和length
        /*
            第1页     从第0条记录开始       要3条
            第2页     从第3条记录开始       要3条
            第3页     从第6条记录开始       要3条
            ...
            第n页     从第(n-1)*3条记录开始       要3条
         */
        int length = rows ;
        int start = (page-1)*rows ;

        Map<String,Object> params = new HashMap<String,Object>();
        params.put("start",start);
        params.put("length",length);
        params.put("rno",rno);
        params.put("rname",rname);
        params.put("description",description);
        //select * from t_role
        return dao.findRoles(params);
    }

    @Override
    public long total(Integer rno, String rname, String description) {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("rno",rno);
        params.put("rname",rname);
        params.put("description",description);
        return dao.total(params);
    }

    @Override
    public List<Role> findUnlinkRolesByUser(int uno) {
        return dao.findNolinkRolesByUser(uno);
    }

    @Override
    public List<Role> findLinkRolesByUser(int uno) {
        return dao.findLinkRolesByUser(uno);
    }

    @Override
    public void setRoles(int uno, String rnos) {
        //先删除之前的关系
        dao.deleteRelationship(uno);
        //再增加新的关系
        String[] rnoArray = rnos.split(",") ;
        for(String rno : rnoArray){
            dao.addRelationship(uno,Integer.parseInt(rno));
        }
    }
}
