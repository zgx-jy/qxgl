package com.service;

import com.domain.Role;

import java.util.List;

public interface RoleService {
    public List<Role> findRoles(int page , int rows , Integer rno,String rname,String description);

    public long total(Integer rno,String rname,String description);

    public List<Role> findUnlinkRolesByUser(int uno);

    public List<Role> findLinkRolesByUser(int uno);

    public void setRoles(int uno,String rnos);
}
