package com.dao;

import com.domain.Menu;
import orm.annotation.Delete;
import orm.annotation.Insert;
import orm.annotation.Select;
import orm.annotation.Update;

import java.util.List;
import java.util.Map;

public interface MenuDao {
    @Select("select * from t_menu")
    public List<Menu> findMenus();


    @Insert("insert into t_menu values(null,#{mname},#{mhref},#{mtarget},#{pno},#{yl1},#{yl2})")
    public void saveMenu(Menu menu) ;

    @Select("select mno from t_menu where mname = #{mname}")
    public int findIdByMname(String mname) ;

    @Select("select * from t_menu where mno = #{mno}")
    public Menu findMenuById(int mno) ;

    @Update("update t_menu set mname=#{mname},mhref=#{mhref},mtarget=#{mtarget} where mno = #{mno}")
    public void updateMenu(Menu menu) ;

    @Delete("delete from t_menu where mno = #{mno}")
    public void deleteMenu(int mno) ;

    @Delete("delete from t_role_menu where rno = #{rno}")
    public void deleteRelationship(int rno);

    @Insert("insert into t_role_menu values(#{rno},#{mno})")
    public void addRelationship(Map<String,Integer> params);

    @Select("select mno from t_role_menu where rno = #{rno}")
    public List<Integer> findMenuNosByRole(int rno) ;

    @Select("select * from t_menu where mno in (select mno from t_role_menu where rno in (select rno from t_user_role where uno = #{uno}) )")
    public List<Menu> findMenusByUser(int uno) ;

}
