package com.domain;

import java.util.List;

public class Role {

    private Integer rno ;
    private String rname ;
    private String description ;
    private String yl1 ;
    private String yl2 ;

    private List<User> users;
    private List<Menu> menus ;

    public Role(Integer rno, String rname, String description, String yl1, String yl2) {
        this.rno = rno;
        this.rname = rname;
        this.description = description;
        this.yl1 = yl1;
        this.yl2 = yl2;
    }

    public Role() {
    }

    public Integer getRno() {
        return rno;
    }

    public void setRno(Integer rno) {
        this.rno = rno;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getYl1() {
        return yl1;
    }

    public void setYl1(String yl1) {
        this.yl1 = yl1;
    }

    public String getYl2() {
        return yl2;
    }

    public void setYl2(String yl2) {
        this.yl2 = yl2;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public List<Menu> getMenus() {
        return menus;
    }

    public void setMenus(List<Menu> menus) {
        this.menus = menus;
    }
}
