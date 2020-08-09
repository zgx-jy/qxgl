package com.dao;

import com.domain.Role;

import java.util.List;
import java.util.Map;

public interface RoleDao {

    public List<Role> findRoles(Map<String,Object> params);
    public int total(Map<String,Object> params);

    public List<Role> findNolinkRolesByUser(int uno) ;

    public List<Role> findLinkRolesByUser(int uno) ;

    public void deleteRelationship(int uno) ;

    public void addRelationship(int uno,int rno) ;

}
