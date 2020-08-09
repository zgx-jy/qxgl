package com.action;

import com.domain.Menu;
import com.domain.User;
import com.service.MenuService;
import com.service.UserService;
import com.service.impl.MenuServiceImpl;
import com.service.impl.UserServiceImpl;
import mymvc.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;

@SessionAttributes({"loginUser","menus","allMenus"})
public class UserAction {

    private UserService service = UserServiceImpl.getService() ;
    private MenuService menuService = new MenuServiceImpl() ;

    @RequestMapping("login.do")
    public ModelAndView login(@Param("uname")String uname , @Param("upass")String upass){
        User user= service.checkLogin(uname,upass) ;
        if(user == null){
            //登录失败，重新登录界面，同时传递一个参数，表示登录失败。
            ModelAndView mv = new ModelAndView();
            mv.setViewName("index.jsp");
            mv.addAttribute("flag","9");
            return mv;
        }else{
            //登录成功, 访问主界面，同时将登录成功的信息装入session，以供后续操作使用。

            List<Menu> menus = menuService.findMenusByUser(user.getUno());
            List<Menu> allMenus = menuService.findMenus() ;
            ModelAndView mv = new ModelAndView();
            mv.setViewName("main.jsp");
            mv.addAttribute("loginUser" , user);
            mv.addAttribute("menus" , menus);
            mv.addAttribute("allMenus" , allMenus);
            return mv ;
        }
    }


    @RequestMapping("userList.do")
    public ModelAndView userList(){
        List<User> users = service.findUserAll() ;
        //访问jsp，传递users数据 ： 转发
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userList.jsp");//req.getRequestDisptacher().forward()
        mv.addAttribute("users",users);//req.setAttribute(key,value);
        return mv ;
    }

    @RequestMapping("userAdd.do")
    @ResponseBody
    //public String userAdd(@Param("uname") String uname,@Param("upass")String upass,@Param("truename")String truename,@Param("age")Integer age,@Param("sex")String sex,@Param("phone")String phone){
    public String userAdd(User user){
        service.saveUser(user);
        return "保存成功";
    }

    @RequestMapping("userDelete.do")
    @ResponseBody
    public String userDelete(@Param("uno")Integer uno){
        service.deleteUser(uno);
        return "删除成功" ;
    }

    @RequestMapping("userEdit.do")
    public ModelAndView userEdit(@Param("uno")Integer uno){
        User user = service.findUserById(uno) ;
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userEdit.jsp");
        mv.addAttribute("user",user);
        return mv;
    }

    @RequestMapping("userUpdate.do")
    public String userUpdate(User user){
        try {
            service.updateUser(user);
            return "userList.do" ;
        }catch(Exception e){
            e.printStackTrace();
            return "error.jsp" ;
        }

    }

    @RequestMapping("userDeletes.do")
    public String userDeletes(@Param("unos")String unos){
        service.deleteUsers(unos);
        return  "userList.do";
    }

    @RequestMapping("userImport.do")
    public String userImport(HttpServletRequest request) throws FileUploadException, IOException {
        DiskFileItemFactory factory = new DiskFileItemFactory() ;
        ServletFileUpload upload = new ServletFileUpload(factory) ;
        List<FileItem> fis = upload.parseRequest(request) ;

        FileItem fi = fis.get(0);//此次业务只传递了 1个 文件参数
        InputStream is =fi.getInputStream() ;//获得输入流对象，可以间接获得文件内容

        //通过输入流读取excel文件内容
        Workbook book = WorkbookFactory.create(is) ; //jvm版excel文件
        Sheet sheet = book.getSheetAt(0) ; //数据表
        for(int i=1;i<=sheet.getLastRowNum();i++){
            Row row = sheet.getRow(i) ;
            if(row == null)continue ;

            Cell c1 = row.getCell(0);
            Cell c2 = row.getCell(1);
            Cell c3 = row.getCell(2);
            Cell c4 = row.getCell(3);
            Cell c5 = row.getCell(4);
            Cell c6 = row.getCell(5);
            Cell c7 = row.getCell(6);
            Cell c8 = row.getCell(7);

            String uname = c1.getStringCellValue() ;
            //只要excel文件中写的都是数字，就必须按照数字格式获取
            String upass = (int)c2.getNumericCellValue()+"" ; //123.0 -> "123"
            String truename = c3.getStringCellValue() ;
            int age = (int) c4.getNumericCellValue();
            String sex = c5.getStringCellValue() ;
            String phone = (int)c6.getNumericCellValue()+"";
            String yl1=null ;
            String yl2=null ;
            if(c7 != null){
                yl1 = c7.getStringCellValue() ;
            }
            if(c8!=null){
                yl2 = c8.getStringCellValue();
            }

            User user = new User(null,uname,upass,truename,age,sex,phone,yl1,yl2);
            service.saveUser(user);
        }

        return "userList.do" ;
    }

    @RequestMapping("userTemplateDown.do")
    @ResponseBody
    public void userTemplateDown(HttpServletRequest request ,HttpServletResponse response) throws IOException {
        //下载的本质就是复制。 将服务器的文件内容  复制到 浏览器客户端
        //复制的本质就是io读写 ，读取服务器的文件内容，写(响应)给浏览器
        //InputStream is = new FileInputStream("d:/z/users.xlsx");
        //request.getServletContext().getRealPath("files/users.xlsx");
        InputStream is = Thread.currentThread().getContextClassLoader()
                .getResourceAsStream("files/users.xlsx") ;
        OutputStream os  = response.getOutputStream() ;
        response.setHeader("content-Disposition","attachment;filename=users.xlsx");
        while(true){
            int b = is.read() ;
            if(b == -1){
                break;
            }
            os.write(b);
        }
        os.flush();
        is.close();
    }
}
